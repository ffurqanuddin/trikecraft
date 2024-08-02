import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trikecraft/base/routes/app_routes.dart';
import 'package:trikecraft/logic/all_available_bikes/available_bikes_bloc.dart';
import 'package:trikecraft/logic/available_pageview_changed/available_page_view_changed_cubit.dart';
import 'package:trikecraft/presentation/home/widgets/available_widget.dart';
import 'package:trikecraft/presentation/home/widgets/bike_card.dart';

class LoadedBikesView extends StatelessWidget {
  final AllAvailableBikesSuccessState state;
  final PageController pageViewController;
  final Function(int) onPageChanged;

  const LoadedBikesView({
    Key? key,
    required this.state,
    required this.pageViewController,
    required this.onPageChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.42.sh,
      child: BlocBuilder<AvailablePageViewChangedCubit,
          AvailablePageViewChangedState>(
        builder: (context, pageState) {
          return PageView.builder(
            scrollDirection: Axis.horizontal,
            controller: pageViewController,
            physics: const BouncingScrollPhysics(),
            itemCount: state.bikes.length,
            onPageChanged: onPageChanged,
            itemBuilder: (context, index) {
              final bike = state.bikes[index];

              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.productViewRoute,
                    arguments: bike
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BikeCard(bike: bike),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
