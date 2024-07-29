import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trikecraft/base/assets/app_fonts.dart';

class SearchProductsPage extends StatefulWidget {
  const SearchProductsPage({super.key});

  @override
  State<SearchProductsPage> createState() => _SearchProductsPageState();
}

class _SearchProductsPageState extends State<SearchProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 0.1.sh,
            actions: [
              Expanded(
                  child: Container(
                padding:
                    EdgeInsets.only(top: 0.03.sh, left: 8.sp, right: 8.sp),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(CupertinoIcons.back)),
                    Expanded(
                      child: TextField(
                      
                        onTapOutside: (p){
                         FocusManager.instance.primaryFocus?.unfocus();
                        },
                        style: TextStyle(color: Colors.white, fontFamily: AppFonts.poppins),
                        decoration: InputDecoration(
                            hintText: " Search Products",
                            hintStyle: TextStyle(color: Colors.white70),
                            
                            border: InputBorder.none),
                      ),
                    ),
                  ],
                ),
              ))
            ],
          ),
        ],
      ),
    );
  }
}
