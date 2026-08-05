### Reposync-ng - Function Files
<hr> 

<h4> TODO </h4>

- Document what each config file does

<hr> 
	
<h4> Display Functions </h4>

- DisplayOptions.bfunc  -  Main Output Control.
- ShowAndTell.bfunc  - Controls Additional Output Capabilities.
- ShowCase.bfunc  - Runs a CASE Statement For CommandLine Arguments.

<hr>
		
<h4> Excludes Functions </h4>

- FilterExcludes.bfunc  - Allows Use Of Excludes From An External File.

-  RemoveFilteredFile.bfunc  -  Removes The Temporary Filtered Excludes File.

-  SourceExcludesFile.bfunc - Sources the excludes file and puts it into the variable $ExcludesFile. <br>
  	&nbsp;&nbsp; Use 'cat $ExcludesFile' to display excludes and 'echo $ExcludesFile' to show excludes filename.  
	
<hr>		

<h4> Main Functions </h4>

- FuncUtil.sh  -  Function Utility (WIP).

- ParseConfigOptions.bfunc  -  Config File Parser. <br>
	 &nbsp;&nbsp;  Currently Only Supports .conf files. <br>
  	 &nbsp;&nbsp;  INI Support will be added later. <br>
	
- PerformRepoSync.bfunc  -  Main Reposync Control.

-  SanityChecks.bfunc  -  Sanity Checker.  Confirm Files/Folders Are Present And Certain Functions Are NOT Empty.
		
- CleanMetadata.bfunc  -  Runs ```dnf clean metadata```.


<hr>
-  functions.list  - List Of Functions.

<hr>

<h4>3rd Party INI Library Files </h4>
-  lib_ini.bfunc -  3rd Party Library. Supports Read/Write To/From INI Files.
	

-  lib_ini.sh  -  3rd Party Library. Supports Read/Write To/From INI Files.
  
<hr>
