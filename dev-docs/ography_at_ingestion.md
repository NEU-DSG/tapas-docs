Ben —

First you need to understand why we are currently in this “ography 1st” situation.

When a TEI file is uploaded, it is converted to XHTML at that time. The XHTML is stored in the system (used to be by Drupal, nowadays is by eXist). When a user asks to see the reading view of the TEI file, that previously-generated XHTML file is served to the user’s client.

When a user mouses-over or clicks on an ography-item, she gets a pop-up of data extracted from the ography. That data is (currently) sucked out of the ography into the XHTML file for use as a pop-up **at TEI file upload time**. So when the user mouses-over or clicks, the data is not being grabbed from the ography, but rather is being grabbed from the underlying XHTML reading version of the TEI. That is, at upload time when the XSLT sees things like
```xml
<persName @ref="persons.xml#A.Haslam03">Annie H.</persName>
```
it goes and gets the <person xml:id="A.Haslam03"> from 'persons.xml'
right then and there, and converts it into something like
```xml
 <div class="contextualItem-person">
   <a id="A.Haslam03"/>
   <p class="identifier">Haslam, Annie</p>
   <p data-tapas-label="born">
    <span>
       <span class="normalized-date">1947-08-06</span>
       <settlement>Bolton</settlement>
       <region>Lancashire</region>
       <country>England</country>
     </span>
   </p>
   <p data-tapas-label="note">
     <span>Lead singer of <name>Renaissance</name>.</span>
   </p>
 </div>
```
in the XHTML. If it can’t find 'persons.xml' at that time, it can’t create this chunk of data.

The reasons why we do it this way are both historical and practical, and probably no longer relevant at all. AFAIK there is no significant reason why this could not be done at serve time instead.

This could be done either

a) doing the entire TEI → XHTML transform dynamically, when the reading view of the TEI document is requested by the user, or

b) by doing most the TEI → XHTML transform statically at upload time as we do now, but sucking in the bit from ographies via Javascript only at mouse-over or click time, or

c) by doing most the TEI → XHTML transform statically at upload time as we do now, but sucking in the bit from ographies via XSLT only when the reading view of the TEI document is requested by the user. 

Method (a) has **lots** of advantages (like being able to change the parameters of the transformation based on user input), but is _so_ costly in CPU time that it was discounted out of hand in the very early stages of TAPAS development.

Method (b) is would require (far) more Javascript expertise than I have, but in principle it should not be hard to do. The devil, of course, is in the details, and there are a **lot** of thorny details in ography processing. Even worse when doing so in 'generic', which needs to take in most any balony a user might put it there.

I haven’t thought much about method (c), which was simply not feasible in the previous TAPAS environment, but would probably be very reasonable now that we have an eXist back-end for serving the reading view. 
