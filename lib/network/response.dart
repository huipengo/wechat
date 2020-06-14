class Response {
  final int statusCode;
  final dynamic data;
  final String message;

  const Response({this.statusCode, this.data, this.message});

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      statusCode : json['statusCode'] as int,
      data: json['data'],
      message: json['message'] as String,
    );
  }
}