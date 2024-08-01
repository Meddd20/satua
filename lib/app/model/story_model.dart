class Story {
  String? id;
  final String title;
  final String body;
  final List<String> reflectiveQuestions;
  final List<String> category;
  final bool isRead;
  final String? readTime;
  final String createTime;
  final String updateTime;

  Story({
    this.id,
    required this.title,
    required this.body,
    required this.reflectiveQuestions,
    required this.category,
    required this.isRead,
    this.readTime,
    required this.createTime,
    required this.updateTime,
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      id: json["id"] as String?,
      title: json['title'] as String,
      body: json['body'] as String,
      reflectiveQuestions: List<String>.from(json['reflectiveQuestions'] as List),
      category: List<String>.from(json['category'] as List),
      isRead: json['isRead'] as bool,
      readTime: json['readTime'] as String?,
      createTime: json['createTime'] as String,
      updateTime: json['updateTime'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'reflectiveQuestions': reflectiveQuestions,
      'category': category,
      'isRead': isRead,
      'readTime': readTime,
      'createTime': createTime,
      'updateTime': updateTime,
    };
  }
}
