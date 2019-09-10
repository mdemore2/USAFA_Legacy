#!/usr/bin/env python

"""
Lab05 - Learning turtle graphics.
"""
# =====================================================================

# Modules used for this program; built-in modules first, followed by
# third-party modules, followed by any changes to the path and your own modules
import math
from turtle import TurtleScreen, RawTurtle, TK
# Metadata
__author__ = "Mark Demore"
__email__ = "C19Mark.Demore@usafa.edu"
__date__ = "Aug 23, 2016"

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
# Problems 2
# Turtle objects have methods and attributes. For example, a turtle has
# a position and when you move the turtle forward, the position changes.
# Think about the other methods shown in the summary above
# (http://interactivepython.org/runestone/static/USAFA_CS210_2016/PythonTurtle
# /SummaryofTurtleMethods.html). Which attributes, if any, does each
# method relate to? Does the method change the attribute?
#----------------------------------------------------------------------

# Answer: forward - position - increments
#          backward - position - decrements
#           right - heading - decrements
#           left - heading - increments
#           up - draw - disables
#           down - draw - enables
#           color - color - sets
#           fillcolor - fill color - sets
#           heading - heading - gets
#           position - position - gets
#           goto - position - sets
#           begin_fill - fill - sets start
#           end_fill - fill - sets end
#           dot - draw - draws dot
#           stamp - draw - draws turtle
#           shape - draw - draws shape

# #----------------------------------------------------------------------
# Problems 3
# Write a program that uses a for loop to print
#   One of the months of the year is January
#   One of the months of the year is February
#   One of the months of the year is March
#   etc ...
#----------------------------------------------------------------------

# months = {1:"January",2:"February",3:"March",4:"April",5:"May",6:"June",7:"July",8:"August",9:"September",10:"October",11:"November",12:"December"}
# for i in months:
#     print("One of the months of the year is ", months[i])
#

#----------------------------------------------------------------------
# Problems 4
# Assume you have a list of numbers 12, 10, 32, 3, 66, 17, 42, 99, 20
#
#    Write a loop that prints each of the numbers on a new line.
#    Write a loop that prints each number and its square on a new line.
#----------------------------------------------------------------------

# nums=[12,10,32,3,66,17,42,99,20]
# for j in nums:
#     print("\n",j)
# for k in nums:
#     print("\n",k,k**2)

#----------------------------------------------------------------------
# Problems 5
# Use for loops to make a turtle draw these regular polygons (regular
# means all sides the same lengths, all angles the same):
#
#   An equilateral triangle
#   A square
#   A hexagon (six sides)
#   An octagon (eight sides)
#----------------------------------------------------------------------

# for i in range(3):
#     mary.forward(50)
#     mary.left(120)
#
# for j in range(4):
#     mary.forward(50)
#     mary.left(90)
#
# for k in range(6):
#     mary.forward(50)
#     mary.left(60)
#
# for l in range(8):
#     mary.forward(50)
#     mary.left(45)


#----------------------------------------------------------------------
# Problems 7
# A drunk pirate makes a random turn and then takes 100 steps forward,
# makes another random turn, takes another 100 steps, turns another
# random amount, etc. A social science student records the angle of
# each turn before the next 100 steps are taken. Her experimental data
# is 160, -43, 270, -97, -43, 200, -940, 17, -86.(Positive angles are
# counter-clockwise.) Use a turtle to draw the path taken by our
# drunk friend. After the pirate is done walking, print the current
# heading.
#----------------------------------------------------------------------

# direction=[160,-43,270,-97,-43,200,-940,17,-86]
# for i in direction:
#     mary.left(i)
#     mary.forward(100)
# print("Final heading: ",mary.heading())

#----------------------------------------------------------------------
# Problems 8
# On a piece of scratch paper, trace the following program and show the
# drawing. When you are done, un-comment the code and execute it to check
# your answer.
#----------------------------------------------------------------------

# tess = RawTurtle(turtle_canvas)
# tess.right(90)
# tess.left(3600)
# tess.right(-90)
# tess.left(3600)
# tess.left(3645)
# tess.forward(-100)

#----------------------------------------------------------------------
# Challenge Problems 1
# Implement a loop within a loop that draws the pattern shown in the Lab05
# description. It is created by drawing a set of square where each square
# is orientated 30 degrees from the previous square.
#----------------------------------------------------------------------

for i in range(4):
    mary.forward(25)
    mary.left(90)
    mary.forward(50)
    mary.left(90)
    mary.forward(25)
    mary.left(90)
    mary.forward(25)
    mary.left(90)
    mary.forward(50)

    for j in range(4):
        mary.forward(50)
        mary.left(90)

    mary.up()
    mary.setpos(0, 0)
    mary.down()
    mary.right(22.5)

#----------------------------------------------------------------------
# Challenge Problem 2
# Implement a program to draw the pattern shown in the Lab05 description.
#----------------------------------------------------------------------


# Keep the window open until the user closes it.
TK.mainloop()