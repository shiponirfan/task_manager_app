class Urls {
  static const String baseUrl = 'http://35.73.30.144:2005/api/v1';
  static const String registrationUrl = '$baseUrl/Registration';
  static const String loginUrl = '$baseUrl/Login';
  static const String profileUpdateUrl = '$baseUrl/ProfileUpdate';
  static const String profileDetailsUrl = '$baseUrl/ProfileDetails';
  static const String recoverVerifyEmailUrl = '$baseUrl/RecoverVerifyEmail';
  static const String recoverVerifyOtpUrl = '$baseUrl/RecoverVerifyOtp';
  static const String recoverResetPasswordOtpUrl = '$baseUrl/RecoverResetPassword';
  static const String createTaskUrl = '$baseUrl/createTask';
  static const String getNewTaskList = '$baseUrl/listTaskByStatus/New';
  static const String getProgressTaskList = '$baseUrl/listTaskByStatus/Progress';
  static const String getCompletedTaskList = '$baseUrl/listTaskByStatus/Completed';
  static const String getCanceledTaskList = '$baseUrl/listTaskByStatus/Canceled';
  static const String getTaskStatusCount = '$baseUrl/taskStatusCount';
  static const String updateProfile = '$baseUrl/ProfileUpdate';
  static const String updateProfileDetails = '$baseUrl/ProfileDetails';
  static const String recoverResetPassword = '$baseUrl/RecoverResetPassword';
  static String updateTaskStatus(String taskId, String status) => '$baseUrl/updateTaskStatus/$taskId/$status';
  static String deleteTaskStatus(String taskId) => '$baseUrl/deleteTask/$taskId';
  static String recoverVerifyEmail(String email) => '$baseUrl/RecoverVerifyEmail/$email';
  static String recoverVerifyOtp(String email, int otp) => '$baseUrl/RecoverVerifyOtp/$email/$otp';
}