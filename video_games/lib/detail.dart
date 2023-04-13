import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:video_games/data_provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'game.dart';
import 'utils.dart';

class Details extends StatefulWidget {
  final Game game;
  const Details({super.key, required this.game});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int selected = 0;
  List<String?> heading = [];
  List<String?> reviews = [];
  List<double?> rating = [];
  List<double?> ratingTotal = [];
  @override
  void initState() {
    String reviewsString = widget.game.gameId.data.reviews;
    if (reviewsString.trim().isNotEmpty) {
      RegExp exp = RegExp(r'“(.*?)”');
      final headingRegex = RegExp(r'<a.*?>(.*?)<\/a>');
      final ratingRegex = RegExp(r'(?<!\d)\d{1,2}\.?\d?\/(?:10{1,2})(?!\d)');
      Iterable<Match> matches = exp.allMatches(reviewsString);
      Iterable<Match> hmatches = headingRegex.allMatches(reviewsString);
      Iterable<Match> rmatches = ratingRegex.allMatches(reviewsString);
      reviews = matches.map((match) => match.group(1)).toList();
      rmatches.map((match) => match.group(0)).toList().forEach((element) {
        List<String> data = element!.split("/");
        rating.add(double.parse(data[0]));
        ratingTotal.add(double.parse(data[1]));
      });
      heading = hmatches.map((match) => match.group(1)).toList();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail du jeu',
        ),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<Database>(context, listen: false).like(widget.game);
              setState(() {});
            },
            icon: Provider.of<Database>(context, listen: false)
                    .isLiked(widget.game)
                ? SvgPicture.asset('assets/like_full.svg')
                : SvgPicture.asset('assets/like.svg'),
          ),
          IconButton(
            onPressed: () {
              Provider.of<Database>(context, listen: false)
                  .addToWishList(widget.game);
              setState(() {});
            },
            icon: Provider.of<Database>(context, listen: false)
                    .isInWishList(widget.game)
                ? SvgPicture.asset('assets/whishlist_full.svg')
                : SvgPicture.asset('assets/whishlist.svg'),
          ),
        ],
      ),
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .4,
                width: double.maxFinite,
                child: Image.network(
                  widget.game.gameId.data.screenshots[1].pathFull,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: -75,
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      image:
                          NetworkImage(widget.game.gameId.data.backgroundRaw),
                      onError: (exception, stackTrace) {},
                      fit: BoxFit.cover,
                    ),
                  ),
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  padding: const EdgeInsets.all(10),
                  height: 150,
                  width: MediaQuery.of(context).size.width * .9,
                  child: SizedBox(
                    height: 150,
                    child: Row(
                      children: [
                        AspectRatio(
                          aspectRatio: .8,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(
                              widget.game.gameId.data.headerImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        space(10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.game.gameId.data.name,
                                style: const TextStyle(fontSize: 17),
                              ),
                              Text(widget.game.gameId.data.publishers[0]),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          space(90),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: blue),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selected = 0;
                                });
                              },
                              child: Container(
                                height: double.maxFinite,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color:
                                      selected == 0 ? blue : Colors.transparent,
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    topLeft: Radius.circular(5),
                                  ),
                                ),
                                child: const Text(
                                  'DESCRIPTION',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selected = 1;
                                });
                              },
                              child: Container(
                                height: double.maxFinite,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color:
                                      selected == 1 ? blue : Colors.transparent,
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  ),
                                ),
                                child: const Text(
                                  'AVIS',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  space(10),
                  Expanded(
                    child: selected == 0
                        ? SingleChildScrollView(
                            child: Text(
                              widget.game.gameId.data.detailedDescription,
                            ),
                          )
                        : ListView.separated(
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: grey,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            heading[index]!,
                                            style: const TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                        RatingBarIndicator(
                                          itemBuilder: (context, index) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          rating: (rating[index]! /
                                                  ratingTotal[index]!) *
                                              100,
                                          itemCount: 5,
                                          itemSize: 15,
                                        )
                                      ],
                                    ),
                                    Text(
                                      reviews[index]!,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 5,
                            ),
                            itemCount: rating.length,
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
