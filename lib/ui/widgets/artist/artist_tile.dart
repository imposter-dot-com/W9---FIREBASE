import 'package:firebase_practice/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import '../../../model/artists/artist.dart';

class ArtistTile extends StatelessWidget {
  const ArtistTile({super.key, required this.artist});

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(20),
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.grey[300],
            backgroundImage: NetworkImage(artist.imageUrl.toString()),
          ),
          title: Text(artist.name),
          subtitle: Text(artist.genre, style: AppTextStyles.title.copyWith(fontSize: 14)),
        ),
      ),
    );
  }
}
