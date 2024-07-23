import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/link.dart';

class WhatsAppNowButtonWidget extends StatelessWidget {
  const WhatsAppNowButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const phoneNumber = '+923201982284';
    final String url = 'https://wa.me/$phoneNumber';
    return Link(
      uri: Uri.parse(url),
      target: LinkTarget.blank,
      builder: (context, followLink) => ElevatedButton.icon(
        label: Text("WhatsApp"),
        onPressed: () {
          followLink!(); // Call followLink function to navigate
        },
        icon: Icon(
          FontAwesomeIcons.whatsapp,
          size: 25.spMax,
        ),
      ),
    );
  }
}
