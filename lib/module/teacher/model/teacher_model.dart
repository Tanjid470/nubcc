class TeacherModel {
  final String id;
  final String name;
  final String university;

  TeacherModel({
    required this.id,
    required this.name,
    required this.university,
  });

  factory TeacherModel.fromMap(Map<String, String> map) {
    return TeacherModel(
      id: map['Id'] ?? '',
      name: map['Name'] ?? '',
      university: map['University'] ?? '',
    );
  }
  Map<String, String> toMap() {
    return {
      'Id': id,
      'Name': name,
      'University': university,
    };
  }
}
