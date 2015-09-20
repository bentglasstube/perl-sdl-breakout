# Blocks

Represents the blocks in the game field that are destroyed by the ball.
They have the following attributes:

  * `rect` - An `SDLx::Rect` representing the position of the block
  * `type` - The block type, which controls its behavior
  * `hits` - The number of times the block has been hit

The following types of block exist:

  * Normal - destroyed in a single hit
  * Glass  - requires multiple hits to destroy
  * Metal  - indestructable
