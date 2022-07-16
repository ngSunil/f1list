class TodoItem {
  final String title;
  final String description;
  final bool isComplete;
  final DateTime dateAdded;
  TodoItem(
      {required this.title,
      required this.description,
      this.isComplete = false,
      required this.dateAdded});

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'isComplete': isComplete,
        'dateAdded': dateAdded
      };
  // named constructor...
  TodoItem.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        description = json['description'],
        isComplete = json['isComplete'],
        dateAdded = json['dateAdded'];
}
