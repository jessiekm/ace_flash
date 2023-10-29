import 'package:ace_flash/common/error_page.dart';
import 'package:ace_flash/common/loading_page.dart';
import 'package:ace_flash/common/rounded_small_button.dart';
import 'package:ace_flash/features/auth/widgets/auth_field.dart';
import 'package:ace_flash/features/auth/widgets/multi_line_auth_field.dart';
import 'package:ace_flash/features/flash/controller/flash_controller.dart';
import 'package:ace_flash/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddQuestionAnswerPage extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const AddQuestionAnswerPage(),
      );
  const AddQuestionAnswerPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddQuestionAnswerPageState();
}

class _AddQuestionAnswerPageState extends ConsumerState<AddQuestionAnswerPage> {
  TextEditingController questionController = TextEditingController();
  TextEditingController answerController = TextEditingController();
  TextEditingController catalogController = TextEditingController();

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
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                AuthField(
                  controller: catalogController,
                  hintText: 'Catalog',
                ),
                const SizedBox(height: 25),
                MultiLineAuthField(
                  // Use MultiLineAuthField for question
                  controller: questionController,
                  hintText: 'Question',
                ),
                const SizedBox(height: 25),
                MultiLineAuthField(
                  // Use MultiLineAuthField for answer
                  controller: answerController,
                  hintText: 'Answer',
                ),
                const SizedBox(height: 40),
                Align(
                  alignment: Alignment.topRight,
                  child: RoundedSmallButton(
                    onTap: onSubmit,
                    label: 'Submit',
                    textColor: Pallete.blackColor,
                    backgroundColor: Pallete.blueColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                // Add your custom logic for the "add" button here
              },
            ),
          ],
        ),
      ),
    );
  }

  void onSubmit() {
    // ignore: unused_result
    ref.refresh(getFlashCardCountProvider.future);
    ref.read(getFlashCardCountProvider).when(
          data: (count) {
            if (count == null) {
              const ErrorText(error: "Error Retrieve Flashcard");
            } else {
              ref.watch(flashControllerProvider.notifier).addFlashCard(
                  catalog: catalogController.text,
                  question: questionController.text,
                  answer: answerController.text,
                  cid: count,
                  context: context);
            }
            // ignore: unused_result
            ref.refresh(getFlashCardCountProvider.future);
          },
          error: (error, stackTrace) => ErrorText(
            error: error.toString(),
          ),
          loading: () => const Loader(),
        );
  }
}
