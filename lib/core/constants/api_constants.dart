class ApiConstants{
  static const String baseUrl = 'http://10.0.2.2:3000';


  static const String login = '$baseUrl/api/login';
  static const String signup = '$baseUrl/api/signup';
  static const String getProfile = '$baseUrl/api/user/profile';
  static const String getHistory = '$baseUrl/api/user/history';
  static const String checkMobileNo = '$baseUrl/api/user/checkMobileNumber';
  static const String checkAccNo= '$baseUrl/api/user/checkAccountNumber';
  static const String transferFund= '$baseUrl/api/user/balanceTransfer';
}