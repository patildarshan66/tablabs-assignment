import '../../utils/enums.dart';

class ApiResponse<T> {
  Status status;
  T? data;
  String? message;

  ApiResponse.initial(this.message) : status = Status.INITIAL;

  ApiResponse.loading(this.message) : status = Status.LOADING;

  ApiResponse.completed(this.data) : status = Status.COMPLETED;

  ApiResponse.error(this.message) : status = Status.ERROR;

  ApiResponse.notInternet(this.message) : status = Status.NOINTERNET;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}
