
# TAPAS Design and Architecture Update
posted Apr 9, 2013, 1:57 PM by qdelete-1-eliot_scott@brown.edu

## TAPAS Display

    The TAPAS site is now displayed according to the layouts designed by Jeremy Boggs (http://clioweb.github.com/tapas/index.html
    http://clioweb.github.com/tapas/project.html
    http://clioweb.github.com/tapas/collection.html
    http://clioweb.github.com/tapas/document.html
    http://clioweb.github.com/tapas/browse.html)
    This was accomplished by modifying Panel and Views layouts with mostly css at the theme layer. A few php modifications were made on page.tpl but only to allow the admin to see default drupal tabs on admin pages.

    Default Drupal editing features have been replaced with custom buttons based on Jeremy’s designs

    All test projects and collections have been made private with just 4 collections available for semi public view - Hamilton College Collections, The Thomas Wilson Dorr Letters Project, Victorian Women Writers Project, Greenfield Digital Project

    Data from the other projects has not been “cleaned up”, its waiting for project owners to delete what they don’t want

    TAPAS is now a closed beta test and no one can view TAPAS without first obtaining the authorized username and password


## Major New TAPAS Functionalities

    bulk file management

    bulk editing of metadata

    creation of metadata on TEI file ingest

    controlled vocabularies for subject, location, language and genres

    linked data for subject, location, language and institutional affiliations

    the ability to add and manage multiple TAPAS users in a projects

    the ability to add new users to TAPAS and a user project simultaneously

    A multistep process for Project, Collection and TEI creation

    Collections can now have separate images

    Collections are marked by default when creating TEI content from the Collection

    Page elements are optional and editable

    Captcha was implemented and spam has become negligible





    The attached xml file contains all the development issues in tapas: [dev-issue.xml](https://sites.google.com/site/teipublishing/updates/tapasdesignandarchitectureupdate/dev-issue.xml)


## Alpha site
posted Nov 9, 2012, 2:00 PM by Scott Hamlin

I just posted a link to the alpha site on our main page, which has been up and available for a couple months now. Just thought I would post a link to it here as well so that we can all find it easily:

http://www.ptapascit.services.brown.edu/

(Edit post)

## Post Islandora Camp 2012 Update
posted Aug 7, 2012, 8:54 AM by qdelete-1-eliot_scott@brown.edu   [ updated Aug 7, 2012, 8:58 AM ]

Hello Everyone,

I’ve been working on TAPAS for a little over a month now and just returned from Islandora Camp on Prince Edward Island. So I wanted everyone to have a brief update prior to any larger meeting we might have. Please read Julia’s notes from the previous meeting for a better background if you haven’t already - https://sites.google.com/site/teipublishing/updates/architectureconversation2012-07-25.

Unsurprisingly to me at least, Drupal entity/node/field integration was the number one topic at Islandora camp this year. As many universities across North America are using or converting their public websites to Drupal for better content management, they would like an easier way to integrate Drupal’s power and codebase with a Fedora repository and not just have the repository attached to Drupal as it is currently in Islandora. The University of Toronto and UCLA both struggled with Islandora projects that needed both a dynamic Drupal front end and a back end repository for long term storage, and a developer at SFU thought that the biggest weakness of Islandora was the lack of Drupal node/entity integration.

So what exactly is the issue and why haven’t Drupal and Fedora been more thoroughly integrated through Islandora? The biggest issue the Islandora developers talked about was the syncing issue – ie keeping the Fedora content in sync with the Drupal content. As Islandora still aims to be somewhat CMS agnostic, they want to make sure that content can be ingested in both directions – ie from Fedora to Drupal as well as from Drupal to Fedora. Developers both within the Islandora/Discovery Gardens team and from other universities all agreed this was a difficult problem to solve.

Another issue that was brought up, and one which the Fedora folks here at Brown might have a better grasp of, was the number of Fedora REST calls that Drupal might make in a web application and the lag time that would occur with too many calls. To solve this issue, the Islandora team is implementing better SOLR integration to Drupal, but this approach again had some problems integrating with the rest of the Drupal system as they have not yet worked on a way to integrate the SOLR data into Drupal entities.

Several of the modules I looked at for better Drupal integration to Fedora were then brought up by another attendee; mostly modules developed by Alexander O’Neill who is now a Drupal developer at Stanford and these modules are discussed here - https://groups.google.com/forum/?hl=en&fromgroups#!topic/islandora/K9oTloWidbk. Many people liked the way these solutions were headed, ie a Fedora Object as a Drupal node, attached to a Drupal node, or as a Drupal CCK field(6x)/Entity(7x), but since Alexander moved on from the project, Islandora 7x has been the priority for the rest of the Islandora team and no new work on this approach has been done.

I inquired of the Islandora developers if the sync issue was still a problem if a user always went from Drupal to Fedora, ie upload an access copy to Drupal then store a long term datastream to Fedora with any associated metadata and keep adding revisions to Fedora as the Drupal content changed. All the developers agreed that this approach would be much easier to implement with the rewritten Tuque API library for Islandora 7x, but would not support all their use cases. Fortunately, this approach should support the TAPAS use case as it is a project relying on end user contributions rather than a bulk ingest of librarian/archivist curated collections. The SFU developer felt that this approach was a reasonable solution that would be relatively easy to implement and this appears to be the direction UCLA would like to move in as well. I will be in regular contact with the Programmer/Analyst at the UCLA Library, where they are heavily invested in building this type of integration piece and currently have a much larger team to work on the problem. As the UCLA programmer and I also discussed, Drupal now has basic RDF in core as well as a module for extending the core RDF that could be integrated with Fedora as well. So it seems we may be on the right track with this approach to the repository, long term storage and system agnostic metadata problems and we are certainly in good company in our concerns.

The Islandora team definitely heard that the community was interested in Drupal entity integration, and their 7x version has been overhauled to be more Drupal like in both behavior and code. Unfortunately, their development schedule for the entity integration feature will be on hold while they convert all their solution packs over to the 7x version, which will be at least another several months.

Several interesting solution packs are in the works at Islandora and were demo-ed at the camp including a Chemistry Solution Pack that incorporated Organic Groups and commenting, but unfortunately did not yet store any of that metadata in Fedora and again wasn’t entirely integrated with Drupal for use in key modules like Rules, Views, and Tokens. The most interesting solution pack from the TAPAS perspective was the Digital Humanities pack which is being developed for this project - http://editingmodernism.ca/2011/09/commonwealth-of-modernist-studies/. Combined, these packs would be a step in the right direction for TAPAS but unfortunately, both of these packs are currently for Islandora 6 x only, which would limit TAPAS somewhat moving forward.

Given all this information, I still believe the best way forward for the TAPAS project is to continue developing the user interface in Drupal 7, and wait for Islandora/Tuque/Drupal Entity Integration to catch up either at Discovery Gardens/UPEI or UCLA or somewhere else, or here when we need it if it hasn’t been solved at that point. Within my local virtual machine, I currently have the “Projects” concept developed with the Organic Groups module, and have transforms occurring with an uploaded TEI file and single XSLT include within an iFrame using a custom PHP script that runs within a Drupal node. I am also adding the ability for a user to explore a project directory on the server so they can set up multiple xslt includes and manage multiple files and directories as well. My goal is to recreate this virtual instance on a public facing server requiring a login and have all of this functionality available as an early alpha for all TAPAS collaborators to view and test by the end of the month so we can have more in depth discussions. I will begin rebuilding this alpha site for testing as soon as I have access to a public facing server.

In the meantime, please contact me via chat, email or phone if you have any suggestions or concerns at
Eliot Scott
eliot_scott@brown.edu
401-863-7759
I will be posting this email to the

Thanks again for everyone’s hard work on the project and I’m looking forward to working with all of you!

 

Eliot

(Edit post)

## Architecture conversation, 2012-07-25
posted Jul 26, 2012, 8:55 AM by julia_flanders@brown.edu

Members of the TAPAS team from Brown and Wheaton met yesterday to talk about the work Eliot has been doing since his arrival on investigating Islandora, and also to talk more generally about how to organize the communication and work for this aspect of the project's development. The notes below describe our discussion, which may be of particular interest to those who have been involved in the discussions of repository architecture (Raf, Mike, Peter). 

Please share any thoughts/responses/comments via the tei-publishing discussion list!

I've summarized and grouped ideas where helpful to represent outcomes rather than trying to preserve the detailed flow of the conversation.

1. Communication
We agreed that it would be useful to have regular communication of several kinds:

    chat for short, time-sensitive questions and discussion; for this we might use Google chat (does this mean we should generally plan to have a gmail window or equivalent open when we're available?)
    discussion list postings for communicating more substantive reports or questions that require broader discussion; for this we agreed to use the tei-publishing@googlegroups.com discussion list, with the understanding that there are a few people on this list who may not find the discussions helpful, but they are free to ignore them :-)
    regular but infrequent Skype calls to check in on progress towards milestones (Scott and Julia will set these up)


2. TAPAS infrastructure

Eliot reported on the results of his investigations of Islandora so far; overall it is not what we expected.

The Islandora repository sits next to Drupal and talks to Drupal but is not tightly integrated with Drupal: the information assets that live in Drupal are not the same as the information assets that live in Islandora/Fedora. Fedora data is not being made native to Drupal; hence although one can do Drupal-like things with the web content that is managed within Drupal, one cannot do Drupal-like things with the repository content. 

    so for instance one can create a group or a project or a collection within Drupal, but that will not create anything in Fedora. Similarly one can create a collection and add objects/assets in Fedora through the Islandora module interface, but that will not create anything that Drupal can access and manipulate (although several specialized projects have created Drupal nodes automatically from Fedora objects). The main API that the Islandora module utilizes to access and store data in Fedora is the Tuque API. This API was designed to be a PHP Fedora library (https://groups.google.com/forum/?fromgroups#!topic/islandora/YldOU3yDjvg) and should be able to be called via a separate Drupal module, but no one has created this functionality as yet (https://groups.google.com/forum/?fromgroups#!topic/islandora/K9oTloWidbk). 
    Eliot noted that existing Islandora projects don't typically have novice users uploading objects directly into a repository; the upload is more typically handled through batch processes, so end users are just accessing information in Drupal, not managing it
    the upshot of all this is that Islandora's design doesn't really support the ways we had anticipated using Drupal: i.e. to provide a fairly user-friendly and full-featured interface for uploading, managing, and interacting with content that is stored in Fedora but brokered through Drupal. In particular it does not support the ability to take advantage of Drupal's wide array of modules to actually work with repository objects, since those objects are never actually operating within Drupal and are not even in the same format. 


We discussed the possibility of decoupling Drupal from Islandora: essentially, building TAPAS in Drupal (to take advantage of Drupal's wide array of modules, and in particular its handling of identities, access control, and "projects") and then providing some sort of synchronization mechanism to get the data into Fedora for long-term storage. We ended up agreeing to proceed with this approach, but we first discussed the pros and cons and the accompanying details: 

A. Why use Fedora at all, given that Drupal also provides for data storage?

    Fedora allows us to handle object relationships in a way that is robust over the long term, via RDF, whereas Drupal stores the data in MySQL in a Drupal-specific way
    [Joe and Andy, are there any other features of Fedora that are pertinent here? I'm thinking of things having to do with data storage and curation: what makes Fedora distinctively a "repository" system while we might not characterize Drupal in that way?]
    we noted that it would be possible to export or "compile" object relationships as expressed in Drupal to re-express them in RDF, for purposes of communicating these to Fedora


B. How wedded to Drupal would we be, and are there ways of easing any future migration to a different system?

    we discussed the question of what data we might want to store in Fedora (to make it independent of Drupal) such as information about user identity, projects, relationships, collections, permissions and IP, publication behaviors, and processing pipelines. 
    we also noted that if we were thinking about how to *preserve* TAPAS we might want to store a lot more of this kind of data (to allow the TAPAS system to be reconstructed, in effect, from information stored in Fedora), we're actually focusing more on how to *migrate* or *redevelop* TAPAS in a new system, presuming that in such a case we would still have the existing TAPAS and all of its constitutive information available to us. So in this case, we should focus more on making sure that these kinds of information are easily accessible within Drupal (or perhaps are expressed authoritatively outside of Drupal, if that's feasible). This is probably an issue we should spend time thinking about more carefully.


C. What additional expertise would we need to implement TAPAS in this way?

    we noted that this approach would require additional types of expertise to develop the part of the system that exports/sends/synchs data to or with Fedora, since this is something we had been assuming Islandora would take care of. We also noted that we will know more about what's involved and what has already been done once Eliot has been to Islandora camp
    we noted that CWRC may also be working on this, since their needs are similar to ours, and if so they might be interested in working with us on this component; Julia will contact Susan Brown to discuss this
    we noted that there is some consulting money in the IMLS and NEH budgets that could be used for this purpose; not clear at this point whether it would suffice


D. Finally, we discussed how to approach the actual development process

    we agreed (tentatively, pending more information from Islandora camp) that it would make sense to begin by developing the Drupal portion of the system, focusing on the user interface and storing all the data within Drupal
    the next step would be to develop a simple export of the TEI data plus essential accompanying TAPAS metadata so that it could be ingested by Fedora; this could be fairly clunky and would serve chiefly to satisfy the need for long-term repository storage which for many users will be a key value of the service (but they will not care how it is implemented as long as we are able to ensure that their data is safe)
    the next step would be to refine that export/synch process so that it does a better job of integrating the Drupal and Fedora parts of the system, using the Tuque API. This might be of value chiefly for its elegance and efficiency, or it might prove to make possible some additional features (? this occurs to me after the fact, not sure if it's true)
    we noted that for purposes of this grant, that third step would be deferrable if necessary to a future funding phase, since it would not have a strong impact on how the service is used
    we agreed that we should revisit the question of how to get data into Fedora once we have a working version of the Drupal portion in place, and at that point we would be in a better position to scope the work, ascertain the feasibility of different approaches, discover whether Eliot is able to undertake it on his own or would need assistance e.g. from a consultant, and any other details of approach. 
    we noted that for many purposes, the use of Fedora within TAPAS is simply as long-term storage, which does not  require that data be taken back out of the repository, only checked in. 


3. Next steps:

    after Eliot returns from Islandora camp, we'll schedule a conference call to include participants from this meeting plus Raf, Mike, and Peter, to discuss this approach in light of what Eliot has learned and to confirm the details of our approach.
    Eliot will start posting occasional updates to the TAPAS internal site (https://sites.google.com/site/teipublishing/updates/) to help keep the team informed
    we'll use the tei-publishing discussion list for substantive questions that require discussion
    we will start using Google chat as needed to increase day-to-day contact among members of the team; this may be even more useful once Eliot is working on the details of the user interface
    Andy will check on the progress of getting the TAPAS server set up; once it's set up, Eliot can start getting a working prototype (is there a more accurate characterization?) up and running so that others in the group can follow progress, provide feedback, etc.


Thanks to all for a really productive meeting, and again, comments and questions are welcome.

(Edit post)

## Islandora
posted Nov 23, 2011, 11:57 AM by Scott Hamlin   [ updated Nov 23, 2011, 11:58 AM ]

The interface working group (Andy, Patrick, Peter, Raf, Mike, and Scott) met on November 23 and decided to use Islandora as the development environment for TAPAS. Meeting notes can be found here.

(Edit post)

## Discussion Group
posted Nov 8, 2011, 7:15 AM by Scott Hamlin

I just added a link to our Google Discussion Group in the navigation bar, and a widget on the front page which should show recent discussions in the group. I also changed the group name from "Publishing TEI Documents for Small Liberal Arts Colleges" to "The TAPAS Project (TEI Archiving, Publishing, and Access Service)."

(Edit post)

## Calendar is working
posted Nov 4, 2011, 8:05 AM by Scott Hamlin

I just created a TAPAS Project calendar and inserted it into the Calendar section and put it on the front page. Currently, Andy, Julia, Raf, and I can add items to it. Let me know if I should share it out with anyone else.

(Edit post)

## Project Plan has been updated
posted Sep 15, 2009, 5:02 PM by TAPAS Project

New project plan has been uploaded to Project Documents area.

(Edit post)
