import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  static Future<User?> signInWithGoogle() async {
    try {
      print("🔁 Starting Google Sign-In...");

      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        print("❌ User cancelled Google Sign-In");
        return null;
      }

      print("✅ Google user selected: ${googleUser.displayName}");

      final googleAuth = await googleUser.authentication;

      print("🔑 Getting Firebase credential...");
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase
      print("🔐 Signing in to Firebase...");
      final userCred = await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCred.user;

      if (user == null) {
        print("❌ Firebase returned null user");
        return null;
      }

      print("👤 Firebase user: ${user.uid}");

      // Create/update user doc in Firestore
      final docRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
      print("📄 Creating/Updating Firestore doc for user...");

      await docRef.set({
        'name': user.displayName ?? '',
        'email': user.email ?? '',
        'photoURL': user.photoURL ?? '',
        'phone': user.phoneNumber ?? '',
        'createdAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      print("✅ Firestore user document created/updated");

      return user;
    } catch (e) {
      print("❌ Error in Google Sign-In flow: $e");
      return null;
    }
  }
}
