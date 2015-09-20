# Show Handler

Responsible for rendering the screen.

    $app->add_show_handler(
      sub {
        my ($delta, $app) = @_;
        $app->draw_rect([ 0, 0, $app->w, $app->h ], 0x000000ff);
        $game->draw($app);
        $app->update();
      }
    );

  * `$delta` - Time in seconds since last run of the handler
  * `$app` - The `SDLx::Controller` to be drawn.
