class BaseStoreModel
{

  final dynamic model;
  final DateTime time;

  BaseStoreModel({this.model, this.time});


  BaseStoreModel.fromJson(Map<String, dynamic> json)
      : model = json['model'],
        time = DateTime.fromMillisecondsSinceEpoch(json['time']);

  Map<String, dynamic> toJson() =>
      {
        'model': model.toJson(),
        'time': time.millisecondsSinceEpoch,
      };

}