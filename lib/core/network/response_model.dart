// 성공 응답용 모델
class ApiResponse<T> {
  final int statusCode;
  final String message;
  final DateTime timestamp;
  final String requestURL;
  final T? data;

  ApiResponse({
    required this.statusCode,
    required this.message,
    required this.timestamp,
    required this.requestURL,
    required this.data,
  });
}

// 실패 응답용 모델
class ApiError {
  final int statusCode;
  final String message;
  final DateTime timestamp;
  final String requestURL;

  ApiError({
    required this.statusCode,
    required this.message,
    required this.timestamp,
    required this.requestURL,
  });
}
