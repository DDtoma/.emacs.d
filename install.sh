#! /bin/bash

mac_install_command="brew install "
mac_install_package=("the_silver_searcher", "llvm")

isDo=true
machine="UN"

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)      machine="Linux";;
    Darwin*)     machine="Mac";;
    CYGWIN*)     machine="Cygwin";;
    MINGW*)      machine="MinGw";;
    *)           machine="UNKNOWW"
esac
echo ${machine}

if [ isDo ] && [ $machine == "Mac" ]
then
    echo $machine
    #for package in mac_install_package
    # do
    #	$($mac_install_command$package)
    # done
fi

if [ isDo ] && [ $machine == "Linux" ]
then
    echo $machine
fi
