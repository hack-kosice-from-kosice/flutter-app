class DailyTask {
  final int id;
  final String name;
  final int skillId;
  final String amount;
  final String status;
  final String description;
  final String imageURL;
  //Constructor
  const DailyTask(
      {this.id,
        this.name,
      this.skillId,
      this.amount,
      this.status,
      this.description,
      this.imageURL});

  factory DailyTask.fromJson(Map<String, dynamic> json) => DailyTask(
    id: json['id'],
      name: json['skill']['name'],
      skillId: json['skill']['id'],
      amount: json['amount'],
      status: json['status'],
      description: json['description'] == null ? '' : json['description'],
      imageURL: json['skill']['imageUrl']);
}
