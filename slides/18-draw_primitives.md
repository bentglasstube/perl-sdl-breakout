# Drawing with Primitives

The ball is simply a filled circle:

    sub draw {
      my ($self, $app) = @_;
      $app->draw_circle_filled([ $self->x, $self->y ], $self->radius, 0xffffffff);
    }

The paddle is simply a filled rectangle:

    sub draw {
      my ($self, $app) = @_;
      $app->draw_rect($self->rect, 0xffffffff);
    }

For the blocks, use the value to determine the color:

    sub draw {
      my ($self, $app) = @_;
      $app->draw_rect($self->rect, $_colors[ $self->value / 2 ]);
    }

