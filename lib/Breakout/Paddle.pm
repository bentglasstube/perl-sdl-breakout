package Breakout::Paddle;

use strict;
use warnings;

use List::Util qw(min max);
use SDLx::Rect;
use SDLx::Sprite;

use Breakout::Audio;

sub new {
  my ($class, $x) = @_;

  return bless {
    x      => $x,
    vx     => 0,
    width  => 48,
    speed  => 20,
    sprite => SDLx::Sprite->new(image => 'paddle.bmp', y => 568),
    sound  => Breakout::Audio->new(),
  }, $class;
}

sub x      { return shift->{x} }
sub vx     { return shift->{vx} }
sub width  { return shift->{width} }
sub speed  { return shift->{speed} }
sub sprite { return shift->{sprite} }
sub sound  { return shift->{sound} }

sub rect {
  my ($self) = @_;
  return SDLx::Rect->new($self->x - $self->width / 2, 568, $self->width, 16);
}

sub update {
  my ($self, $step, $app) = @_;

  $self->{x} += $step * $self->speed * $self->vx;

  $self->{x} = max($self->x, $self->width / 2);
  $self->{x} = min($self->x, $app->width - $self->width / 2);
}

sub handle_collision {
  my ($self, $ball) = @_;
  $self->sound->play('bounce.wav');
}

sub draw {
  my ($self, $app) = @_;
  $self->sprite->x($self->x - $self->width / 2);
  $self->sprite->draw($app);
}

sub move {
  my ($self, $direction) = @_;
  $self->{vx} += $direction;
}

1;
