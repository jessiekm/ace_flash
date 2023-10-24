import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: const <Widget>[
        PageTitle(title: 'Welcome to AP Computer Science Flashcards'),
        TextParagraph(
          text:
              'Get ready to master AP Computer Science concepts with our interactive flashcards. '
              'Our app is designed to help you learn and reinforce key topics in computer science.',
        ),
        SectionHeading(text: 'Features'),
        BulletPoint(
            text:
                'Hundreds of flashcards covering AP CS A and AP CS Principles.'),
        BulletPoint(text: 'Practice and test modes to enhance your learning.'),
        BulletPoint(text: 'Detailed explanations for each flashcard.'),
        TextParagraph(
            text:
                'Whether you are preparing for the AP Computer Science exam or simply want to improve your coding skills, our flashcards are here to assist you.'),
        SectionHeading(text: 'How to Use'),
        BulletPoint(
            text:
                'Browse flashcards by topic or use the search feature to find specific concepts.'),
        BulletPoint(
            text: 'Tap a flashcard to reveal the answer and explanation.'),
        BulletPoint(text: 'Swipe left or right to move between flashcards.'),
        TextParagraph(
          text:
              'Start learning now and ace your AP Computer Science exam with confidence!',
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
