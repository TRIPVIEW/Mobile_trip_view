import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:kakao_flutter_sdk_auth/kakao_flutter_sdk_auth.dart';
import 'package:naver_login_sdk/naver_login_sdk.dart';
import 'package:trip_view/core/errors/failure.dart';
import 'package:trip_view/core/network/response_model.dart';
import 'package:trip_view/features/auth/data/datasources/auth_data_source.dart';
import 'package:trip_view/features/auth/domain/entities/user.dart';

import '../../../../core/errors/auth_failure.dart';
import '../../domain/repositories/auth_reopository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, ApiResponse<User>>> signInWithKakao() async {
    try {
      // 1. 인가 코드 발급
      String authCode;
      try {
        if (await isKakaoTalkInstalled()) {
          authCode =
              await AuthCodeClient.instance.authorizeWithTalk(redirectUri: '');
        } else {
          authCode = await AuthCodeClient.instance.authorize(redirectUri: '');
        }
      } on Exception catch (e) {
        return Left(KakaoSignInFailure("카카오 인가 코드 발급 실패: ${e.toString()}"));
      }

      // 2. 인가 코드를 사용하여 토큰 발급
      if (authCode.isNotEmpty) {
        final response = await dataSource.getTokenWithKakaoAuthCode(authCode);
        return Right(response);
      } else {
        return Left(KakaoSignInFailure("인가 코드 발급 실패"));
      }
    } catch (e) {
      return Left(KakaoSignInFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiResponse<User>>> signInWithNaver() async {
    try {
      // 1. 인가 코드 발급
      String? authCode;
      try {
        final completer = Completer<String?>();

        await NaverLoginSDK.authenticate(
          callback: OAuthLoginCallback(
            onSuccess: () async {
              final token = await NaverLoginSDK.getAccessToken();
              completer.complete(token);
            },
            onFailure: (httpStatus, message) {
              completer.completeError(message);
            },
            onError: (errorCode, message) {
              completer.completeError(message);
            },
          ),
        );

        authCode = await completer.future;
      } on Exception catch (e) {
        return Left(NaverSignInFailure("네이버 인가 코드 발급 실패: ${e.toString()}"));
      }

      // 2. 인가 코드를 사용하여 토큰 발급
      if (authCode != null && authCode.isNotEmpty) {
        final response = await dataSource.getTokenWithNaverAuthCode(authCode);
        return Right(response);
      } else {
        return Left(NaverSignInFailure("인가 코드 발급 실패"));
      }
    } catch (e) {
      return Left(NaverSignInFailure(e.toString()));
    }
  }

  // 추후 수정 필요
  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await dataSource.signOut();
      return const Right(null);
    } catch (e) {
      return Left(KakaoSignInFailure(e.toString()));
    }
  }
}
