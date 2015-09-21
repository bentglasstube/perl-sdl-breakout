package Breakout::Wall;

use strict;
use warnings;

use SDLx::Rect;

sub new {
  my ($class, $x, $y, $h, $w) = @_;

  return bless {
    rect => SDLx::Rect->new($x, $y, $h, $w),
  }, $class;
}

sub rect { return shift->{rect} }

sub handle_collision {
  my ($self, $ball) = @_;
}

1;
