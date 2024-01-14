class Entry {
  String name;
  String description;
  String category;
  String duration;
  String cost;
  String effortLevel;
  String environment; // Outdoor / Indoor
  String season;

  Entry({
    required this.name,
    required this.description,
    required this.category,
    required this.duration,
    required this.cost,
    required this.effortLevel,
    required this.environment,
    required this.season,
  });

  // Convert an Entry object into a map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'category': category,
      'duration': duration,
      'cost': cost,
      'effortLevel': effortLevel,
      'environment': environment,
      'season': season,
    };
  }

  // Create an Entry object from a map
  factory Entry.fromJson(Map<String, dynamic> json) {
    return Entry(
      name: json['name'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      duration: json['duration'] as String,
      cost: json['cost'] as String,
      effortLevel: json['effortLevel'] as String,
      environment: json['environment'] as String,
      season: json['season'] as String,
    );
  }
}
