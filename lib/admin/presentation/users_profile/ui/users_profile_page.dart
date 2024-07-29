import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:trikecraft/base/assets/app_images.dart';

import '../../../logic/admin_users_data/admin_users_data_cubit.dart';

class AdminUsersProfilePage extends StatefulWidget {
  const AdminUsersProfilePage({Key? key}) : super(key: key);

  @override
  State<AdminUsersProfilePage> createState() => _AdminUsersProfilePageState();
}

class _AdminUsersProfilePageState extends State<AdminUsersProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<AdminUsersProfileDataCubit>().getUsersDataList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users Profile"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child:
            BlocBuilder<AdminUsersProfileDataCubit, AdminUsersProfileDataState>(
          builder: (context, state) {
            if (state is AdminUsersProfileDataLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AdminUsersProfileDataFailureState) {
              return Center(
                child: Text(
                  'Failed to load users: ${state.errorMessage}',
                  style: TextStyle(color: Colors.red, fontSize: 16.sp),
                ),
              );
            } else if (state is AdminUsersProfileDataLoadedState) {
              final usersList = state.usersList;

              return ListView.builder(
                itemCount: usersList.length,
                itemBuilder: (context, index) {
                  final user = usersList[index];
                  return FadeInUp(
                    delay: Duration(milliseconds: 100 * index),
                    child: Card(
                      margin:
                          EdgeInsets.symmetric(vertical: 5.sp, horizontal: 5.sp),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(10.w),
                        leading: CircleAvatar(
                          radius: 30.r,
                          backgroundImage:
                             user.profilePicture.isNotEmpty? CachedNetworkImageProvider(user.profilePicture,):AssetImage(AppImages.neonLandscape),
                        ),
                        title: Text(
                          user.fullName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp,
                          ),
                        ),
                        subtitle: Text(user.email),
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(child: Text('No users available.'));
          },
        ),
      ),
    );
  }
}
