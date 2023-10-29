import 'dart:io';
import 'dart:math';

import 'package:ace_flash/common/error_page.dart';
import 'package:ace_flash/common/loading_page.dart';
import 'package:ace_flash/constants/constants.dart';
import 'package:ace_flash/features/flash/controller/flash_controller.dart';
import 'package:ace_flash/features/flash/views/add_flashcard.dart';
import 'package:ace_flash/features/flash/widgets/flash_card.dart';
import 'package:ace_flash/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class CreateFlashScreen extends ConsumerStatefulWidget {
  static route(int cid, {int currentFlashCardIdx = 0}) => MaterialPageRoute(
        builder: (context) => CreateFlashScreen(currentFlashCardIdx: cid),
      );

  final int currentFlashCardIdx; // Add this parameter

  const CreateFlashScreen({required this.currentFlashCardIdx, Key? key})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateFlashScreenState();
}

class _CreateFlashScreenState extends ConsumerState<CreateFlashScreen> {
  final flashTextController = TextEditingController();
  List<File> images = [];
  int currentFlashCardIdx = 0;

  @override
  void initState() {
    super.initState();
    currentFlashCardIdx = widget.currentFlashCardIdx;
  }

  @override
  void dispose() {
    super.dispose();
    flashTextController.dispose();
  }

  void startFlash() {
    ref.read(flashControllerProvider.notifier).startFlash(
          cid: currentFlashCardIdx - 1,
          context: context,
        );
    Navigator.pop(context);
  }

  Future<void> fetchNextFlashcard() async {
    if (currentFlashCardIdx < getTotalFlashCardCount() - 1) {
      currentFlashCardIdx++;
      setState(() {});
    }
  }

  void drawRandomFlashcard() {
    final random = Random();
    final randomIndex = random.nextInt(getTotalFlashCardCount());
    currentFlashCardIdx = randomIndex;
    setState(() {});
  }

  Future<void> fetchPreviousFlashcard() async {
    if (currentFlashCardIdx > 0) {
      currentFlashCardIdx--;
      setState(() {});
    }
  }

  void drawFlashcardByCid(int cid) {
    currentFlashCardIdx = cid;
    setState(() {});
  }

  void addQuestionAnswerPage() {
    Navigator.push(context, AddQuestionAnswerPage.route());
  }

  int getTotalFlashCardCount() {
    // ignore: unused_result
    ref.refresh(getFlashCardCountProvider.future);
    final count = ref.watch(getFlashCardCountProvider).value;
    if (count == null) {
      return 0;
    } else {
      return count;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.blueColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close, size: 30),
        ),
        title: const Text(
          "AP Computer Science Flashcards",
          style: TextStyle(
            color: Pallete.blackColor, // Set the color of the banner text
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          size: 40, //change size on your need
          color: Pallete.whiteColor, //change color on your need
        ),
      ),
      body: ref.watch(getFlashByCidProvider(currentFlashCardIdx)).when(
            data: (flashcard) {
              if (flashcard != null) {
                return SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Flashcard(
                          question: flashcard.question,
                          answer: flashcard.answer,
                          catalog: flashcard.catalog,
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return ErrorText(
                    error: "No flashcard found for cid: $currentFlashCardIdx");
              }
            },
            error: (error, st) => ErrorText(
              error: error.toString(),
            ),
            loading: () => const Loader(),
          ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 10),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Pallete.greyColor,
              width: 0.3,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment
              .spaceAround, // Use MainAxisAlignment.spaceAround
          children: [
            Expanded(
              // Use Expanded to evenly space the icons
              child: GestureDetector(
                onTap: startFlash,
                child: SvgPicture.asset(AssetsConstants.homeFilledIcon),
              ),
            ),
            Expanded(
              // Use Expanded to evenly space the icons
              child: GestureDetector(
                  onTap: fetchPreviousFlashcard,
                  child: const Icon(Icons.arrow_back,
                      color: Pallete.blackColor, size: 40.0)),
            ),
            // Left Arrow Button
            Expanded(
              // Use Expanded to evenly space the icons
              child: GestureDetector(
                  onTap: fetchNextFlashcard,
                  child: const Icon(Icons.arrow_forward,
                      color: Pallete.blackColor, size: 40.0)),
            ),
            Expanded(
              // Use Expanded to evenly space the icons
              child: GestureDetector(
                  onTap: drawRandomFlashcard,
                  child: const Icon(Icons.shuffle,
                      color: Pallete.blackColor, size: 40.0)),
            ),
            Expanded(
              // Use Expanded to evenly space the icons
              child: GestureDetector(
                  onTap: addQuestionAnswerPage,
                  child: const Icon(Icons.plus_one_rounded,
                      color: Pallete.blackColor, size: 40.0)),
            ),
          ],
        ),
      ),
    );
  }
}
