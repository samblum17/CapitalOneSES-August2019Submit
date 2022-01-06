<img src="https://github.com/samblum17/CapitalOneSES-August2019Submit/blob/master/CapitalOneSES-August2019Submit/CapitalOneSES-August2019Submit/Assets.xcassets/NPS%20Kiosk%202.1%20Marketing.001.png?raw=true">

###### Winning submission of the Capital One Software Engineering summit (August 2019)
[Download today on the App Store](https://apps.apple.com/us/app/national-park-kiosk/id1465222121)

## Description
National Park Kiosk is your go-to quick guide for planning your next adventure to any US National Park.

The National Parks have been a staple of America for over 100 years, and the National Park Service (NPS) has been the primary contributor to their success in both preserving beauty and ensuring the safety of visitors. National Park Kiosk uses data pulled directly from the NPS API, so it's always updated and accessible. This is your one-stop destination for finding important, concise information to help plan your next National Park adventure. 

You can use NPS Kiosk to:
- Search for specific information with state filtering and relevance-based keyword search
- Explore suggested things to do recommended by and for specific national parks
- Find details about specific visitor centers and nearby campgrounds.
- Stay up to date with alerts, articles, events, and news releases
- View an interactive map of the park and surrounding area
- Learn more about your destination with educational information including classroom lesson plans and guides on relevant people and places
- Access the full park website directly within the app

National Park Kiosk was proudly recognized as a coding challenge winning submission to the 2019 Capital One Software Engineering Summit.

## Prerequisites
National Park Kiosk is an iOS Application that is designed to run on iPhones running iOS 12+ and Macs with Apple silicon.

## Installing and Testing
National Park Kiosk is available on the iOS App Store. It can be downloaded directly from your iPhone running iOS 12+ [here](https://apps.apple.com/us/app/national-park-kiosk/id1465222121). Testing of this application can be done in the Xcode iOS Simulator or Xcode 11 live preview. Download all project files onto a Mac running macOS Mojave or later.

## Built With
Although the coding challenge called for a live, deployable web app, I consulted with Capital One engineers on the MindSumo forum and was granted permission to create an iOS Application instead, given my passion for iOS development. Therefore, National Park Kiosk was designed, developed, and tested in Xcode 10.2. It uses native iOS Frameworks including [Foundation](https://developer.apple.com/documentation/foundation) and [UIKit](https://developer.apple.com/documentation/uikit) to build table views and a navigation view controller for a seamless user experience. This application decodes JSON using Swift 5 syntax. The JSON data is pulled directly from the [National Park Service API](https://www.nps.gov/subjects/developer/api-documentation.htm#/) and stored into custom Swift types.
[August 2019 coding challenge can be accessed here.](https://www.mindsumo.com/contests/national-park-api)

## Authors
This application was designed, developed, and tested entirely and solely by Sam Blum. At the time of this publication, Sam Blum is a 19 year old rising sophomore studying Computer Science at Vanderbilt University. He began teaching himself the Swift Programming Language for designing native iOS Apps during the second semester of his senior year of high school in Fort Lauderdale, Florida, and is now a registered [Apple Developer](https://apps.apple.com/us/developer/sam-blum/id1448067874). He continued learning how to code when he took his first Java programming course at Vanderbilt in the Spring of his freshman year. He plans to continue learning C++ and Python this year.

## Acknowledgments
I'd like to thank Capital One for choosing me as a semifinalist for the Software Engineering Summit. I'd like to thank Apple as always for their extremely helpful resources on learning the fundamentals of Swift and Xcode. Additionally I'd like to thank the entire developer community for always being repsonsive to online forums and personal DMs on Twitter. And finally I'd like to thank my family for always pushing me to continue learning and developing even when it got tough.



//Last updated for Version 3.3 on January 6, 2022:
- Introducing "Things To Do"
NPS Kiosk now helps you brainstorm activities for popular National Parks! After selecting a park, explore suggested things to do recommended by the National Park Service for that specific park. Each activity displays location, description, price, and reservation information. Never run out of ideas for your itinerary again!

- Minor bug fixes
