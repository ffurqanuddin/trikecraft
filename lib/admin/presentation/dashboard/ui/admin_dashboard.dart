import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:trikecraft/admin/constant/order_status.dart';
import 'package:trikecraft/admin/logic/user_feedback/user_feedback_cubit.dart';
import 'package:trikecraft/base/routes/app_routes.dart';
import 'package:trikecraft/models/order_model.dart';
import 'package:trikecraft/utils/snackbars.dart';

import '../../../../logic/auth/auth_bloc.dart';
import '../../../../models/customization_order_model.dart';
import '../../../logic/admin_bike_order/admin_bike_orders_cubit.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);

    context.read<AdminBikeOrdersCubit>().listenToRealTimeOrders();
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      // Call listenToRealTimeOrders when the tab changes
      context.read<AdminBikeOrdersCubit>().listenToRealTimeOrders();
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Admin Dashboard"),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: logOut,
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              context.read<AdminBikeOrdersCubit>().listenToRealTimeOrders();
              context.read<AdminUserFeedbackCubit>().getUsersFeedbacksList();
            },
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: BlocListener<AdminBikeOrdersCubit, AdminBikeOrderState>(
        listener: (context, adminState) {
          if (adminState is AdminFailureState) {
            Fluttertoast.showToast(
              msg: adminState.errorMessage,
              backgroundColor: Colors.red,
            );
          }
        },
        child: Column(
          children: [
            TabBar(
              automaticIndicatorColorAdjustment: true,
              controller: _tabController,
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(text: 'Customized Orders'),
                Tab(text: 'New Orders'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  CustomizedOrdersTab(),
                  NewOrdersTab(),
                ],
              ),
            ),
            Divider(color: Colors.white),
            Expanded(
              child: OtherOptionsTab(),
            ),
          ],
        ),
      ),
    );
  }

  ////////////////////!//////////////////////////////////////////////////
  ///?------------------------    M E T H O D S  --------------------///
  //!/////////////////////////////////////////////////////////////////////

  logOut() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        alignment: Alignment.center,
        shape: CircleBorder(),
        child: Center(
          child: Container(
            height: 0.2.sh,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Are you sure",
                    style: TextStyle(
                      fontSize: 22.sp,
                    ),
                  ),
                  Gap(10),
                  ElevatedButton.icon(
                      icon: Icon(Icons.logout),
                      onPressed: () {
                        context
                            .read<AuthBloc>()
                            .add(LogOutEvent(context: context));
                      },
                      label: Text("LogOut Now"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomizedOrdersTab extends StatelessWidget {
  const CustomizedOrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Customized Bikes Orders",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16),
          CustomizedOrdersStatusGridViewWidget(),
        ],
      ),
    );
  }
}

class NewOrdersTab extends StatelessWidget {
  const NewOrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "New Bikes Orders",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16),
          NewOrdersStatusGridViewWidget(),
        ],
      ),
    );
  }
}

class OtherOptionsTab extends StatelessWidget {
  const OtherOptionsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        DashboardListTileWidget(
          title: "Users",
          icon: FontAwesomeIcons.peopleLine,
          color: Colors.grey[700]!,
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.adminUserProfileRoute);
          },
        ),
        Gap(8),
        DashboardListTileWidget(
          title: "Products",
          icon: FontAwesomeIcons.shop,
          color: Colors.grey[900]!,
          onTap: () {
             Navigator.pushNamed(context, AppRoutes.adminAddProductRoute);
          },
        ),
        Gap(8),
        DashboardListTileWidget(
          title: "Users Feedback",
          icon: Icons.feedback,
          color: Colors.grey[850]!,
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.adminUserFeedbacksRoute);
          },
        ),
      ],
    );
  }
}

class DashboardListTileWidget extends StatelessWidget {
  const DashboardListTileWidget(
      {super.key,
      required this.title,
      required this.icon,
      this.color,
      this.onTap});
  final String title;
  final IconData icon;
  final Color? color;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        style: ListTileStyle.drawer,
        onTap: onTap,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        trailing: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}

class GridBoxWidget extends StatelessWidget {
  const GridBoxWidget({
    super.key,
    required this.title,
    required this.itemsCount,
    required this.boxColor,
    this.onTap,
    this.iconData,
  });
  final String title;
  final String itemsCount;
  final Color boxColor;
  final IconData? iconData;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: boxColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 1,
              softWrap: true,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 15.sp,
              ),
            ),
            SizedBox(height: 4.sp),
            Icon(
              iconData,
              color: Colors.white,
              size: 20.sp,
            ),
            SizedBox(height: 4.sp),
            Container(
              padding: EdgeInsets.all(8.sp),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                shape: BoxShape.circle,
              ),
              child: Text(
                itemsCount,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomizedOrdersStatusGridViewWidget extends StatelessWidget {
  CustomizedOrdersStatusGridViewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminBikeOrdersCubit, AdminBikeOrderState>(
      builder: (context, adminState) {
        return Expanded(
          child: GridView(
            padding: EdgeInsets.all(8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            children: [
              //   -------------------- Customized Orders Grid Tile -----------------///

              if (adminState is AdminGetCombinedOrdersState)
                CustomizedAdminStreamGridBoxWidget(
                  stream: adminState.customizedOrders,
                  gridTitle: "Pending",
                  adminOrderStatus: AdminOrderStatus.pending,
                  gridColor: Colors.grey[850]!,
                  icon: FontAwesomeIcons.boxesStacked,
                ),
              if (adminState is AdminGetCombinedOrdersState)
                CustomizedAdminStreamGridBoxWidget(
                  stream: adminState.customizedOrders,
                  gridTitle: "Reviewing",
                  adminOrderStatus: AdminOrderStatus.reviewing,
                  gridColor: Colors.grey[800]!,
                  icon: FontAwesomeIcons.eye,
                ),

              if (adminState is AdminGetCombinedOrdersState)
                CustomizedAdminStreamGridBoxWidget(
                  stream: adminState.customizedOrders,
                  gridTitle: "Approved",
                  adminOrderStatus: AdminOrderStatus.approved,
                  gridColor: Colors.grey[700]!,
                  icon: FontAwesomeIcons.check,
                ),
              if (adminState is AdminGetCombinedOrdersState)
                CustomizedAdminStreamGridBoxWidget(
                  stream: adminState.customizedOrders,
                  gridTitle: "Rejected",
                  adminOrderStatus: AdminOrderStatus.rejected,
                  gridColor: Colors.grey[600]!,
                  icon: Icons.close,
                ),

              if (adminState is AdminGetCombinedOrdersState)
                CustomizedAdminStreamGridBoxWidget(
                  stream: adminState.customizedOrders,
                  gridTitle: "RFD",
                  adminOrderStatus: AdminOrderStatus.rfd,
                  gridColor: Colors.grey[600]!,
                  icon: FontAwesomeIcons.truck,
                ),
              if (adminState is AdminGetCombinedOrdersState)
                CustomizedAdminStreamGridBoxWidget(
                  stream: adminState.customizedOrders,
                  gridTitle: "Completed",
                  adminOrderStatus: AdminOrderStatus.completed,
                  gridColor: Colors.grey[400]!,
                  icon: Icons.done_all,
                ),

              //   -------------------- Loading Grid Tile -----------------///
              if (adminState is AdminLoadingState) AdminLoadingGridTileWidget(),
              if (adminState is AdminLoadingState) AdminLoadingGridTileWidget(),
              if (adminState is AdminLoadingState) AdminLoadingGridTileWidget(),
              if (adminState is AdminLoadingState) AdminLoadingGridTileWidget(),
              if (adminState is AdminLoadingState) AdminLoadingGridTileWidget(),
              if (adminState is AdminLoadingState) AdminLoadingGridTileWidget(),
            ],
          ),
        );
      },
    );
  }
}

class NewOrdersStatusGridViewWidget extends StatelessWidget {
  NewOrdersStatusGridViewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminBikeOrdersCubit, AdminBikeOrderState>(
      builder: (context, adminState) {
        return Expanded(
          child: GridView(
            padding: EdgeInsets.all(8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            children: [
              //   -------------------- New Orders Grid Tile -----------------///

              if (adminState is AdminGetCombinedOrdersState)
                NewAdminStreamGridBoxWidget(
                  stream: adminState.newOrders,
                  gridTitle: "Pending",
                  adminOrderStatus: AdminOrderStatus.pending,
                  gridColor: Colors.grey[850]!,
                  icon: FontAwesomeIcons.boxesStacked,
                ),
              if (adminState is AdminGetCombinedOrdersState)
                NewAdminStreamGridBoxWidget(
                  stream: adminState.newOrders,
                  gridTitle: "Reviewing",
                  adminOrderStatus: AdminOrderStatus.reviewing,
                  gridColor: Colors.grey[800]!,
                  icon: FontAwesomeIcons.eye,
                ),

              if (adminState is AdminGetCombinedOrdersState)
                NewAdminStreamGridBoxWidget(
                  stream: adminState.newOrders,
                  gridTitle: "Approved",
                  adminOrderStatus: AdminOrderStatus.approved,
                  gridColor: Colors.grey[700]!,
                  icon: FontAwesomeIcons.check,
                ),
              if (adminState is AdminGetCombinedOrdersState)
                NewAdminStreamGridBoxWidget(
                  stream: adminState.newOrders,
                  gridTitle: "Rejected",
                  adminOrderStatus: AdminOrderStatus.rejected,
                  gridColor: Colors.grey[600]!,
                  icon: Icons.close,
                ),

              if (adminState is AdminGetCombinedOrdersState)
                NewAdminStreamGridBoxWidget(
                  stream: adminState.newOrders,
                  gridTitle: "RFD",
                  adminOrderStatus: AdminOrderStatus.rfd,
                  gridColor: Colors.grey[600]!,
                  icon: FontAwesomeIcons.truck,
                ),
              if (adminState is AdminGetCombinedOrdersState)
                NewAdminStreamGridBoxWidget(
                  stream: adminState.newOrders,
                  gridTitle: "Completed",
                  adminOrderStatus: AdminOrderStatus.completed,
                  gridColor: Colors.grey[400]!,
                  icon: Icons.done_all,
                ),

              //   -------------------- Loading Grid Tile -----------------///
              if (adminState is AdminLoadingState) AdminLoadingGridTileWidget(),
              if (adminState is AdminLoadingState) AdminLoadingGridTileWidget(),
              if (adminState is AdminLoadingState) AdminLoadingGridTileWidget(),
              if (adminState is AdminLoadingState) AdminLoadingGridTileWidget(),
              if (adminState is AdminLoadingState) AdminLoadingGridTileWidget(),
              if (adminState is AdminLoadingState) AdminLoadingGridTileWidget(),
            ],
          ),
        );
      },
    );
  }
}

class CustomizedAdminStreamGridBoxWidget extends StatelessWidget {
  CustomizedAdminStreamGridBoxWidget({
    super.key,
    required this.stream,
    required this.gridTitle,
    // required this.count,
    required this.gridColor,
    required this.icon,
    required this.adminOrderStatus,
  });
  Stream<List<CustomizationOrderModel>> stream;
  String gridTitle;
  Color gridColor;
  IconData icon;
  String adminOrderStatus;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasData) {
                int ordersCount = snapshot.data!
                    .where(
                      (element) =>
                          element.orderStatus.toLowerCase() ==
                          adminOrderStatus.toLowerCase(),
                    )
                    .toList()
                    .length;

                List<CustomizationOrderModel> ordersList = snapshot.data!
                    .where(
                      (element) => element.orderStatus == adminOrderStatus,
                    )
                    .toList();
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                        context, AppRoutes.adminCustomizedBikesOrderPreviewPage,
                        arguments: ordersList);
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: gridColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          gridTitle,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          softWrap: true,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15.sp,
                          ),
                        ),
                        SizedBox(height: 4.sp),
                        Icon(
                          icon,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                        SizedBox(height: 4.sp),
                        Container(
                          padding: EdgeInsets.all(8.sp),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            ordersCount.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Container(
                  child: Center(child: Text("Nope")),
                );
              }
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.none:
              return Center(
                child: Text("No Connection"),
              );
          }
        });
  }
}

class NewAdminStreamGridBoxWidget extends StatelessWidget {
  NewAdminStreamGridBoxWidget({
    super.key,
    required this.stream,
    required this.gridTitle,
    required this.gridColor,
    required this.icon,
    required this.adminOrderStatus,
  });
  Stream<List<NewBikeOrderModel>> stream;
  String gridTitle;
  Color gridColor;
  IconData icon;
  String adminOrderStatus;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasData) {
                int ordersCount = snapshot.data!
                    .where(
                      (element) =>
                          element.orderStatus.toLowerCase() ==
                          adminOrderStatus.toLowerCase(),
                    )
                    .toList()
                    .length;
                List<NewBikeOrderModel> ordersList = snapshot.data!
                    .where(
                      (element) => element.orderStatus.toLowerCase() == adminOrderStatus.toLowerCase(),
                    )
                    .toList();

                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                        context, AppRoutes.adminNewBikesOrderPreviewPage,
                        arguments:
                         ordersList
                        );
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: gridColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          gridTitle,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          softWrap: true,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15.sp,
                          ),
                        ),
                        SizedBox(height: 4.sp),
                        Icon(
                          icon,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                        SizedBox(height: 4.sp),
                        Container(
                          padding: EdgeInsets.all(8.sp),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            ordersCount.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Container(
                  child: Center(child: Text("Nope")),
                );
              }
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.none:
              return Center(
                child: Text("No Connection"),
              );
          }
        });
  }
}

class AdminLoadingGridTileWidget extends StatelessWidget {
  const AdminLoadingGridTileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
