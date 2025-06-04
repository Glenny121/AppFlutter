class Painting {
  final int id;
  final String title;
  final String body;

  Painting({required this.id, required this.title, required this.body});

  factory Painting.fromJson(Map<String, dynamic> json) {
    return Painting(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
