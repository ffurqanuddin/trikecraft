import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trikecraft/presentation/setting/widgets/change_theme_list_tile_widget.dart';

class ChangeThemeExpansionTileWidget extends StatelessWidget {
  const ChangeThemeExpansionTileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text("Change Theme"),
      trailing: CircleAvatar(
        radius: 15.spMax,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      children: [
        changeThemeListTileWidget(
          label: "Amber",
          input: "amber",
        ),
        changeThemeListTileWidget(
          label: "PinkM3",
          input: "pinkm3",
        ),
        changeThemeListTileWidget(
          label: "IndigoM3",
          input: "indigom3",
        ),
        changeThemeListTileWidget(
          label: "RedM3",
          input: "redm3",
        ),
        changeThemeListTileWidget(
          label: "RedWine",
          input: "redwine",
        ),

         changeThemeListTileWidget(
          label: "BlueM3",
          input: "bluem3",
        ),
         changeThemeListTileWidget(
          label: "CyanM3",
          input: "cyanm3",
        ),
         changeThemeListTileWidget(
          label: "DeepPurple",
          input: "deeppurple",
        ),
      ],
    );
  }
}
