import 'package:trip_view/core/network/response_model.dart';
import 'package:trip_view/features/auth/domain/entities/user.dart';

abstract class AuthDataSource {
  Future<ApiResponse<User>> getTokenWithKakaoAuthCode(String authCode);
  Future<void> signOut();
}

class AuthMockDataSourceImpl implements AuthDataSource {
  @override
  Future<ApiResponse<User>> getTokenWithKakaoAuthCode(String authCode) async {
    // 실제 API 호출처럼 보이게 딜레이 추가
    await Future.delayed(const Duration(seconds: 2));

    return ApiResponse(
      statusCode: 200,
      message: "로그인 성공",
      timestamp: DateTime.now(),
      requestURL: "/auth/kakao",
      data: User(
          id: "mock_user_id",
          name: "홍길동",
          email: "test@example.com",
          nickname: "길동이",
          profileImageUrl: "https://example.com/profile.jpg",
          accessToken: "mock_access_token_${authCode}",
          refreshToken: "mock_refresh_token"),
    );
  }

  @override
  Future<void> signOut() {
    // 추후 구현
    throw UnimplementedError();
  }
}

class AuthDataSourceImpl implements AuthDataSource {
  @override
  Future<ApiResponse<User>> getTokenWithKakaoAuthCode(String authCode) {
    // 추후 구현
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // 추후 구현
    throw UnimplementedError();
  }
}
