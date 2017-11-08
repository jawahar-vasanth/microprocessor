#! /bin/bash
# This is the script file that integrates both the microprocessor code and the program written in txt file
echo "$(tput clear)$(tput setaf 6)$(tput bold)$(tput smul)EE2016 -Project  8-bit Microprocessor$(tput sgr 0)"
echo
echo "$(tput setaf 3)$(tput bold)Done by:"
echo "$(tput bold)$(tput setaf 6)V Jawahar Narayanan (EE16B042) $(tput sgr 0)"
echo
echo
#echo "Enter the $(tput bold)program$(tput sgr 0) that you want to run $(tput bold)$(tput setaf 1)( Don't Enter the Extension i.e (.txt) )$(tput sgr 0)"

read varname

#echo Converting the $varname into machine understandable code ....

python assembler.py $varname &&
# exit $?
echo Converted Successfully !!

iverilog -o dsn mini.v test.v &&
# exit $?
vvp dsn &&
# exit $?
gtkwave test.vcd&
exit $?
