import 'package:trikecraft/data/providers/change_user_profile_data_provider.dart';

class ChangeUserProfileDataRepository {
  ChangeUserProfileDataProvider profileDataProvider;
  ChangeUserProfileDataRepository({required this.profileDataProvider});

  Future<void> changeUserProfileData({required Map<String, dynamic> userData}) async {
    try {
      await profileDataProvider.changeUserProfileData(userData: userData);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
