# SSEA Student Teams Repository

This repository contains the raw data, scripts for data analysis, and the paper and presentation presented at the Symposium on Space Educational Activities (SSEA) 2026, April 8-10, in Munich, Germany, by Maximilian von Arnim.

# The Data

The Excel file contains the following columns:

`state` The state (country) the team is based in.

`City` The city the team is based in. If teams are collaborations between students of multiple cities, they are separated by `/`.

`School` The school or university the team is based in. If teams are collaborations between students of multiple universities, they are separated by `/`.

`Club Name` The name of the student club or association. If no permanent club was found (team was active for a single project only or never created any formal club), `-` is put. If the team does not have their own club, but there exists a permanent structure supporting student teams within the university or other institution, its name is put in `(brackets)`.

`Project Names` The names of some of the projects conducted by this team. If the `club name` is empty, this field is equivalent to the team name. This column is incomplete.

`Founded` The year the student club was created or was first active. May be inaccurate or incomplete in some cases.

`Last Active` The year in which the club last had any public appearance (social media, press releases, competition participation). `2025` indicates that the club is currently still active.

`Website` The official homepage of the team. In some cases, the university press release or the hosting institution was put here.

`Twitter`, `Facebook`, `Instagram`, `Linkedin` The official social media presence of the team. Not fully complete. Generally, at least one online presence was put for each team, if found.

`Notable Successes` Field for any entries, incomplete.

`ERC` Years in which the team participated in ERC (at least applied to ERC, on-site presence not required).

`ERC_TOTAL` Indicates if the team participated in ERC at least once (automatically filled).

`ESA FYS (selection - launch)` Years in which the team participated in ESA Fly Your Satellite (FYS). Team selection is marked by a capital `X`, years of subsequent project activities are marked by a small `x`, launch is marked by `o`. Satellites that were not launched but whose development resumed at a later time may have empty fields in years the project was dormant. Projects that participated in short-duration campaigns such as the ESA Design Booster or test campaigns may only have a single `X` in the year this activity was conducted or completed.

`ESA_FYS_TOTAL` Indicates if the team participated in ESA FYS at least once (automatically filled).

`ESA Academy Exp.` Years in which the team participated in ESA Academy Experiments; incomplete.

`EUROC` Years in which the team participated in EUROC.

`EUROC_TOTAL` Indicates if the team participated in EUROC at least once (automatically filled).

`Überflieger` Years in which the team participated in the German DLR Überflieger program; incomplete.

`REXUS/BEXUS (Launch)` Years in which an experiment of the team was launched with REXUS/BEXUS. Note: REXUS/BEXUS projects generally follow a 2-year cycle, so each experiment started development in the preceding year, sometimes even earlier.

`RXBX` Indicates if the team participated in REXUS/BEXUS at least once (automatically filled).

`C'Space` Years in which the team participated in the French CNES C'Space program; incomplete.

`UKSEDS Olympus Rover Trials`  Years in which the team participated in the UK's UKSEDS Olympus Rover Trials program; incomplete.

`STERN` Years in which the team participated in the German DLR STERN program; incomplete.

`Cubesats (independent)`, `Balloons (independent)`, `CanSats (independent)`, `Rockets (other)`, `Robots (other)` Any satellite, balloon, cansat, rocketry or robotics activity outside the mentioned programmes; partially filled but incomplete.

# Author
Maximilian von Arnim, ISAE-SUPAERO (2026)