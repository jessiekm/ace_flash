import 'package:flutter/foundation.dart';

@immutable
class Flash {
  final String id;
  final String question;
  final String answer;
  final String catalog;
  final int cid;
  const Flash({
    required this.id,
    required this.question,
    required this.answer,
    required this.catalog,
    required this.cid,
  });

  Flash copyWith({
    String? id,
    String? question,
    String? answer,
    String? catalog,
    int? cid,
  }) {
    return Flash(
      id: id ?? this.id,
      question: question ?? this.question,
      answer: answer ?? this.answer,
      catalog: catalog ?? this.catalog,
      cid: cid ?? this.cid,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'question': question});
    result.addAll({'answer': answer});
    result.addAll({'catalog': catalog});
    result.addAll({'cid': cid});

    return result;
  }

  factory Flash.fromMap(Map<String, dynamic> map) {
    return Flash(
      question: map['question'] ?? '',
      answer: map['answer'] ?? '',
      catalog: map['catalog'] ?? '',
      cid: map['cid'] ?? '',
      id: map['\$id'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Flash(question: $question, answer: $answer, catalog: $catalog, cid: $cid, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Flash &&
        other.question == question &&
        other.answer == answer &&
        other.catalog == catalog &&
        other.cid == cid &&
        other.id == id;
  }

  @override
  int get hashCode {
    return question.hashCode ^
        answer.hashCode ^
        catalog.hashCode ^
        cid.hashCode ^
        id.hashCode;
  }
}
