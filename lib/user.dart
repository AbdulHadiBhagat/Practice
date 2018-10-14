class User {

  final String userId;
  final String name; 
  final String gender;
  
  User({this.userId,this.name,this.gender});


  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['key'],
      name: json['name'],
      gender: json['gender'],
    );
  }


}