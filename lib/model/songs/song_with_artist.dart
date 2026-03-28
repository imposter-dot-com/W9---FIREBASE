import '../artists/artist.dart';
import 'song.dart';

class SongWithArtist {
  final Song song;
  final Artist artist;

  const SongWithArtist({required this.song, required this.artist});

  String get title => song.title;
  String get artistName => artist.name;
  String get genre => artist.genre;
  Uri get songImageUrl => song.imageUrl;
  Uri get artistImageUrl => artist.imageUrl;
  Duration get duration => song.duration;

  String get durationFormatted {
    final minutes = song.duration.inMinutes;
    final seconds = song.duration.inSeconds % 60;
    return '$minutes:${seconds.toString()} mins';
  }

}