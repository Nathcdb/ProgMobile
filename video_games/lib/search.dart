import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:video_games/data_provider.dart';
import 'package:video_games/game.dart';

import 'detail.dart';
import 'utils.dart';

class SearchGame extends StatefulWidget {
  const SearchGame({super.key});

  @override
  State<SearchGame> createState() => _SearchGameState();
}

class _SearchGameState extends State<SearchGame> {
  final searchCont = TextEditingController();
  final focusNode = FocusNode();
  List<Game> games = [];
  List<Game> filtered = [];
  @override
  void initState() {
    focusNode.requestFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    games = Provider.of<Database>(context).games;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recherche'),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset('assets/close.svg')),
        leadingWidth: 20,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              onChanged: (value) {
                if (value.isEmpty) {
                  filtered.clear();
                  filtered.addAll(games);
                } else {
                  filtered.clear();
                  for (Game game in games) {
                    if (game.gameId.data.name
                        .toLowerCase()
                        .contains(value.toLowerCase())) {
                      filtered.add(game);
                    }
                  }
                }
                setState(() {});
              },
              focusNode: focusNode,
              controller: searchCont,
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
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                Data data = filtered[index].gameId.data;
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.name,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 17),
                                    ),
                                    Text(
                                      data.publishers[0],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
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
                                  game: filtered[index],
                                ),
                                context);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            backgroundColor:
                                const Color.fromARGB(255, 26, 118, 193),
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
    );
  }
}
