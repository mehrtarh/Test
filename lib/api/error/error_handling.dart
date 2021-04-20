import 'package:dio/dio.dart';
import 'package:job/api/error/error_model.dart';
import 'package:job/api/error/error_type.dart';
import 'package:job/api/error/response_status.dart';

class ErrorHandling {
  static ErrorModel getErrorModel(Exception error) {
    ErrorModel errorModel;
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.CANCEL:
          errorModel = ErrorModel(
          "Request to API server was cancelled",ErrorType.Cancel);
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          errorModel = ErrorModel(
          "Connection timeout with API server",ErrorType.Timeout);
          break;
        case DioErrorType.DEFAULT:
              errorModel = ErrorModel(
              "Your internet is not connected",ErrorType.Internet_Connection);
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          errorModel = ErrorModel(
              "Receive timeout in connection with API server",ErrorType.Timeout);
          break;
        case DioErrorType.RESPONSE:
          {
            ResponseStatus responseStatus=ResponseStatus.None;
            if(error.response.statusCode==401)
              responseStatus=ResponseStatus.Authentication;
            else if(error.response.statusCode==400)
              responseStatus=ResponseStatus.BadRequest;
            else if(error.response.statusCode>=500)
              responseStatus=ResponseStatus.Server;
            errorModel = ErrorModel(
                "Received invalid status code: ${error.response.statusCode}",
                ErrorType.Response,status: responseStatus);
            break;
          }
        case DioErrorType.SEND_TIMEOUT:
          return
              errorModel = ErrorModel(
              "An error occurred. Please try again",ErrorType.Timeout);
          break;
      }
    } else {
      errorModel =  errorModel = ErrorModel("An error occurred. Please try again",ErrorType.Unknown);
    }
    return errorModel;
  }
}
