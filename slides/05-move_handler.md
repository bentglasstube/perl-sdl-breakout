# Move Handler

Handles updating the game state.

    $app->add_move_handler(
      sub {
        my ($step, $app, $t) = @_;
        $game->update($step, $app) or $app->stop;
      }
    );

  * `$step` - The amount of time that has passed, related to `dt`
  * `$app` - The `SDLx::Controller` running the callback
  * `$t` - The total time elapsed since calling `$app->run`
