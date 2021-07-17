#! /usr/bin/python3

import sys 
import re

if len(sys.argv) < 3:
    sys.exit("args")

if re.match(r'.*\.csv', sys.argv[1]) is None:
    sys.exit("Pogresna ekstenzija")

try:
    f = open(sys.argv[1], 'r')
    fajl = f.readlines()
    f.close()
except IOError:
    sys.exit("IOError")

reg = re.compile(r"^([A-Z][a-z]+\s*(?:[A-Za-z]*\s*[A-Z][a-z]*)?)"
                    + r",\s*([A-Z][a-z]+)"
                    + r",\s*([1-9]+)"
                    + r",\s*([1-9]+)"
                    + r",\s*(19[3-9][0-9]|20(?:0[0-9]|1[0-9]|2[0-1]))-(19[3-9][0-9]|20(?:0[0-9]|1[0-9]|2[0-1]))?"
                    + r",\s*([A-Z][a-z0-9]+[\sa-z\dA-Z]*"   
                    + r"(?:,\s*[A-Z][a-z\d]+[\sa-z\dA-Z]+)*)")
                    
igraci = []

for line in fajl:
    m = reg.search(line)
    if m is not None:
       # print(m.groups())
        igraci.append(m.groups())
        
if sys.argv[2] == "-g":
    igraci.sort(reverse = True, key = lambda x : int(x[2])/float(x[3]))
    for igrac in igraci:
        print("%s %.2f" % (igrac[0], int(igrac[2])/float(igrac[3])))
elif sys.argv[2] == '-t':
    
    klub = ""
    for a in sys.argv[3:]:
        klub = klub + " " + a
    #print(klub.strip())
    klub = klub.strip()
    #klub = sys.argv[3]
    for igrac in igraci:
        if klub in igrac[6]:
            print(igrac[0], igrac[4], end=" ")
            if(igrac[5] is None):
                print(2018 - int(igrac[3]))
            else:
                print(int(igrac[4]) - int(igrac[3]))
