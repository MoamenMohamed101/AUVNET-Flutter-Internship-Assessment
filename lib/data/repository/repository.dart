import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:nawel/domain/models/create_user_model.dart';
import 'package:nawel/domain/models/restaurants_model.dart';
import 'package:nawel/domain/models/service_model.dart';
import 'package:nawel/domain/repository/repository.dart';

class RepositoryImpl extends Repository {
  final FirebaseAuth _firebaseAuth;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  RepositoryImpl(this._firebaseAuth);

  @override
  Future<void> register(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user?.uid;
      if (uid == null) throw Exception("User ID is null");

      await createUser(email, password, uid);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? "Registration failed");
    }
  }

  @override
  Future<void> login(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? "Login failed");
    }
  }

  @override
  Future<void> createUser(String email, String password, String uid) async {
    try {
      final userModel = CreateUserModel(email: email, password: password);

      await fireStore.collection('users').doc(uid).set(userModel.toMap());
    } catch (e) {
      throw Exception("Failed to create user in Firestore: $e");
    }
  }

  @override
  Future<List<ServiceModel>> getServices() async {
    final box = Hive.box<ServiceModel>('servicesBox');
    if (box.isNotEmpty) {
      return box.values.toList();
    }
    try {
      final snapshot = await fireStore.collection('services').get();
      final services = snapshot.docs.map((doc) {
        return ServiceModel.fromMap(doc.data());
      }).toList();
      await box.clear();
      for (int i = 0; i < services.length; i++) {
        await box.put(i, services[i]);
      }
      return services;
    } catch (e) {
      throw Exception('Failed to load services: $e');
    }
  }

  @override
  Future<List<RestaurantsModel>> getRestaurants() async {
    final box = Hive.box<RestaurantsModel>('restaurantsBox');
    if (box.isNotEmpty) {
      return box.values.toList();
    }
    try {
      final snapshot = await fireStore.collection('restaurants').get();

      final restaurants = snapshot.docs.map((doc) {
        return RestaurantsModel.fromJson(doc.data());
      }).toList();
      await box.clear();
      for (int i = 0; i < restaurants.length; i++) {
        await box.put(i, restaurants[i]);
      }
      return restaurants;
    } catch (e) {
      throw Exception('Failed to load restaurants: $e');
    }
  }
}
