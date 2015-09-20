package Breakout::Game;

use strict;
use warnings;

use experimental 'switch';

use SDL::Event;

use Breakout::Ball;
use Breakout::Block;
use Breakout::Paddle;

sub __load_level {
  my @blocks = ();
  for my $y (1 .. 5) {
    for my $x (1 .. 15) {
      push @blocks, Breakout::Block->new(50 * $x - 40, 20 * $y + 20);
    }
  }

  return \@blocks;
}

sub _reset {
  my ($self) = @_;

  $self->{paddle}   = Breakout::Paddle->new(400);
  $self->{ball}     = Breakout::Ball->new(400, 575);
  $self->{blocks}   = __load_level();
  $self->{powerups} = [];
}

sub new {
  my ($class) = @_;

  my $self = bless {
    lives => 3,
    score => 0,
  }, $class;

  $self->_reset();

  return $self;
}

sub lives    { return shift->{lives} }
sub score    { return shift->{score} }
sub paddle   { return shift->{paddle} }
sub ball     { return shift->{ball} }
sub blocks   { return @{ shift->{blocks} } }
sub powerups { return @{ shift->{powerups} } }

sub key_press {
  my ($self, $key) = @_;

  given ($key) {
    when (SDLK_a) {
      $self->paddle->move(-1);
    }

    when (SDLK_d) {
      $self->paddle->move(1);
    }

    when ([SDLK_ESCAPE]) {
      $self->{lives} = 0;
    }
  }
}

sub key_release {
  my ($self, $key) = @_;

  given ($key) {
    when (SDLK_a) {
      $self->paddle->move(1);
    }

    when (SDLK_d) {
      $self->paddle->move(-1);
    }
  }
}

sub update {
  my ($self, $step, $app) = @_;

  $self->paddle->update($step, $app);
  $_->update($step, $app) foreach $self->powerups;
  $self->_update_ball($step, $app);

  return $self->lives > 0;
}

sub SDLx::Rect::top_seg {
  my ($self) = @_;
  return [ $self->left, $self->top, $self->right, $self->top ];
}

sub SDLx::Rect::left_seg {
  my ($self) = @_;
  return [ $self->left, $self->top, $self->left, $self->bottom ];
}

sub SDLx::Rect::right_seg {
  my ($self) = @_;
  return [ $self->right, $self->top, $self->right, $self->bottom ];
}

sub SDLx::Rect::bottom_seg {
  my ($self) = @_;
  return [ $self->left, $self->bottom, $self->right, $self->bottom ];
}

sub _update_ball {
  my ($self, $step, $app) = @_;

  while ($step > 0) {
    my @segments = ();

    my $window = SDLx::Rect->new(0, 100, $app->width, $app->height);

    push @segments, $window->top_seg if $self->ball->moving_up;
    push @segments, $window->left_seg if $self->ball->moving_left;
    push @segments, $window->right_seg if $self->ball->moving_right;

    foreach my $block ($self->blocks) {
      push @segments, $block->rect->top_seg if $self->ball->moving_down;
      push @segments, $block->rect->left_seg if $self->ball->moving_right;
      push @segments, $block->rect->right_seg if $self->ball->moving_left;
      push @segments, $block->rect->bottom_seg if $self->ball->moving_up;
    }

    push @segments, $self->paddle->rect->top_seg if $self->ball->moving_down;
    push @segments, $self->paddle->rect->left_seg if $self->ball->moving_right;
    push @segments, $self->paddle->rect->right_seg if $self->ball->moving_left;

    if (my $collision = $self->ball->nearest_collision($step, @segments)) {
      $self->ball->advance_motion($collision->{t} * $step);
      $self->ball->bounce($collision->{segment});
      $step *= 1 - $collision->{t};
    } else {
      $self->ball->advance_motion($step);
      last;
    }
  }
}

sub draw {
  my ($self, $app) = @_;

  $self->paddle->draw($app);
  $self->ball->draw($app);
  $_->draw($app) foreach $self->blocks;
  $_->draw($app) foreach $self->powerups;
}

sub pause {
  # TODO pause the game
}

1;
