import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/link.dart';

class WhatsAppNowFloatingActionButtonWidget extends StatelessWidget {
  const WhatsAppNowFloatingActionButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const phoneNumber = '+923201982284';
    final String url = 'https://wa.me/$phoneNumber';
    return Link(
      uri: Uri.parse(url),
      target: LinkTarget.blank,
      builder: (context, followLink) => IconButton(
        onPressed: () {
          followLink!(); // Call followLink function to navigate
        },
        icon: Icon(
          FontAwesomeIcons.whatsapp,
          size: 40.spMax,
        ),
      ),
    );

  }
}
