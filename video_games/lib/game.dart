import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Game gameFromJson(String str, String id) => Game.fromJson(json.decode(str), id);

String gameToJson(Game data) => json.encode(data.toJson());

class Game {
  Game({
    required this.gameId,
  });

  GameId gameId;
  DocumentReference? reff;

  factory Game.fromJson(Map<String, dynamic> json, String id) => Game(
        gameId: GameId.fromJson(json[id]),
      );

  Map<String, dynamic> toJson() => {
        "${gameId.data.steamAppid}": gameId.toJson(),
      };
}

class GameId {
  GameId({
    required this.success,
    required this.data,
  });

  bool success;
  Data data;

  factory GameId.fromJson(Map<String, dynamic> json) => GameId(
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.type,
    required this.name,
    required this.steamAppid,
    required this.requiredAge,
    required this.isFree,
    required this.dlc,
    required this.detailedDescription,
    required this.aboutTheGame,
    required this.shortDescription,
    // required this.supportedLanguages,
    required this.headerImage,
    // required this.website,
    // required this.pcRequirements,
    // required this.legalNotice,
    required this.developers,
    required this.publishers,
    required this.priceOverview,
    // required this.packages,
    // required this.packageGroups,
    // required this.platforms,
    // required this.categories,
    // required this.genres,
    required this.screenshots,
    // required this.movies,
    required this.recommendations,
    required this.achievements,
    required this.releaseDate,
    required this.supportInfo,
    required this.background,
    required this.reviews,
    required this.backgroundRaw,
    // required this.contentDescriptors,
  });

  String type;
  String name;
  int steamAppid;
  String reviews;
  dynamic requiredAge;
  bool isFree;
  List<int>? dlc;
  String detailedDescription;
  String aboutTheGame;
  String shortDescription;
  // String supportedLanguages;
  String headerImage;
  // String? website;
  // PcRequirements pcRequirements;
  // String legalNotice;
  List<String> developers;
  List<String> publishers;
  PriceOverview? priceOverview;
  // List<int> packages;
  // List<PackageGroup> packageGroups;
  // Platforms platforms;
  // List<Category> categories;
  // List<Genre> genres;
  List<Screenshot> screenshots;
  // List<Movie> movies;
  Recommendations? recommendations;
  Achievements? achievements;
  ReleaseDate releaseDate;
  SupportInfo supportInfo;
  String background;
  String backgroundRaw;
  // ContentDescriptors contentDescriptors;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        type: json["type"],
        reviews: json['reviews'] ?? '',
        name: json["name"],
        steamAppid: json["steam_appid"],
        requiredAge: json["required_age"],
        isFree: json["is_free"],
        dlc: List<int>.from(json["dlc"]?.map((x) => x) ?? []),
        detailedDescription: json["detailed_description"],
        aboutTheGame: json["about_the_game"],
        shortDescription: json["short_description"],
        // supportedLanguages: json["supported_languages"],
        headerImage: json["header_image"],
        // website: json["website"],
        // pcRequirements: PcRequirements.fromJson(json["pc_requirements"]),
        // legalNotice: json["legal_notice"] ?? '',
        developers: List<String>.from(json["developers"].map((x) => x)),
        publishers: List<String>.from(json["publishers"].map((x) => x)),
        priceOverview: json["price_overview"] == null
            ? null
            : PriceOverview.fromJson(json["price_overview"]),
        // packages: List<int>.from(json["packages"]?.map((x) => x) ?? []),
        // packageGroups: List<PackageGroup>.from(
        // json["package_groups"].map((x) => PackageGroup.fromJson(x))),
        // platforms: Platforms.fromJson(json["platforms"]),
        // categories: List<Category>.from(
        //     json["categories"].map((x) => Category.fromJson(x))),
        // genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
        screenshots: List<Screenshot>.from(
            json["screenshots"].map((x) => Screenshot.fromJson(x))),
        // movies: List<Movie>.from(
        //     json["movies"]?.map((x) => Movie.fromJson(x)) ?? []),
        recommendations: json["recommendations"] == null
            ? null
            : Recommendations.fromJson(json["recommendations"]),
        achievements: json["achievements"] == null
            ? null
            : Achievements.fromJson(json["achievements"]),
        releaseDate: ReleaseDate.fromJson(json["release_date"]),
        supportInfo: SupportInfo.fromJson(json["support_info"]),
        background: json["background"],
        backgroundRaw: json["background_raw"],
        // contentDescriptors:
        //     ContentDescriptors.fromJson(json["content_descriptors"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "name": name,
        "reviews": reviews,
        "steam_appid": steamAppid,
        "required_age": requiredAge,
        "is_free": isFree,
        "dlc": dlc == null ? [] : List<dynamic>.from(dlc!.map((x) => x)),
        "detailed_description": detailedDescription,
        "about_the_game": aboutTheGame,
        "short_description": shortDescription,
        // "supported_languages": supportedLanguages,
        "header_image": headerImage,
        // "website": website,
        // "pc_requirements": pcRequirements.toJson(),
        // "legal_notice": legalNotice,
        "developers": List<dynamic>.from(developers.map((x) => x)),
        "publishers": List<dynamic>.from(publishers.map((x) => x)),
        "price_overview": priceOverview?.toJson(),
        // "packages": List<dynamic>.from(packages.map((x) => x)),
        // "package_groups":
        //     List<dynamic>.from(packageGroups.map((x) => x.toJson())),
        // "platforms": platforms.toJson(),
        // "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        // "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "screenshots": List<dynamic>.from(screenshots.map((x) => x.toJson())),
        // "movies": List<dynamic>.from(movies.map((x) => x.toJson())),
        // "recommendations": recommendations.toJson(),
        "achievements": achievements?.toJson(),
        "release_date": releaseDate.toJson(),
        "support_info": supportInfo.toJson(),
        "background": background,
        "background_raw": backgroundRaw,
        // "content_descriptors": contentDescriptors.toJson(),
      };
}

class Achievements {
  Achievements({
    required this.total,
    required this.highlighted,
  });

  int total;
  List<Highlighted> highlighted;

  factory Achievements.fromJson(Map<String, dynamic> json) => Achievements(
        total: json["total"],
        highlighted: List<Highlighted>.from(
            json["highlighted"].map((x) => Highlighted.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "highlighted": List<dynamic>.from(highlighted.map((x) => x.toJson())),
      };
}

class Highlighted {
  Highlighted({
    required this.name,
    required this.path,
  });

  String name;
  String path;

  factory Highlighted.fromJson(Map<String, dynamic> json) => Highlighted(
        name: json["name"],
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "path": path,
      };
}

class Category {
  Category({
    required this.id,
    required this.description,
  });

  int id;
  String description;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
      };
}

class ContentDescriptors {
  ContentDescriptors({
    required this.ids,
    this.notes,
  });

  List<dynamic> ids;
  dynamic notes;

  factory ContentDescriptors.fromJson(Map<String, dynamic> json) =>
      ContentDescriptors(
        ids: List<dynamic>.from(json["ids"].map((x) => x)),
        notes: json["notes"],
      );

  Map<String, dynamic> toJson() => {
        "ids": List<dynamic>.from(ids.map((x) => x)),
        "notes": notes,
      };
}

class Genre {
  Genre({
    required this.id,
    required this.description,
  });

  String id;
  String description;

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
      };
}

class Movie {
  Movie({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.webm,
    required this.mp4,
    required this.highlight,
  });

  int id;
  String name;
  String thumbnail;
  Mp4 webm;
  Mp4 mp4;
  bool highlight;

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json["id"],
        name: json["name"],
        thumbnail: json["thumbnail"],
        webm: Mp4.fromJson(json["webm"]),
        mp4: Mp4.fromJson(json["mp4"]),
        highlight: json["highlight"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "thumbnail": thumbnail,
        "webm": webm.toJson(),
        "mp4": mp4.toJson(),
        "highlight": highlight,
      };
}

class Mp4 {
  Mp4({
    required this.the480,
    required this.max,
  });

  String the480;
  String max;

  factory Mp4.fromJson(Map<String, dynamic> json) => Mp4(
        the480: json["480"],
        max: json["max"],
      );

  Map<String, dynamic> toJson() => {
        "480": the480,
        "max": max,
      };
}

class PackageGroup {
  PackageGroup({
    required this.name,
    required this.title,
    required this.description,
    required this.selectionText,
    required this.saveText,
    required this.displayType,
    required this.isRecurringSubscription,
    required this.subs,
  });

  String name;
  String title;
  String description;
  String selectionText;
  String saveText;
  dynamic displayType;
  String isRecurringSubscription;
  List<Sub> subs;

  factory PackageGroup.fromJson(Map<String, dynamic> json) => PackageGroup(
        name: json["name"],
        title: json["title"],
        description: json["description"],
        selectionText: json["selection_text"],
        saveText: json["save_text"],
        displayType: json["display_type"],
        isRecurringSubscription: json["is_recurring_subscription"],
        subs: List<Sub>.from(json["subs"].map((x) => Sub.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "title": title,
        "description": description,
        "selection_text": selectionText,
        "save_text": saveText,
        "display_type": displayType,
        "is_recurring_subscription": isRecurringSubscription,
        "subs": List<dynamic>.from(subs.map((x) => x.toJson())),
      };
}

class Sub {
  Sub({
    required this.packageid,
    required this.percentSavingsText,
    required this.percentSavings,
    required this.optionText,
    required this.optionDescription,
    required this.canGetFreeLicense,
    required this.isFreeLicense,
    required this.priceInCentsWithDiscount,
  });

  int packageid;
  String percentSavingsText;
  int percentSavings;
  String optionText;
  String optionDescription;
  String canGetFreeLicense;
  bool isFreeLicense;
  int priceInCentsWithDiscount;

  factory Sub.fromJson(Map<String, dynamic> json) => Sub(
        packageid: json["packageid"],
        percentSavingsText: json["percent_savings_text"],
        percentSavings: json["percent_savings"],
        optionText: json["option_text"],
        optionDescription: json["option_description"],
        canGetFreeLicense: json["can_get_free_license"],
        isFreeLicense: json["is_free_license"],
        priceInCentsWithDiscount: json["price_in_cents_with_discount"],
      );

  Map<String, dynamic> toJson() => {
        "packageid": packageid,
        "percent_savings_text": percentSavingsText,
        "percent_savings": percentSavings,
        "option_text": optionText,
        "option_description": optionDescription,
        "can_get_free_license": canGetFreeLicense,
        "is_free_license": isFreeLicense,
        "price_in_cents_with_discount": priceInCentsWithDiscount,
      };
}

class PcRequirements {
  PcRequirements({
    required this.minimum,
    required this.recommended,
  });

  String minimum;
  String recommended;

  factory PcRequirements.fromJson(Map<String, dynamic> json) => PcRequirements(
        minimum: json["minimum"] ?? '',
        recommended: json["recommended"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "minimum": minimum,
        "recommended": recommended,
      };
}

class Platforms {
  Platforms({
    required this.windows,
    required this.mac,
    required this.linux,
  });

  bool windows;
  bool mac;
  bool linux;

  factory Platforms.fromJson(Map<String, dynamic> json) => Platforms(
        windows: json["windows"],
        mac: json["mac"],
        linux: json["linux"],
      );

  Map<String, dynamic> toJson() => {
        "windows": windows,
        "mac": mac,
        "linux": linux,
      };
}

class PriceOverview {
  PriceOverview({
    required this.currency,
    required this.initial,
    required this.priceOverviewFinal,
    required this.discountPercent,
    required this.initialFormatted,
    required this.finalFormatted,
  });

  String currency;
  int initial;
  int priceOverviewFinal;
  int discountPercent;
  String initialFormatted;
  String finalFormatted;

  factory PriceOverview.fromJson(Map<String, dynamic> json) => PriceOverview(
        currency: json["currency"],
        initial: json["initial"],
        priceOverviewFinal: json["final"],
        discountPercent: json["discount_percent"],
        initialFormatted: json["initial_formatted"],
        finalFormatted: json["final_formatted"],
      );

  Map<String, dynamic> toJson() => {
        "currency": currency,
        "initial": initial,
        "final": priceOverviewFinal,
        "discount_percent": discountPercent,
        "initial_formatted": initialFormatted,
        "final_formatted": finalFormatted,
      };
}

class Recommendations {
  Recommendations({
    required this.total,
  });

  int total;

  factory Recommendations.fromJson(Map<String, dynamic> json) =>
      Recommendations(
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
      };
}

class ReleaseDate {
  ReleaseDate({
    required this.comingSoon,
    required this.date,
  });

  bool comingSoon;
  String date;

  factory ReleaseDate.fromJson(Map<String, dynamic> json) => ReleaseDate(
        comingSoon: json["coming_soon"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "coming_soon": comingSoon,
        "date": date,
      };
}

class Screenshot {
  Screenshot({
    required this.id,
    required this.pathThumbnail,
    required this.pathFull,
  });

  int id;
  String pathThumbnail;
  String pathFull;

  factory Screenshot.fromJson(Map<String, dynamic> json) => Screenshot(
        id: json["id"],
        pathThumbnail: json["path_thumbnail"],
        pathFull: json["path_full"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "path_thumbnail": pathThumbnail,
        "path_full": pathFull,
      };
}

class SupportInfo {
  SupportInfo({
    required this.url,
    required this.email,
  });

  String url;
  String email;

  factory SupportInfo.fromJson(Map<String, dynamic> json) => SupportInfo(
        url: json["url"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "email": email,
      };
}
