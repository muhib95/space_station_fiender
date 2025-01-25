class PositionResponse {
  String? message;
  int? timestamp;
  IssPosition? issPosition;

  PositionResponse({this.message, this.timestamp, this.issPosition});

  PositionResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    timestamp = json['timestamp'];
    issPosition = json['iss_position'] != null
        ? new IssPosition.fromJson(json['iss_position'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['timestamp'] = this.timestamp;
    if (this.issPosition != null) {
      data['iss_position'] = this.issPosition!.toJson();
    }
    return data;
  }
}

class IssPosition {
  String? longitude;
  String? latitude;

  IssPosition({this.longitude, this.latitude});

  IssPosition.fromJson(Map<String, dynamic> json) {
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    return data;
  }
}
