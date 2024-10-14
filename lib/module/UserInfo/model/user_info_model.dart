
class UserInfoModel{
  static String name = 'name';
  static String email = 'email';
  static String number = 'number';
  static String semester = 'semester';
  static String studentId = 'studentId';
  static String bloodGroup = 'bloodGroup';

  static List<String> getUserInfo() => [name,email,number,semester,studentId,bloodGroup];

}