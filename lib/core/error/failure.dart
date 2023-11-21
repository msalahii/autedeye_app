abstract class Failure {}

class BusinessFailure implements Failure {
  final String failureMessage;

  BusinessFailure({required this.failureMessage});
}

class InternetFailure implements Failure {}

class ServerFailure implements Failure {}
