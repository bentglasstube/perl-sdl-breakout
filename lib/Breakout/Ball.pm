package Breakout::Ball;

use strict;
use warnings;

use constant PI => 3.14159265358979;

sub new {
  my ($class, $x, $y) = @_;

  return bless {
    x      => $x,
    y      => $y,
    dir    => 2 * PI * rand,
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
  my ($self, $step, $app) = @_;

  $self->{x} += cos($self->dir) * $step * $self->speed;
  $self->{y} += sin($self->dir) * $step * $self->speed;

  if ($self->x <= $self->radius) {
    $self->_hbounce($self->radius);
  } elsif ($self->x >= $app->width) {
    $self->_hbounce($app->width);
  }

  if ($self->y <= $self->radius) {
    $self->_vbounce($self->radius);
  } elsif ($self->y >= $app->height) {
    $self->_vbounce($app->height);
  }
}

sub draw {
  my ($self, $app) = @_;
  $app->draw_circle_filled([ $self->x, $self->y ], $self->radius, 0xd8ff00ff);
}

sub _hbounce {
  my ($self, $x) = @_;

  $self->{x}   = 2 * $x - $self->x;
  $self->{dir} = 3 * PI - $self->dir;
}

sub _vbounce {
  my ($self, $y) = @_;

  $self->{y}   = 2 * $y - $self->y;
  $self->{dir} = 2 * PI - $self->dir;
}

1;
