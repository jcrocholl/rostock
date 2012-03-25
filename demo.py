#!/usr/bin/python

import math


class Vector(object):

    def __init__(self, x, y, z):
        self.x = x
        self.y = y
        self.z = z

    def __abs__(self):
        return math.sqrt(self.x * self.x +
                         self.y * self.y +
                         self.z * self.z)

    def __add__(self, other):
        return Vector(self.x + other.x,
                      self.y + other.y,
                      self.z + other.z)

    def __sub__(self, other):
        return Vector(self.x - other.x,
                      self.y - other.y,
                      self.z - other.z)

    def __mul__(self, factor):
        return Vector(self.x * factor,
                      self.y * factor,
                      self.z * factor)

    def gcode(self):
        return 'X%.3f Y%.3f Z%.3f' % (self.x, self.y, self.z)


SIN_60 = math.sin(math.pi / 3)
COS_60 = 0.5

RADIUS = 150 - 33 - 15
TOWER_1 = Vector(0, RADIUS, 0)
TOWER_2 = Vector(SIN_60 * RADIUS, -COS_60*RADIUS, 0)
TOWER_3 = Vector(-SIN_60 * RADIUS, -COS_60*RADIUS, 0)


def delta(v):
    t1 = TOWER_1 - v
    t2 = TOWER_2 - v
    t3 = TOWER_3 - v
    return Vector(
        400 - v.z - math.sqrt(250*250 - t1.x*t1.x - t1.y*t1.y),
        400 - v.z - math.sqrt(250*250 - t2.x*t2.x - t2.y*t2.y),
        400 - v.z - math.sqrt(250*250 - t3.x*t3.x - t3.y*t3.y))


def linear(start, stop, speed):
    steps = max(1, int(abs(stop - start) * 50 / min(speed, 200)))
    for step in range(steps):
        d = delta(start + (stop - start) * (float(1 + step) / steps))
        print 'G1', d.gcode()


print 'G21 ; set units to millimeters'
print 'G90 ; use absolute positioning'
print 'G28 ; move to origin'
# print 'G92', delta(Vector(0, 0, 0)).gcode()

SIZE = 80

previous = Vector(0, 0, 0)
print 'G1 F3000'

speeds = [100, 200, 300, 400, 500, 600]
for speed in speeds:
    print 'G1 F%d' % (speed * 60)
    z = (speed - 100) / 5
    for a in range(0, 720, 5):
        vector = Vector(math.sin(a * math.pi / 180) * SIZE,
                        math.cos(a * math.pi / 180) * SIZE, z)
        linear(previous, vector, speed)
        previous = vector

# linear(previous, Vector(0, 0, 0), 300)
print 'G1 X30 Y30 Z30'
print 'M84 ; all motors off'
