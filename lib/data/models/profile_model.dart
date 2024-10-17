class ProfileModel {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String mobile;
  final String password;
  final String createdDate;

  ProfileModel(
      {required this.id,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.mobile,
      required this.password,
      required this.createdDate});

  static ProfileModel setProfileModel(List<dynamic> data) {
    return ProfileModel(
      id: data[0]['_id'],
      email: data[0]['email'],
      firstName: data[0]['firstName'],
      lastName: data[0]['lastName'],
      mobile: data[0]['mobile'],
      password: data[0]['password'],
      createdDate: data[0]['createdDate'],
    );
  }
}
