class UserFeedbackModel {
  final String title;
  final String message;
  final String userEmail;
  final String userPic;
  final DateTime date;

  UserFeedbackModel({
    required this.title,
    required this.message,
    required this.userEmail,
    required this.userPic,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'message': message,
      'userEmail': userEmail,
      'userPic': userPic,
      'date': date.toIso8601String(),
    };
  }

  factory UserFeedbackModel.fromMap(Map<String, dynamic> map) {
    return UserFeedbackModel(
      title: map['title'] ?? '',
      message: map['message'] ?? '',
      userEmail: map['userEmail'] ?? '',
      userPic: map['userPic'] ?? '',
      date: DateTime.parse(map['date'] ?? DateTime.now().toIso8601String()),
    );
  }
}