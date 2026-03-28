import 'package:firebase_practice/model/songs/song_with_artist.dart';
import 'package:flutter/material.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../../data/repositories/artists/artist_repository.dart';
import '../../../states/player_state.dart';
import '../../../../model/songs/song.dart';
import '../../../../model/artists/artist.dart';
import '../../../utils/async_value.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final ArtistRepository artistRepository;
  final PlayerState playerState;

  AsyncValue<List<SongWithArtist>> songsValue = AsyncValue.loading();

  LibraryViewModel({required this.songRepository, required this.artistRepository, required this.playerState}) {
    playerState.addListener(notifyListeners);

    // init
    _init();
  }

  @override
  void dispose() {
    playerState.removeListener(notifyListeners);
    super.dispose();
  }

  void _init() async {
    fetchSong();
  }

  void fetchSong() async {
    // 1- Loading state
    songsValue = AsyncValue.loading();
    notifyListeners();

    try {
     final results = await Future.wait([
      songRepository.fetchSongs(),
      artistRepository.fetchArtists(),
     ]);

     final songs = results[0] as List<Song>;
     final artists = results[1] as List<Artist>;

     final artistMap = { for (var a in artists) a.id : a };

     final joined = songs
          .where((s) => artistMap.containsKey(s.artistId))
          .map((s) => SongWithArtist(song: s, artist: artistMap[s.artistId]!))
          .toList();

     songsValue = AsyncValue.success(joined);
    } catch (e) {
      // 3- Fetch is unsucessfull
      songsValue = AsyncValue.error(e);
    }
     notifyListeners();

  }

  bool isSongPlaying(SongWithArtist item) => playerState.currentSong == item.song;

  void start(SongWithArtist item) => playerState.start(item.song);
  void stop () => playerState.stop();
}
