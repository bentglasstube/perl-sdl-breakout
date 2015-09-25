# Ball Move Handler Planning

When using physical modelling, you must ensure that you don't overstep
collision when objects are moving very quickly:

![Problem with checking only at end](fig1.png)

Checking for the first collision works out most of the time, but still
has potential corner cases:

![Corner case](fig2.png)

Recursively processing the first collision and then updating to that
point should handle every case:

![Correct collision detection](fig3.png)
