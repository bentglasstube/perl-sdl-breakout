use strict;
use warnings;

use lib 'lib';

use experimental 'switch';

use SDL;
use SDL::Event;
use SDLx::App;

use Breakout::Game;

my $app = SDLx::App->new(
  width        => 800,
  height       => 600,
  title        => 'Breakout!',
  depth        => 32,
  dt           => 0.1,
);

my $game = Breakout::Game->new(1);

$app->add_event_handler(
  sub {
    my ($event, $app) = @_;

    given ($event->type) {
      when (SDL_KEYDOWN) {
        $game->key_press($event->key_sym);
      }
      when (SDL_KEYUP) {
        $game->key_release($event->key_sym);
      }
      when (SDL_ACTIVEEVENT) {
        $game->pause if $event->active_gain == 0;
      }
      when (SDL_QUIT) {
        $app->stop;
      }
    }
  }
);

$app->add_move_handler(
  sub {
    my ($step, $app, $t) = @_;
    $game->update($step, $app);
  }
);

$app->add_show_handler(
  sub {
    my ($delta, $app) = @_;
    $app->draw_rect([ 0, 0, $app->w, $app->h ], 0x000000ff);
    $game->draw($app);
    $app->update();
  }
);

# TODO start music
$app->run();
