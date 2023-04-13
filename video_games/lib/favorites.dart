import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:video_games/data_provider.dart';

import 'detail.dart';
import 'game.dart';
import 'utils.dart';

class WishList extends StatefulWidget {
  const WishList({super.key});

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  List<Game> games = [];
  @override
  Widget build(BuildContext context) {
    games = Provider.of<Database>(context).favorites;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: SvgPicture.asset(
            'assets/close.svg',
            fit: BoxFit.contain,
            width: 16,
            height: 16,
          ),
        ),
        leadingWidth: 20,
        automaticallyImplyLeading: false,
        title: const Text('Ma liste de souhaits'),
      ),
      body: games.isEmpty
          ? Center(
              child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/empty_whishlist.svg',
                  width: 100,
                  height: 100,
                ),
                space(50),
                const Text(
                  "Vous n'avez encore pas liké de contenu.\nCliquez sur le coeur pour en rajouter.",
                  textAlign: TextAlign.center,
                )
              ],
            ))
          : ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
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
                          onPressed: () async {
                            await goto(
                                Details(
                                  game: games[index],
                                ),
                                context);
                            setState(() {});
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
    );
  }
}
