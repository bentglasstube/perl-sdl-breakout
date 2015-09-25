# Music

    sub music {
      my ($self, $name) = @_;
      my $music = SDL::Mixer::Music::load_MUS($name);
      SDL::Mixer::Music::fade_in_music($music, -1, 500);
    }

SDL also has callbacks for when the music ends if you want to play
random tracks instead of just repeating the same track over and over.
