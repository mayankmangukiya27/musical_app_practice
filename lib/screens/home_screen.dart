import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musical_app_practice/providers/audio_player_provider.dart';
import 'package:musical_app_practice/routes/app_routing.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../providers/song_provider.dart';
import '../providers/cart_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<SongProvider>(context, listen: false).loadSongs();
    });
  }

  @override
  Widget build(BuildContext context) {
    final songProvider = Provider.of<SongProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Musical",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () => NavigationService.goToCart(context),
              ),
              if (cartProvider.cartItems.isNotEmpty)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${cartProvider.cartItems.length}',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: 10),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => songProvider.loadSongs(),
        child:
            songProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : songProvider.error != null
                ? Center(child: Text('Error: ${songProvider.error}'))
                : ListView.separated(
                  itemCount: songProvider.songs.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 12);
                  },
                  itemBuilder: (context, index) {
                    final song = songProvider.songs[index];

                    return Selector<CartProvider, bool>(
                      selector:
                          (_, cart) =>
                              cart.cartItems.any((item) => item.id == song.id),
                      builder: (context, isInCart, _) {
                        return ListTile(
                          leading: SizedBox(
                            height: 70,
                            width: 70,
                            child: Consumer<AudioPlayerProvider>(
                              builder: (context, audioProvider, _) {
                                final isCurrent =
                                    audioProvider.currentSong?.id == song.id;
                                final isLoading =
                                    isCurrent &&
                                    audioProvider
                                            .player
                                            .playerState
                                            .processingState ==
                                        ProcessingState.loading;

                                final progress =
                                    isCurrent &&
                                            audioProvider
                                                    .duration
                                                    .inMilliseconds >
                                                0
                                        ? audioProvider
                                                .position
                                                .inMilliseconds /
                                            audioProvider
                                                .duration
                                                .inMilliseconds
                                        : 0.0;

                                return GestureDetector(
                                  onTap: () async {
                                    if (!isCurrent ||
                                        !audioProvider.isPlaying) {
                                      await audioProvider.playSong(song);
                                    } else {
                                      audioProvider.togglePlayPause();
                                    }
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: song.imageUrl,
                                          fit: BoxFit.cover,
                                          placeholder:
                                              (context, url) =>
                                                  Shimmer.fromColors(
                                                    baseColor:
                                                        Colors.grey[300]!,
                                                    highlightColor:
                                                        Colors.grey[100]!,
                                                    child: Container(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                          errorWidget:
                                              (context, url, error) =>
                                                  const Icon(
                                                    Icons.broken_image,
                                                  ),
                                        ),
                                        if (isCurrent)
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.black.withValues(
                                                alpha: 0.4,
                                              ),
                                            ),
                                          ),
                                        if (isCurrent)
                                          Center(
                                            child:
                                                isLoading
                                                    ? const SizedBox(
                                                      width: 26,
                                                      height: 26,
                                                      child:
                                                          CircularProgressIndicator(
                                                            strokeWidth: 2.5,
                                                            color: Colors.white,
                                                          ),
                                                    )
                                                    : GestureDetector(
                                                      onTap:
                                                          () =>
                                                              audioProvider
                                                                  .togglePlayPause(),
                                                      child: Container(
                                                        width: 30,
                                                        height: 30,
                                                        decoration:
                                                            const BoxDecoration(
                                                              shape:
                                                                  BoxShape
                                                                      .circle,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                        child: Icon(
                                                          audioProvider
                                                                  .isPlaying
                                                              ? Icons.pause
                                                              : Icons
                                                                  .play_arrow,
                                                          size: 20,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                          ),
                                        /*  if (isCurrent && !isLoading)
                                          Positioned.fill(
                                            child: Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  bottom: 4.0,
                                                ),
                                                child: LinearProgressIndicator(
                                                  value: progress.clamp(
                                                    0.0,
                                                    1.0,
                                                  ),
                                                  backgroundColor:
                                                      Colors.white24,
                                                  color:
                                                      Colors.deepPurpleAccent,
                                                  minHeight: 3,
                                                ),
                                              ),
                                            ),
                                          ), */
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          /* ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                              imageUrl: song.imageUrl,
                              fit: BoxFit.cover,
                              height: 70,
                              width: 70,
                              placeholder:
                                  (context, url) => Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      color: Colors.grey,
                                      width: 60,
                                      height: 60,
                                    ),
                                  ),
                              errorWidget:
                                  (context, url, error) =>
                                      const Icon(Icons.broken_image),
                            ),
                          ), */
                          title: Text(
                            song.title,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            song.artist,
                            style: TextStyle(color: Colors.grey),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              isInCart
                                  ? Icons.check_circle
                                  : Icons.add_shopping_cart,
                              color: isInCart ? Colors.green : null,
                            ),
                            onPressed: () {
                              if (!isInCart) {
                                context.read<CartProvider>().addToCart(song);
                              } else {
                                context.read<CartProvider>().removeFromCart(
                                  song,
                                );
                              }
                            },
                          ),
                          onTap: () async {
                            final player =
                                context.read<AudioPlayerProvider>().player;

                            if (player.playing) {
                              await player.pause();
                            }
                            NavigationService.goToSongDetails(
                              context: context,
                              songId: song,
                            );
                          },
                        );
                      },
                    );
                  },
                ),
      ),
    );
  }
}
