import 'package:trip_view/core/errors/failure.dart';

class AuthFailure extends Failure {
  AuthFailure(super.message);
}

// 카카오 로그인 실패
class KakaoSignInFailure extends AuthFailure {
  KakaoSignInFailure(super.message);
}

// 로그아웃 실패
class SignOutFailure extends AuthFailure {
  SignOutFailure(super.message);
}
