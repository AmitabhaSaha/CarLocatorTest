# CarLocatorTest

Requirement: 

Implement an iOS app that retrieves and displays our cars both on a map and on a list.
• The list of cars can be found at https://cdn.sixt.io/codingtask/cars
• In case any car images are missing, use a fall-back image.
• You may use any external frameworks and libraries you like, just add a short note explaining why
you chose them.
• Please use Swift with the latest devtools.
• Show us what you care about when it comes to architecture, structure, clean code, UI/UX, error-
handling and automated testing.
• Share your code with us either via Github, Bitbucket, zip file. Etc.

## UI: 
- UI is optimised for iOS 15 iPhone / iPod devices, Landscape mode

![Alt text](CarLocator/Documentation/IMG_3729.PNG "Map View")
![Alt text](CarLocator/Documentation/IMG_3730.PNG "List View")

## Setup:
- Application also runs on m1 based Macs (Compatibility mode)
- Xcode used 13 Beta 

## Architecture: 
- MVVM-C Architure followed. 

## 3rdParty Frameworks:
- MBProgressHUD 3rd party HUD spinner used 

## Applicaiton Info:
- Network Layer is written from scratch
- Cache is sued for storing Car images. Cache can be improoved.
- Orange color used as  primary color 
- Only English language is used 
- Error Handling done, but can be improved


## XCT 
- Code Coverage 60% overall 
- Tried to test entire business logic 
