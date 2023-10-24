// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class Flashcard extends StatefulWidget {
  final String question;
  final String answer;
  final String catalog;

  Flashcard(
      {Key? key,
      required this.question,
      required this.answer,
      required this.catalog})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FlashcardState createState() => _FlashcardState();
}

class _FlashcardState extends State<Flashcard> {
  final bool _isFlipped = true; // Set it to true to show the question initially

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      front: _buildCardSide(
        widget.question,
        'Tap to reveal answer',
        widget.catalog,
        isFront: true,
      ),
      back: _buildCardSide(
        widget.answer,
        'Tap to see question',
        widget.catalog,
        isFront: false,
      ),
      flipOnTouch: true,
      direction: FlipDirection.HORIZONTAL,
    );
  }

  Widget _buildCardSide(String text, String hintText, String catalog,
      {required bool isFront}) {
    Color backgroundColor = isFront
        ? const Color.fromRGBO(236, 235, 234, 1)
        : const Color.fromARGB(255, 185, 215, 240);
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      height: 400.0, // Increased card height
      decoration: BoxDecoration(
        // color: const Color.fromRGBO(236, 235, 234, 1),
        color: backgroundColor,
        border: Border.all(
          color: Colors.lightBlue,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 8.0,
            right: 8.0,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: isFront ? Colors.lightBlue : Colors.blue,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                catalog,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          if (isFront) // Display "Question" only on the front
            const Positioned(
              top: 8.0,
              left: 8.0,
              child: Text(
                'Question',
                style: TextStyle(
                  color: Colors.black, // Text color for the front side
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          if (!isFront) // Display "Answer" only on the back
            const Positioned(
              top: 8.0,
              left: 8.0,
              child: Text(
                'Answer',
                style: TextStyle(
                  color: Colors.black, // Text color for the back side
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Center(
            child: Text(
              _isFlipped ? text : hintText,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
