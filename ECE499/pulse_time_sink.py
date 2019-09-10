#!/usr/bin/env python
# -*- coding: utf-8 -*-
# 
# Copyright 2017 <+YOU OR YOUR COMPANY+>.
# 
# This is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3, or (at your option)
# any later version.
# 
# This software is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this software; see the file COPYING.  If not, write to
# the Free Software Foundation, Inc., 51 Franklin Street,
# Boston, MA 02110-1301, USA.
# 

import numpy
import time
import datetime
from gnuradio import gr

class pulse_time_sink(gr.sync_block):
	"""
    docstring for block pulse_time_sink
    """
	def __init__(self, sample_rate, min_samples, max_samples):
		gr.sync_block.__init__(self,
							   name="pulse_time_sink",
							   in_sig=[numpy.float32],
							   out_sig=None)
		self.sample_rate = sample_rate
		self.min_samples = min_samples
		self.max_samples = max_samples


	def work(self, input_items, output_items):
		# we import the Twilio client from the dependency we just installed
		from twilio.rest import Client

		# the following line needs your Twilio Account SID and Auth Token
		client = Client("AC2c1880623b8366f1b08d6bc2e28d16f4", "aa863c327682ac4fceed5ca764f092da")



		i = 0	#increment through input
		samps = 0	#number of current positive samples
		test = [0,0,0,0,0,1,1,1,1,1]	#list for sliding average to deal with potential drops below threshold for a sample
		test_inc = 0			#increment through sliding avg
		sum_test = 0
		time_stamp = datetime.datetime.now()
		time_print = time_stamp.strftime("%c")
		f = open('time_verify_test.txt','w')
		for i in input_items:
			for item in i:
				#sliding average - look at 10 samps, if avg < 1/2 disregard, else count as all 1
				test[test_inc] = int(item)
				test_inc += 1
				if(test_inc > 9):
					test_inc = 0
				for x in test:
					sum_test += x
				sum_test = sum_test * 2
				if (sum_test >= 10):
					samps += 1 #if within tolerance, count as positive sample, add to total
				#can test for positives here
				if(samps > self.min_samples):
					if(samps < self.max_samples):
						f.write(time_print + '\n')
						# change the "from_" number to your Twilio number and the "to" number
						# to the phone number you signed up for Twilio with, or upgrade your
						# account to send SMS to any phone number
						client.messages.create(to="+14124455982",
											   from_="+14124670832",
											   body=time_print)
		f.close()
		return(input_items[0])

