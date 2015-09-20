package Breakout::Ball;

use strict;
use warnings;

use constant PI => 3.14159265358979;

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

sub draw {
  my ($self, $app) = @_;
  $app->draw_circle_filled([ $self->x, $self->y ], $self->radius, 0xd8ff00ff);

  $app->draw_line(
    [ $self->x, $self->y ],
    [ $self->x + cos($self->dir) * $self->speed, $self->y + sin($self->dir) * $self->speed ],
    0xd8ff00ff
  );
}

sub bounce {
  my ($self, $segment) = @_;

  my ($x1, $y1, $x2, $y2) = @$segment;

  if ($x1 == $x2) {
    $self->{dir} = 3 * PI - $self->dir;
  } elsif ($y1 == $y2) {
    $self->{dir} = 2 * PI - $self->dir;
  } else {
    die 'Segment neither horizontal nor vertical';
  }
}

sub nearest_collision {
  my ($self, $step, @segments) = @_;

  my $dx = cos($self->dir) * $step  * $self->speed;
  my $dy = sin($self->dir) * $step  * $self->speed;

  my $best = {};

  foreach my $segment (@segments) {
    if (my $t = $self->_collide($dx, $dy, @$segment)) {
      if (not defined $best->{t} or $t < $best->{t}) {
        $best->{t} = $t;
        $best->{segment} = $segment;
      }
    }
  }

  return $best->{segment} ? $best : undef;
}

sub _collide {
  my ($self, $dx, $dy, $x1, $y1, $x2, $y2) = @_;

  if ($y1 == $y2) {
    return undef if $dy == 0;

    my $t = ($y1 - $self->y) / $dy;

    if ($t > 0 and $t <= 1) {
      my $ix = $self->x + $t * $dx;
      return $t if $ix >= $x1 and $ix <= $x2;
    }

    return undef;
  } elsif ($x1 == $x2) {

    return undef if $dx == 0;

    my $t = ($x1 - $self->x) / $dx;
    if ($t > 0 and $t <= 1) {
      my $iy = $self->y + $t * $dy;
      return $t if $iy >= $y1 and $iy <= $y2;
    }

    return undef;
  } else {
    die "Segment neither horizontal nor vertical - ($x1, $y1), ($x2, $y2)";
  }
}

sub advance_motion {
  my ($self, $step) = @_;

  $self->{x} += cos($self->dir) * $step * $self->speed;
  $self->{y} += sin($self->dir) * $step * $self->speed;
}

sub moving_up { return sin(shift->dir) < 0 }
sub moving_down { return sin(shift->dir) > 0 }
sub moving_left { return cos(shift->dir) < 0 }
sub moving_right { return cos(shift->dir) > 0 }

1;
