import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trikecraft/base/assets/app_fonts.dart';
import 'package:trikecraft/base/di/dependency_injection.dart';
import 'package:trikecraft/base/routes/app_routes.dart';
import 'package:trikecraft/data/repository/bikes_data_repository.dart';
import 'package:trikecraft/models/bike_model.dart';

class SearchProductsPage extends StatefulWidget {
  const SearchProductsPage({super.key});

  @override
  State<SearchProductsPage> createState() => _SearchProductsPageState();
}

class _SearchProductsPageState extends State<SearchProductsPage> {
  List<BikeModel> searchList = [];
  List<BikeModel> allBikesList = [];
  bool _loading = true;
  final BikesDataRepository _bikesDataRepository = getIt<BikesDataRepository>();

  @override
  void initState() {
    super.initState();
    getAllBikeDataFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final accentColor = theme.colorScheme.primary;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 0.1.sh,
            actions: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 0.03.sh, left: 8.sp, right: 8.sp),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(CupertinoIcons.back, color: theme.iconTheme.color),
                      ),
                      Expanded(
                        child: TextField(
                          onChanged: _searchBikes,
                          onTapOutside: (p) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          style: TextStyle(
                            fontFamily: AppFonts.poppins,
                          ),
                          decoration: InputDecoration(
                            hintText: "company name, model, engine cc, seats capacity, color etc.",
                            hintStyle: TextStyle(fontSize: 10.sp),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (_loading)
            SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(color: accentColor),
              ),
            )
          else if (searchList.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Text(
                  "No bikes found.",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: AppFonts.poppins,
                  ),
                ),
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final bike = searchList[index];
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.productViewRoute,
                          arguments: bike);
                    },
                    child: Card(
                      margin: EdgeInsets.symmetric(
                          vertical: 8.sp, horizontal: 12.sp),
                      color: isDarkMode ? Colors.grey[850] : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.sp),
                        side: BorderSide(color: accentColor, width: 1.sp),
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.all(10.sp),
                        child: Row(
                          children: [
                            // Bike picture
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.sp),
                              child: Image.network(
                                bike.picture,
                                width: 0.25.sw,
                                height: 0.15.sh,
                                fit: BoxFit.contain,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded /
                                              (loadingProgress.expectedTotalBytes ?? 1)
                                          : null,
                                      color: accentColor,
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(
                                  Icons.error,
                                  color: accentColor,
                                ),
                              ),
                            ),
                            SizedBox(width: 10.sp),
                            // Bike details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Bike company and model
                                  Text(
                                    '${bike.company} ${bike.model}',
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontFamily: AppFonts.poppins,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4.sp),
                                  // Bike price
                                  Text(
                                    'Price: ${bike.price} PKR',
                                    style: TextStyle(
                                      color: accentColor,
                                      fontSize: 16.sp,
                                      fontFamily: AppFonts.poppins,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 4.sp),
                                  // Bike seats
                                  Text(
                                    'Seats: ${bike.seats}',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontFamily: AppFonts.poppins,
                                    ),
                                  ),
                                  SizedBox(height: 4.sp),
                                  // Bike color and engine CC
                                    Text(
                                        'Color: ${bike.color}',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontFamily: AppFonts.poppins,
                                        ),
                                      ),
                                      SizedBox(width: 10.sp),
                                      Text(
                                        'Engine: ${bike.engineCc} CC',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontFamily: AppFonts.poppins,
                                        ),
                                      ),
                                ],
                              ),
                            ),
                            Icon(
                              CupertinoIcons.chevron_forward,
                              color: accentColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                childCount: searchList.length,
              ),
            ),
        ],
      ),
    );
  }

  ///------------------------ M E T H O D S ------------------------------///

  getAllBikeDataFromFirestore() async {
    setState(() {
      _loading = true;
    });
    _bikesDataRepository.getAvailableBikesFromFirestore().then((snap) {
      setState(() {
        allBikesList = snap;
        searchList = allBikesList;
        _loading = false;
      });
    });
  }

  void _searchBikes(String query) {
    final filteredBikes = allBikesList.where((bike) {
      final bikeCompany = bike.company.toLowerCase();
      final bikeEngine = bike.engineCc.toLowerCase();
      final bikeModel = bike.model.toLowerCase();
      final bikePrice = bike.price.toLowerCase();
      final bikeColor = bike.color.toLowerCase();
      final bikeSeats = bike.seats.toLowerCase();

      final input = query.toLowerCase().trim();
      return bikeCompany.contains(input) ||
          bikeEngine.contains(input) ||
          bikeModel.contains(input) ||
          bikePrice.contains(input) ||
          bikeColor.contains(input) ||
          bikeSeats.contains(input);
    }).toList();

    setState(() {
      searchList = filteredBikes;
    });
  }
}
