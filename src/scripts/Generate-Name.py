# Author: Aidan Neal <squidwardnose4507@gmail.com>
# Maintainer: Aidan Neal
# Contact: https://discord.gg/8wBUFeGGYC (Discord)
# Target platform(s): Windows, Linux, MacOS
import names
from sys import argv,exit
import getopt

if len(argv) > 1:
  argumentOne = int(argv[1])
    
else:
  argumentOne = 1

if argumentOne > 0:
  for i in range(argumentOne):
    print(names.get_full_name())

exit