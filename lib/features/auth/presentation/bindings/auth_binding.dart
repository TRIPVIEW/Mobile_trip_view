import 'package:get/get.dart';
import 'package:trip_view/features/auth/data/datasources/auth_data_source.dart';
import 'package:trip_view/features/auth/data/repositories/%08auth_repository_impl.dart';
import 'package:trip_view/features/auth/domain/repositories/auth_reopository.dart';
import 'package:flutter/foundation.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    if (kReleaseMode) {
      Get.lazyPut<AuthDataSource>(() => AuthDataSourceImpl()); // 실제 API 호출
    } else {
      Get.lazyPut<AuthDataSource>(() => AuthMockDataSourceImpl()); // Mock 데이터
    }

    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(Get.find<AuthDataSource>()),
    );
  }
}
