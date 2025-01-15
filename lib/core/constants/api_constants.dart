class ApiConstants{
  static const String baseUrl = 'https://easy-bank-5w4k.onrender.com';

  static const String login = '$baseUrl/api/login';
  static const String signup = '$baseUrl/api/signup';
  static const String getProfile = '$baseUrl/api/user/profile';
  static const String getHistory = '$baseUrl/api/user/history';
  static const String checkMobileNo = '$baseUrl/api/user/checkMobileNumber';
  static const String checkAccNo= '$baseUrl/api/user/checkAccountNumber';
  static const String transferFund= '$baseUrl/api/user/balanceTransfer';
  static const String toggleTransaction= '$baseUrl/api/user/toggleTransaction';
  static const String changePassword= '$baseUrl/api/user/change-password';
  static const String changePin= '$baseUrl/api/user/change-pin';
}