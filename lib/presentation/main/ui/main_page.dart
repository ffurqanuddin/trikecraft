import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trikecraft/logic/check_internet/check_internet_bloc.dart';
import 'package:trikecraft/logic/check_internet/check_internet_state.dart';
import 'package:trikecraft/presentation/home/ui/home_page.dart';
import 'package:trikecraft/presentation/my_orders/ui/my_orders_page.dart';
import 'package:trikecraft/presentation/setting/ui/settings_page.dart';
import 'package:trikecraft/utils/snackbars.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int currentIndex;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckInternetConnectionBloc,
        CheckInternetConnectionState>(
      listener: (context, internetState) {
        _ifInternetIsNotConnected(internetState, context);
      },
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: currentIndex,
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      CupertinoIcons.home,
                    ),
                    label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.cube_box), label: "My Orders"),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.settings), label: "Settings"),
              ]),
          body: _pages[currentIndex],
        );
      },
    );
  }

  void _ifInternetIsNotConnected(
      CheckInternetConnectionState internetState, BuildContext context) {
    if (internetState is NoInternetConnectionState) {
      MySnackbars.showErrorSnackbar(context,
          message: "Please make sure your internet connection is on !");
    }
  }

  List<Widget> _pages = [HomePage(), MyOrdersPage(), SettingsPage()];
}
