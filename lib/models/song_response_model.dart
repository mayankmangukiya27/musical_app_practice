// To parse this JSON data, do
//
//     final songModel = songModelFromJson(jsonString);

import 'dart:convert';

SongModel songModelFromJson(String str) => SongModel.fromJson(json.decode(str));

String songModelToJson(SongModel data) => json.encode(data.toJson());

class SongModel {
  final Feed? feed;

  SongModel({this.feed});

  factory SongModel.fromJson(Map<String, dynamic> json) => SongModel(
    feed: json["feed"] == null ? null : Feed.fromJson(json["feed"]),
  );

  Map<String, dynamic> toJson() => {"feed": feed?.toJson()};
}

class Feed {
  final Author? author;
  final List<Entry>? entry;
  final Icon? updated;
  final Icon? rights;
  final Icon? title;
  final Icon? icon;
  final List<ImCollectionLink>? link;
  final Icon? id;

  Feed({
    this.author,
    this.entry,
    this.updated,
    this.rights,
    this.title,
    this.icon,
    this.link,
    this.id,
  });

  factory Feed.fromJson(Map<String, dynamic> json) => Feed(
    author: json["author"] == null ? null : Author.fromJson(json["author"]),
    entry:
        json["entry"] == null
            ? []
            : List<Entry>.from(json["entry"]!.map((x) => Entry.fromJson(x))),
    updated: json["updated"] == null ? null : Icon.fromJson(json["updated"]),
    rights: json["rights"] == null ? null : Icon.fromJson(json["rights"]),
    title: json["title"] == null ? null : Icon.fromJson(json["title"]),
    icon: json["icon"] == null ? null : Icon.fromJson(json["icon"]),
    link:
        json["link"] == null
            ? []
            : List<ImCollectionLink>.from(
              json["link"]!.map((x) => ImCollectionLink.fromJson(x)),
            ),
    id: json["id"] == null ? null : Icon.fromJson(json["id"]),
  );

  Map<String, dynamic> toJson() => {
    "author": author?.toJson(),
    "entry":
        entry == null ? [] : List<dynamic>.from(entry!.map((x) => x.toJson())),
    "updated": updated?.toJson(),
    "rights": rights?.toJson(),
    "title": title?.toJson(),
    "icon": icon?.toJson(),
    "link":
        link == null ? [] : List<dynamic>.from(link!.map((x) => x.toJson())),
    "id": id?.toJson(),
  };
}

class Author {
  final Icon? name;
  final Icon? uri;

  Author({this.name, this.uri});

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    name: json["name"] == null ? null : Icon.fromJson(json["name"]),
    uri: json["uri"] == null ? null : Icon.fromJson(json["uri"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name?.toJson(),
    "uri": uri?.toJson(),
  };
}

class Icon {
  final String? label;

  Icon({this.label});

  factory Icon.fromJson(Map<String, dynamic> json) =>
      Icon(label: json["label"]);

  Map<String, dynamic> toJson() => {"label": label};
}

class Entry {
  final Icon? imName;
  final List<ImImage>? imImage;
  final ImCollection? imCollection;
  final ImPrice? imPrice;
  final ImCollectionImContentType? imContentType;
  final Icon? rights;
  final Icon? title;
  final List<EntryLink>? link;
  final Id? id;
  final ImArtist? imArtist;
  final Category? category;
  final ImReleaseDate? imReleaseDate;

  Entry({
    this.imName,
    this.imImage,
    this.imCollection,
    this.imPrice,
    this.imContentType,
    this.rights,
    this.title,
    this.link,
    this.id,
    this.imArtist,
    this.category,
    this.imReleaseDate,
  });

  factory Entry.fromJson(Map<String, dynamic> json) => Entry(
    imName: json["im:name"] == null ? null : Icon.fromJson(json["im:name"]),
    imImage:
        json["im:image"] == null
            ? []
            : List<ImImage>.from(
              json["im:image"]!.map((x) => ImImage.fromJson(x)),
            ),
    imCollection:
        json["im:collection"] == null
            ? null
            : ImCollection.fromJson(json["im:collection"]),
    imPrice:
        json["im:price"] == null ? null : ImPrice.fromJson(json["im:price"]),
    imContentType:
        json["im:contentType"] == null
            ? null
            : ImCollectionImContentType.fromJson(json["im:contentType"]),
    rights: json["rights"] == null ? null : Icon.fromJson(json["rights"]),
    title: json["title"] == null ? null : Icon.fromJson(json["title"]),
    link:
        json["link"] == null
            ? []
            : List<EntryLink>.from(
              json["link"]!.map((x) => EntryLink.fromJson(x)),
            ),
    id: json["id"] == null ? null : Id.fromJson(json["id"]),
    imArtist:
        json["im:artist"] == null ? null : ImArtist.fromJson(json["im:artist"]),
    category:
        json["category"] == null ? null : Category.fromJson(json["category"]),
    imReleaseDate:
        json["im:releaseDate"] == null
            ? null
            : ImReleaseDate.fromJson(json["im:releaseDate"]),
  );

  Map<String, dynamic> toJson() => {
    "im:name": imName?.toJson(),
    "im:image":
        imImage == null
            ? []
            : List<dynamic>.from(imImage!.map((x) => x.toJson())),
    "im:collection": imCollection?.toJson(),
    "im:price": imPrice?.toJson(),
    "im:contentType": imContentType?.toJson(),
    "rights": rights?.toJson(),
    "title": title?.toJson(),
    "link":
        link == null ? [] : List<dynamic>.from(link!.map((x) => x.toJson())),
    "id": id?.toJson(),
    "im:artist": imArtist?.toJson(),
    "category": category?.toJson(),
    "im:releaseDate": imReleaseDate?.toJson(),
  };
}

class Category {
  final CategoryAttributes? attributes;

  Category({this.attributes});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    attributes:
        json["attributes"] == null
            ? null
            : CategoryAttributes.fromJson(json["attributes"]),
  );

  Map<String, dynamic> toJson() => {"attributes": attributes?.toJson()};
}

class CategoryAttributes {
  final String? imId;
  final String? term;
  final String? scheme;
  final String? label;

  CategoryAttributes({this.imId, this.term, this.scheme, this.label});

  factory CategoryAttributes.fromJson(Map<String, dynamic> json) =>
      CategoryAttributes(
        imId: json["im:id"],
        term: json["term"],
        scheme: json["scheme"],
        label: json["label"],
      );

  Map<String, dynamic> toJson() => {
    "im:id": imId,
    "term": term,
    "scheme": scheme,
    "label": label,
  };
}

class Id {
  final String? label;
  final IdAttributes? attributes;

  Id({this.label, this.attributes});

  factory Id.fromJson(Map<String, dynamic> json) => Id(
    label: json["label"],
    attributes:
        json["attributes"] == null
            ? null
            : IdAttributes.fromJson(json["attributes"]),
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "attributes": attributes?.toJson(),
  };
}

class IdAttributes {
  final String? imId;

  IdAttributes({this.imId});

  factory IdAttributes.fromJson(Map<String, dynamic> json) =>
      IdAttributes(imId: json["im:id"]);

  Map<String, dynamic> toJson() => {"im:id": imId};
}

class ImArtist {
  final String? label;
  final ImArtistAttributes? attributes;

  ImArtist({this.label, this.attributes});

  factory ImArtist.fromJson(Map<String, dynamic> json) => ImArtist(
    label: json["label"],
    attributes:
        json["attributes"] == null
            ? null
            : ImArtistAttributes.fromJson(json["attributes"]),
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "attributes": attributes?.toJson(),
  };
}

class ImArtistAttributes {
  final String? href;

  ImArtistAttributes({this.href});

  factory ImArtistAttributes.fromJson(Map<String, dynamic> json) =>
      ImArtistAttributes(href: json["href"]);

  Map<String, dynamic> toJson() => {"href": href};
}

class ImCollection {
  final Icon? imName;
  final ImCollectionLink? link;
  final ImCollectionImContentType? imContentType;

  ImCollection({this.imName, this.link, this.imContentType});

  factory ImCollection.fromJson(Map<String, dynamic> json) => ImCollection(
    imName: json["im:name"] == null ? null : Icon.fromJson(json["im:name"]),
    link: json["link"] == null ? null : ImCollectionLink.fromJson(json["link"]),
    imContentType:
        json["im:contentType"] == null
            ? null
            : ImCollectionImContentType.fromJson(json["im:contentType"]),
  );

  Map<String, dynamic> toJson() => {
    "im:name": imName?.toJson(),
    "link": link?.toJson(),
    "im:contentType": imContentType?.toJson(),
  };
}

class ImCollectionImContentType {
  final ImContentTypeImContentType? imContentType;
  final ImContentTypeAttributes? attributes;

  ImCollectionImContentType({this.imContentType, this.attributes});

  factory ImCollectionImContentType.fromJson(Map<String, dynamic> json) =>
      ImCollectionImContentType(
        imContentType:
            json["im:contentType"] == null
                ? null
                : ImContentTypeImContentType.fromJson(json["im:contentType"]),
        attributes:
            json["attributes"] == null
                ? null
                : ImContentTypeAttributes.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
    "im:contentType": imContentType?.toJson(),
    "attributes": attributes?.toJson(),
  };
}

class ImContentTypeAttributes {
  final String? term;
  final String? label;

  ImContentTypeAttributes({this.term, this.label});

  factory ImContentTypeAttributes.fromJson(Map<String, dynamic> json) =>
      ImContentTypeAttributes(term: json["term"], label: json["label"]);

  Map<String, dynamic> toJson() => {"term": term, "label": label};
}

class ImContentTypeImContentType {
  final ImContentTypeAttributes? attributes;

  ImContentTypeImContentType({this.attributes});

  factory ImContentTypeImContentType.fromJson(Map<String, dynamic> json) =>
      ImContentTypeImContentType(
        attributes:
            json["attributes"] == null
                ? null
                : ImContentTypeAttributes.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {"attributes": attributes?.toJson()};
}

class ImCollectionLink {
  final PurpleAttributes? attributes;

  ImCollectionLink({this.attributes});

  factory ImCollectionLink.fromJson(Map<String, dynamic> json) =>
      ImCollectionLink(
        attributes:
            json["attributes"] == null
                ? null
                : PurpleAttributes.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {"attributes": attributes?.toJson()};
}

class PurpleAttributes {
  final String? rel;
  final String? type;
  final String? href;

  PurpleAttributes({this.rel, this.type, this.href});

  factory PurpleAttributes.fromJson(Map<String, dynamic> json) =>
      PurpleAttributes(
        rel: json["rel"],
        type: json["type"],
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {"rel": rel, "type": type, "href": href};
}

class ImImage {
  final String? label;
  final ImImageAttributes? attributes;

  ImImage({this.label, this.attributes});

  factory ImImage.fromJson(Map<String, dynamic> json) => ImImage(
    label: json["label"],
    attributes:
        json["attributes"] == null
            ? null
            : ImImageAttributes.fromJson(json["attributes"]),
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "attributes": attributes?.toJson(),
  };
}

class ImImageAttributes {
  final String? height;

  ImImageAttributes({this.height});

  factory ImImageAttributes.fromJson(Map<String, dynamic> json) =>
      ImImageAttributes(height: json["height"]);

  Map<String, dynamic> toJson() => {"height": height};
}

class ImPrice {
  final String? label;
  final ImPriceAttributes? attributes;

  ImPrice({this.label, this.attributes});

  factory ImPrice.fromJson(Map<String, dynamic> json) => ImPrice(
    label: json["label"],
    attributes:
        json["attributes"] == null
            ? null
            : ImPriceAttributes.fromJson(json["attributes"]),
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "attributes": attributes?.toJson(),
  };
}

class ImPriceAttributes {
  final String? amount;
  final String? currency;

  ImPriceAttributes({this.amount, this.currency});

  factory ImPriceAttributes.fromJson(Map<String, dynamic> json) =>
      ImPriceAttributes(amount: json["amount"], currency: json["currency"]);

  Map<String, dynamic> toJson() => {"amount": amount, "currency": currency};
}

class ImReleaseDate {
  final DateTime? label;
  final Icon? attributes;

  ImReleaseDate({this.label, this.attributes});

  factory ImReleaseDate.fromJson(Map<String, dynamic> json) => ImReleaseDate(
    label: json["label"] == null ? null : DateTime.parse(json["label"]),
    attributes:
        json["attributes"] == null ? null : Icon.fromJson(json["attributes"]),
  );

  Map<String, dynamic> toJson() => {
    "label": label?.toIso8601String(),
    "attributes": attributes?.toJson(),
  };
}

class EntryLink {
  final FluffyAttributes? attributes;
  final Icon? imDuration;

  EntryLink({this.attributes, this.imDuration});

  factory EntryLink.fromJson(Map<String, dynamic> json) => EntryLink(
    attributes:
        json["attributes"] == null
            ? null
            : FluffyAttributes.fromJson(json["attributes"]),
    imDuration:
        json["im:duration"] == null ? null : Icon.fromJson(json["im:duration"]),
  );

  Map<String, dynamic> toJson() => {
    "attributes": attributes?.toJson(),
    "im:duration": imDuration?.toJson(),
  };
}

class FluffyAttributes {
  final String? rel;
  final String? type;
  final String? href;
  final String? title;
  final String? imAssetType;

  FluffyAttributes({
    this.rel,
    this.type,
    this.href,
    this.title,
    this.imAssetType,
  });

  factory FluffyAttributes.fromJson(Map<String, dynamic> json) =>
      FluffyAttributes(
        rel: json["rel"],
        type: json["type"],
        href: json["href"],
        title: json["title"],
        imAssetType: json["im:assetType"],
      );

  Map<String, dynamic> toJson() => {
    "rel": rel,
    "type": type,
    "href": href,
    "title": title,
    "im:assetType": imAssetType,
  };
}
