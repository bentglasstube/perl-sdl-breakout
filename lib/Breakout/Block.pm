package Breakout::Block;

use strict;
use warnings;

use SDLx::Rect;

sub new {
  my ($class, $x, $y, $value) = @_;

  return bless {
    rect  => SDLx::Rect->new($x, $y, 50, 20),
    hit   => undef,
    value => $value,
  }, $class;
}

sub rect  { return shift->{rect} }
sub hit   { return shift->{hit} }
sub value { return shift->{value} }

sub update {
  my ($self, $step, $app) = @_;
}

sub handle_collision {
  my ($self, $ball) = @_;
  $self->{hit}++;
}

my @_colors = (
  0xffff00ff,
  0x00ff00ff,
  0xff8800ff,
  0xff0000ff,
);

sub draw {
  my ($self, $app) = @_;

  $app->draw_rect($self->rect, $_colors[ $self->value / 2 ]);
}

1;
