import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  //카카오 로그인
  Future<Either<Failure, User>> signInWithKakao();

  // 로그아웃
  Future<Either<Failure, void>> signOut();
}
