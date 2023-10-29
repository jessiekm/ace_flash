import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: const <Widget>[
        PageTitle(title: 'Welcome to AP Computer Science Flashcards'),
        SectionHeading(text: 'How to Use'),
        BulletPoint(
            text:
                'Flashcards are conveniently organized by categories: Definitions, Keywords, True/False, Simple Statements.'),
        BulletPoint(
            text: 'Tap a flashcard to reveal the answer and explanation.'),
        BulletPoint(text: 'Swipe left or right to move between flashcards.'),
        BulletPoint(text: 'Shuffle flashcards to randomly draw flashcard.'),
        BulletPoint(
            text: 'Insert customized flashcards by clicking PLUS icon.'),
        TextParagraph(
          text: 'Now get ready to start learning!',
        ),
      ],
    );
  }
}

class PageTitle extends StatelessWidget {
  final String title;

  const PageTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class SectionHeading extends StatelessWidget {
  final String text;

  const SectionHeading({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class TextParagraph extends StatelessWidget {
  final String text;

  const TextParagraph({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16.0),
      ),
    );
  }
}

class BulletPoint extends StatelessWidget {
  final String text;

  const BulletPoint({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            '\u2022', // Bullet point character
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(text, style: const TextStyle(fontSize: 16.0)),
          ),
        ],
      ),
    );
  }
}
