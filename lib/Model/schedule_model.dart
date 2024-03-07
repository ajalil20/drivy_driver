class ScheduleModel {
  String id='';
  String title='';
  String description='';
  String startTime='';
  String endTime='';

  ScheduleModel({
    this.id='',
    this.title='',
    this.description='',
    this.startTime='',
    this.endTime='',
  });

  ScheduleModel.fromJson(Map<String, dynamic> json) {
    id = json['_id']??'';
    title = json['title']??'';
    description = json['description']??'';
    startTime = json['start_time']??'';
    endTime = json['end_time']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['_id'] = id;
    json['title'] = title;
    json['description'] = description;
    json['start_time'] = startTime;
    json['end_time'] = endTime;
    return json;
  }
}
