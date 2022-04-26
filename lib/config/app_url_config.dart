class AppUrl {
  static const String baseURL = "https://toeic-learning-app.herokuapp.com";

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

  static const String getAllQuizs = baseURL + "/getAllQuestionsByPartOfExamId";
  static const String getAllQuizsGroup =
      baseURL + "/getAllQuestionsByQuestionGroupByExamId";

  static const String getAllLessons = baseURL + "/getAllLessons";

  static const String getAllVideos = baseURL + "/getAllVideos";
  static const String createNewVideo = baseURL + "/createNewVideo";
  static const String deleteVideo = baseURL + "/deleteVideo/";
  static const String updateVideo = baseURL + "/updateVideo/";

  static const String getAllVocabularies = baseURL + "/getAllVocabularies/";

  static const String getAllExams = baseURL + "/getAllExams";
  static const String deleteExam = baseURL + "/deleteExam/";

  static const String getAllQuestionQA = baseURL + "/getAllQuestionQA";
  static const String getAllQuestionKeyWord = baseURL + "/getAllQAByKeyWord";
}
