import "package:equatable/equatable.dart";

/// A base exception class for the application.
abstract class AppException extends Equatable implements Exception {

  /// human readable title of the problem.
  final String title;

  /// human readable description of the problem that happened.
  final String? description;

  /// The error which was caught.
  final Object? error;

  /// The stack trace of the error.
  final StackTrace? stackTrace;

  /// Creates a [AppException] with the given [error].
  const AppException({this.title = "Application exception has occurred!", this.description, this.error, this.stackTrace});

  @override
  List<Object?> get props => [title, description, error, stackTrace];
}
