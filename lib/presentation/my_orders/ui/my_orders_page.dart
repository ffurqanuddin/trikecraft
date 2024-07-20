import 'package:cached_network_image/cached_network_image.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trikecraft/base/assets/app_fonts.dart';
import 'package:trikecraft/data/providers/bikes_data_provider.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "My Orders",
          style: TextStyle(fontFamily: AppFonts.poppins),
        ),
      ),
      floatingActionButton: ElevatedButton.icon(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            fixedSize: Size(0.5.sw, 0.05.sh), shape: StadiumBorder()),
        label: Text("Support Team"),
        icon: Icon(Icons.chat),
      ),
      body: ListView.builder(
        itemCount: BikesDataProvider().available.length,
        itemBuilder: (context, index) => ListTile(
            visualDensity: VisualDensity.comfortable,
            onTap: () {},
            title: Text("Order No. ${index}"),
            subtitle: Text("Fast and Affordable Price"),
            trailing: Column(
              children: [
                Text(
                  "Order Status",
                  style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 10.sp),
                ),
                Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.red),
                    child: Text(
                      "Reviewing",
                      style: TextStyle(color: Colors.white, fontSize: 13.sp),
                    ))
              ],
            ),
            leading: Container(
              width: 0.15.sw,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(
                          BikesDataProvider().available[index].picture),
                      fit: BoxFit.contain)),
            )),
      ),
    );
  }
}
