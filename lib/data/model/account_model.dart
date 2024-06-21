class AccountModel {
  final int id;
  final String email;
  final String unsignFullName;
  final String fullName;
  final String password;
  final String dob;
  final String gender;
  final String image;
  final String? university;
  final bool isDeleted;
  final String roleName;
  final dynamic role; // You might need to define a specific type for 'role'

  AccountModel({
    required this.id,
    required this.email,
    required this.unsignFullName,
    required this.password,
    required this.fullName,
    required this.dob,
    required this.gender,
    required this.image,
    required this.university,
    required this.isDeleted,
    required this.roleName,
    required this.role,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      id: json['id'] as int,
      email: json['email'] as String,
      unsignFullName: json['unsign-full-name'] as String,
      password: json['password'] as String,
      fullName: json['full-name'] as String,
      dob: json['dob'] as String,
      gender: json['gender'] as String,
      image: json['image'] as String,
      university: json['university'] as String?,
      isDeleted: json['is-deleted'] as bool,
      roleName: json['role-name'] as String,
      role: json['role'], // Define a proper type if needed
    );
  }
}
class RegisterAccountModel {
  final String email;
  final String password;
  final String fullName;
  final String dob;
  final String gender;
  final String image;
  final String university;

  RegisterAccountModel({
    required this.email,
    required this.password,
    required this.fullName,
    required this.dob,
    required this.gender,
    required this.image,
    required this.university,
  });

  // Method to convert the object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'full-name': fullName,
      'dob': dob,
      'gender': gender,
      'image': image,
      'university': university,
    };
  }
}
class PaginationModel {
  final int currentPage;
  final int pageSize;
  final int totalCount;
  final int totalPages;

  PaginationModel({
    required this.currentPage,
    required this.pageSize,
    required this.totalCount,
    required this.totalPages,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      currentPage: json['current-page'] as int,
      pageSize: json['page-size'] as int,
      totalCount: json['total-count'] as int,
      totalPages: json['total-pages'] as int,
    );
  }
}