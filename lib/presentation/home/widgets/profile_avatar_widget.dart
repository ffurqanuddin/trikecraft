import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileAvatarWidget extends StatelessWidget {
  const ProfileAvatarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        maxRadius: 23.sp,
        minRadius: 20.sp,
        onBackgroundImageError: (exception, stackTrace) => Icon(Icons.person),
        backgroundImage: CachedNetworkImageProvider(FirebaseAuth.instance.currentUser!.photoURL??_userImage)
      ),
    );
  }
}

final _userImage = "https://cdn.pixabay.com/photo/2017/01/30/23/52/female-2022387_1280.png";
