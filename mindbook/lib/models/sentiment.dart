class Sentiment {
  final String sentiment;

  Sentiment({this.sentiment});

  factory Sentiment.fromJson(Map<String, dynamic> json) {
    return Sentiment(sentiment: json['sentiment']);
  }
}
