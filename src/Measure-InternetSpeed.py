#!usr/bin/env python3
# Author: Aidan Neal <squidwardnose4507@gmail.com>
# Maintainer: Aidan Neal
# Contact: https://discord.gg/8wBUFeGGYC (Discord)
# Target platform(s): Windows, Linux, MacOS

""" The MIT License (MIT) <https://mit-license.org/>
Copyright © 2022 Aidan Neal

Permission is hereby granted, free of charge,
to any person obtaining a copy of this software and associated
documentation files (the “Software”), to deal in the Software
without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell copies of the Software, and to permit persons to
whom the Software is furnished to do so, subject to the
following conditions:

The above copyright notice and this permission notice shall
be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
THE USE OR OTHER DEALINGS IN THE SOFTWARE
"""

import speedtest
import urllib.request


def connect(host='https://github.com'):
  try:
    urllib.request.urlopen(host)
    return True
  except:
    return False


if connect():
  print('✅ Connected to the internet')
else:
  print('❌ Not connected to the internet!')
  exit(1)

print('Starting network speed test...')

# Get the speed test results
downloadSpeedBits = speedtest.Speedtest().download()
uploadSpeedBits = speedtest.Speedtest().upload()

# Convert the speed results into megabits then truncate the converted speed results at the decimal point
downloadSpeedFinal = int(downloadSpeedBits / 1000000)
uploadSpeedFinal = int(uploadSpeedBits / 1000000)

# Print the speed test results
print('↓ Download Speed: ' + str(downloadSpeedFinal) + ' Mb/s (Megabits per second)')
print('↑ Upload Speed: ' + str(uploadSpeedFinal) + ' Mb/s (Megabits per second)')