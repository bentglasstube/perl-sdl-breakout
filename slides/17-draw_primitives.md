# Drawing with primitives

![Primitive Drawing](fig4.png)

Primitives are basic shapes that can be drawn to the screen.  While
developing the game, I used draw functions similar to these:

## Paddle

A filled rectangle

    sub draw {
      my ($self, $app) = @_;
      $app->draw_rect($self->rect, 0xffffffff);
    }

## Ball

A filled circle

    sub draw {
      my ($self, $app) = @_;
      $app->draw_circle_filled(
        [ $self->x, $self->y ],
        $self->radius,
        0xffffffff
      );
    }

## Blocks

Determine the color from the value.

    sub draw {
      my ($self, $app) = @_;
      $app->draw_rect($self->rect, $_colors[ $self->value / 2 ]);
    }