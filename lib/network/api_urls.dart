class AppUrls {
  // AUTH
  static String baseUrl = 'http://doubledate-api.thesuitchstaging2.com:9001/api/v1';
  static String socketUrl = 'http://doubledate-api.thesuitchstaging2.com:9001';
  // static String baseUrl = 'http://192.168.0.5:9001/api/v1';
  // static String socketUrl = 'http://192.168.0.5:9001';
  static String signInUrl = '$baseUrl/auth/login';
  static String socialLoginUrl = '$baseUrl/auth/social-login';
  static String signUpUrl = '$baseUrl/auth/signup';
  static String getProfileUrl = '$baseUrl/auth/profile';
  static String forgotPasswordUrl = '$baseUrl/auth/send-otp';
  static String otpVerifyUrl = '$baseUrl/auth/verify-otp';
  static String resetPasswordUrl = '$baseUrl/auth/reset-password';
  static String changePasswordUrl = '$baseUrl/auth/change-password';
  static String logoutUrl = '$baseUrl/auth/logout';

  // PROFILE
  static String getItemsUrl = '$baseUrl/admin/list-items';
  static String createProfileUrl = '$baseUrl/auth/create-profile';
  static String editProfileUrl = '$baseUrl/auth/update-profile';
  static String removePartnerUrl = '$baseUrl/auth/remove-partner';
  static String pairPartnerUrl = '$baseUrl/auth/pair-partner';
  static String addPartnerRequestUrl = '$baseUrl/auth/add-partner';
  static String getOtherProfileUrl = '$baseUrl/auth/profile';

  // HOME
  static String getHomeMatchesUrl = '$baseUrl/news-feed';
  static String sendLikeRequestUrl = '$baseUrl/friends/send-request';
  static String fetchContactsUrl = '$baseUrl/friends/add';
  static String homeSearchUrl = '$baseUrl/news-feed/filter';
  static String getNotificationsUrl = '$baseUrl/notifications';
  static String toggleNotificationsUrl = '$baseUrl/notifications/toggle';

  // MATCHED
  static String getMatchedListsUrl = '$baseUrl/friends/requests';
  static String respondRequestsUrl = '$baseUrl/friends/respond';
  static String partnerRespondUrl = '$baseUrl/friends/partner-like';

  // FEEDS
  static String getFeedsUrl = '$baseUrl/user/post-feed';
  static String createFeedUrl = '$baseUrl/user/post';

  // SHORTS
  static String createShortUrl = '$baseUrl/user/short';

  // SETTING
  static String reportUserUrl = '$baseUrl/user/report';
  static String blockUserUrl = '$baseUrl/user/block';
  static String sendFeedbackUrl = '$baseUrl/admin/feedbacks';
  static String getReportUsersUrl = '$baseUrl/user/list-reported-users';
  static String getReportPostsUrl = '$baseUrl/user/list-reported-posts';

  // CONVERSATION
  static String getRoomDetailsUrl = '$baseUrl/conversation/details';
  static String updateIdeaPlannerStatusUrl = '$baseUrl/conversation/status';
  static String updateRoomDetailsUrl = '$baseUrl/conversation';
  static String inviteForKnowMeUrl = '$baseUrl/conversation/invite-game';
  static String reportGroupMemberUrl = '$baseUrl/conversation/report-group';
  static String blockGroupMemberUrl = '$baseUrl/conversation/block';
  static String leaveGroupUrl = '$baseUrl/conversation/leave';

  // GAME
  static String getGameList = '$baseUrl/admin/game';

  // DATE PLANNER
  static String getDatePlannerList = '$baseUrl/date-planner';

  // DATING CONSULTANT
  static String getQuestionsList = '$baseUrl/admin/consultant-questions';

  // DATE OFFERS
  static String getDoubleDateOffersUrl = '$baseUrl/double-date';
  static String syncOfferUrl = '$baseUrl/subscribed-double-date/subscribe';
  static String unSyncOfferUrl = '$baseUrl/subscribed-double-date/unsubscribe';
  static String upcomingOfferUrl = '$baseUrl/subscribed-double-date/upcoming-dates';
  static String getCategoryUrl = '$baseUrl/admin/double-date-categories';
}
