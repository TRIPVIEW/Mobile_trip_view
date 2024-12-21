import 'package:dartz/dartz.dart';
import 'package:trip_view/core/errors/failure.dart';
import 'package:trip_view/core/network/response_model.dart';
import 'package:trip_view/features/auth/domain/entities/user.dart';

import '../repositories/auth_reopository.dart';

enum LoginMethod {
  kakao,
  // 추후 로그인 프로바이더 추가 시 명시
}

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, ApiResponse<User>>> call(LoginMethod method) async {
    switch (method) {
      case LoginMethod.kakao:
        return await repository.signInWithKakao();
    }
  }
}
