class Profile {
  final String username;
  final String first;
  final String? last; // Example of an optional value (nullable)
  final String? image;

  Profile({required this.username, required this.first, this.last, this.image});

  /* Named constructor to return a user object representing "no user"
       to avoid dealing with nulls (e.g., when a user is not found)
   */
  Profile.noUser(): username="", first="", last="", image="";

  bool isNoUser() {
    return username == "";
  }

  // Named constructor
  Profile.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        first = json['first'],
        last = json['last'],
        image = json['image'];

  Map<String, dynamic> toJson() =>
      {'username': username, 'first': first, 'last': last, 'image': image};
}
