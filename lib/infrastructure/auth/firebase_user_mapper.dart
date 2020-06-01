import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasenotesddd/domain/auth/user.dart';
import 'package:firebasenotesddd/domain/core/value_objects.dart';

extension FirebaseDomainX on FirebaseUser {
  User toDomain() {
    return User(
      id: UniqueId.fromUniqueString(uid),
    );
  }
}
