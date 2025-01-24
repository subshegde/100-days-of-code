class YoutubeModel {
  String? continuation;
  String? estimatedResults;
  List<Data>? data;
  String? msg;
  List<String>? refinements;

  YoutubeModel({
    this.continuation,
    this.estimatedResults,
    this.data,
    this.msg,
    this.refinements,
  });

  YoutubeModel.fromJson(Map<String, dynamic> json) {
    continuation = json['continuation'];
    estimatedResults = json['estimatedResults'];

    // Ensure that 'data' is not null before assigning
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    } else {
      data = [];
    }

    msg = json['msg'];

    // Check if 'refinements' is null before casting to List<String>
    refinements = json['refinements'] != null
        ? List<String>.from(json['refinements'])
        : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['continuation'] = this.continuation;
    data['estimatedResults'] = this.estimatedResults;

    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }

    data['msg'] = this.msg;
    data['refinements'] = this.refinements;

    return data;
  }
}

class Data {
  String? type;
  String? videoId;
  String? title;
  String? channelTitle;
  String? channelId;
  String? channelHandle;
  List<ChannelThumbnail>? channelThumbnail;
  String? description;
  String? viewCount;
  String? publishedTimeText;
  String? publishDate;
  String? publishedAt;
  String? lengthText;
  List<Thumbnail>? thumbnail;
  List<RichThumbnail>? richThumbnail;
  List<Data>? data;
  List<String>? badges;
  bool? isLive;

  Data({
    this.type,
    this.videoId,
    this.title,
    this.channelTitle,
    this.channelId,
    this.channelHandle,
    this.channelThumbnail,
    this.description,
    this.viewCount,
    this.publishedTimeText,
    this.publishDate,
    this.publishedAt,
    this.lengthText,
    this.thumbnail,
    this.richThumbnail,
    this.data,
    this.badges,
    this.isLive,
  });

  Data.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    videoId = json['videoId'];
    title = json['title'];
    channelTitle = json['channelTitle'];
    channelId = json['channelId'];
    channelHandle = json['channelHandle'];

    if (json['channelThumbnail'] != null) {
      channelThumbnail = <ChannelThumbnail>[];
      json['channelThumbnail'].forEach((v) {
        channelThumbnail!.add(ChannelThumbnail.fromJson(v));
      });
    }

    description = json['description'];
    viewCount = json['viewCount'];
    publishedTimeText = json['publishedTimeText'];
    publishDate = json['publishDate'];
    publishedAt = json['publishedAt'];
    lengthText = json['lengthText'];

    if (json['thumbnail'] != null) {
      thumbnail = <Thumbnail>[];
      json['thumbnail'].forEach((v) {
        thumbnail!.add(Thumbnail.fromJson(v));
      });
    }

    if (json['richThumbnail'] != null) {
      richThumbnail = <RichThumbnail>[];
      json['richThumbnail'].forEach((v) {
        richThumbnail!.add(RichThumbnail.fromJson(v));
      });
    }

    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }

    // Ensure badges is never null before calling cast
    badges = json['badges'] != null ? List<String>.from(json['badges']) : [];
    isLive = json['isLive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['type'] = this.type;
    data['videoId'] = this.videoId;
    data['title'] = this.title;
    data['channelTitle'] = this.channelTitle;
    data['channelId'] = this.channelId;
    data['channelHandle'] = this.channelHandle;

    if (this.channelThumbnail != null) {
      data['channelThumbnail'] = this.channelThumbnail!.map((v) => v.toJson()).toList();
    }

    data['description'] = this.description;
    data['viewCount'] = this.viewCount;
    data['publishedTimeText'] = this.publishedTimeText;
    data['publishDate'] = this.publishDate;
    data['publishedAt'] = this.publishedAt;
    data['lengthText'] = this.lengthText;

    if (this.thumbnail != null) {
      data['thumbnail'] = this.thumbnail!.map((v) => v.toJson()).toList();
    }

    if (this.richThumbnail != null) {
      data['richThumbnail'] = this.richThumbnail!.map((v) => v.toJson()).toList();
    }

    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }

    data['badges'] = this.badges;
    data['isLive'] = this.isLive;

    return data;
  }
}

class ChannelThumbnail {
  dynamic? url;
  dynamic? width;
  dynamic? height;

  ChannelThumbnail({this.url, this.width, this.height});

  ChannelThumbnail.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = this.url;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}

class Thumbnail {
  dynamic? url;
  dynamic? width;
  dynamic? height;

  Thumbnail({this.url, this.width, this.height});

  Thumbnail.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = this.url;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}

class RichThumbnail {
  dynamic? url;
  dynamic? width;
  dynamic? height;

  RichThumbnail({this.url, this.width, this.height});

  RichThumbnail.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = this.url;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}
