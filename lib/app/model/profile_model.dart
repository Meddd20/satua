class Profile {
  String? id;
  final String childsName;
  final DateTime birthDate;
  final int age;
  final String gender;
  final String? neurodevelopmentalDisorder;
  final String createTime;
  final String updateTime;

  Profile({
    this.id,
    required this.childsName,
    required this.birthDate,
    required this.age,
    required this.gender,
    required this.neurodevelopmentalDisorder,
    required this.createTime,
    required this.updateTime,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      childsName: json['childsName'],
      birthDate: DateTime.parse(json['birthDate']),
      age: json['age'],
      gender: json['gender'],
      neurodevelopmentalDisorder: json['neurodevelopmentalDisorder'],
      createTime: json['createTime'],
      updateTime: json['updateTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'childsName': childsName,
      'birthDate': birthDate.toIso8601String(),
      'age': age,
      'gender': gender,
      'neurodevelopmentalDisorder': neurodevelopmentalDisorder,
      'createTime': createTime,
      'updateTime': updateTime,
    };
  }
}
