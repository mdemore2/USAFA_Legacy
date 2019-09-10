#!/usr/bin/env python

"""
Lab06 - Learn more about turtle graphics and problem solving.
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
graphics_window.title("Lab 5 Problems")

# Create a "canvas" inside the graphics window to draw on
my_canvas = TK.Canvas(graphics_window, width=CANVAS_WIDTH, height=CANVAS_HEIGHT)
my_canvas.pack()  # Organizes my_canvas inside the graphics window

# Create a "canvas" made specifically for turtle graphics
turtle_canvas = TurtleScreen(my_canvas)
turtle_canvas.bgcolor("white")

# Create a turtle to draw on the canvas
mary = RawTurtle(turtle_canvas)

#----------------------------------------------------------------------
# Problems 1
# Write a program that prints "We like Python's turtles!" 1000 times.
#----------------------------------------------------------------------

# for i in range(1000):
#         print("We like Python's turtles!")

# ----------------------------------------------------------------------
# Problems 6
# Write a program that asks the user for the number of sides, the length
# of the side, the color, and the fill color of a regular polygon. The
# program should draw the polygon and then fill it in.
# ----------------------------------------------------------------------

# sides = int(input("Number of sides?"))
# length = int(input("Length of side?"))
# clr_side = input("Color of side?")
# clr_fill = input("Fill color?")
#
# angle = 360/sides
#
# mary.pencolor(clr_side)
# mary.fillcolor(clr_fill)
# mary.begin_fill()
#
# for i in range(sides):
#     mary.forward(length)
#     mary.left(angle)
#
# mary.end_fill()

#----------------------------------------------------------------------
# Problems 9
# Write a program to draw a 5 sided star. See the problem in the textbook
# for an example figure. Hint: The angle formed by each point of the star
# is 36 degrees. (It is also possible to draw a 10 pointed star with an
# angle of 72 degrees at each point.
#----------------------------------------------------------------------

# angle = 180+36
# for i in range(5):
#     mary.forward(50)
#     mary.left(angle)

#----------------------------------------------------------------------
# Problems 10
# Draw an image of a clock face, where each "number" on the clock face
# is a stamp of a turtle. Refer to problem 10 in the textbook for an
# example image.
#----------------------------------------------------------------------

# mary.up()
# angle = 360/12
# for i in range(12):
#     mary.forward(100)
#     mary.stamp()
#     mary.backward(100)
#     mary.left(angle)

#----------------------------------------------------------------------
# Problems 11
# Write a program to draw some kind of picture. Be creative and experiment
# with the turtle methods provided in Summary of Turtle Methods.
#----------------------------------------------------------------------

# mary.up()
# mary.setposition(0,-100)
# mary.down()
#
# mary.circle(100)
# mary.up()
# mary.setposition(0,0)
#
# mary.forward(50)
# mary.left(90)
# mary.forward(50)
# mary.stamp()
#
# mary.setposition(0,0)
# mary.left(90)
# mary.forward(50)
# mary.right(90)
# mary.forward(50)
# mary.stamp()
#
# mary.setposition(0,0)
# mary.left(90)
# mary.down()
# mary.forward(75)
# mary.backward(150)

#----------------------------------------------------------------------
# Problems 12
# Create a turtle and assign it to a variable. When you print its type,
# what do you get?
#----------------------------------------------------------------------

# new_var= mary
# print(type(new_var))

#----------------------------------------------------------------------
# Problems 13
# A sprite is a simple spider shaped thing with n legs coming out from
# a center point. The angle between each leg is 360 / n degrees. Write
# a program to draw a sprite where the number of legs is provided by the
# user.
#----------------------------------------------------------------------

# num_legs=int(input("How many legs?"))
# angle=360/num_legs
#
# mary.stamp()
# for i in range(num_legs):
#     mary.forward(50)
#     mary.backward(50)
#     mary.left(angle)

#----------------------------------------------------------------------
# Challenge Problem 1
# Copy and paste your code from problem 9 that draws a 5-point star and
# modify it to draw a star of any size based on a variable called "size".
# Then modify it to draw the star centered at the current location.
# Now draw multiple stars in multiple locations of different sizes on
# the canvas.
#----------------------------------------------------------------------
# size=10
# angle = 180+((360/50)*size)
#
# for i in range(size):
#     mary.forward(50)
#     mary.left(angle)

# Keep the window open until the user closes it.
TK.mainloop()