// lib/services/firebase_service.dart
//
// All Firebase Auth + Firestore operations live here.
// The rest of the app treats Firebase as a remote sync target, not a source of truth.
// The source of truth is always the local Drift database.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/child_model.dart';
import '../../models/user.dart';


class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  // ─── Auth ─────────────────────────────────────────────────────────────────

  Future<User?> signUp({required String email, required String password}) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return cred.user;
  }

  Future<User?> signIn({required String email, required String password}) async {
    final cred = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return cred.user;
  }

  Future<void> signOut() => _auth.signOut();

  // ─── User Firestore ───────────────────────────────────────────────────────

  Future<void> ensureSignedInFromCache() async {
    try {
      // Firebase automatically restores session from disk
      // Just touching currentUser ensures initialization
      final user = _auth.currentUser;

      if (user == null) {
        // No cached session — do nothing
        return;
      }

      // Optionally reload to refresh token (safe)
      await user.reload();
    } catch (_) {
      // Swallow errors — background sync must never crash app
    }
  }

  /// Write (or overwrite) user document in Firestore.
  Future<void> saveUser(UserModel user) async {
    await _firestore
        .collection('users')
        .doc(user.id)
        .set(user.toJson(), SetOptions(merge: true));
  }

  /// Fetch user document from Firestore. Returns null if not found.
  Future<Map<String, dynamic>?> fetchUser(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    return doc.exists ? doc.data() : null;
  }

  // ─── Children Firestore ───────────────────────────────────────────────────

  // /// Upload a child document; returns the new Firestore document ID.
  // Future<String> saveChild({
  //   required String userId,
  //   required ChildModel child,
  // }) async {
  //   final ref = await _firestore
  //       .collection('users')
  //       .doc(userId)
  //       .collection('children')
  //       .add(child.toString());
  //   return ref.id;
  // }

  /// Fetch all children for a user from Firestore (used during merge on login).
  Future<List<Map<String, dynamic>>> fetchChildren(String userId) async {
    final snap = await _firestore
        .collection('users')
        .doc(userId)
        .collection('children')
        .get();

    return snap.docs.map((d) => {'firebaseId': d.id, ...d.data()}).toList();
  }
}
