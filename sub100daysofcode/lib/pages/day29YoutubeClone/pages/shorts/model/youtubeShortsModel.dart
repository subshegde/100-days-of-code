class YouTubeShortsModel {
  Meta? meta;
  String? continuation;
  List<ShortsData>? data;
  String? msg;

  YouTubeShortsModel({this.meta, this.continuation, this.data, this.msg});

  YouTubeShortsModel.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    continuation = json['continuation'];
    if (json['data'] != null) {
      data = <ShortsData>[];
      json['data'].forEach((v) {
        data!.add(new ShortsData.fromJson(v));
      });
    }
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    data['continuation'] = this.continuation;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['msg'] = this.msg;
    return data;
  }
}

class Meta {
  String? videoId;
  String? title;
  List<Thumbnail>? thumbnail;
  dynamic? duration;
  String? totalResults;

  Meta(
      {this.videoId,
      this.title,
      this.thumbnail,
      this.duration,
      this.totalResults});

  Meta.fromJson(Map<String, dynamic> json) {
    videoId = json['videoId'];
    title = json['title'];
    if (json['thumbnail'] != null) {
      thumbnail = <Thumbnail>[];
      json['thumbnail'].forEach((v) {
        thumbnail!.add(new Thumbnail.fromJson(v));
      });
    }
    duration = json['duration'];
    totalResults = json['totalResults'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['videoId'] = this.videoId;
    data['title'] = this.title;
    if (this.thumbnail != null) {
      data['thumbnail'] = this.thumbnail!.map((v) => v.toJson()).toList();
    }
    data['duration'] = this.duration;
    data['totalResults'] = this.totalResults;
    return data;
  }
}

class Thumbnail {
  String? url;
  int? width;
  int? height;

  Thumbnail({this.url, this.width, this.height});

  Thumbnail.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}

class ShortsData {
  String? type;
  String? videoId;
  String? viewCountText;
  List<Thumbnail>? thumbnail;
  bool? isOriginalAspectRatio;
  String? params;
  String? playerParams;
  String? sequenceParams;

  ShortsData(
      {this.type,
      this.videoId,
      this.viewCountText,
      this.thumbnail,
      this.isOriginalAspectRatio,
      this.params,
      this.playerParams,
      this.sequenceParams});

  ShortsData.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    videoId = json['videoId'];
    viewCountText = json['viewCountText'];
    if (json['thumbnail'] != null) {
      thumbnail = <Thumbnail>[];
      json['thumbnail'].forEach((v) {
        thumbnail!.add(new Thumbnail.fromJson(v));
      });
    }
    isOriginalAspectRatio = json['isOriginalAspectRatio'];
    params = json['params'];
    playerParams = json['playerParams'];
    sequenceParams = json['sequenceParams'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['videoId'] = this.videoId;
    data['viewCountText'] = this.viewCountText;
    if (this.thumbnail != null) {
      data['thumbnail'] = this.thumbnail!.map((v) => v.toJson()).toList();
    }
    data['isOriginalAspectRatio'] = this.isOriginalAspectRatio;
    data['params'] = this.params;
    data['playerParams'] = this.playerParams;
    data['sequenceParams'] = this.sequenceParams;
    return data;
  }
}