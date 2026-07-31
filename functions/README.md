# Reposync-ng
Function Files
<hr> 

<h4> TODO </h4>
- Document what each config file does
  
<h4> Files </h4>

- CleanMetadata.bfunc  -  Runs ```dnf clean metadata```
	

- DisplayOptions.bfunc  -  Main Output Control.
		

- FilterExcludes.bfunc  - Allows Use Of Excludes From An External File.
		

- FuncUtil.sh  -  Function Utility (WIP).
		

- ParseConfigOptions.bfunc  -  Config File Parser.  Currently Only Supports .conf files. <br>
      INI Support will be added later.
	

- PerformRepoSync.bfunc  -  Main Reposync Control.
		

-  RemoveFilteredFile.bfunc  -  Removes The Temporary Filtered Excludes File.
	

-  SanityChecks.bfunc  -  Sanity Checker.  Confirm Files/Folders Are Present And Certain Functions Are NOT Empty.

-  SourceExcludesFile.bfunc - Sources the excludes file and puts it into the variable $ExcludesFile.
  	Use 'cat $ExcludesFile' to display excludes and 'echo $ExcludesFile' to show excludes filename.  
	

-  ShowAndTell.bfunc  - Controls Additional Output Capabilities.
		

-  ShowCase.bfunc  - Runs a CASE Statement For CommandLine Arguments.
		

-  functions.list  - List Of Functions.
	
<hr>
<h4>3rd Party INI Library Files </h4>
-  lib_ini.bfunc -  3rd Party Library. Supports Read/Write To/From INI Files.
	

-  lib_ini.sh  -  3rd Party Library. Supports Read/Write To/From INI Files.
  
