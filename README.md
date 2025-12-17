# Reposync-ng
The ultimate successor to RepoSync scripts, including RepoSync4.sh
<h4> A Complex wrapper for reposync with many features </h4>
<hr>

> [!NOTE]
> Reposync-ng is under active development and testing. <br>
> It doesn't work at the moment, but after a few bugfixes, it should start becoming suitable for testing.
<hr>

> [!WARNING]
> This code is highly experiemental and has NOT been fully implemented or tested.
<hr>

> [!IMPORTANT]
> Code is not considered stable yet, and still lacks most features.

<hr>


  
<div id="Proposed-Features">
  <details open>
    <summary>
      <b>Proposed Features</b>
    </summary>
      <ul>
        <li> :ballot_box_with_check: [DONE] Core functionality is contained within functions. :ballot_box_with_check: </li>
        <li> :ballot_box_with_check: [MOSTLY WORKING] ColorEcho-like output. :ballot_box_with_check: </li>
        <li> :ballot_box_with_check: [PLANNED] Support for customizable profiles. </li>
        <li> :ballot_box_with_check: [READY FOR TESTING] Support for excludes from external files. </li>
        <li> :ballot_box_with_check: [IN PROGRESS] INI-based configuration with an INI library (3rd party, also open source) and viewer (ViewINI.sh). :ballot_box_with_check:  </li> 
        <li> :ballot_box_with_check: [PLANNED] RPM/DEB packaging for various platforms (Fedora/CentOS/Debian/Ubuntu/Raspberry Pi, etc.) :ballot_box_with_check: </li> 
      </ul>
</details>
</div>
<hr>
<div id="TODO">
  <details open>
    <summary>
    <b>TODO</b>
    </summary>
    <ul>
      <li> :heavy_check_mark: [TESTABLE] Finish implementing ColorLib a.k.a. Cecho. :heavy_check_mark: </li>
      <li> :heavy_check_mark:  [TESTABLE] Rename all functions to use .bfunc extension. :heavy_check_mark: </li>
      <li> :ballot_box_with_check:  [DONE] Create Config Loader (AdvPreLoader.sh).  :ballot_box_with_check: </li> 
      <li> :ballot_box_with_check:  [DONE] Create Function Loader (AdvPreLoader.sh).  :ballot_box_with_check: </li> 
      <li> :ballot_box_with_check:  [DONE] Create Profile Loader (AdvPreLoader.sh).  :ballot_box_with_check: </li> 
      <li> :ballot_box_with_check:     [IN PROGRESS] Test all functions. </li> 
      <li> :ballot_box_with_check: [PLANNED] Use -v for verbose as argument for each function; use -q for quiet. :ballot_box_with_check: </li>
      <li> :x: [DEPRECATED] Fix BuildLib.sh script: backups aren't moved to $BackupDir. :x: </li>
      <li> :x: [DEPRECATED] Test new BuildLib2.sh utility - Uses a separate functions file (BuildLib.func). :x: </li>
      <li> :x: [DEPRECATED] Ensure that move of built libraries to /lib works as expected. :x: </li>
    </ul>
  </details>
</div>

<hr>
<div id="Updates_12-2025">
  <details>
    <summary>
      <b>Updates 12/2025</b>
    </summary>
      <ul>
        <li> Updated Cecho function for easy fallback when no color is selected. </li>
        <li> Added several functions and scripts related to boot: <br>
            - chipset detection, disable secure boot, change between graphical and commandline, etc. - NOT FULLY TESTED! </li>
        <li> Added TakeOwnership.sh (UNTESTED!). </li>
        <li> Added a few Reposync-ngDev functions to allow for easier development in the future. <br>
          - loader for config/ and functions/ folders, sanity checks, CASE statement generation, extracting functions, etc - UNTESTED! </li>
        <li> Added NewEchoBox and SimpleBanner functions. </li>
        </ul>
  </details>
</div>
