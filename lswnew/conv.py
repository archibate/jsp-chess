#!/usr/bin/env python

import sys

for path in sys.argv[1:]:
    with open(path, 'r') as f:
        lines = f.readlines()

    with open(path, 'w') as f:
        for line in lines:
            line = line.replace('\r', '').replace('\n', '')
            print(line, file=f)
