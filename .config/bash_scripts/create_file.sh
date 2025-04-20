#!/usr/bin/bash 
# create_file file
# ================================================================================
# ================================================================================
# - Purpose: This file contains bash scripts that are used to create formatted
#            code files for Python, C, C++, and Arduino
#
# Source Metadata
# - Author:  Jonathan A. Webb
# - Date:    February 26, 2022
# - Version: 1.0
# - Copyright: Copyright 2022, Jon Webb Inc.
# ================================================================================
# ================================================================================
# - Read the language to be created as a command line_ardument.  The languages
#   can be Python, C, C++, Python_Test, C_Test, C++_Test, or Arduino

language=$1

# Verify that the entry is acceptable
if [ $language != "Python" ] && [ $language != "C" ] && [ $language != "C++" ] && \
    [ $language != "Arduino" ] && [ $language != "Python_Test" ] && \
	[ $language != "C_Test" ] && [ $language != "C++_Test" ] && \
	[ $language != "C_Lib" ] && [ $lanugage != "C++_Lib" ] && \
	[ $language != "C_Main" ] && [ &language != "C++_Main" ] ; then
	echo 'Language must be Python, C, C++, Python_Test, C_Test, C++_Test, Arduino, C_Lib, or C++_Lib'
	exit 1
fi
# --------------------------------------------------------------------------------
# Create aliases and path lengths

name='Jonathan A. Webb'
company='Jon Webb'
copy='/usr/bin/cp'
dir=`/usr/bin/pwd`
replace='/usr/bin/sed'
make_dir='/usr/bin/mkdir'
py_dir=$HOME'/.config/py_files/'
c_dir=$HOME'/.config/c_files/'
cpp_dir=$HOME'/.config/c++_files/'
ard_dir=$HOME'/.config/arduino_files/'
# ================================================================================
# Create the files

# Get date information
day=`date +%d`
month=`date +%B`
year=`date +%Y`

if [ $language == "Python" ] ; then
	echo "Enter the filename without the .py extension"
	read file_name
    $copy $py_dir'main.py' $dir'/'$file_name'.py'
 
	$replace -i "s/Day/$day/g" $dir'/'$file_name'.py' 
    $replace -i "s/Month/$month/g" $dir'/'$file_name'.py'
    $replace -i "s/Year/$year/g" $dir'/'$file_name'.py'
    $replace -i "s/Name/$name/g" $dir'/'$file_name'.py'
	$replace -i "s/Company/$company/g" $dir'/'$file_name'.py'
    $replace -i "s/filename/$file_name/g" $dir'/'$file_name'.py'
elif [ $language == "Python_Test" ] ; then
	echo "Enter the filename without the .py extension"
	read file_name
	$copy $py_dir'test.py' $dir'/'$file_name'.py'

    $replace -i "s/Day/$day/g" $dir'/'$file_name'.py' 
    $replace -i "s/Month/$month/g" $dir'/'$file_name'.py'
    $replace -i "s/Year/$year/g" $dir'/'$file_name'.py'
    $replace -i "s/Name/$name/g" $dir'/'$file_name'.py'
	$replace -i "s/Company/$company/g" $dir'/'$file_name'.py'
	$replace -i "s/filename/$file_name/g" $dir'/'$file_name'.py'
elif [ $language == "C" ] ; then
    echo "Enter the filename without the .c or .h extension"
	read file_name
	$copy $c_dir'additional_file.c' $dir'/'$file_name'.c'
    $copy $c_dir'additional_file.h' $dir'/'$file_name'.h'

    $replace -i "s/Day/$day/g" $dir'/'$file_name'.c' 
    $replace -i "s/Month/$month/g" $dir'/'$file_name'.c'
    $replace -i "s/Year/$year/g" $dir'/'$file_name'.c'
    $replace -i "s/Name/$name/g" $dir'/'$file_name'.c'
	$replace -i "s/Company/$company/g" $dir'/'$file_name'.c'
    $replace -i "s/filename/$file_name/g" $dir'/'$file_name'.c'

    $replace -i "s/Day/$day/g" $dir'/'$file_name'.h' 
    $replace -i "s/Month/$month/g" $dir'/'$file_name'.h'
    $replace -i "s/Year/$year/g" $dir'/'$file_name'.h'
    $replace -i "s/Name/$name/g" $dir'/'$file_name'.h'
	$replace -i "s/Company/$company/g" $dir'/'$file_name'.h'
    $replace -i "s/filename/$file_name/g" $dir'/'$file_name'.h'
elif [ $language == "C++" ] ; then
    echo "Enter the filename without the .cpp or .hpp extension"
	read file_name
    $copy $cpp_dir'additional_file.cpp' $dir'/'$file_name'.cpp'
    $copy $cpp_dir'additional_file.hpp' $dir'/'$file_name'.hpp'

    $replace -i "s/Day/$day/g" $dir'/'$file_name'.cpp' 
    $replace -i "s/Month/$month/g" $dir'/'$file_name'.cpp'
    $replace -i "s/Year/$year/g" $dir'/'$file_name'.cpp'
    $replace -i "s/Name/$name/g" $dir'/'$file_name'.cpp'
	$replace -i "s/Company/$company/g" $dir'/'$file_name'.cpp'
    $replace -i "s/filename/$file_name/g" $dir'/'$file_name'.cpp'

    $replace -i "s/Day/$day/g" $dir'/'$file_name'.hpp' 
    $replace -i "s/Month/$month/g" $dir'/'$file_name'.hpp'
    $replace -i "s/Year/$year/g" $dir'/'$file_name'.hpp'
    $replace -i "s/Name/$name/g" $dir'/'$file_name'.hpp'
	$replace -i "s/Company/$company/g" $dir'/'$file_name'.hpp'
    $replace -i "s/filename/$file_name/g" $dir'/'$file_name'.hpp'
elif [ $language == "C_Test" ] ; then
	echo "Enter the filename without the .c extension"
	read file_name
	$copy $c_dir'test.c' $dir'/'$file_name'.c'
    
	$replace -i "s/Day/$day/g" $dir'/'$file_name'.c' 
    $replace -i "s/Month/$month/g" $dir'/'$file_name'.c'
    $replace -i "s/Year/$year/g" $dir'/'$file_name'.c'
    $replace -i "s/Name/$name/g" $dir'/'$file_name'.c'
	$replace -i "s/Company/$company/g" $dir'/'$file_name'.c'
	$replace -i "s/filename/$file_name/g" $dir'/'$file_name'.c'

	$copy $c_dir'test.h' $dir'/'$file_name'.h'
    
	$replace -i "s/Day/$day/g" $dir'/'$file_name'.h' 
    $replace -i "s/Month/$month/g" $dir'/'$file_name'.h'
    $replace -i "s/Year/$year/g" $dir'/'$file_name'.h'
    $replace -i "s/Name/$name/g" $dir'/'$file_name'.h'
	$replace -i "s/Company/$company/g" $dir'/'$file_name'.h'
	$replace -i "s/filename/$file_name/g" $dir'/'$file_name'.h'
elif [ $language == "C++_Test" ] ; then
	echo "Enter the filename without the .cpp extension"
	read file_name
	$copy $cpp_dir'test.cpp' $dir'/'$file_name'.cpp'
    
	$replace -i "s/Day/$day/g" $dir'/'$file_name'.cpp' 
    $replace -i "s/Month/$month/g" $dir'/'$file_name'.cpp'
    $replace -i "s/Year/$year/g" $dir'/'$file_name'.cpp'
    $replace -i "s/Name/$name/g" $dir'/'$file_name'.cpp'
	$replace -i "s/Company/$company/g" $dir'/'$file_name'.cpp'
	$replace -i "s/filename/$file_name/g" $dir'/'$file_name'.cpp'
elif [ $language == "C++_Lib" ] ; then
	echo "Enter the library name"
	read file_name
    $make_dir $dir'/'$file_name
	$copy $cpp_dir'CMake2.txt' $dir'/'$file_name'/CMakeLists.txt'

	$replace -i "s/prjct_name/$file_name/g" $dir'/'$file_name'/CMakeLists.txt'
    $replace -i "s/Name/$name/g" $dir'/'$file_name'/CMakeLists.txt'
    $replace -i "s/Day/$day/g" $dir'/'$file_name'/CMakeLists.txt'
    $replace -i "s/Month/$month/g" $dir'/'$file_name'/CMakeLists.txt'
    $replace -i "s/Year/$year/g" $dir'/'$file_name'/CMakeLists.txt'
    $replace -i "s/Company/$company/g" $dir'/'$file_name'/CMakeLists.txt'
else
    echo "Enter the library name"
	read file_name
    $make_dir $dir'/'$file_name
	$copy $c_dir'CMake2.txt' $dir'/'$file_name'/CMakeLists.txt'

	$replace -i "s/prjct_name/$file_name/g" $dir'/'$file_name'/CMakeLists.txt'
    $replace -i "s/Name/$name/g" $dir'/'$file_name'/CMakeLists.txt'
    $replace -i "s/Day/$day/g" $dir'/'$file_name'/CMakeLists.txt'
    $replace -i "s/Month/$month/g" $dir'/'$file_name'/CMakeLists.txt'
    $replace -i "s/Year/$year/g" $dir'/'$file_name'/CMakeLists.txt'
    $replace -i "s/Company/$company/g" $dir'/'$file_name'/CMakeLists.txt'
 elif [[ $language == "C_Main" ]] then
 	echo "Enter the main file name"
 	read file_name
    $copy $c_dir'main.c' $dir'/'$file_name'.c'

    $replace -i "s/Day/$day/g" $dir'/'$file_name'.c' 
    $replace -i "s/Month/$month/g" $dir'/'$file_name'.c'
    $replace -i "s/Year/$year/g" $dir'/'$file_name'.c'
    $replace -i "s/Name/$name/g" $dir'/'$file_name'.c'
 	$replace -i "s/Company/$company/g" $dir'/'$file_name'.c'
	$replace -i "s/filename/$file_name/g" $dir'/'$file_name'.c'
 elif [[ $language == "C++_Main" ]] then
 	echo "Enter the main file name"
 	read file_name
    $copy $cpp_dir'main.cpp' $dir'/'$file_name'.cpp'

    $replace -i "s/Day/$day/g" $dir'/'$file_name'.cpp' 
    $replace -i "s/Month/$month/g" $dir'/'$file_name'.cpp'
    $replace -i "s/Year/$year/g" $dir'/'$file_name'.cpp'
    $replace -i "s/Name/$name/g" $dir'/'$file_name'.cpp'
 	$replace -i "s/Company/$company/g" $dir'/'$file_name'.cpp'
	$replace -i "s/filename/$file_name/g" $dir'/'$file_name'.cpp'

fi
# ================================================================================
# ================================================================================
# eof

