import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:musical_app_practice/core/database/database_models/song_model.dart';
import 'package:musical_app_practice/providers/cart_provider.dart';
import 'package:musical_app_practice/providers/song_provider.dart';
import 'package:musical_app_practice/screens/home_screen.dart';
import 'package:provider/provider.dart';



// Mock SongProvider
class MockSongProvider extends ChangeNotifier implements SongProvider {
  @override
  List<Song> songs = [
    Song(
      id: '1',
      title: 'Test Song',
      artist: 'Test Artist',
      imageUrl: 'https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/6e/c9/00/6ec900c4-31cd-bde1-2eb1-b47bcfcc9c55/886443650176.jpg/170x170bb.png',
    ),
  ];

  @override
  bool isLoading = false;

  @override
  String? error;

  @override
  Future<void> loadSongs() async {
    await Future.delayed(Duration(milliseconds: 500)); // simulate delay
    notifyListeners();
  }

  @override
  Future<void> loadSongsFromDb() {

    throw UnimplementedError();
  }
}

// Mock CartProvider
class MockCartProvider extends ChangeNotifier implements CartProvider {
  final List<Song> _cartItems = [];

  @override
  List<Song> get cartItems => _cartItems;

  @override
  void addToCart(Song song) {
    _cartItems.add(song);
    notifyListeners();
  }

  @override
  void removeFromCart(Song song) {
    _cartItems.removeWhere((s) => s.id == song.id);
    notifyListeners();
  }

  @override
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('HomeScreen - load songs and add to cart', (WidgetTester tester) async {
    final mockSongProvider = MockSongProvider();
    final mockCartProvider = MockCartProvider();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<SongProvider>.value(value: mockSongProvider),
          ChangeNotifierProvider<CartProvider>.value(value: mockCartProvider),
        ],
        child: const MaterialApp(home: HomeScreen()),
      ),
    );

    // Wait for UI to build
    await tester.pumpAndSettle();

    // Check that the test song is displayed
    expect(find.text('Test Song'), findsOneWidget);
    expect(find.text('Test Artist'), findsOneWidget);

    // Tap the add to cart icon
    final addToCartIcon = find.byIcon(Icons.add_shopping_cart);
    expect(addToCartIcon, findsOneWidget);

    await tester.tap(addToCartIcon);
    await tester.pumpAndSettle();

    // The icon should now be a check_circle (added to cart)
    expect(find.byIcon(Icons.check_circle), findsOneWidget);

    // Cart badge should show '1'
    expect(find.text('1'), findsOneWidget);
  });
}
