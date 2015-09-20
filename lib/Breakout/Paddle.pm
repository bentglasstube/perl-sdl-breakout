package Breakout::Paddle;

use strict;
use warnings;

use List::Util qw(min max);

sub new {
  my ($class, $x) = @_;

  return bless {
    x     => $x,
    v_x   => 0,
    width => 50,
    speed => 20,
  }, $class;
}

sub x     { return shift->{x} }
sub v_x   { return shift->{v_x} }
sub width { return shift->{width} }
sub speed { return shift->{speed} }

sub update {
  my ($self, $step, $app) = @_;

  $self->{x} += $step * $self->speed * $self->v_x;

  $self->{x} = max($self->x, $self->width / 2);
  $self->{x} = min($self->x, $app->width - $self->width / 2);
}

sub draw {
  my ($self, $app) = @_;
  $app->draw_rect(
    [ $self->x - $self->width / 2, $app->height - 20, $self->width, 10 ],
    0x00ffd8ff,
  );
}

sub move {
  my ($self, $direction) = @_;
  $self->{v_x} += $direction;
}

1;
