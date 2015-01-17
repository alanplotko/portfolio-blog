---
layout: post
title: HackPrinceton
date: 2014-03-31 00:17
category: Hackathons
---

So I just got back from my first hackathon: [HackPrinceton](http://hackprinceton.com/). There were many amazing projects in software and hardware. For the participants on the hardware track, HackPrinceton provided plenty of choices such as the [leap motion](https://www.leapmotion.com) and the [pebble watch](https://getpebble.com/). I worked with Taylor Foxhall, a peer studying Computer Science at Binghamton University, on a project we call [CodeBoard](http://www.code-board.com/).

CodeBoard facilitates collaborative code review for programmers. It was designed to be used in an educational context, but can be easily adapted for use in the industry. With CodeBoard, programmers can post snippets of code for others to review. Code can be reviewed with three different tools: annotations, notes, and comments. Annotations are major criticisms of several lines of code and lie in the margins. Notes are minor suggestions that point to a small part of the code. Comments house a discussion of the code in its entirety at the bottom of the screen. CodeBoard creates a meeting place for new and experienced programmers to review code together and learn from each other.

Our planned vision involved using APIs of social networks (i.e. Google+, Facebook, Twitter) for logging in. This would tie everything together - the commenting system and the CodeBoard accounts. For the demo, we allowed for registration of user accounts. MongoDB was our database solution, which efficiently allowed us to work with JSON data. The website is responsive and runs off Python 3.3 using the Bottle framework. RedHat OpenShift allowed us to set up the Python server. The project is in progress and we hope to complete the aforementioned tools, expand to a larger variety of programming languages, and change how the code appears, so that it is readable. CodeBoard is open source and will be available via my GitHub account soon.

[caption id="" align="alignnone" width="1366"]<img src="http://alanplotko.com/wp-content/uploads/2014/03/CodeBoard.jpg" alt="" width="1366" height="643" /> Front page of the CodeBoard website.[/caption]
