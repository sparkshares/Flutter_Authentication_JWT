class ApiEndPoints {
  static final String baseUrl = "http://10.0.2.2:8000/";
  static _AuthEndPoints get authEndPoints => _AuthEndPoints();
}

class _AuthEndPoints {
  final String registerEmail = 'api/user/register/';
  final String loginEmail = 'api/user/login/';
}
