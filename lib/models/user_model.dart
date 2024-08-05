class TheUser {
  TheUser({
    required this.about,
    required this.isOnline,
    required this.id,
    required this.createdAt,
    required this.lastLogin,
    required this.pushToken,
    required this.name,
    required this.image,
    required this.email,
  });
  late String about;
  late bool isOnline;
  late String id;
  late String createdAt;
  late String lastLogin;
  late String pushToken;
  late String name;
  late String image;
  late String email;

  TheUser.fromJson(Map<String, dynamic> json) {
    about = json['About'];
    isOnline = json['is_online'];
    id = json['Id'];
    createdAt = json['created_at'];
    lastLogin = json['last_login'];
    pushToken = json['push_token'];
    name = json['Name'];
    image = json['Image'];
    email = json['Email'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['About'] = about;
    data['is_online'] = isOnline;
    data['Id'] = id;
    data['created_at'] = createdAt;
    data['last_login'] = lastLogin;
    data['push_token'] = pushToken;
    data['Name'] = name;
    data['Image'] = image;
    data['Email'] = email;
    return data;
  }
}
