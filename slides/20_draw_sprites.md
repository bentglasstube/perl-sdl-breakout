# Drawing with sprites

Loading the sprite:

    sub new {
      my ($class, $x, $y) = @_;

      return bless {
        x      => $x,
        y      => $y,
        dir    => 5 / 4 * PI + PI / 2 * rand,
        speed  => 0,
        radius => 8,
        sprite => SDLx::Sprite->new( image => 'ball.bmp' ),
      }, $class;
    }

Modified draw routine for the ball:

    sub draw {
      my ($self, $app) = @_;
      $self->sprite->x($self->x - $self->radius);
      $self->sprite->y($self->y - $self->radius);
      $self->sprite->draw($app);
    }
