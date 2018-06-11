#!/usr/bin/env python

import json

fields = ["mpg", "cylinders", "displacement", "horsepower", "weight", "acceleration", "model year", "origin", "car name"]

for line in open("auto-mpg.data", "r"):
    rest, last = line.split("\t")
    d = {k: v for (k, v) in zip(fields, rest.split() + [last.strip()[1:-1]]) if v != '?'}
    for k in fields[:-1]:
        if k in d:
            d[k] = '.' in d[k] and float(d[k]) or int(d[k])
    print(json.dumps(d))
