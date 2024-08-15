class Story {
  String? id;
  final String title;
  final String body;
  final List<String> reflectiveQuestions;
  final List<String> category;
  final String name;
  final String age;
  final String language;
  final String gender;
  final String? neurodevelopmentalDisorder;
  final String storyAbout;
  final String storySetting;
  final String storyFeel;
  final String primaryValues;
  final String? additionalCharacter;
  final String? extraDetails;
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
    required this.name,
    required this.age,
    required this.language,
    required this.gender,
    this.neurodevelopmentalDisorder,
    required this.storyAbout,
    required this.storySetting,
    required this.storyFeel,
    required this.primaryValues,
    this.additionalCharacter,
    this.extraDetails,
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
      name: json['name'] as String,
      age: json['age'] as String,
      language: json['language'] as String,
      gender: json['gender'] as String,
      neurodevelopmentalDisorder: json['neurodevelopmentalDisorder'] as String?,
      storyAbout: json['storyAbout'] as String,
      storySetting: json['storySetting'] as String,
      storyFeel: json['storyFeel'] as String,
      primaryValues: json['primaryValues'] as String,
      additionalCharacter: json['additionalCharacter'] as String?,
      extraDetails: json['extraDetails'] as String?,
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
      'name': name,
      'age': age,
      'language': language,
      'gender': gender,
      'neurodevelopmentalDisorder': neurodevelopmentalDisorder,
      'storyAbout': storyAbout,
      'storySetting': storySetting,
      'storyFeel': storyFeel,
      'primaryValues': primaryValues,
      'additionalCharacter': additionalCharacter,
      'extraDetails': extraDetails,
      'isRead': isRead,
      'readTime': readTime,
      'createTime': createTime,
      'updateTime': updateTime,
    };
  }
}
