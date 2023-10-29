import 'package:ace_flash/apis/flash_api.dart';
import 'package:ace_flash/core/utils.dart';
import 'package:ace_flash/features/flash/views/create_flash_view.dart';
import 'package:ace_flash/models/flash_model.dart';
import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final flashControllerProvider = StateNotifierProvider<FlashController, bool>(
  (ref) {
    return FlashController(
      ref: ref,
      flashAPI: ref.watch(flashAPIProvider),
    );
  },
);

final getFlashCardsProvider = FutureProvider((ref) {
  final flashController = ref.watch(flashControllerProvider.notifier);
  return flashController.getFlashcards();
});

final getFlashByCidProvider = FutureProvider.family((ref, int cid) async {
  final flashController = ref.watch(flashControllerProvider.notifier);
  return flashController.getFlashByCid(cid);
});

final getFlashCardCountProvider = FutureProvider((ref) {
  final flashController = ref.watch(flashControllerProvider.notifier);
  return flashController.getFlashCardCount();
});

class FlashController extends StateNotifier<bool> {
  final FlashAPI _flashAPI;
  FlashController({
    required Ref ref,
    required FlashAPI flashAPI,
  })  : _flashAPI = flashAPI,
        super(false);

  Future<List<Flash>> getFlashcards() async {
    final flashList = await _flashAPI.getFlashcards();
    return flashList.map((flash) => Flash.fromMap(flash.data)).toList();
  }

  Future<Flash?> getFlashByCid(int cid) async {
    final flashList = await _flashAPI.getFlashcardsByCid(cid);
    List<Flash> cards =
        flashList.map((flash) => Flash.fromMap(flash.data)).toList();
    return cards[0];
  }

  Future<int?> getFlashCardCount() async {
    final flashList = await _flashAPI.getFlashcardsByCidOrder();
    List<Flash> cards =
        flashList.map((flash) => Flash.fromMap(flash.data)).toList();
    return cards[0].cid + 1;
    // return cards.length;
  }

  Flash? findCardByCid(List<Flash> cards, int targetCid) {
    try {
      return cards.firstWhere((card) => card.cid == targetCid);
    } catch (e) {
      return null; // Return null if no match is found
    }
  }

  void startFlash({
    required int cid,
    required BuildContext context,
  }) {
    if (cid < 0) {
      showSnackBar(context, 'Invalid');
      return;
    }

    _getFlashCard(
      cid: cid,
      context: context,
    );
  }

  void _getFlashCard({
    required int cid,
    required BuildContext context,
  }) async {
    state = true;
    final res = getFlashByCid(cid); //Get first flash card
    // ignore: unnecessary_null_comparison
    if (res == null) {
      showSnackBar(context, "Invalid");
    } else {
      showSnackBar(context, 'Flashcard is drawn, please continue.');
      // Navigator.push(context, CreateFlashScreen.route());
    }
    state = false;
  }

  void addFlashCard({
    required String catalog,
    required String question,
    required String answer,
    required int cid,
    required BuildContext context,
  }) async {
    state = true;
    Flash flash = Flash(
      cid: cid,
      question: question,
      answer: answer,
      catalog: catalog,
      id: ID.unique(),
    );
    final res = await _flashAPI.addFlashcard(flash);
    state = false;
    // ignore: avoid_print
    res.fold(
      // ignore: avoid_print
      (l) => showSnackBar(context, l.message),
      (r) async {
        showSnackBar(context, 'New flashcard $cid inserted!');
        Navigator.push(context, CreateFlashScreen.route(cid));
      },
    );
  }
}
