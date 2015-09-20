# Move Handlers

## Paddle

    sub update {
      my ($self, $step, $app) = @_;

      $self->{x} += $step * $self->speed * $self->v_x;

      $self->{x} = max($self->x, $self->width / 2);
      $self->{x} = min($self->x, $app->width - $self->width / 2);
    }

## Powerups

TODO: Not yet implemented
