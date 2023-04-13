import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_games/data_provider.dart';
import 'package:video_games/detail.dart';
import 'package:video_games/favorites.dart';
import 'package:video_games/likes.dart';
import 'package:video_games/search.dart';
import 'package:video_games/utils.dart';

import 'game.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Game> games = [];
  Game? featured;
  @override
  Widget build(BuildContext context) {
    games = Provider.of<Database>(context).games;
    if (featured == null && games.isNotEmpty) {
      featured = games[0];
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Accueil',
        ),
        actions: [
          IconButton(
            onPressed: () {
              goto(const MyLikes(), context);
            },
            icon: const Icon(
              CupertinoIcons.heart,
            ),
          ),
          IconButton(
            onPressed: () {
              goto(const WishList(), context);
            },
            icon: const Icon(
              CupertinoIcons.star,
            ),
          ),
        ],
      ),
      body: games.isEmpty
          ? Center(
              child: CircularProgressIndicator(color: blue),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    onTap: () {
                      goto(const SearchGame(), context);
                    },
                    readOnly: true,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      fillColor: Color.fromARGB(255, 29, 36, 47),
                      filled: true,
                      hintText: 'Rechercher un jeu...',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      suffixIcon: Icon(
                        Icons.search,
                        color: Colors.blue,
                      ),
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                AspectRatio(
                  aspectRatio: 1.7,
                  child: Stack(
                    children: [
                      Image.network(featured!.gameId.data.backgroundRaw),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                      featured!.gameId.data.name,
                                      style: const TextStyle(
                                        fontSize: 22,
                                      ),
                                    ),
                                  ),
                                  space(10),
                                  Text(
                                    featured!.gameId.data.shortDescription,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  space(10),
                                  ElevatedButton(
                                    onPressed: () {
                                      goto(Details(game: featured!), context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.only(
                                          left: 50, right: 50),
                                      backgroundColor: blue,
                                    ),
                                    child: const Text(
                                      'En savoir plus',
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              height: 150,
                              child: Image.network(
                                featured!.gameId.data.headerImage,
                                fit: BoxFit.cover,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                space(15),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Les meilleures ventes',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 10,
                            ),
                            itemCount: games.length,
                            itemBuilder: (context, index) {
                              Data data = games[index].gameId.data;
                              return SizedBox(
                                height: 100,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        child: Row(
                                          children: [
                                            AspectRatio(
                                              aspectRatio: .8,
                                              child: Image.network(
                                                data.headerImage,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            space(10),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    data.name,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 17),
                                                  ),
                                                  Text(
                                                    data.publishers[0],
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  // space(5),
                                                  Text(
                                                      'Prix: ${data.isFree ? 'Free' : (data.priceOverview?.priceOverviewFinal ?? 0)}${data.priceOverview?.currency ?? ''}')
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 120,
                                      height: double.maxFinite,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          goto(
                                              Details(
                                                game: games[index],
                                              ),
                                              context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.only(
                                              left: 15, right: 15),
                                          backgroundColor: const Color.fromARGB(
                                              255, 26, 118, 193),
                                        ),
                                        child: const Text(
                                          'En savoir plus',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
