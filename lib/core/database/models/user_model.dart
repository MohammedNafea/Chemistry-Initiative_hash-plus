/// User model for database storage - supports auth and profile data.
class UserModel {
  final String id;
  final String email;
  final String password;
  final String name;
  final String bio;
  final String phone;
  final String location;
  final String imageUrl;

  UserModel({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    this.bio = 'مستكشف فضولي',
    this.phone = '',
    this.location = '',
    this.imageUrl = 'assets/images/avatar.jpg',
  });

  UserModel copyWith({
    String? id,
    String? email,
    String? password,
    String? name,
    String? bio,
    String? phone,
    String? location,
    String? imageUrl,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'password': password,
        'name': name,
        'bio': bio,
        'phone': phone,
        'location': location,
        'imageUrl': imageUrl,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] as String,
        email: json['email'] as String,
        password: json['password'] as String,
        name: json['name'] as String,
        bio: json['bio'] as String? ?? 'مستكشف فضولي',
        phone: json['phone'] as String? ?? '',
        location: json['location'] as String? ?? '',
        imageUrl: json['imageUrl'] as String? ?? 'assets/images/avatar.jpg',
      );
}
