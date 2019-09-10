#Pre-Lab:

##Software flowchart and/or pseudo-code

**Which pins will output which signals you need?**<br>
        Pins 3, 4, 8, and 9 (TA 0.0, 0.1, 1.0, and 1.1 respectively)<br><br>
**Which side of the motor will you attach these signals to?**<br>
        I will attach the signals to the terminal that will drive the wheels forward (in reference to the ultrasonic sensor). If initially the wheels spin backwards, I will reverse the terminal connections.<br><br>
**How will you use these signals to achieve forward / back / left / right movement?**<br>
        The 4 output PWM signals will be associated with forward and backward on the left and right wheels independently. To move forward and backward, the wheels will both move in the same direction at the same speed. Left and right turns will be handled by driving the left and right motors at different speeds.<br><br>

**What are the registers you'll need to use?**<br>
    TACCTL0, TACCTL1, TACCR0, TACCR1 <br><br>
**Which bits in those registers are important?**<br>
    TACCTLx - BIT15-14 (CMx), BIT13-12 (CCISx), BIT11 (SCS), BIT8 (CAP), BIT3 (CCI), BIT0 (CCIFG)    TACCRx - BIT15-0<br><br>
**What's the initialization sequence you'll need?**<br>
    1) Set I/O direction (MUX PWM)
    2) Set period
    3) set duty cycle
    4) Enable PWM mode on timer
    5) Configure and start timer<br>

![Schematic](images/Demore_lab6Schematic.png)
Figure 1: Lab 6 Schematic<br>

**Do you want to move each motor invidiually (moveLeftMotorForward())? Or do you want to move them together (moveRobotForward())?**<br>
    Moving each motor individually will make code more flexible and reusable when implementing turning functionality. <br><br>

#####Psuedocode

    Main:
        call initPWM
        call moveForward
        call stop
        call moveBackward
        call stop
        call turnLeft
        call stop
        call turnRight
        call stop
        
    initPWM:
        Initialize PWM signal using steps above

    moveForward:
        set duty cycle for TA0.0 and TA1.0 (left and right positive) to 75%
        
    stop:
        set duty cycle for Timer A (all outputs) to 0%
        
    moveBackward:
        set duty cycle for TA0.1 and TA1.1 (left and right negative) to 75%
        
    turnLeft:
        set duty cycle for TA0.0 (left positive) to 50%
        
    turnRight:
        set duty cycle for TA1.0 (right positive) to 50%