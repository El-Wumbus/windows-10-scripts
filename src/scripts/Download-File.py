# Author: Aidan Neal <squidwardnose4507@gmail.com>
# Maintainer: Aidan Neal
# Contact: https://discord.gg/8wBUFeGGYC (Discord)
# Target platform(s): Windows, Linux, MacOS
import os
from sys import argv,exit
from getopt import getopt
from download import download as dl


class colors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'


def throw(text):
    print(f"{colors.FAIL} {text} {colors.ENDC}")


def warn(text):
    print(f"{colors.WARNING} {text} {colors.ENDC}")


def display_help():
    print("command: --help\n\
        options:\n\
            -u <argument> : --url <argument> [Supply the url to download]\n\
            -o <argument> : --output_path <argument> [Supply the output path]\n\
            -r            : --replace [Replace any pre-existing files]\n\
            -h            : --help [Display this help message]\n\
            -v            : --verbose [Enable verbose output]\n\
            -t <argument> : --timeout <argument> [Specify the timeout value]\n\
            -p            : --disable_progress_bar [Disable the progress bar]\n\
            -k <argument> : --kind <argument> [specify the kind/type of file]")

    print("\n\
        exit codes:\n\
            0    [success]\n\
            1    [General Failure]\n\
            1000 [Downloading failed]\n\
            1001 [Getopts error]\n\
            1002 [No ouptput_path supplied]\n\
            1003 [No URL povided]\n\
            1004 [supplied argument cannot be empty]\n")
    exit(0)

def check_opts():
    if output_path == None:
        throw(
            "No output path provided, use --help for more information. [1002]")
        exit(1002)

    elif url == None:
        throw("No URL provided, use --help for more information. [1003]")
        exit(1003)


def download():
    if KIND != None:
        path = dl(url, output_path, progressbar=PROGRESSBAR, replace=REPLACE,
                  verbose=VERBOSE, timeout=TIMEOUT, kind=str(KIND))
    else:
        path = dl(url, output_path, progressbar=PROGRESSBAR,
                  replace=REPLACE, verbose=VERBOSE, timeout=TIMEOUT)
    return 0


def download_simple():
    return 1

try:
    url = None
    outputfile = None
    REPLACE = False
    VERBOSE = False
    TIMEOUT = 10
    PROGRESSBAR = True
    KIND = None
    SIMPLE = False
    argv = argv[1:]
    try:
        opts, args = getopt(argv, "u:o:rhvt:pk:s", ["url =",
                                                    "output_path =",
                                                    "replace",
                                                    "help",
                                                    "verbose",
                                                    "timeout =",
                                                    "disable_progress_bar",
                                                    "kind =",
                                                    "simple"])
    except:
        throw("getopts error!")
        exit(1001)
    for opt, arg in opts:

        if opt in ['-u', '--url']:
            if arg == "":
                throw("argument for 'url' cannot be empty")
                exit(1004)
            url = arg

        elif opt in ['-o', '--output_path']:
            if arg == "":
                throw("argument for 'output_path' cannot be empty")
                exit(1004)

            output_path = arg

        elif opt in ['-r', '--replace']:
            REPLACE = True
        elif opt in ['-h', '--help']:
            display_help()
            exit(0)
        elif opt in ['-v', '--verbose']:
            VERBOSE = True
        elif opt in ['-t', '--timeout']:
            if int(arg) < 1:
                warn("supplied value is less than one,\
                     using the defualt value of 10")
                arg = 10
            TIMEOUT = int(arg)
        elif opt in ['-p', '--disable_progress_bar']:
            PROGRESSBAR = False
        elif opt in ['-k', '--kind']:
            if arg == "":
                throw("argument for 'kind' cannot be empty")
                exit(1004)
            KIND = arg
        elif opt in ['-s', '--simple']:
            SIMPLE = True
except:
    throw("getopts error! [1001]")
    exit(1001)

def main():

    try:
        check_opts()
    except:
        throw("getopts error! [1001]")
        exit(1001)
    
    download()


if __name__ == "__main__":
    main()
    exit(0)