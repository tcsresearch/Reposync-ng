# Store results inside a variable.
NumberOfFoundFunctions=$(eval cat *.bfunc | grep function | grep { | wc -l)

function ShowFunctions() {
	## TODO: Use cut to remove 'function' and '() {' from displaying
	cat *.bfunc | grep function | grep {
	echo " "
}

function GetNumberOfFunctions() {
	echo "Number Of Functions Found: $NumberOfFoundFunctions. "
	# cat *.bfunc | grep function | grep { | wc -l
}

function IsFunctionDefined() {
	## TODO: Have ShowFunctions output generate a list of functions for this to use.
	if [ "$(type -t my_function)" == "function" ]; then
 	  echo "Function my_function is defined."
	else
  	  echo "Function my_function is NOT defined."
	fi
}

function AreFunctionDefined() {
        ## TODO: Have ShowFunctions output generate a list of functions for this to use.
        my_function_list=`cat functions.list`
	if [ "$(type -t my_function_list)" == "function" ]; then
          echo "Function my_function is defined."
        else
          echo "Function my_function is NOT defined."
        fi
}


# Run Our Function
ShowFunctions
GetNumberOfFunctions

# IsFunctionDefined
#

