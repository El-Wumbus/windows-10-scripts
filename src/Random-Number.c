//\
Author: Aidan Neal <squidwardnose4507@gmail.com>\
Maintainer: Aidan Neal \
Contact: https://discord.gg/8wBUFeGGYC (Discord) \
Target platform(s): Windows\
License: (MIT)

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
THE USE OR OTHER DEALINGS IN THE SOFTWARE
*/

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include "randnum.h"

#define program_name "Random-Number"

void usage(int status)
{
  printf(("\
Exit Status: %d\n\
Usage: %s [OPTIONS] [ARGUMENTS]\n\
Options: [-c] Single command mode\n\
         [-h] display this help message\n\
Example: '%s -c 1 5'\n\
Explanation: -c takes two arguments.\n\
The first argument is the seed for the random\
number generator.\n The second is the number of random\
numbers to generate."),
         status, program_name, program_name);
  exit(status);
}

int main(int argc, char *argv[])
{
  int opt;
  while ((opt = getopt(argc, argv, "hc:")) != -1)
  {
    switch (opt)
    {
    case 'h':
      usage(0);
      return 0;
      break;
    case 'c':; // Add a semi-colon to prevent errors with varaiable declaration
      if (argc < 4)
      {
        usage(1);
        return 1;
      }

      int seed_num = atoi(argv[2]);
      int rand_nums = atoi(argv[3]);
      get_random_number(seed_num, rand_nums);
      return 0;
      break;
    case '?':
      printf("No option -? found\n");
      usage(1);
      return 1;
      break;
    }
  }
  // Only runs if no -c option supplied 
  get_random_number_interactive();
  return 0;
}