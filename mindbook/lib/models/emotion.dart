class Emotion {
  final String primary;
  final String secondary;
  final String tertiary;

  Emotion(this.primary, this.secondary, this.tertiary);

  Emotion.fromSet(Map<String, dynamic> json)
      : primary = json['primary'],
        secondary = json['secondary'],
        tertiary = json['tertiary'];
  
  @override
  String toString() => "Emotion<$primary:$secondary:$tertiary>";
  
}
