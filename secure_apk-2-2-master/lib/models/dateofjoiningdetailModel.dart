class DateOfJoiningModel {
  var DATE_OF_JOINING;
  DateOfJoiningModel({required this.DATE_OF_JOINING});

  factory DateOfJoiningModel.fromJson(Map<String, dynamic> json) {
    return DateOfJoiningModel(
      DATE_OF_JOINING: json["DATE_OF_JOINING"],
    );
  }
}
