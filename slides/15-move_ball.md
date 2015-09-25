# Ball Move Handler 1

![Collision diagram](fig1.png)

First, find the next collision

    sub update() {
      my ($self, $step, $app, @objects) = @_;

      push @objects, Breakout::Wall->new(-10, 0, 10, $app->height);
      push @objects, Breakout::Wall->new($app->width, 0, 10, $app->height);
      push @objects, Breakout::Wall->new(0, -10, $app->width, 10);

      while ($step > 0) {
        my $dx = cos($self->dir) * $step * $self->speed;
        my $dy = sin($self->dir) * $step * $self->speed;

        my $best;

        foreach my $object (@objects) {
          if (my $collision = $self->_collide($dx, $dy, $object)) {
            if (not defined $best or $best->{t} > $collision->{t}) {
              $best = $collision;
            }
          }
        }

        # continued
