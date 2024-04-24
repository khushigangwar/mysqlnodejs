class Students {
  late String name, email;
  late int age, id, phone;
  Students({
    required this.name,
    required this.email,
    required this.age,
    required this.id,
    required this.phone,
  });
  static Students fromJson(Map<String, dynamic> json) => Students(
      name: json['name'],
      email: json['email'],
      age: json['age'],
      id: json['id'],
      phone: json['phone']);
}
