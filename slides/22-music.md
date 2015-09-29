# Music

There is an `SDLx::Music` class which seems to be more flushed out than
`SDLx::Sound`.  However, it warns against using it alongside the raw
`SDL::Mixer::Music` calls, so I just added this function to my existing audio
class to allow looping music:

    sub music {
      my ($self, $name) = @_;
      my $music = SDL::Mixer::Music::load_MUS($name);
      SDL::Mixer::Music::fade_in_music($music, -1, 500);
    }
