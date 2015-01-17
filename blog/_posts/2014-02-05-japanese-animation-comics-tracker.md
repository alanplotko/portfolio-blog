---
layout: post
title: Japanese Animation & Comics Tracker
date: 2014-02-05 17:22
category: Personal Projects
---

The project is all in Python and I'm in the midst of switching to object-oriented because the goals I have in mind exceed what the script would originally accomplish. With the many trackers out there that keep record of what you're watching and reading, and the API the trackers offer to developers, I'm surprised that aren't any trackers that analyze your list and keep a schedule of what's airing for the day in the same fashion as someone would flip through the TV guide to see what's airing. While you could easily look up when the shows are coming out, it becomes increasingly complex to search the records for just what you particularly watch and read.

The tracker is a simple script that asks for the user's preference in what system they use to track what they watch and read. I will focus on the major systems that have API available before looking into others. After selecting a system, a username is sufficient for fetching the necessary data, which will be cross-checked with online databases of airing dates.  The output will be comprised of definitive dates and times for new releases in Japan and close estimates for online subtitled or translated versions. To maximize performance, the code is dynamic in that all of the necessary methods are split into various files in a modular fashion. Only what is needed will be imported and utilized by the main script. I plan to port the final product into an .exe that could potentially be run under startup. With an accompanying GUI, a widget will simply pop up to show which of your favorites are released for the day.

I have considered messing around with rainmeter for to mix the tracker with other widgets on rainmeter's architecture, thus bypassing the step in making an standalone GUI for the tracker. I've found some work on GitHub that addresses running Python to generate a widget for rainmeter, so I'll be looking into that after the script is complete. This will be an interesting project as I'll be able to work with Python again. Since I'm technically taking CS140 (Java) as per major requirements, I might as well port the final product into Java for an Android release.
