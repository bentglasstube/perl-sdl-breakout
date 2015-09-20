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

sub _update_ball {
  my ($self, $step, $app) = @_;

  # TODO recursively update ball path
  $self->ball->update($step, $app);
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
