# Other Events

## SDL_ACTIVEEVENT

Notifies the application about changes to its focus state.  There are
various values that can be set in the `active_state` parameter:

 * `SDL_APPACTIVE` - Occurs when the application is
   minimised/restored
 * `SDL_APPINPUTFOCUS` - Occurs when the application gains/loses
   keyboard input focus
 * `SDL_APPMOUSEFOCUS` - Occurs when the mouse leaves/enters the
   application's window

The `active_gain` parameter tells you if focus is gained or lost.

    when (SDL_ACTIVEEVENT) {
      $game->pause if $event->active_gain == 0;
    }

## SDL_QUIT

Occurs when the window manager or operating system requests that the
application shut down.

    when (SDL_QUIT) {
      $app->stop;
    }

This handling is so common, you can invoke it just by setting
`exit_on_quit` to a true value in `SDLx::App->new`.
