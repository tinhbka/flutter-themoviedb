import 'dart:io';

class RemoteDataSourceException extends HttpException {
  final int statusCode;

  RemoteDataSourceException(this.statusCode, String message) : super(message);

  @override
  String toString() => '$message';
}
