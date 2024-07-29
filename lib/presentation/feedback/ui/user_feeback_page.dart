import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trikecraft/models/feedback_model.dart';
import 'package:trikecraft/presentation/craft_your_old_bike/ui/craft_your_old_bike_page.dart';
import 'package:trikecraft/utils/snackbars.dart';

import '../../../base/services/hive/hive_services.dart';
import '../../../logic/user_feeback/user_feedback_cubit.dart';

class UserFeedbackPage extends StatefulWidget {
  const UserFeedbackPage({super.key});

  @override
  State<UserFeedbackPage> createState() => _UserFeedbackPageState();
}

class _UserFeedbackPageState extends State<UserFeedbackPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Feedback"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<UserFeedbackCubit, UserFeedbackState>(
          listener: (context, state) {
            if (state is UserFeedbackSubmittedState) {
              MySnackbars.showInfoSnackbar(context,
                  message: "Your feedback is submitted");
                  Navigator.pop(context);
            }
            if (state is UserFeedbackFailureState) {
              MySnackbars.showErrorSnackbar(context,
                  message: state.errorMessage);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(16.sp),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "We value your feedback!",
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    TextFormField(
                      controller: _titleController,
                      onTapOutside: (p) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      decoration: InputDecoration(
                        labelText: "Title",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),
                    TextFormField(
                      controller: _messageController,
                      maxLines: 8,
                      minLines: 3,
                      onTapOutside: (p) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      decoration: InputDecoration(
                        labelText: "Message",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your feedback message';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {

                             String userEmail = await MyHiveBoxes.settingBox.get(MyHiveKeys.userEmailHiveKey);
                             String userProfilePic = await MyHiveBoxes.settingBox.get(MyHiveKeys.userProfilePicHiveKey);

                            context.read<UserFeedbackCubit>().submitFeedback(
                                feedback: UserFeedbackModel(
                                    title: _titleController.text.trim(),
                                    message: _messageController.text.toString(),
                                    userEmail: userEmail,
                                    userPic: userProfilePic,
                                    date: DateTime.now()));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: state is UserFeedbackLoadingState
                            ? CircularProgressIndicator(color: Colors.black,)
                            : Text(
                                "Submit Feedback",
                                style: TextStyle(fontSize: 18.sp),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
