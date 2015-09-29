# Event Handler

Handles SDL events, from input devices and the window manager

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
          when (SDL_QUIT) {
            $app->stop;
          }
        }
      }
    );

  * `$event` - The `SDL::Event` object
  * `$app` - The `SDLx::Controller` that received the event
