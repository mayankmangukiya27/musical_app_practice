import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:musical_app_practice/core/database/database_models/song_model.dart';
import 'package:musical_app_practice/screens/song_details_screen.dart';
import 'package:network_image_mock/network_image_mock.dart';




void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('SongDetailScreen displays song info and loads audio UI',
          (WidgetTester tester) async {
        final song = Song(
          id: '1',
          title: 'Test Song',
          artist: 'Test Artist',
          imageUrl: 'https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/6e/c9/00/6ec900c4-31cd-bde1-2eb1-b47bcfcc9c55/886443650176.jpg/170x170bb.png',
          album: 'Test Album',
          releaseDate: '2024-01-01',
          audioUrl: 'https://example.com/audio.mp3',
        );

       await mockNetworkImagesFor(()async{
         await tester.pumpWidget(
           MaterialApp(
             home: SongDetailScreen(song: song),
           ),
         );
       });

        // Let UI settle and audio initialize (if mocked later)
        await tester.pump(const Duration(seconds: 3)); // simulate async loading

        // Check UI elements
        expect(find.text('Test Song'), findsOneWidget);
        expect(find.text('👤 Test Artist'), findsOneWidget);
        expect(find.text('💿 Test Album'), findsOneWidget);
        expect(find.text('📅 2024-01-01'), findsOneWidget);

        // Wait until audio is ready and play/pause button appears
        await tester.pumpAndSettle();

        // Ensure slider and button exist (audio player initialized)
        expect(find.byType(Slider), findsOneWidget);
        expect(find.byType(ElevatedButton), findsOneWidget);

        // Tap the play button if enabled
        final playButton = find.byType(ElevatedButton);
        if (playButton.evaluate().isNotEmpty &&
            playButton.evaluate().first.widget is ElevatedButton &&
            (playButton.evaluate().first.widget as ElevatedButton).onPressed != null) {
          await tester.tap(playButton);
          await tester.pumpAndSettle();
        }
      });
}
