# Sound Effects

The `SDLx::Sound` package exists ostensibly to ease with sound effect
playback, but it seems to be very early in development and it was not
very easy to use.

    package Breakout::Audio;

    ...

    sub new {
      my ($class) = @_;
      SDL::Mixer::open_audio(44100, AUDIO_S16, 2, 1024);
      return bless {}, $class;
    }

    sub play {
      my ($self, $name) = @_;
      SDL::Mixer::Channels::play_channel(-1, $self->_load_sample($name), 0);
    }

    sub _load_sample {
      my ($self, $name) = @_;
      return $self->{s}{$name} //= SDL::Mixer::Samples::load_WAV($name);
    }

    1;
