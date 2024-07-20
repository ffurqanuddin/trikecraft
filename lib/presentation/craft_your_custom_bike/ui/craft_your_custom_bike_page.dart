import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:trikecraft/base/assets/app_fonts.dart';

import '../../../logic/theme/theme_cubit.dart';

class CraftYourCustomBikePage extends StatefulWidget {
  const CraftYourCustomBikePage({super.key});

  @override
  State<CraftYourCustomBikePage> createState() =>
      _CraftYourCustomBikePageState();
}

class _CraftYourCustomBikePageState extends State<CraftYourCustomBikePage> {
  late int _selectedSeat;
  late bool _selfStart;
  late int _engineCC;
  late String _color;
  late String _brake;
  late String _gear;
  late bool _roof;
  late String _transmission;
  late String _tyreType;

  @override
  void initState() {
    super.initState();
    _selectedSeat = 1;
    _selfStart = false;
    _roof = false;
    _engineCC = 70;
    _color = "Red";
    _brake = "Hand";
    _gear = "Feet";
    _transmission = "Shaft";
    _tyreType = "Regular";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          children: [
            //---------Self Start ---------------//
            _customSwitchTile(context,
                label: "Self Start",
                value: _selfStart,
                onChanged: (val) => setState(() => _selfStart = val)),

            //---------Roof ---------------//
            _customSwitchTile(context,
                label: "Roof",
                value: _roof,
                onChanged: (val) => setState(() => _roof = val)),

            //---------Color Selection Dropdown ---------------//
            _colorSelectionDropDown(),

            //---------Seats Selection ---------------//
            _buildExpansionTile(
              context: context,
              title: "Seats",
              options: List.generate(4, (index) => "${index + 1}"),
              selectedOption: _selectedSeat.toString(),
              onSelect: (value) =>
                  setState(() => _selectedSeat = int.parse(value)),
            ),

            //---------Engine CC Selection ---------------//
            _buildExpansionTile(
              context: context,
              title: "Engine (cc)",
              options: ["70", "100", "110", "125", "150"],
              selectedOption: _engineCC.toString(),
              onSelect: (value) => setState(() => _engineCC = int.parse(value)),
            ),

            //---------Brake ---------------//
            _buildExpansionTile(
              context: context,
              title: "Brake",
              options: ["Hand", "Feet"],
              selectedOption: _brake,
              onSelect: (value) => setState(() => _brake = value),
            ),

            //---------Gear ---------------//
            _buildExpansionTile(
              context: context,
              title: "Gear",
              options: ["Hand", "Feet"],
              selectedOption: _gear,
              onSelect: (value) => setState(() => _gear = value),
            ),

            //-----------Transmission-----------///
            _buildExpansionTile(
              context: context,
              title: "Transmission",
              options: ["Shaft", "Chain"],
              selectedOption: _transmission,
              onSelect: (value) => setState(() => _transmission = value),
            ),

            //-----------Tyre Type-----------///
            _buildExpansionTile(
              context: context,
              title: "Tyre Type",
              options: ["Regular", "Large"],
              selectedOption: _tyreType,
              onSelect: (value) => setState(() => _tyreType= value),
            ),

            ///--------Bottom Gap-------//
            Gap(0.05.sh),
            SwipeButton.expand(
              thumb: Icon(Icons.double_arrow_rounded, color: Colors.white),
              child: Text("Swipe to Order Now"),
              activeThumbColor: Theme.of(context).primaryColor,
              activeTrackColor: Colors.grey.shade300,
              onSwipe: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text("Swiped"), backgroundColor: Colors.green),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  ///-------------- M E T H O D S -----------------///

  ///------------  APP BAR -------------------///
  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      toolbarHeight: 0.1.sh,
      actions: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 20.sp, left: 15.sp),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18.sp,
                  backgroundColor: Colors.grey.shade200,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(CupertinoIcons.back),
                  ),
                ),
                Gap(15.sp),
                // Title
                BlocBuilder<ThemeCubit, ThemeState>(
                  builder: (context, state) {
                    return Text(
                      "Customize Your Own Bike",
                      style: TextStyle(
                          fontSize: 19.sp,
                          fontFamily: AppFonts.poppins,
                          color:
                              state.isDarkMode ? Colors.white : Colors.black),
                    );
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  ///------Custom Switch ----------////
  Widget _customSwitchTile(BuildContext context,
      {required bool value,
      required String label,
      required ValueChanged<bool> onChanged}) {
    return ListTile(
      onTap: () => setState(() => onChanged(!value)),
      title: Text(label, style: TextStyle(fontFamily: AppFonts.poppins)),
      trailing: CupertinoSwitch(
        activeColor: Theme.of(context).primaryColor,
        value: value,
        onChanged: onChanged,
      ),
    );
  }

  ///------------ Color Selection Dropdown -------------///
  ListTile _colorSelectionDropDown() {
    return ListTile(
      title: Text("Color", style: TextStyle(fontFamily: AppFonts.poppins)),
      trailing: DropdownButton<String>(
        borderRadius: BorderRadius.circular(20),
        dropdownColor:
            Theme.of(context).dropdownMenuTheme.inputDecorationTheme?.fillColor,
        icon: Icon(EvaIcons.colorPalette),
        value: _color,
        iconEnabledColor: _color == "Red" ? Colors.red.shade800 : Colors.black,
        alignment: Alignment.center,
        items: ["Red", "Black "].map((String value) {
          return DropdownMenuItem<String>(value: value, child: Text(value));
        }).toList(),
        onChanged: (newValue) => setState(() => _color = newValue!),
      ),
    );
  }

  /// Builds an expansion tile with filter chips for selection
  Widget _buildExpansionTile({
    required BuildContext context,
    required String title,
    required List<String> options,
    required String selectedOption,
    required ValueChanged<String> onSelect,
  }) {
    return ExpansionTile(
      initiallyExpanded: false,
      title: Text(title),
      children: [
        Wrap(
          spacing: 8.sp,
          children: options.map((option) {
            return FilterChip(
              label: Text(option),
              selected: option == selectedOption,
              onSelected: (val) => onSelect(option),
              selectedColor: Theme.of(context).primaryColor,
              backgroundColor: Colors.grey.shade200,
              shape:
                  StadiumBorder(side: BorderSide(color: Colors.grey.shade400)),
              labelStyle: TextStyle(
                color: option == selectedOption ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
