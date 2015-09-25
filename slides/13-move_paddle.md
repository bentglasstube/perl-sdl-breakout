# Paddle Move Handlers

Controls the left/right motion of the paddle and checks bounds.

    sub update {
      my ($self, $step, $app) = @_;

      $self->{x} += $step * $self->speed * $self->v_x;

      $self->{x} = max($self->x, $self->width / 2);
      $self->{x} = min($self->x, $app->width - $self->width / 2);
    }
