# The Game Loop

    use strict;
    use warnings;

    use lib 'lib';

    use SDL;
    use SDL::Event;
    use SDLx::App;

    use Breakout::Game;

    my $app = SDLx::App->new(
      width        => 800,
      height       => 600,
      title        => 'Breakout!',
      dt           => 0.1,
      exit_on_quit => 1,
    );

    my $game = Breakout::Game->new();

    $app->add_event_handler(...);
    $app->add_move_handler(...);
    $app->add_show_handler(...);

    $app->run();
