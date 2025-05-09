In this Project we have used Flutter SDK version is 3.29.3

In this project we have used Provider state management
Why we choose Provider state management technique:-

-Provider is recommended by the Flutter team and well-integrated with the core framework. It’s stable and has long-term support.
-Provider uses basic Dart/Flutter concepts like ChangeNotifier and BuildContext, making it easy to learn for beginners.
-Compared to BLoC, it requires less code to achieve the same results.
-Perfect for apps where you don’t need complex event streams or architecture.
-Plenty of examples, tutorials, and community support make troubleshooting easier.

Screen and UI overview
Home Screen:
 - Displays a list of songs with album posters and artist names.
 - Player Integration: A mini audio player is displayed when a song is playing. Tapping the poster toggles blur overlay, play/pause, and shows the current progress.
 - Cart Support: Users can add or remove songs from their cart with a single tap. Cart icon shows total selected songs.

Song Details
 - Shows full details of a selected song (title, artist, album, release date).
 - Integrated audio playback using just_audio.

Cart
 - checkout/remove product

Data Handling
    - Local storage with Hive is used to cache API responses.
    - On the first app launch, songs are fetched from the remote API.
    - On subsequent launches, data is loaded from the local database for faster performance and offline access.

In this Project we have used MVVM Architecture:

Why we have used MVVM architecture:-
 Model:-     Business logic, data, and API layer                                         
 View:-       UI code (widgets), listens to changes                                       
 ViewModel:- Acts as a bridge between View and Model, manages state and logic for the UI 

-With logic in the ViewModel, you can write unit tests for your logic without needing to spin up UI widgets.
-MVVM fits naturally with state management libraries like:
    -Provider
    -Riverpod
    -BLoC
    -MobX    
        Because ViewModel is where state lives and changes, tools like ChangeNotifier plug in cleanly.

-Logic in ViewModels can be reused across multiple views.
-Views remain declarative and lightweight, focused only on rendering UI.

We have tested 
Home screen 
Cart screen
Test case is in test code
