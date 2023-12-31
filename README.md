# ace_flash

Source Code for Full Stack AceFlash App - Works on Android & iOS!

## Features
- Sign Up With Email, Password
- Sign In With Email, Password
- Flashcard Introduction
- Select Flashcard Forward or Backword In Order
- Randomly Pickup Flashcard
- Flip Flashcard Front (Question) and Back (Answer)
- Create a New Flashcard 
- Submit a New Flashcard 
- Navigation to Home Page or Different Page
- Log Out

## Installation
After cloning this repository, migrate to `ace_flash` folder. Then, follow the following steps:
- Install Appwrite (Installation Steps [here](https://appwrite.io/docs/installation)
- Create Appwrite Project Locally
- Create Android & iOS Apps in the Dashboard
- Create Appwrite Database
- Modify Roles in Auth, Database
- Create Attributes for Users, aceFlash Collection
- Copy the required ids & change it in `lib/constants/appwrite_constants.dart`
- Change your IP Address in `lib/constants/appwrite_constants.dart`

Then run the following commands to run your app:
```bash
  flutter pub get
  open -a simulator (to get iOS Simulator)
  flutter run
```

## Tech Used
**Server**: Appwrite Auth, Appwrite Database, Appwrite Realtime

**Client**: Flutter, Riverpod, Dart