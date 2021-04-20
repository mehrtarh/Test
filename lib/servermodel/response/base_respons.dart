import 'package:job/api/error/error_model.dart';
import 'package:job/api/error/error_type.dart';

class BaseResponse<T> {

  final dynamic result;
  final isSuccessFull;
  final error;


  BaseResponse.fromJson(Map<String, dynamic> json,T result)
     : isSuccessFull=true,
        error=ErrorModel('', ErrorType.None),
        this.result=result;


  Map<String, dynamic> toJsonBase(dynamic resultJson) =>
      {
        'data': resultJson,
      };



  BaseResponse.withError(errorModel)
      :  isSuccessFull = false,
        this.result=errorModel,
        error = errorModel is ErrorModel?errorModel:ErrorModel(errorModel.message,ErrorType.Exception);

}