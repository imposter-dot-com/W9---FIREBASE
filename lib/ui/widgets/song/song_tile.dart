import 'package:flutter/material.dart';

import '../../../model/songs/song_with_artist.dart';

class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.song,
    required this.isPlaying,
    required this.onTap,
  });

  final SongWithArtist song;
  final bool isPlaying;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15)
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(20),
          onTap: onTap,
          leading: CircleAvatar(radius: 25, backgroundColor: Colors.grey[300], backgroundImage: NetworkImage(song.song.imageUrl.toString())),
          title: Text(song.song.title),
          subtitle: Text('${song.durationFormatted}   ${song.artist.name} - ${song.artist.genre}'),
          trailing: Text(
            isPlaying ? "Playing" : "",
            style: TextStyle(color: Colors.amber),
          ),
        ),
      ),
    );
  }
}
