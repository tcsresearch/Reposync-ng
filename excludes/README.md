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
 - Create utility to update excludes-filtered.list from excludes.list. <br>
    &nbsp;&nbsp;&nbsp;&nbsp;   Use the FilterExcludesFile() function for this. <br>
    &nbsp;&nbsp;&nbsp;&nbsp;   Be sure to add error checking in case users cause PICNIC errors modifying the lists! <br>
 <br>
 - Update code to use both excludes.list and excludes-langpacks.list <br>
    &nbsp;&nbsp;&nbsp;&nbsp;   Remove langpacks from excludes.list after code changes completed. <br>
    &nbsp;&nbsp;&nbsp;&nbsp;   Use excludes.list to specify files as excludes files ? <br>
