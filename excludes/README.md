#### RepoSync-ng - Excludes
This folder contains the excludes lists and utilities. <br>

<p> 
<h5>Added Sep 19, 2026</h5>
<ul>
 <li> Added excludes-langpacks.list</li>
 <li> Added langpacks to excludes.list</li>
</ul>
</p>

<h4> TODO </h4>  
 <h5> Create utility to update excludes-filtered.list from excludes.list. </h5>
   <ul>
    <li> Use the FilterExcludesFile() function for this. </li>
    <li> Add CheckForDuplicateFilters() function. </li>
    <li> Be sure to add error checking in case users cause PICNIC errors modifying the lists! </li>
</ul>

 <h5> Update code to use both excludes.list and excludes-langpacks.list </h5>
  <ul>
    <li> Remove langpacks from excludes.list after code changes completed. </li>
    <li> Code update should allow for any new .list file to be parsed as excludes, subject to error & duplicate checks. </li>
    <li> Use excludes.list to specify files as excludes files ? </li>
 </ul>
