class AppUrl {
  static const String baseURL = "https://toeic-learning-backend.herokuapp.com";

  static const String login = baseURL + "/login";
  static const String otpRegister = baseURL + "/otpRegister";
  static const String verifyOTP = baseURL + "/verifyOTP";
  static const String register = baseURL + "/register";
  static const String forgotPassword = baseURL + "/forgotPassword";

  static const String getIdLectureTypeByName =
      baseURL + "/admin/getIdLectureTypeByName";

  static const String createNewTopic = baseURL + "/createNewTopic";
  static const String getAllTopics = baseURL + "/getAllTopics";
  static const String deleteTopic = baseURL + "/deleteTopic/";
  static const String updateTopic = baseURL + "/updateTopic/";
}