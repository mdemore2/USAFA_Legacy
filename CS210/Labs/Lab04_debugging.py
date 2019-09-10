#!/usr/bin/env python

"""
Lab04 - Practice debugging a program to find ParseErrors, TypeErrors,
        NameErrors, and ValueErrors.

Documentation Statement: (none)

"""
# =====================================================================

# Modules used for this program; built-in modules first, followed by
# third-party modules, followed by any changes to the path and your own modules
import math

# Metadata
__author__ = "Mark Demore"
__email__ = "c19mark.demore@usafa.edu"
__date__ = "Aug 19, 2016"

# Constants
N = 3

# Get three numbers from the user
n1 = float(input("First number : "))  #parse all input vars
n2 = float(input("Second number: "))
n3 = float(input("Third number: ")) #change to "third number"

# Calculate properties of the three numbers
sum = n1 +n2 + n3
average = sum / 3 #change from integer division
variance = (average - n1) ** 2 + (average - n2) ** 2 + (average - n3) ** 2 #was multiplying by 2 instead of squaring
standard_deviation = math.sqrt(variance)
population_standard_deviation = math.sqrt(variance / N) #spell variance correctly
sample_standard_deviation = math.sqrt(variance / (N-1)) #added parentheses around n-1
minimum = min(n1, n2, n3) #change from n4 to n3
maximum = max(n1, n2, n3)

# Display the results
print("The inputs were: ", n1, n2, n3)
print("Their average is", average)
print("Their standard deviation is", standard_deviation)
print("Their population standard deviation is", population_standard_deviation)
print("Their sample standard deviation is", sample_standard_deviation)
print("Their minimum value is", minimum)
print("Their maximum value is", maximum)

# Make a list of the errors you found.
# Include the line number, the type of error, and how you fixed it.
"""
line 25: parse inputs to float
line 27: change to "third" number
line 31: change from int division to just division
line 32: was multiplying by 2 instead of squaring, add asterisk
line 34: spell variance correctly
line 35: added parentheses around denominator
line 36: change from n4 to n3
"""