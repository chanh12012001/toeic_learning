class AppUrl {
  static const String baseURL = "https://toeic-learning-app.herokuapp.com";

  static const String login = baseURL + "/login";
  static const String otpRegister = baseURL + "/otpRegister";
  static const String verifyOTP = baseURL + "/verifyOTP";
  static const String register = baseURL + "/register";
  static const String forgotPassword = baseURL + "/forgotPassword";
  static const String updateAvatar = baseURL + "/updateAvatar";
  static const String updateUserInfo = baseURL + "/updateUserInfo";

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
  static const String getAllBlogs = baseURL + "/getAllBlogs";
  static const String createNewBlog = baseURL + "/createNewBlog";
  static const String deleteBlog = baseURL + "/deleteBlog/";

  static const String createTermsOfUse = baseURL + "/createTermsOfUse";
  static const String getTermsOfUse = baseURL + "/getTermsOfUse";
  static const String updateTermsOfUse = baseURL + "/updateTermsOfUse/";

  static const String createNewFeedback = baseURL + "/createNewFeedback";
  static const String getAllFeedbacks = baseURL + "/getAllFeedbacks";
  static const String deleteFeedback = baseURL + "/deleteFeedback/";
  static const String updateFeedback = baseURL + "/updateFeedback/";

  static const String addNewScore = baseURL + "/addNewScore";
  static const String getScoreByExamIdAndPart =
      baseURL + "/getScoreByExamIdAndPart";
}
