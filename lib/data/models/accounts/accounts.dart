class Login {
    const Login({
        required this.email,
        required this.password,
    });

    final String email;
    final String password;

    factory Login.fromJson(Map<String, dynamic> json) => Login(
        email: json["email"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
    };
}

class Token {
  final String refresh;
  final String access;

  Token({required this.refresh, required this.access});

  factory Token.fromJson(Map<String, dynamic> json) =>
    Token(
    refresh:json['refresh'],
    access:json['access'],
    );

  Map<String, dynamic> toJson() =>{
    "refresh": refresh,
    "access": access,
  };
}

class User{
  final String email;
  final String firstName;
  final String lastName;
  final String classStatus;

  User({required this.email, required this.firstName, required this.lastName, required this.classStatus});

  factory User.fromJson(Map<String, dynamic> json)=>

    User(
    email:json['email'],
    firstName:json['first_name'],
    lastName:json['last_name'],
    classStatus:json['class_status'],
    );


  Map<String, dynamic> toJson() =>{
    'email':email,
    'first_name':firstName,
    'last_name':lastName,
    'class_status':classStatus,
  };
}
