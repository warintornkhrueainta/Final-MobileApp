class Movie {
  int? id;
  String title;
  String type;
  int episodes;
  String status;
  double rating;
  String note;

  Movie({
    this.id,
    required this.title,
    required this.type,
    required this.episodes,
    required this.status,
    required this.rating,
    required this.note, required String category,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'episodes': episodes,
      'status': status,
      'rating': rating,
      'note': note,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'],
      title: map['title'],
      type: map['type'],
      episodes: map['episodes'],
      status: map['status'],
      rating: map['rating'],
      note: map['note'], category: '',
    );
  }

  get category => null;
}