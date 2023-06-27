import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'AuthRepository.dart';
import 'profile.dart';

/// Repository (i.e. Model) that provides access to a Firestore
///    database.  Change actions will notify listeners via the associated provider.
class ProfileRepository extends ChangeNotifier {
  var db;
  AuthRepository authRepository;
  /* Initialize the firestore database and remember that db value */
  ProfileRepository(this.authRepository) {
    db = FirebaseFirestore.instance;
  }

  /// Reads all users from the database and returns a list of User.
  ///   Return value is a future:  Future<List<User>>
  Future<List<Profile>> getAllUsers() async {
    var results = await db.collection("users").get();
    List<Profile> users = [];
    for (var doc in results.docs) {
      var user = Profile.fromJson(doc.data());
      users.add(user);
    }

    return users;
  }

  Future<Profile> getFixedUser() {
    return getUser(username:"alove");
  }

  /// Get the user with the given username (which will be unique)
  Future<Profile> getUser({required String username}) async {
    var existing = await db.collection("users").doc(username).get();
    var data = await existing.data();
    if (data == null) {
      print("User $username not found");
      return Profile.noUser();
    } else {
      var user = Profile.fromJson(data);
      return user;
    }
  }


  void addFixedUser() {
    addUser(username: "alove", first: "Ada", last: "Lovelace", image: null, password: "1234");
  }

  /// Create a new user with the given username (which will be unique)
  ///    and the given first name (required), last name and image url.
  void addUser({required String username, required String first,
    String? last, String? image, required String password}) async {
    // First check to see if the username already exists
    var existing = await db.collection("users").doc(username).get();
    if (existing.data() == null) {
      String result = await authRepository.signUp(email: username, password: password);
      if (result == "Success") {
        final user = Profile(username: username,
            first: first,
            last: last,
            image: image);

        // Add a new document with the given username
        db.collection("users").doc(username).set(user.toJson());
        notifyListeners();
        print("New user $username added");
      }
      else{
        print("failed to add $username - $result");
      }
    }
    else {
      print("Duplicate user $username - not added");
    }
  }

  updateFirstNameFixed() {
    updateFirstName(username: "alove", first: "Adada");
  }

  /// Update the user matching the given username with the given first name
  void updateFirstName(
      {required String username, required String first}) async {
    var user = await db.collection("users").doc(username);
    try {
      await user.update({"first": first});
      print("user $username successfully updated");
      notifyListeners();
    } catch (e) {
      print("Error updating user $username: $e");
    }
  }

  void deleteFixedUser() {
    deleteUser(username: "alove");
  }

  /// Delete the user that matches the given username
  void deleteUser({required String username}) async {
    var user = await db.collection("users").doc(username);
    var doc = await user.get();
    if (doc.data() == null) {
      print("Unable to delete user $username - not found");
    } else {
      try {
        await user.delete();
        print("user $username successfully deleted");
        notifyListeners();
      } catch (e) {
        print("Error deleting user $username: $e");
      }
    }
  }
}