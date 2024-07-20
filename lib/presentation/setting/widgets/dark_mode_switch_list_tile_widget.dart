import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trikecraft/logic/theme/theme_cubit.dart';

class DarkModeSwitchListTileWidget extends StatelessWidget {
  const DarkModeSwitchListTileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return ListTile(
            title: Text("Dark Mode"),
            onTap: (){
               context.read<ThemeCubit>().toggleTheme();
            },
            trailing: CupertinoSwitch(
              value: state.isDarkMode,
              activeColor: Theme.of(context).primaryColor,
              onChanged: (value) {
                context.read<ThemeCubit>().toggleTheme();
              },
            ));
      },
    );
  }
}
