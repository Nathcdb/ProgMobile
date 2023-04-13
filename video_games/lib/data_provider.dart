import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:video_games/game.dart';
import 'package:video_games/top_games.dart';

class Database extends ChangeNotifier {
  List<Game> games = [];
  List<Game> likes = [];
  List<Game> favorites = [];
  Database() {
    loadData();
    loadFavs();
    loadLikes();
  }
  loadLikes() async {
    FirebaseFirestore.instance
        .collection('likes')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      likes = List.generate(value.size, (index) {
        Game g = gameFromJson(
          value.docs[index].data()['json'],
          value.docs[index].data()['id'],
        );
        g.reff = value.docs[index].reference;
        return g;
      });
      notifyListeners();
    });
  }

  loadFavs() async {
    FirebaseFirestore.instance
        .collection('favorites')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      favorites = List.generate(value.size, (index) {
        Game g = gameFromJson(
          value.docs[index].data()['json'],
          value.docs[index].data()['id'],
        );
        g.reff = value.docs[index].reference;
        return g;
      });
      notifyListeners();
    });
  }

  loadData() async {
    final res = await http.get(
      Uri.parse(
          'https://api.steampowered.com/ISteamChartsService/GetMostPlayedGames/v1/?'),
    );
    TopGames topGames = topGamesFromJson(res.body);
    int failed = 0;
    for (Rank rank in topGames.response.ranks) {
      final gameRes = await http.get(Uri.parse(
          'https://store.steampowered.com/api/appdetails?appids=${rank.appid}'));
      try {
        games.add(gameFromJson(gameRes.body, rank.appid.toString()));
        notifyListeners();
      } catch (e) {
        failed++;
      }
    }
  }

  bool isLiked(Game game) {
    return likes
        .where((element) =>
            element.gameId.data.steamAppid == game.gameId.data.steamAppid)
        .isNotEmpty;
  }

  bool isInWishList(Game game) {
    return favorites
        .where((element) =>
            element.gameId.data.steamAppid == game.gameId.data.steamAppid)
        .isNotEmpty;
  }

  like(Game game) async {
    if (isLiked(game)) {
      likes.remove(game);
      game.reff!.delete();
    } else {
      likes.add(game);
      final reff = await FirebaseFirestore.instance.collection('likes').add({
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'json': gameToJson(game),
        'id': game.gameId.data.steamAppid.toString(),
      });
      likes[likes.indexOf(game)].reff = reff;
    }
  }

  addToWishList(Game game) async {
    if (isInWishList(game)) {
      favorites.remove(game);
      game.reff!.delete();
    } else {
      favorites.add(game);
      final reff =
          await FirebaseFirestore.instance.collection('favorites').add({
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'json': gameToJson(game),
        'id': game.gameId.data.steamAppid.toString(),
      });
      favorites[favorites.indexOf(game)].reff = reff;
    }
  }
}
