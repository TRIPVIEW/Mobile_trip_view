import 'package:dartz/dartz.dart';
import 'package:trip_view/core/network/response_model.dart';
import 'package:trip_view/features/auth/domain/entities/user.dart';

import '../../../../core/errors/failure.dart';

abstract class AuthRepository {
  //카카오 로그인
  Future<Either<Failure, ApiResponse<User>>> signInWithKakao();

  //네이버 로그인
  Future<Either<Failure, ApiResponse<User>>> signInWithNaver();

  // 로그아웃
  Future<Either<Failure, void>> signOut();
}
