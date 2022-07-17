class TodoItem {
  String id;
  final String title;
  final String description;
  final bool isComplete;
  final DateTime dateAdded;
  TodoItem(
      {this.id = "",
      required this.title,
      required this.description,
      this.isComplete = false,
      required this.dateAdded});

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'isComplete': isComplete,
        'dateAdded': dateAdded
      };
  // named constructor...
  TodoItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        description = json['description'],
        isComplete = json['isComplete'],
        dateAdded = json['dateAdded'];
}
