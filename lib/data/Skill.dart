class Skill{
  final int id;
  final String name;
  final String description;
  final String imageURL;

  const Skill({
    this.id,
    this.name,
    this.description,
    this.imageURL
  });

  factory Skill.fromJson(Map<String, dynamic> json) => Skill(
      id: json['id'],
      name: json['name'],
      description: json['description'] == null ? '' : json['description'],
      imageURL: json['imageUrl']
    );

}