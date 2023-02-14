class Model {
  Model(this.createdAt, this.name, this.avatar, this.id);



  String createdAt;
  String name;
  String avatar;
  String id;



  factory Model.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  // Model.fromJson(dynamic json) {
  //   createdAt = json['createdAt'];
  //   name = json['name'];
  //   avatar = json['avatar'];
  //   id = json['id'];
  // }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['createdAt'] = createdAt;
    map['name'] = name;
    map['avatar'] = avatar;
    map['id'] = id;
    return map;
  }
}
