class PrefaceModel{
  String preface;
  String dedication;
  String auditor;
  String vision;

  PrefaceModel({
    required this.preface,
    required this.dedication,
    required this.auditor,
    required this.vision
  });

  static PrefaceModel fromJson(Map<String, dynamic> data){
    return PrefaceModel(
      preface: data['preface'],
      dedication: data['dedication'],
      auditor: data['auditor'],
      vision: data['vision'],
    );
  }
}