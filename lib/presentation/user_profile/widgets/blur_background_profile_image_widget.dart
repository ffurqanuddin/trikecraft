
import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trikecraft/presentation/craft_your_old_bike/ui/craft_your_old_bike_page.dart';

import '../../../logic/theme/theme_cubit.dart';


class BlurBackgroundProfileImageWidget extends StatelessWidget {
  const BlurBackgroundProfileImageWidget({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
          final String? userProfileImage =
                FirebaseAuth.instance.currentUser?.photoURL;
            return ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    image: userProfileImage !=null
                        ? DecorationImage(
                        image: CachedNetworkImageProvider(userProfileImage),
                        fit: BoxFit.cover)
                        : const DecorationImage(
                        image: CachedNetworkImageProvider("https://wallpapercave.com/wp/wp6050770.jpg"),
                        fit: BoxFit.cover)),
              ),
            );
      },
    );
  }
}