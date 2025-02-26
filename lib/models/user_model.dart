class UserModel {
  // Create a userModel model with id, name, email, password, phone number and address
  String id;
  String name;
  String email;
  String phoneNumber;
  String address;
  final String? profileImage;

  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.phoneNumber,
      required this.address,
      this.profileImage});

  // Create a toMap method for this class
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phoneNumber,
      'address': address,
      'profileImage': profileImage
    };
  }

  // Create a factory method to serialize a UserModel object from a Firestore snapshot
  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    return UserModel(
      id: id,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      address: map['address'] ?? '',
      profileImage: map['profileImage'] ?? '',
    );
  }
}
