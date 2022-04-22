#include <iostream>
#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <cstring>
#define program_author "Aidan Neal"

int main(int argc, char *argv[])
{
  char pkglist[100];
  char command;
  for (int i = 1; i < argc; i++)
  {
    strcpy(pkglist[(i - 1)], argv[i]);
    char sys_command = "winget install" + pkglist[i - 1];
    strcpy(command, "winget install %s", pkglist[i-1]);
    system(command);
  }
}