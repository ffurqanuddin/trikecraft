import 'package:trikecraft/data/providers/bikes_data_provider.dart';

class BikesDataRepository {
  final BikesDataProvider _bikesDataProvider = BikesDataProvider();

  List<AvailableBikeModel> availableBikeList() {
    return _bikesDataProvider.available;
  }
}
