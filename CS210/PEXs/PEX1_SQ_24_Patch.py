#!/usr/bin/env python

"""
Scheduled Work Hours: Friday(8/26) during T4, Monday(8/29) during M6, Tuesday(8/30) during T4

EXPLAIN THE PROBLEM
Using turtles, create a program which draws a semblance of CS-24's patch. Must create triangle containing the number 24
using curved line for the 2, and fill with squad color (blue triangle fill, yellow pen color for 24)

Documentation Statement:
None
"""
# =====================================================================

# Modules used for this program; built-in modules first, followed by
# third-party modules, followed by any changes to the path and your own modules
import math
from turtle import TurtleScreen, RawTurtle, TK

# Metadata
__author__ = "Mark Demore"
__email__ = "C19Mark.Demore@usafa.edu"
__date__ = "Aug 25, 2016"

# Constants
CANVAS_WIDTH = 600
CANVAS_HEIGHT = int(CANVAS_WIDTH * 9 / 16)  # Produces the eye-pleasing 16:9 HD aspect ratio.

# Create a Tkinter graphics window
graphics_window = TK.Tk()
graphics_window.title("WINDOW NAME")

# Create a "canvas" inside the graphics window to draw on
my_canvas = TK.Canvas(graphics_window, width=CANVAS_WIDTH, height=CANVAS_HEIGHT)
my_canvas.pack()  # Organizes my_canvas inside the graphics window

# Create a "canvas" made specifically for turtle graphics
turtle_canvas = TurtleScreen(my_canvas)
turtle_canvas.bgcolor("white")

# Create a turtle to draw on the canvas
sammy = RawTurtle(turtle_canvas)

# If you want the drawing to be as fast as possible, uncomment these lines
# turtle_canvas.delay(0)
# sammy.hideturtle()
# sammy.speed("fastest")

# Draw squadron NN patch (your code goes here)

#get turtle in position for first side of triangle
sammy.up()
sammy.left(90)
sammy.forward(50)
sammy.right(90)

#draw first side of triangle
sammy.down()
sammy.forward(75)
sammy.backward(150)

#draw second side of triangle
sammy.left(300)
sammy.forward(150)

#draw final side of triangle
sammy.left(120)
sammy.forward(150)

#setup and draw the 2
sammy.up()
sammy.setposition(0,0)
sammy.down()
sammy.circle(25,150)

# Keep the window open until the user closes it.
TK.mainloop()
