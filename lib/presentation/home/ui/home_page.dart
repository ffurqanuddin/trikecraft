import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trikecraft/base/routes/app_routes.dart';
import 'package:trikecraft/common/custom_elevated_icon_button_widget.dart';
import 'package:trikecraft/logic/greeting_text/greeting_cubit.dart';

import '../../../logic/available_bikes/available_bikes_bloc.dart';
import '../widgets/home_app_bar_custom_widget.dart';
import '../widgets/available_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<GreetingCubit>().updateGreeting();
    context.read<AvailableBikesBloc>().add(FetchAvailableBikesListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //-----App Bar ------------///
      appBar: HomeAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //---- Available Bikes
            Expanded(child: AvailableWidget()),
        
            //----------- Customize your Old bike
            BounceInUp(
              child: CustomElevatedIconButtonWidget(
                  label: "Craft Your Old Bike",
                  icon: FontAwesomeIcons.screwdriverWrench,
                  onPressed: () {
                    print("Craft Button On Pressed");
                    Navigator.pushNamed(
                        context, AppRoutes.craftYourCustomBikeRoute);
                  }),
            )
          ],
        ),
      ),
    );
  }
}
