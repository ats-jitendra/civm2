class ImageModel {
  List<Images>? images;

  ImageModel({this.images});

  ImageModel.fromJson(Map<String, dynamic> json) {
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  int? id;
  String? tokenNo;
  String? imageLocation;

  Images({this.id, this.tokenNo, this.imageLocation});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tokenNo = json['tokenNo'];
    imageLocation = json['imageLocation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tokenNo'] = tokenNo;
    data['imageLocation'] = imageLocation;
    return data;
  }
}
