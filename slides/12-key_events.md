# Keyboard Events

    sub key_press {
      my ($self, $key) = @_;

      given ($key) {
        when (SDLK_a) {
          $self->paddle->move(-1);
        }

        when (SDLK_d) {
          $self->paddle->move(1);
        }

        when ([SDLK_ESCAPE]) {
          $self->{lives} = 0;
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

