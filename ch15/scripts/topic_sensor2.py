#!/usr/bin/env python
#-*- coding: utf-8 -*-
# github에 저장된 코드를 일부 수정하여 동작 가능하게 하였음.

from math import pi

from fake_sensor import FakeSensor

import rospy
import tf
from time import sleep  # added

from geometry_msgs.msg import Quaternion


def make_quaternion(angle):
    q = tf.transformations.quaternion_from_euler(0, 0, angle)
    return Quaternion(*q)

def publish_value(value):
    angle = value * 2 * pi / 100.0
    q = make_quaternion(angle)
    pub.publish(q)

    
if __name__ == '__main__':
    rospy.init_node('fake_sensor')

    pub = rospy.Publisher('angle', Quaternion, queue_size=10) 

    sensor = FakeSensor()
    sleep(1)  # added
    sensor.sensor.register_callback(publish_value)  # modified

    rospy.spin()  # added
