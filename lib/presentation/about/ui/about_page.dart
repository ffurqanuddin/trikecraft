import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:trikecraft/base/assets/app_fonts.dart';
import 'package:trikecraft/base/assets/app_svgs.dart';
import 'package:trikecraft/base/contents/app_contents.dart';
import 'package:trikecraft/common/social_media_button_icon_widget.dart';
import 'package:url_launcher/link.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(CupertinoIcons.back),
        ),
        title: const Text("About"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Animated Logo
              SlideInDown(
                child: SvgPicture.asset(
                  theme.brightness == Brightness.dark
                      ? AppSvgs.trikecraftLogoForDarkMode
                      : AppSvgs.trikecraftLogoForLightMode,
                  height: 0.2.sh,
                ),
              ),

              // Version
              FadeIn(
                child: Text(
                  AppContents.appFullVersion,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: theme.primaryColor,
                  ),
                ),
              ),

              Gap(0.05.sh),

              // Detail
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.sp),
                child: FadeInLeft(
                  child: Text(
                    "This final year project is conducted as part of our academic program at Sarhad University of Science & Information Technology and is available for review on",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10.5.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: AppFonts.poppins,
                      color: theme.textTheme.bodyMedium?.color,
                    ),
                  ),
                ),
              ),

              Gap(0.02.sh),

              // GitHub Button
              FadeInRight(
                child: Link(
                  uri: Uri.parse("https://github.com/"),
                  target: LinkTarget.blank,
                  builder: (context, followLink) => TextButton(
                    onPressed: followLink,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.sp, horizontal: 20.sp),
                      backgroundColor: theme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.sp),
                      ),
                    ),
                    child: Text(
                      "GitHub",
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              Gap(0.02.sh),

              // Message
              FadeInUp(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.sp),
                  child: Text(
                    "If you liked my work,\nshow some ❤️ and ⭐ the repo",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: theme.textTheme.bodyMedium?.color,
                    ),
                  ),
                ),
              ),

              Gap(0.05.sh),

              // Sponsors Section
              FadeInUp(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.sp),
                  child: Column(
                    children: [
                      Text(
                        "Sponsors",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: theme.primaryColor,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Link(
                            uri: Uri.parse("https://www.suit.edu.pk/"),
                            target: LinkTarget.blank,
                            builder: (context, followLink) => InkWell(
                              onTap: () {
                                followLink!();
                              },
                              child: SvgPicture.asset(
                                  height: 0.08.sh,
                                  AppSvgs.sarhadUniversityLogoForLightMode),
                            ),
                          ),
                          Link(
                            uri: Uri.parse(
                                "https://www.linkedin.com/company/lyrilab"),
                            target: LinkTarget.blank,
                            builder: (context, followLink) => InkWell(
                              onTap: () {
                                followLink!();
                              },
                              child: SvgPicture.asset(
                                height: 0.12.sh,
                                theme.brightness == Brightness.dark
                                    ? AppSvgs.lyrilabLogoForDarkMode
                                    : AppSvgs.lyrilabLogoForLightMode,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Stay Connected
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 4.sp),
                child: ZoomIn(
                  child: Text(
                    "Stay Connected",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              ),

              ElasticInUp(
                child: const ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    // LinkedIn Button
                    SocialMediaIconButton(
                        url: "https://www.linkedin.com/in/ghulam-mustafa-765174291",
                        icon: FontAwesomeIcons.linkedin),

                    // Instagram Button
                    SocialMediaIconButton(
                        url: "https://www.instagram.com/dilwale7457",
                        icon: FontAwesomeIcons.instagram),

                    // Twitter Button
                    SocialMediaIconButton(
                        url: "https://www.twitter.com/GMustafa4050",
                        icon: FontAwesomeIcons.twitter),

                    // Threads Button
                    SocialMediaIconButton(
                        url: "https://www.threads.net/dilwale7457",
                        icon: FontAwesomeIcons.threads),
                  ],
                ),
              ),

              Gap(0.05.sh),

              // Credits
              FadeInUp(
                child: Center(
                  child: Text(
                    "Made with ❤️ by Ghulam Mustafa & Abdul Sattar",
                    style: TextStyle(fontSize: 12.spMax),
                  ),
                ),
              ),

              Gap(0.05.sh),
            ],
          ),
        ),
      ),
    );
  }
}
