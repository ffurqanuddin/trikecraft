import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:trikecraft/base/services/hive/hive_services.dart';
import 'dart:io';

import 'package:trikecraft/data/repository/change_user_profile_data_repository.dart';

part 'change_user_profile_state.dart';

class ChangeUserProfileCubit extends Cubit<ChangeUserProfileState> {
  final ChangeUserProfileDataRepository changeUserProfileDataRepository;
  final ImagePicker _picker = ImagePicker();

  ChangeUserProfileCubit({required this.changeUserProfileDataRepository})
      : super(ChangeUserProfileInitialState());

  Future<void> changeUserProfilePicture({required XFile pickedFile}) async {
    emit(ChangeUserProfileLoadingState());

    try {
     
      final userEmail =
          await MyHiveBoxes.settingBox.get(MyHiveKeys.userEmailHiveKey);

        File imageFile = File(pickedFile.path);

        // Upload the image to Firebase Storage
        String fileName = 'profile_pictures/$userEmail+profile_pic.jpg';
        Reference storageReference =
            FirebaseStorage.instance.ref().child(fileName);

        UploadTask uploadTask = storageReference.putFile(imageFile);
        await uploadTask;

        String downloadURL = await storageReference.getDownloadURL();

        // Prepare user data to update
        Map<String, dynamic> userData = {
          'profilePicture': downloadURL,
        };

        // Update user profile data in the repository
        await changeUserProfileDataRepository
            .changeUserProfileData(userData: userData)
            .whenComplete(() async {
          await MyHiveBoxes.settingBox
              .put(MyHiveKeys.userProfilePicHiveKey, downloadURL);
          emit(ChangeUserProfileSuccessfullyUpdatedState());
        });
      
    } catch (e) {
      emit(ChangeUserProfileFailureState(errorMessage: e.toString()));
    }
  }


  changeUserName({required String username})async{
    emit(ChangeUserProfileLoadingState());
    try {
        // Prepare user data to update
        Map<String, dynamic> userData = {
          'fullName': username,
        };

        // Update user profile data in the repository
        await changeUserProfileDataRepository
            .changeUserProfileData(userData: userData)
            .whenComplete(() async {
          await MyHiveBoxes.settingBox
              .put(MyHiveKeys.userNameHiveKey, username);
          emit(ChangeUserProfileSuccessfullyUpdatedState());
        });



    } catch (e) {
      emit(ChangeUserProfileFailureState(errorMessage: e.toString()));
    }
  }
}
