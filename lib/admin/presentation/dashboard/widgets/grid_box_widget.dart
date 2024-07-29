// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gap/gap.dart';

// class GridBoxWidget extends StatelessWidget {
//   const GridBoxWidget(
//       {super.key,
//       required this.title,
//       required this.itemsCount,
//       required this.boxColor,
//       this.iconData});
//   final String title;
//   final String itemsCount;
//   final Color boxColor;
//   final IconData? iconData;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: boxColor,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               title,
//               textAlign: TextAlign.center,
//               maxLines: 2,
//               softWrap: true,
//               style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                   fontSize: 18.sp),
//             ),
//           ),
//           Icon(
//             iconData,
//             color: Colors.white,
//           ),
//           Gap(2),
//           Container(
//             padding: EdgeInsets.all(8.sp),
//             decoration:
//                 BoxDecoration(color: Colors.black, shape: BoxShape.circle),
//             child: Text(
//               itemsCount,
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 17.sp,
//                   fontWeight: FontWeight.bold),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
