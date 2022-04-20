//\
Author: Aidan Neal <squidwardnose4507@gmail.com>\
Maintainer: Aidan Neal \
Contact: https://discord.gg/8wBUFeGGYC (Discord) \
Target platform(s): Windows

/* The MIT License (MIT) <https://mit-license.org/>
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
THE USE OR OTHER DEALINGS IN THE SOFTWARE*/

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

#define program_name "Hello-World"

void usage(int status)
{
  if (status)
  {
    printf(("\
ERROR:\n\
Usage: %s\n"),
           program_name);
    exit(1);
  }

  else
  {
    printf(("\
    Usage: %s\n"),
           program_name);
    exit(0);
  }
}

int main(int argc, char *argv[])
{
  // Get options and show help\
  using the usage function when\
  the 'h' flag is used

  int opt;
  while ((opt = getopt(argc, argv, "h")) != -1)
  {
    switch (opt)
    {
    case 'h':
      usage(0);
      break;
    }
  }

  printf("Hello World");
  return 0;
}