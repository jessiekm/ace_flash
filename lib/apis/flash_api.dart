import 'package:ace_flash/constants/appwrite_constants.dart';
import 'package:ace_flash/core/failure.dart';
import 'package:ace_flash/core/providers.dart';
import 'package:ace_flash/core/type_defs.dart';
import 'package:ace_flash/models/flash_model.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ace_flash/core/core.dart' as either;

final flashAPIProvider = Provider((ref) {
  return FlashAPI(
    db: ref.watch(appwriteDatabaseProvider),
  );
});

abstract class IFlashAPI {
  Future<List<Document>> getFlashcards();
  either.FutureEitherVoid addFlashcard(Flash flash);
}

class FlashAPI implements IFlashAPI {
  final Databases _db;
  FlashAPI({required Databases db}) : _db = db;

  @override
  Future<List<Document>> getFlashcards() async {
    final documents = await _db.listDocuments(
      databaseId: AppwriteConstants.databaseId,
      collectionId: AppwriteConstants.aceFlashCollection,
    );
    return documents.documents;
  }

  @override
  FutureEitherVoid addFlashcard(Flash flash) async {
    try {
      await _db.createDocument(
          databaseId: AppwriteConstants.databaseId,
          collectionId: AppwriteConstants.aceFlashCollection,
          documentId: flash.id,
          data: flash.toMap());

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
}
