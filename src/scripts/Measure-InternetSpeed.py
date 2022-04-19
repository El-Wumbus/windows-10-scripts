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