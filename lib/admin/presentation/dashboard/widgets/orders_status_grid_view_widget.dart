// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:trikecraft/logic/theme/theme_cubit.dart';
// import 'package:trikecraft/admin/presentation/dashboard/ui/admin_dashboard.dart';
// import 'package:trikecraft/admin/presentation/dashboard/widgets/grid_box_widget.dart';

// class OrdersStatusGridViewWidget extends StatelessWidget {
//   OrdersStatusGridViewWidget({
//     super.key,
//     required this.themeState,
//   });
//   ThemeState themeState;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: GridView(
//         padding: EdgeInsets.zero,
//         shrinkWrap: true,
//         gridDelegate:
//             SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
//         children: [
//           GridBoxWidget(
//             title: "Pending",
//             iconData: FontAwesomeIcons.boxesStacked,
//             boxColor: themeState.isDarkMode
//                 ? Color.fromARGB(255, 57, 6, 63)
//                 : Color.fromARGB(255, 175, 15, 193),
//             itemsCount: "5",
//           ),
//           GridBoxWidget(
//             title: "Reviewing",
//             iconData: FontAwesomeIcons.eye,
//             boxColor: themeState.isDarkMode
//                 ? Color.fromARGB(255, 70, 54, 3)
//                 : Color.fromARGB(255, 197, 150, 9),
//             itemsCount: "2",
//           ),
//           GridBoxWidget(
//             title: "Approved",
//             iconData: Icons.check,
//             boxColor: themeState.isDarkMode
//                 ? Color.fromARGB(255, 20, 66, 3)
//                 : Color.fromARGB(255, 62, 208, 9),
//             itemsCount: "1",
//           ),
//           GridBoxWidget(
//             title: "Rejected",
//             iconData: Icons.close,
//             boxColor: themeState.isDarkMode
//                 ? Color.fromARGB(255, 61, 8, 4)
//                 : Color.fromARGB(255, 167, 39, 30),
//             itemsCount: "0",
//           ),
//           GridBoxWidget(
//             title: "RFD",
//             iconData: FontAwesomeIcons.truck,
//             boxColor: themeState.isDarkMode
//                 ? Color.fromARGB(255, 58, 4, 31)
//                 : Color.fromARGB(255, 142, 19, 80),
//             itemsCount: "2",
//           ),
//           GridBoxWidget(
//             title: "Completed",
//             iconData: Icons.done_all,
//             boxColor: themeState.isDarkMode
//                 ? Color.fromARGB(255, 3, 31, 54)
//                 : Color.fromARGB(255, 18, 84, 138),
//             itemsCount: "10",
//           ),
//         ],
//       ),
//     );
//   }
// }
