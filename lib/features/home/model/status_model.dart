class StatusModel {
  final String id;
  final String status;

  StatusModel({
    required this.id,
    required this.status,
  });

  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(
      id: json['_id'],
      status: json['status'],
    );
  }

  //tojson
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'status': status,
    };
  }

  //tofromdata
  factory StatusModel.tofromData(Map<String, dynamic> data) {
    return StatusModel(
      id: data['_id'],
      status: data['status'],
    );
  }
}