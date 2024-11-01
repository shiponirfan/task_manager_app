class ProfileModel {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String mobile;
  final String createdDate;

  ProfileModel(
      {required this.id,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.mobile,
      required this.createdDate});

  static ProfileModel setProfileModel(Map<String, dynamic> data) {
    return ProfileModel(
      id: data['_id'],
      email: data['email'],
      firstName: data['firstName'],
      lastName: data['lastName'],
      mobile: data['mobile'],
      createdDate: data['createdDate'],
    );
  }
}
