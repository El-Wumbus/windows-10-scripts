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

#include <windows.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define program_name "Get-File"
#define program_author "Aidan Neal"

void usage(int status)
{
  printf(("\
Exit Status: %d\n\
Usage: %s [url] [output_file]\n"),
         status, program_name);
  exit(0);
}

int main(int argc, char **argv)
{
  int opt;
  while ((opt = getopt(argc, argv, "h")) != -1)
  {
    switch (opt)
    {
    case 'h':
      usage(0);
      return 0;
      break;
    case '\?':
      usage(1);
      return 1;
      break;
    }
  }
  // If there's enough arguments
  if (argc > 1)
  {
    char buffer[512];

    HRESULT dl;

    // A bunch of stupid windows things
    typedef HRESULT(WINAPI * URLDownloadToFileA_t)(LPUNKNOWN pCaller, LPCSTR szURL, LPCSTR szFileName, DWORD dwReserved, void *lpfnCB);
    URLDownloadToFileA_t xURLDownloadToFileA;
    xURLDownloadToFileA = (URLDownloadToFileA_t)GetProcAddress(LoadLibraryA("urlmon"), "URLDownloadToFileA");

    dl = xURLDownloadToFileA(NULL, argv[1], argv[2], 0, NULL);

    sprintf(buffer, "Downloading File From: %s, To: %s", argv[1], argv[2]);

    if (dl == S_OK)
    {
      sprintf(buffer, "\
File Successfully Downloaded To: %s\n",
              argv[2]);
      printf(buffer);
    }
    else if (dl == E_OUTOFMEMORY)
    {
      sprintf(buffer, "\
Failed To Download File.\n\
Reason: Insufficient Memory\n");
      printf(buffer);
      return 0;
    }
    else
    {
      sprintf(buffer, "\
Failed To Download File.\n\
Reason: Unknown\n");
      printf(buffer);
      return 0;
    }
  }

  else
  {
    usage(1);
    return (1);
  }
}