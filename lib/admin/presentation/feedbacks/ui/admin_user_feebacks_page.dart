import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trikecraft/admin/logic/user_feedback/user_feedback_cubit.dart';
import 'package:trikecraft/base/assets/app_fonts.dart';
import 'package:trikecraft/utils/date_time_format.dart';

import '../../../../models/feedback_model.dart';
import '../../../logic/admin_customizable_order/admin_customizable_orders_cubit.dart';

class AdminUserFeedbacksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<AdminUserFeedbackCubit>().getUsersFeedbacksList();
    return Scaffold(
      appBar: AppBar(
        title: Text('User Feedbacks'),
      ),
      body: BlocBuilder<AdminUserFeedbackCubit, UserFeedbackState>(
        builder: (context, state) {
          if (state is AdminLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is AdminGetUserFeedbacksSuccessState) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: state.feedbacksList.length,
                itemBuilder: (context, index) {
                  UserFeedbackModel feedback = state.feedbacksList[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    child: ListTile(
                      contentPadding: EdgeInsets.all(15),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(feedback.userPic),
                      ),
                      title: Text(
                        feedback.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              feedback.message,
                              style: TextStyle(fontFamily: AppFonts.poppins),
                            ),
                            SizedBox(height: 10),
                            Text(
                              feedback.userEmail,
                              style: TextStyle(
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              MyDateTimeFormatter.fTD(feedback.date),
                              style: TextStyle(
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is AdminGetUserFeedbacksFailureState) {
            return Center(
                child: Text('Failed to load feedbacks: ${state.errorMessage}'));
          } else {
            return Center(child: Text('No feedbacks found'));
          }
        },
      ),
    );
  }
}
