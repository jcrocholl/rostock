#!/usr/bin/python
#
# Convert G-code from slic3r to deltacode for Rostock 3D printer.
#
# Deltacode is similar to G-code but with delta geometry for X Y Z.
# Straight lines in G-code are translated to parabolic curves in
# deltacode.  These curves are made from many small linear G1
# moves. This may double the size of the G-code file. In the future
# this translation will be implemented in firmware so we can send
# normal G-code to the delta bot.

__author__ = 'johann@rocholl.net'

CENTER = {'X': 100, 'Y': 100}

import math
import sys


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
        return 'X%.8g Y%.8g Z%.8g' % (self.x, self.y, self.z)


SIN_60 = math.sin(math.pi / 3)
COS_60 = 0.5

RADIUS = 175 - 33 - 18  # Horizontal distance of diagonal rods when centered.
ZERO_OFFSET = -9  # Print surface is lower than bottom endstops.

TOWER_1 = Vector(-SIN_60 * RADIUS, -COS_60*RADIUS, 0)
TOWER_2 = Vector(SIN_60 * RADIUS, -COS_60*RADIUS, 0)
TOWER_3 = Vector(0, RADIUS, 0)


def delta(v):
    t1 = TOWER_1 - v
    t2 = TOWER_2 - v
    t3 = TOWER_3 - v
    return Vector(
        v.z + math.sqrt(250*250 - t1.x*t1.x - t1.y*t1.y) + ZERO_OFFSET,
        v.z + math.sqrt(250*250 - t2.x*t2.x - t2.y*t2.y) + ZERO_OFFSET,
        v.z + math.sqrt(250*250 - t3.x*t3.x - t3.y*t3.y) + ZERO_OFFSET)


def G1(pos, dest):
    """Convert a long linear cartesian move into many small moves."""
    global num_lines

    for char in 'XYZEF':
        if char not in dest:
            dest[char] = pos[char]

    start = Vector(pos['X'], pos['Y'], pos['Z'])
    finish = Vector(dest['X'], dest['Y'], dest['Z'])

    cartesian_mm = abs(finish - start)
    steps = max(1, int(5 * cartesian_mm))
    cartesian_mm /= steps

    previous = delta(start)
    previous_e = 'E%.8g' % pos['E']
    previous_f = 'F%.5g' % pos['F']
    for step in range(steps):
        fraction = float(step + 1) / steps
        d = delta(start + (finish - start) * fraction)
        print 'G1', d.gcode(),
        # Extruder steps.
        e = pos['E'] + (dest['E'] - pos['E']) * fraction
        e = 'E%.8g' % e
        if e != previous_e:
            previous_e = e
            print e,
        # Feedrate needs to be adjusted for delta geometry.
        f = pos['F'] + (dest['F'] - pos['F']) * fraction
        if abs(cartesian_mm) > 0.1:
            delta_mm = abs(d - previous)
            f *= delta_mm / cartesian_mm
        f = 'F%.5g' % f
        if f != previous_f:
            previous_f = f
            print f,
        print
        previous = d
        num_lines += 1

    for char in 'XYZEF':
        pos[char] = dest[char]



def G28(pos, dest):
    """Home all axes."""
    if 'X' in dest:
        pos['X'] = -100 * SIN_60
        pos['Y'] = 100 * COS_60
        pos['Z'] = 0
    if 'Y' in dest:
        pos['X'] = 100 * SIN_60
        pos['Y'] = 100 * COS_60
        pos['Z'] = 0
    if 'Z' in dest or not dest:
        pos['X'] = 0
        pos['Y'] = 100
        pos['Z'] = 0


pos = {}
for char in 'XYZEF':
    pos[char] = 0.0

num_lines = 0
for line in sys.stdin:
    words = line.split()
    if not words:
        print
        continue
    dest = {}
    for word in words[1:]:
        if word.startswith(';'):
            break
        for char in 'XYZF':
            if word.startswith(char):
                dest[char] = float(word[1:]) - CENTER.get(char, 0)
    if words[0] == 'G1':
        print ';', line.strip()
        G1(pos, dest)
        if num_lines > 10000:
            sys.exit(0)
    elif words[0] == 'G28':
        G28(pos, dest)
        print line.strip()
    else:
        print line.rstrip()
