package Breakout::Block;

use strict;
use warnings;

use constant WIDTH  => 50;
use constant HEIGHT => 20;

use constant BLOCK_NORMAL => 0;
use constant BLOCK_GLASS  => 1;
use constant BLOCK_METAL  => 2;

use SDLx::Rect;

sub new {
  my ($class, $x, $y, $type) = @_;

  return bless {
    rect => SDLx::Rect->new($x, $y, WIDTH, HEIGHT),
    type => BLOCK_NORMAL,
    hits => 0,
  }, $class;
}

sub rect { return shift->{rect} }
sub type { return shift->{type} }
sub hits { return shift->{hits} }

sub destroyed {
  my ($self) = @_;

  return $self->hits > 0 if $self->type == BLOCK_NORMAL;
  return $self->hits > 2 if $self->type == BLOCK_GLASS;
  return undef;
}

sub value {
  my ($self) = @_;

  return 100 if $self->type == BLOCK_NORMAL;
  return 500 if $self->type == BLOCK_GLASS;
  return 0;
}

sub update {
  my ($self, $step, $app) = @_;
}

my @_colors = (0x800000ff, 0x0090ffff, 0xa0a0a0ff);

sub handle_collision {
  my ($self, $ball) = @_;

  $self->{hits}++;
}

sub draw {
  my ($self, $app) = @_;

  $app->draw_rect($self->rect, 0xffffffff);
  $app->draw_rect($self->rect->inflate(-2, -2), $_colors[ $self->type ]);
}

1;
