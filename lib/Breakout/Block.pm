package Breakout::Block;

use strict;
use warnings;

use SDLx::Rect;
use SDLx::Sprite;

sub new {
  my ($class, $x, $y, $value) = @_;

  return bless {
    hit    => undef,
    value  => $value,
    sprite => SDLx::Sprite->new(
      image => "brick$value.bmp",
      rect  => SDLx::Rect->new($x, $y, 48, 16)
    ),
  }, $class;
}

sub hit    { return shift->{hit} }
sub value  { return shift->{value} }
sub sprite { return shift->{sprite} }
sub rect   { return shift->sprite->rect }

sub update {
  my ($self, $step, $app) = @_;
}

sub handle_collision {
  my ($self, $ball) = @_;
  $self->{hit}++;
}

sub draw {
  my ($self, $app) = @_;
  $self->sprite->draw($app);
}

1;
