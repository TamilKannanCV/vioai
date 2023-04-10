import 'dart:convert';

class Message {
  String? role;
  String? content;

  Message({this.role, this.content});

  @override
  String toString() => 'Message(role: $role, content: $content)';

  factory Message.fromMap(Map<String, dynamic> data) => Message(
        role: data['role'] as String?,
        content: data['content'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'role': role,
        'content': content,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Message].
  factory Message.fromJson(String data) {
    return Message.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Message] to a JSON string.
  String toJson() => json.encode(toMap());

  Message copyWith({
    String? role,
    String? content,
  }) {
    return Message(
      role: role ?? this.role,
      content: content ?? this.content,
    );
  }
}
