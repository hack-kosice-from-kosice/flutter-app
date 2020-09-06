class DailyTask {
  final String name;
  final String amount;
  final String status;
  final String description;
  final String imageURL;
  //Constructor
  const DailyTask({
    this.name,
    this.amount,
    this.status,
    this.description,
    this.imageURL
  });

  factory DailyTask.fromJson(Map<String, dynamic> json) => DailyTask(
      name: json['skill']['name'],
      amount: json['amount'],
      status: json['status'],
      description: json['description'] == null ? '' : json['description'],
      imageURL: json['skill']['imageUrl']
  );
}