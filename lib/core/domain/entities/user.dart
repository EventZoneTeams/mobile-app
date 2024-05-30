import 'package:equatable/equatable.dart';


// ignore: must_be_immutable
class User extends Equatable {
      final String id;
      final String?  dob;
      final String? gender;
      final String? image;
      final String? university;
      final String username;
      final String? email;
      final String password;

      const User(this.id, this.dob, this.gender, this.image, this.university,
      this.username, this.email, this.password);

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    dob,
    gender,
    image,
    university,
    username,
    email,
    password
  ];


}