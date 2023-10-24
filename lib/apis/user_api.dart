import 'package:ace_flash/constants/appwrite_constants.dart';
import 'package:ace_flash/core/failure.dart';
import 'package:ace_flash/core/providers.dart';
import 'package:ace_flash/core/type_defs.dart';
import 'package:ace_flash/models/user_model.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userAPIProvider = Provider((ref) {
  return UserAPI(
    db: ref.watch(appwriteDatabaseProvider),
  );
});

abstract class IUserAPI {
  FutureEitherVoid saveUserData(UserModel userModel);
}

class UserAPI implements IUserAPI {
  final Databases _db;
  UserAPI({
    required Databases db,
  }) : _db = db;

  @override
  FutureEitherVoid saveUserData(UserModel userModel) async {
    try {
      await _db.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.usersCollection,
        documentId: userModel.uid,
        data: userModel.toMap(),
      );
      return const Right(null);
    } on AppwriteException catch (e, st) {
      return Left(
        Failure(
          e.message ?? 'Some unexpected error occurred',
          st,
        ),
      );
    } catch (e, st) {
      return Left(Failure(e.toString(), st));
    }
  }

  Future<model.Document> getUserData(String uid) {
    return _db.getDocument(
      databaseId: AppwriteConstants.databaseId,
      collectionId: AppwriteConstants.usersCollection,
      documentId: uid,
    );
  }
}
