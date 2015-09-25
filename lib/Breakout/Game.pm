package Breakout::Game;

use strict;
use warnings;

use experimental 'switch';

use SDL::Event;

use Breakout::Ball;
use Breakout::Block;
use Breakout::Paddle;

sub _reset_blocks {
  my ($self) = @_;

  my @blocks = ();
  for my $y (0 .. 7) {
    for my $x (0 .. 15) {
      push @blocks, Breakout::Block->new(50 * $x, 20 * $y + 40, 7 - 2 * (int $y / 2));
    }
  }

  $self->{blocks} = \@blocks;
}

sub _reset_ball {
  my ($self) = @_;

  $self->{ball} = Breakout::Ball->new(400, 575);
  $self->paddle->{x} = 400;
}

sub _launch {
  my ($self) = @_;

  if ($self->ball->speed == 0) {
    $self->ball->{speed} = 20;
    # TODO play sound launch.wav
  }
}

sub new {
  my ($class) = @_;

  my $self = bless {
    lives  => 3,
    score  => 0,
    paddle => Breakout::Paddle->new(400),
  }, $class;

  $self->_reset_ball;
  $self->_reset_blocks;

  return $self;
}

sub lives  { return shift->{lives} }
sub score  { return shift->{score} }
sub paddle { return shift->{paddle} }
sub ball   { return shift->{ball} }
sub blocks { return @{ shift->{blocks} } }

sub key_press {
  my ($self, $key) = @_;

  given ($key) {
    when (SDLK_a) {
      $self->paddle->move(-1);
    }

    when (SDLK_d) {
      $self->paddle->move(1);
    }

    when (SDLK_SPACE) {
      $self->_launch;
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

  if ($self->ball->speed) {
    $self->ball->update($step, $app, $self->paddle, $self->blocks);
  } else {
    $self->ball->{x} = $self->paddle->x;
  }

  $self->{blocks} = [ grep {
    if ($_->hit) {
      $self->{score} += $_->value;
      $self->ball->{speed} *= 1.01;

      # TODO play sound break.wav

      undef;
    } else {
      1;
    }
  } $self->blocks ];

  if ($self->ball->y > $app->height / 2 and not $self->blocks) {
    $self->_reset_blocks 
    # TODO play sound clear.wav
  }

  $_->update($step, $app) foreach $self->paddle, $self->blocks;

  if ($self->ball->y > $app->height + 100) {
    $self->_reset_ball;
    $self->{lives}--;

    # TODO play sound miss.wav

    if ($self->lives == 0) {
      $self->_reset_blocks;
      $self->{lives} = 3;
    }
  }
}

sub draw {
  my ($self, $app) = @_;

  $_->draw($app) foreach $self->blocks, $self->paddle, $self->ball;

  for (1 .. $self->lives) {
    $app->draw_circle_filled([ 15 * $_ - 8, 7 ], 5, 0xffffffff);
  }

  $app->draw_gfx_text(
    [ $app->width - 50, 2 ],
    0xffffffff,
    sprintf "%06u", $self->score
  );

}

sub pause {
  # TODO pause the game
}

1;
