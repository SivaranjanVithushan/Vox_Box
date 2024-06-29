# VoxBox Chat Room Application

VoxBox is a real-time chat application built using Flutter, Firebase Authentication, Firebase Realtime Database, and Firebase Storage. This application allows users to create and join chat rooms, send text messages, and share images within chat rooms. Additionally, users can copy the Box ID to share it with others for easy access to the chat room.

## Features

- **User Authentication**: Users can sign in using Google Sign-In.
- **Create and Join Chat Rooms**: Users can create new chat rooms and join existing ones using a Box ID.
- **Real-Time Messaging**: Messages are sent and received in real-time using Firebase Realtime Database.
- **Send Images**: Users can select images from their gallery and send them in the chat.
- **Copy Box ID**: Users can copy the Box ID to the clipboard to share it with others.

## Implementation Choices

### User Authentication

- **Firebase Authentication**: The application uses Firebase Authentication for user sign-in. Google Sign-In is implemented to allow users to authenticate with their Google accounts.

### Real-Time Messaging

- **Firebase Realtime Database**: The chat messages are stored in Firebase Realtime Database, allowing real-time synchronization of messages across all clients.


### Additional Features

#### Image Sharing

- **Firebase Storage**: Images are uploaded to Firebase Storage, and the image URLs are stored in the Realtime Database as part of the message data.
- **Image Picker**: The `image_picker` package is used to allow users to select images from their gallery.

#### Copy Box ID
- **Copy Box ID**: Users can copy the Box ID to their clipboard, making it easy to share the chat room ID with others. This feature uses the `clipboard` package.

## Code Structure

### Main Files

- `main.dart`: Entry point of the application, initializes Firebase and sets up the main app structure.
- `splash_screen`: SplashScreen for initializing the app and handling initial setup.
- `home_screen`:  Main screen of the application, providing navigation and options for users.
- - `create_room_dialog.dart`: Dialog for creating new chat rooms.
- `join_room_dialog.dart`: Dialog for joining existing chat rooms.
- `chat_screen.dart`: Main chat screen where users can send and receive messages.
- `message_bubble.dart`: Widget for displaying individual chat messages.
- `message.dart`: Model class for chat messages.
- `custom_app_bar.dart`: Custom app bar used in the application.

### Dependencies

Ensure the following dependencies are included in your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^1.10.0
  firebase_auth: ^3.1.6
  firebase_database: ^10.0.4
  firebase_storage: ^10.0.3
  google_sign_in: ^5.1.0
  image_picker: ^0.8.4+4
  clipboard: ^0.1.4
  flutter_svg: ^1.0.0
```

## Setup Instructions

1. **Clone the Repository**:

    ```bash
    [git clone https://github.com/yourusername/voxbox-chat-app.git](https://github.com/SivaranjanVithushan/Vox_Box.git)
    cd voxbox
    ```

2. **Install Dependencies**:

    ```bash
    flutter pub get
    ```

3. **Configure Firebase**:

    - Add your `google-services.json` file to the `android/app` directory.
    - Add your `GoogleService-Info.plist` file to the `ios/Runner` directory.
    - Update Firebase Realtime Database and Firebase Storage rules to allow authenticated access.

4. **Run the Application**:

    ```bash
    flutter run
    ```

## Firebase Configuration

Ensure your Firebase rules are set as follows:

### Firebase Storage Rules:

```plaintext
service firebase.storage {
  match /b/{bucket}/o {
    match /{allPaths=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

### Firebase Realtime Database Rules:

```plaintext
{
  "rules": {
    ".read": "auth != null",
    ".write": "auth != null"
  }
}
```

## Usage

- **Create a Chat Room**: Click the "Create Room" button, enter a room name, and start chatting.
- **Join a Chat Room**: Click the "Join Room" button, enter the Box ID, and start chatting.
- **Send a Message**: Type a message and click the send button.
- **Send an Image**: Click the image icon, select an image from your gallery, and send it.
- **Copy Box ID**: Click the copy icon in the app bar to copy the Box ID to your clipboard.
  
---
