import 'package:ace_flash/core/core.dart' as either;
import 'package:ace_flash/core/providers.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authAPIProvider = Provider((ref) {
  final account = ref.watch(appwriteAccountProvider);
  return AuthAPI(account: account);
});

abstract class IAuthAPI {
  either.FutureEither<model.User> signUp({
    required String email,
    required String password,
  });

  either.FutureEither<model.Session> login({
    required String email,
    required String password,
  });

  Future<model.User?> currentUserAccount();
  either.FutureEitherVoid logout();
}

class AuthAPI implements IAuthAPI {
  final Account _account;
  AuthAPI({required Account account}) : _account = account;

  @override
  Future<model.User?> currentUserAccount() async {
    try {
      return await _account.get();
    } on AppwriteException {
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  either.FutureEither<model.User> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final account = await _account.create(
        userId: ID.unique(),
        email: email,
        password: password,
      );
      return Right(account);
    } on AppwriteException catch (e, stackTrace) {
      return Left(
        either.Failure(
            e.message ?? 'Some unexpected error occurred', stackTrace),
      );
    } catch (e, stackTrace) {
      return Left(
        either.Failure(e.toString(), stackTrace),
      );
    }
  }

  @override
  either.FutureEither<model.Session> login({
    required String email,
    required String password,
  }) async {
    try {
      final session = await _account.createEmailSession(
        email: email,
        password: password,
      );
      return Right(session);
    } on AppwriteException catch (e, stackTrace) {
      return Left(
        either.Failure(
            e.message ?? 'Some unexpected error occurred', stackTrace),
      );
    } catch (e, stackTrace) {
      return Left(
        either.Failure(e.toString(), stackTrace),
      );
    }
  }

  @override
  either.FutureEitherVoid logout() async {
    try {
      await _account.deleteSession(
        sessionId: 'current',
      );
      return const Right(null);
    } on AppwriteException catch (e, stackTrace) {
      return Left(
        either.Failure(
            e.message ?? 'Some unexpected error occurred', stackTrace),
      );
    } catch (e, stackTrace) {
      return Left(
        either.Failure(e.toString(), stackTrace),
      );
    }
  }
}
