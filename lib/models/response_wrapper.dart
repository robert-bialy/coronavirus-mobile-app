class ResponseWrapper<T> {
  T message;
  bool isSuccess;
  String error;

  ResponseWrapper.withSuccess(T message) {
    isSuccess = true;
    this.message = message;
  }

  ResponseWrapper.withError(String error) {
    isSuccess = false;
    this.error = error;
  }
}