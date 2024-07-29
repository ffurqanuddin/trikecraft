import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trikecraft/base/services/hive/hive_services.dart';
import 'package:trikecraft/logic/change_user_profile/change_user_profile_cubit.dart';
import 'package:trikecraft/utils/snackbars.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String profileImageUrl; // Replace with your profile image URL
  late TextEditingController _nameController;
  XFile? temporaryPickedImage;

  @override
  void initState() {
    super.initState();
    profileImageUrl = profileImageFromHive() ?? "";
    _nameController = TextEditingController(text: profileNameFromHive() ?? "");
  }

  String profileImageFromHive() =>
      MyHiveBoxes.settingBox.get(MyHiveKeys.userProfilePicHiveKey);
  String profileNameFromHive() =>
      MyHiveBoxes.settingBox.get(MyHiveKeys.userNameHiveKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocConsumer<ChangeUserProfileCubit, ChangeUserProfileState>(
        listener: (context, state) {
          if (state is ChangeUserProfileSuccessfullyUpdatedState) {
            MySnackbars.showSimpleSnackbar(context, message: "Profile is updated");
            Navigator.pop(context);
          }

          if (state is ChangeUserProfileFailureState) {
            MySnackbars.showErrorSnackbar(context, message: state.errorMessage);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF0F2027), Color(0xFF2C5364)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: temporaryPickedImage != null
                                ? FileImage(File(temporaryPickedImage!.path))
                                : CachedNetworkImageProvider(profileImageUrl)
                                    as ImageProvider,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 4,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.blueAccent,
                              child: IconButton(
                                icon: Icon(Icons.edit, color: Colors.white),
                                onPressed: () async {
                                  final _picker = ImagePicker();
                                  XFile? pickedImage = await _picker.pickImage(
                                      source: ImageSource.gallery);

                                  if (pickedImage != null) {
                                    setState(() {
                                      temporaryPickedImage = pickedImage;
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white.withOpacity(0.2)),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: TextField(
                          controller: _nameController,
                          onTapOutside: (p){
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter your name',
                            hintStyle: TextStyle(color: Colors.white54),
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          if (_nameController.text.isNotEmpty) {
                            context.read<ChangeUserProfileCubit>().changeUserName(
                                username: _nameController.text.toString().trim());
                          }
                          if (temporaryPickedImage != null) {
                            context
                                .read<ChangeUserProfileCubit>()
                                .changeUserProfilePicture(pickedFile: temporaryPickedImage!);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          
                        ),
                        child: state is ChangeUserProfileLoadingState
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'Update Profile',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
