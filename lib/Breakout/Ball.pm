package Breakout::Ball;

use strict;
use warnings;

use constant PI => 3.14159265358979;

use Breakout::Wall;

sub new {
  my ($class, $x, $y) = @_;

  return bless {
    x      => $x,
    y      => $y,
    dir    => 5 / 4 * PI + PI / 2 * rand,
    speed  => 20,
    radius => 5,
  }, $class;
}

sub x      { return shift->{x} }
sub y      { return shift->{'y'} }
sub dir    { return shift->{dir} }
sub speed  { return shift->{speed} }
sub radius { return shift->{radius} }

sub update {
  my ($self, $step, $app, @objects) = @_;

  push @objects, Breakout::Wall->new(-10, 0, 10, $app->height);
  push @objects, Breakout::Wall->new($app->width, 0, 10, $app->height);
  push @objects, Breakout::Wall->new(0, -10, $app->width, 10);

  while ($step > 0) {
    my $dx = cos($self->dir) * $step * $self->speed;
    my $dy = sin($self->dir) * $step * $self->speed;

    my $best;

    foreach my $object (@objects) {
      if (my $collision = $self->_collide($dx, $dy, $object)) {
        if (not defined $best or $best->{t} > $collision->{t}) {
          $best = $collision;
        }
      }
    }

    if ($best) {
      $self->{x} += $dx * $best->{t};
      $self->{y} += $dy * $best->{t};
      $self->{dir} = ($best->{dir} eq 'h' ? 3 : 2) * PI - $self->dir;

      $best->{object}->handle_collision($self);

      $step *= 1 - $best->{t};
    } else {
      $self->{x} += $dx;
      $self->{y} += $dy;
      $step = 0;
    }
  }
}

sub draw {
  my ($self, $app) = @_;
  $app->draw_circle_filled([ $self->x, $self->y ], $self->radius, 0xd8ff00ff);

  $app->draw_line(
    [ $self->x, $self->y ],
    [
      $self->x + cos($self->dir) * $self->speed,
      $self->y + sin($self->dir) * $self->speed
    ],
    0xd8ff00ff
  );
}

sub _collide {
  my ($self, $dx, $dy, $object) = @_;

  my $hseg = [ $object->rect->left, 0, $object->rect->right, 0 ];
  my $vseg = [ 0, $object->rect->top, 0, $object->rect->bottom, 0 ];

  if ($dy) {
    my $y = $dy < 0 ? $object->rect->bottom : $object->rect->top;
    my $t = ($y - $self->y) / $dy;

    if ($t > 0 and $t <= 1) {
      my $ix = $self->x + $t * $dx;
      if ($ix >= $object->rect->left and $ix <= $object->rect->right) {
        return {
          t      => $t,
          dir    => 'v',
          object => $object,
        };
      }
    }
  }

  if ($dx) {
    my $x = $dx < 0 ? $object->rect->right : $object->rect->left;
    my $t = ($x - $self->x) / $dx;
    if ($t > 0 and $t <= 1) {
      my $iy = $self->y + $t * $dy;
      if ($iy >= $object->rect->top and $iy <= $object->rect->bottom) {
        return {
          t      => $t,
          dir    => 'h',
          object => $object,
        };
      }
    }
  }

  return undef;
}

1;
