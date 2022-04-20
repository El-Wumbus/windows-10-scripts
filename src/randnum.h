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

#ifndef HEADER_FILE
#define HEADER_FILE
#include <stdio.h>
#include <stdlib.h>

void get_random_number(int seed_num, int rand_nums)
{
  //seed rand()
  srand(seed_num);

  // Loop and generate random numbers
  for (int i = 0; i < rand_nums; i++)
  {
    printf(" %d ", rand());
  }
  printf("\n");
}

void get_random_number_interactive()
{
  int seed_num;
  int rand_nums;

  // Read seed and ammount of numbers
  printf("Enter a seed value:");
  scanf("%d", &seed_num);
  printf("How many numbers?:");
  scanf("%d", &rand_nums);

  // Seed rand()
  srand(seed_num);

  // Loop and generate random numbers
  for (int i = 0; i < rand_nums; i++)
  {
    printf(" %d ", rand());
  }
  printf("\n");
}

#endif