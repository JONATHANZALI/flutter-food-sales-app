import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

class AuthService {
  // For storing data in the firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //   For authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // for file storage

  //Signup the user
  Future<String?> registerUser({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
    required String address,
    required String profileImage,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create user model
      UserModel user = UserModel(
        id: userCredential.user!.uid,
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        address: address,
        profileImage: profileImage,
      );

      // Store in Firestore
      await _firestore.collection('users').doc(user.id).set(user.toMap());

      return null; // Success
    } catch (e) {
      return e.toString();
    }
  }

  /// Signs in the user using Firebase Authentication.
  Future<User?> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      return null;
    }
  }

  // method to fetch a user based on given id
  Future<UserModel?> fetchUserModel(String uid) async {
    try {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      // Check if the document exists
      if (userDoc.exists) {
        // Convert the document data to a map
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
        // Use your fromMap factory to create an instance of UserModel
        UserModel user = UserModel.fromMap(data, userDoc.id);
        return user;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Sign-out user
  Future<void> logoutUser() async {
    await _auth.signOut();
  }
}
