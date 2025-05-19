class Note {
  final int? id;
  final String text;

  Note({required this.id, required this.text});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      text: map['text'],
    );
  }

  Note copyWith({int? id, String? text}) {
    return Note(
      id: id ?? this.id,
      text: text ??  this.text,
    );
  }
}
