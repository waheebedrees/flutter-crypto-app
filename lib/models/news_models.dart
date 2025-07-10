class News {
  final String title;
  final String description;
  final DateTime date;

  News({
    required this.title,
    required this.description,
    required this.date,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['date']),
    );
  }
}
