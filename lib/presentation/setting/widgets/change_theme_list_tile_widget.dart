import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trikecraft/logic/theme/theme_cubit.dart';

class changeThemeListTileWidget extends StatelessWidget {
  const changeThemeListTileWidget({
    super.key,
    required this.label,
    required this.input
  });

  final String label;
  final String input;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      
      title: Text(label),
      onTap: () {
        context.read<ThemeCubit>().changeTheme(name: input);
      },
    );
  }
}
