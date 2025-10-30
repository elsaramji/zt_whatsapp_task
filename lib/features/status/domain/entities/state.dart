abstract class Status {
  String id;
  String? content;
  String? fileUrl;
  DateTime timestamp;
  String authorId;

  Status({
    required this.id,
    required this.timestamp,
    required this.authorId,
    this.content,
    this.fileUrl,
  });
}
