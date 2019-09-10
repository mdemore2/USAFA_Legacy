### C2C Mark Demore II

### ECE382

###
# Assignment 7 - Pong

### Collide Functionality

**xMin**

![xminb](images/detectXMin.png)
Figure 1: xMin before Detection

![xmina](images/detectXMin_after.png)
Figure 2: xMin after Detection

As shown by Figures 1 and 2, the collision detection function works for the left edge (x < 0) of the screen. The x position is off the screen beforehand, but after detection the velocity is changed and position is updated.

**xMax**

![xmaxb](images/detectXMax.png)
Figure 3: xMax before Detection


![xmaxa](images/detectXMax_after.png)
Figure 4: xMax after Detection

As shown by Figures 3 and 4, the collision detection function works for the right edge (x > 240) of the screen. The x position is off the screen beforehand, but after detection the velocity is changed and position is updated.

**yMin**

![yminb](images/detectYMin.png)
Figure 5: yMin before Detection


![ymina](images/detectYMin_after.png)
Figure 6: yMin after Detection

As shown by Figures 5 and 6, the collision detection function works for the bottom edge (y < 0) of the screen. The y position is off the screen beforehand, but after detection the velocity is changed and position is updated.

**yMax**

![ymaxb](images/detectYMax.png)
Figure 7: yMax before Detection


![ymaxa](images/detectYMax_after.png)
Figure 8: yMax after Detection

As shown by Figures 7 and 8, the collision detection function works for the top edge (y > 330) of the screen. The y position is off the screen beforehand, but after detection the velocity is changed and position is updated.

### Questions

**How did you verify your code functions correctly?**
I tested the collision function for all four edges by changing the initial velocity for the ball in the main function and looping though updateBall until a breakpoint was triggered in the detectCollide function. Once the collision was detected, I stepped through the remaining few lines until the ball was updated again to make sure the values were corrected accordingly.

**How could you make the "collision detection" helper functions only visible to your implementation file (i.e. your main.c could not call those functions directly)?**
Do not use #include for the implementation file (or specifically that function) in the main file.