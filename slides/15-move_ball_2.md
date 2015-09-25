# Ball Move Handler 2

Process the move only up until the first collision.  Rinse and repeat.

        # continued

        if ($best) {
          $self->{x} += $dx * $best->{t};
          $self->{y} += $dy * $best->{t};
          $best->{object}->handle_collision($self);

          if ($best->{object}->isa('Breakout::Paddle')) {
            my $offset = ($self->x - $best->{object}->x) * 2 / $best->{object}->width;
            $self->{dir} = (18 + 3 * $offset) * PI / 12;
          } else {
            $self->{dir} = ($best->{dir} eq 'h' ? 3 : 2) * PI - $self->dir;
          }

          $step *= 1 - $best->{t};
        } else {
          $self->{x} += $dx;
          $self->{y} += $dy;
          $step = 0;
        }
      }
    }
