abstract class User {
  String id;
  String phone;
  String? name;
  String? avatar;

  User({required this.id, required this.phone, this.name, this.avatar});
}
