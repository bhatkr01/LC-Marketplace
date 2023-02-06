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