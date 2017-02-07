#!/usr/bin/env python

import csv
import sys
import md5


if(len(sys.argv) != 3):
    print("failed")
    exit(2)


with open(sys.argv[1], 'r') as passwords:
    with open(sys.argv[2], 'wb') as hashes:
        writer = csv.writer(hashes, delimiter=' ')
        for line in passwords:
            hashed = md5.new(str(line.strip())).hexdigest()
            writer.writerow([hashed])
