package Breakout::Paddle;

use strict;
use warnings;

use List::Util qw(min max);
use SDLx::Rect;

sub new {
  my ($class, $x) = @_;

  return bless {
    x     => $x,
    vx    => 0,
    width => 50,
    speed => 20,
  }, $class;
}

sub x     { return shift->{x} }
sub vx    { return shift->{vx} }
sub width { return shift->{width} }
sub speed { return shift->{speed} }

sub rect {
  my ($self) = @_;
  return SDLx::Rect->new($self->x - $self->width / 2, 580, $self->width, 10);
}

sub update {
  my ($self, $step, $app) = @_;

  $self->{x} += $step * $self->speed * $self->vx;

  $self->{x} = max($self->x, $self->width / 2);
  $self->{x} = min($self->x, $app->width - $self->width / 2);
}

sub handle_collision {
  my ($self, $ball) = @_;

  # TODO play sound "bounce.wav"
}

sub draw {
  my ($self, $app) = @_;
  $app->draw_rect($self->rect, 0xffffffff);
}

sub move {
  my ($self, $direction) = @_;
  $self->{vx} += $direction;
}

1;
