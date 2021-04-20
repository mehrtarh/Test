import 'package:job/api/error/error_type.dart';

import 'response_status.dart';

class ErrorModel{

  String _message;
  ErrorType _type;
  ResponseStatus _status;

  ErrorModel(String message, ErrorType type,{ResponseStatus status=ResponseStatus.None})
  {
    this._message=message;
    this._type=type;
    this._status=status;
  }

  get message => _message;
  get type => _type;
  get status => _status;




}