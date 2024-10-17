class ClubCommitteeModel {
  String? id;
  String? name;
  String? contact;
  String? email;
  String? semester;
  String? section;
  String? image;
  String? bloodGroup;
  String? hometown;
  String? role;

  ClubCommitteeModel({
    this.id,
    this.name,
    this.contact,
    this.email,
    this.semester,
    this.section,
    this.image,
    this.bloodGroup,
    this.hometown,
    this.role,
  });

  ClubCommitteeModel.fromJson(Map<String, dynamic> map) {
    id = map['Id'];
    name = map['Name'];
    contact = map['Contact'];
    email = map['Email'];
    semester = map['Semester'];
    section = map['Section'];
    image = map['Image'];
    bloodGroup = map['Blood'];
    hometown = map['Hometown'];
    role = map['Role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['Contact'] = contact;
    data['Email'] = email;
    data['Semester'] = semester;
    data['Section'] = section;
    data['Image'] = image;
    data['Blood'] = bloodGroup;
    data['Hometown'] = hometown;
    data['Role'] = role;
    return data;
  }
}
