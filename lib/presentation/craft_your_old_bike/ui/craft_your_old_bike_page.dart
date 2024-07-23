import 'package:animate_do/animate_do.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:trikecraft/base/assets/app_fonts.dart';
import 'package:trikecraft/base/di/dependency_injection.dart';
import 'package:trikecraft/data/providers/firebase_auth_providers.dart';
import 'package:trikecraft/logic/customized_bike_order/customized_bike_order_bloc.dart';
import 'package:trikecraft/models/customization_order_model.dart';
import 'package:trikecraft/presentation/craft_your_old_bike/methods/show_order_confirm_dialog.dart';
import 'package:trikecraft/presentation/craft_your_old_bike/widgets/custom_text_field_widget.dart';
import 'package:trikecraft/presentation/craft_your_old_bike/widgets/item_row_widget.dart';
import 'package:trikecraft/presentation/craft_your_old_bike/widgets/text_detail_widget.dart';
import 'package:trikecraft/utils/generate_unique_order_id.dart';
import 'package:trikecraft/utils/snackbars.dart';
import '../../../common/custom_elevated_icon_button_widget.dart';
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
  late String _kick;
  late bool _roof;
  late String _transmission;
  late String _tyreSize;
  late TextEditingController _extraDetailTextEditingController;
  late TextEditingController _contactTextEditingController;
  late TextEditingController _addressTextEditingController;

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
    _kick = "Feet";
    _transmission = "Shaft";
    _tyreSize = "Regular";
    _extraDetailTextEditingController = TextEditingController();
    _addressTextEditingController = TextEditingController();
    _contactTextEditingController = TextEditingController();
  }

  int calculateTotalPrice() {
    int serviceCharges = 500;
    int tyreCharges = _tyreSize == 'regular'
        ? 3000
        : _tyreSize == 'large'
            ? 5000
            : 2000;
    int seatCharges = _selectedSeat == 1
        ? 0
        : _selectedSeat == 2
            ? 5000
            : _selectedSeat == 3
                ? 8000
                : 12000;
    int basicCustomizationCharges = 20000;

    int totalPrice =
        serviceCharges + tyreCharges + seatCharges + basicCustomizationCharges;
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.sp),
        child: BlocListener<CustomizedBikeOrderBloc, CustomizedBikeOrderState>(
          listener: (context, state) {
            if (state is CustomizedBikeOrderDataSuccessfullySavedState) {
              Navigator.pop(context);
              Navigator.pop(context);
              showOrderConfirmationDialog(context);
            }

            if (state is CustomizedBikeOrderDataSavingFailureState) {
              MySnackbars.simple(context: context, content: state.errorMessage);
            }
          },
          child: Column(
            children: [
              //---------Self Start ---------------//
              FadeInLeft(
                child: _customSwitchTile(context,
                    label: "Self Start",
                    value: _selfStart,
                    onChanged: (val) => setState(() => _selfStart = val)),
              ),

              //---------Roof ---------------//
              FadeInLeft(
                child: _customSwitchTile(context,
                    label: "Roof",
                    value: _roof,
                    onChanged: (val) => setState(() => _roof = val)),
              ),

              //---------Color Selection Dropdown ---------------//
              FadeInLeft(child: _colorSelectionDropDown()),

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
                onSelect: (value) =>
                    setState(() => _engineCC = int.parse(value)),
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

              //---------Kick ---------------//
              _buildExpansionTile(
                context: context,
                title: "Kick",
                options: ["Hand", "Feet"],
                selectedOption: _kick,
                onSelect: (value) => setState(() => _kick = value),
              ),

              //-----------Transmission-----------///
              _buildExpansionTile(
                context: context,
                title: "Transmission",
                options: ["Shaft", "Chain"],
                selectedOption: _transmission,
                onSelect: (value) => setState(() => _transmission = value),
              ),

              //-----------Tyre Size-----------///
              _buildExpansionTile(
                context: context,
                title: "Tyre Size",
                options: ["Small", "Regular", "Large"],
                selectedOption: _tyreSize,
                onSelect: (value) => setState(() => _tyreSize = value),
              ),

              ExpansionTile(
                title: Text("Please fill the forms"),
                children: [
                  ///--------Extra Detail-------//
                  CustomTextFieldWidget(
                    controller: _extraDetailTextEditingController,
                    hintText: "Extra detail about bike",
                  ),

                  ///------- Your Address --------///
                  CustomTextFieldWidget(
                    controller: _addressTextEditingController,
                    hintText: "Your Full Address",
                    maxLength: 100,
                  ),

                  ///-------- Your Contact Number -------///
                  CustomTextFieldWidget(
                    controller: _contactTextEditingController,
                    hintText:
                        "Your Contact eg. social media username,whatsapp, email etc.",
                    maxLength: 35,
                  ),
                ],
              ),

              //----------- Order Now
              BounceInUp(
                child: Center(
                    child: CustomElevatedIconButtonWidget(
                        label: "Order Now",
                        icon: FontAwesomeIcons.addressBook,
                        onPressed: _orderNow)),
              )
            ],
          ),
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

                // Customize your bike
                BlocBuilder<ThemeCubit, ThemeState>(
                  builder: (context, state) {
                    return FadeInDown(
                      child: Text(
                        "Customize Your Own Bike",
                        style: TextStyle(
                            fontSize: 19.sp,
                            fontFamily: AppFonts.poppins,
                            color:
                                state.isDarkMode ? Colors.white : Colors.black),
                      ),
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
    return FadeInUp(
      child: ExpansionTile(
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
                shape: StadiumBorder(
                    side: BorderSide(color: Colors.grey.shade400)),
                labelStyle: TextStyle(
                  color: option == selectedOption ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  //------------  ORDER NOW Button On Pressed _____________
  _orderNow() {
    print("Order Now Button is Pressed");

    if (_addressTextEditingController.text.isEmpty &&
        _contactTextEditingController.text.isEmpty) {
      print("\nForms are empty\n");
      MySnackbars.simple(
          context: context, content: "Please fill the address & contact form");
    } else {
      customOrderModalSheet();
    }
  }

  //----------- Order Sheet ------------------///
  Future<dynamic> customOrderModalSheet() {
    return showModalBottomSheet(
      context: context,
      useSafeArea: false,
      enableDrag: true,
      isScrollControlled: true,
      showDragHandle: true,
      useRootNavigator: true,
      builder: (context) => SizedBox(
        height: 0.85.sh,
        child: ListView(
          children: [
            ///------ Heading --------------///
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "Order Detail",
                  style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp),
                ),
              ),
            ),

            ///------ Your Customization --------------///
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Center(
                child: Text(
                  "Your Customization",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                      fontFamily: AppFonts.poppins),
                ),
              ),
            ),

            ItemRowWidget(
              label: "Self Start",
              val: _selfStart,
            ),
            ItemRowWidget(
              label: "Roof",
              val: _roof,
            ),
            ItemRowWidget(
              label: "Color",
              val: _color,
            ),
            ItemRowWidget(
              label: "Seat Capacity",
              val: _selectedSeat,
            ),
            ItemRowWidget(
              label: "Engine(cc)",
              val: _engineCC,
            ),
            ItemRowWidget(
              label: "Brake",
              val: _brake,
            ),
            ItemRowWidget(
              label: "Gear",
              val: _gear,
            ),
            ItemRowWidget(
              label: "Kick",
              val: _kick,
            ),
            ItemRowWidget(
              label: "Transmission",
              val: _transmission,
            ),
            ItemRowWidget(
              label: "Tyre Type",
              val: _tyreSize,
            ),

            ///------ Bike Extra Detail --------------///
            TextDetailWidget(
              heading: "Bike Extra Detail",
              controller: _extraDetailTextEditingController,
            ),

            ///-------- User Detail ------------///
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Center(
                child: Text(
                  "Users Detail",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),

            TextDetailWidget(
              heading: "Your Contact Info",
              controller: _contactTextEditingController,
            ),
            TextDetailWidget(
              heading: "Your Address",
              controller: _addressTextEditingController,
            ),

            ///------ Payment Detail --------------///
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Center(
                child: Text(
                  "Payment Detail",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                      fontFamily: AppFonts.poppins),
                ),
              ),
            ),

            ///----------------- Estimated Price -----------------///
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Services Charges :",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 16.sp),
                      ),
                      Text(
                        "500 PKR",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                            fontFamily: AppFonts.poppins),
                      ),
                    ],
                  ),
                  Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tyres Charges :",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 16.sp),
                      ),
                      Text(
                        (_tyreSize == 'regular'
                            ? '3000 PKR'
                            : _tyreSize == 'large'
                                ? '5000 PKR'
                                : '2000 PKR'),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                            fontFamily: AppFonts.poppins),
                      ),
                    ],
                  ),
                  Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Seats Charges :",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 16.sp),
                      ),
                      Text(
                        (_selectedSeat == 1
                            ? 'no charges'
                            : _selectedSeat == 2
                                ? '5000 PKR'
                                : _selectedSeat == 3
                                    ? '8000 PKR'
                                    : '12000 PKR'),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                            fontFamily: AppFonts.poppins),
                      ),
                    ],
                  ),
                  Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Basic Customization Charges :",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 16.sp),
                      ),
                      Text(
                        "20, 000 PKR",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                            fontFamily: AppFonts.poppins),
                      ),
                    ],
                  ),
                  Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Price :",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20.sp),
                      ),
                      Text(
                        "${calculateTotalPrice()} PKR",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                            fontFamily: AppFonts.poppins),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Gap(15),

            ///---------- Swipe Button -----------///
            BlocBuilder<CustomizedBikeOrderBloc, CustomizedBikeOrderState>(
              builder: (context, state) {
                if (state is CustomizedBikeOrderDataLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return FadeInUp(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 16.sp),
                      child: SwipeButton.expand(
                        thumb: Icon(Icons.double_arrow_rounded,
                            color: Colors.white),
                        child: Text("Swipe to Confirm"),
                        activeThumbColor: Theme.of(context).primaryColor,
                        activeTrackColor: Colors.grey.shade300,
                        onSwipe: () {
                          print("Swiped");

                          final _currentUser =
                              FirebaseAuth.instance.currentUser!;

                          ///---------------- Save data to Firestore Customized Orders Collection ------------------///
                          context.read<CustomizedBikeOrderBloc>().add(
                                SaveCustomizedBikeOrderDataEvent(
                                  customizationOrderModel:
                                      CustomizationOrderModel(
                                          orderId: generateOrderId(_currentUser
                                              .email
                                              .toString()),
                                          userName: _currentUser.displayName ??
                                              "User",
                                          userEmail:
                                              _currentUser.email.toString(),
                                          contactInfo:
                                              _contactTextEditingController.text
                                                  .toString(),
                                          address: _addressTextEditingController
                                              .text,
                                          selfStart: _selfStart,
                                          roof: _roof,
                                          color: _color,
                                          seats: _selectedSeat,
                                          engineCc: _engineCC.toString(),
                                          brake: _brake,
                                          gear: _gear,
                                          kick: _kick,
                                          tyreSize: _tyreSize,
                                          transmission: _transmission,
                                          totalPrice: calculateTotalPrice(),
                                          orderDate: DateTime.now(),
                                          orderStatus: "pending",
                                          extraDetail:
                                              _extraDetailTextEditingController
                                                  .text),
                                ),
                              );
                        },
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

getCurrentUserData() async {
  final firebaseAuthProviders = getIt<FirebaseAuthProviders>();
  return firebaseAuthProviders.getCurrentUserData.currentUser;
}
