import 'package:musical_app_practice/core/database/database_models/song_model.dart';
import 'package:musical_app_practice/models/song_response_model.dart';

Song mapEntryToSong(Entry entry) {
  return Song(
    id: entry.id?.attributes?.imId ?? '',
    title: entry.title?.label ?? '',
    artist: entry.imArtist?.label ?? '',
    imageUrl: entry.imImage?.last.label ?? '',
    audioUrl:
        entry.link
            ?.firstWhere(
              (link) => link.attributes?.type?.contains('audio') ?? false,
              orElse: () => EntryLink(attributes: FluffyAttributes(href: '')),
            )
            .attributes
            ?.href,
  );
}
