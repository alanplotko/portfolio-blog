---
layout: post
title: Haunted Mansion
date: 2013-12-31 21:23
category: Web Development
---

*In high school, I was a Software Engineering major (our school had a major system) and took a Web Development class as part of major requirements. The course consisted of classwork, homework assignments, projects, and exams. Some of our projects were labeled as levels, which meant that we were to first complete the current project before proceeding to the next project. We could not submit the next project without having first submitted the current project. Each assignment had a deadline to be met as well.*

Out of all the projects and assignments I've had in Web Development, this project was my favorite. The goal of level 4 was to use JavaScript to create something big (e.g. text adventure, shopping system, forum system). In my case, I made an actual [text adventure](http://en.wikipedia.org/wiki/Adventure_game#Text_adventure), unlike [Treasure Quest](http://alanplotko.com/portfolio/treasure-ques), with a console to accept user input. Well, with the added graphics, that would put make my project a graphic-text adventure. The story was made up as I went along, but working with [LocalStorage](http://diveintohtml5.info/storage.html) was a blast.

LocalStorage offers much more compared to relying on cookies alone, although it gets tricky when you try to use it for a real world application in which you want full browser support (e.g. working across major versions of Chrome, Firefox, Internet Explorer, etc.) and multiple platform support (e.g. working across desktop, tablet, smartphone). You can detect whether a browser supports it and fall back to cookies or other means if that happens to be the case.

The game essentially takes you from the protagonist's point of view and having lost your memories to remembering how you got lost in what seems to be an eerie mansion. I named the game as is: "Haunted Mansion v1.0" - but after various changes and updates to the game, I decided to drop v1.0 after losing track. It's probably on par, if not ahead, of the [major browsers](http://browsehappy.com/?locale=en).

I'm interested in experimenting with LocalStorage again, so stay tuned to seeing some interactivity with my portfolio in the near future along the lines of using LocalStorage for game support (e.g. achievements, badges) and general storage testing.
