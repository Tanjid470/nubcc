class TeacherModel {
  String? id;
  String? name;
  String? university;
  String? contact;
  String? email;
  String? linkedIn;
  String? title;

  TeacherModel({
    this.id,
    this.name,
    this.university,
    this.contact,
    this.email,
    this.linkedIn,
    this.title,
  });
   TeacherModel.fromJson(Map<String, dynamic> map) {
      id = map['Id'];
      name = map['Name'] ;
      university = map['University'] ;
      contact = map['Contact'];
      email = map['Email'] ;
      linkedIn = map['LinkedIn'];
      title = map['Title'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['University'] = university;
    data['Contact'] = contact;
    data['Email'] = email;
    data['LinkedIn'] = linkedIn;
    data['Title'] = title;
    return data;
  }
}
