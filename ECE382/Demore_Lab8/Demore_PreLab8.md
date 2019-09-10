##Demore - Pre-Lab 8

####Psuedocode

    main:
    while(1)
        moveForward
        while(wall = absent)
            checkWall
        stop
        centerWall = true
        wall = absent
        sensorLeft
        checkWall
        if(wall = present)
            turnRight
        else
            turnLeft
    
    