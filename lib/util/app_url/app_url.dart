class Urls {
  static String baseUrl = 'https://backendrealchat.molla.cloud/';
  static String loginUrl = '${baseUrl}token/';
  static String signupUrl = '${baseUrl}signup/';
  static String googleLoginUrl = '${baseUrl}google_login/';
  static String userSideChatListUrl = '${baseUrl}chat/connections/user_id/';
  static String userSearchUrl = '${baseUrl}chat/search/?search=username';
  static String userPreviousChat =
      '${baseUrl}chat/user-previous-chats/<int:user1>/<int:user2>/';
}
