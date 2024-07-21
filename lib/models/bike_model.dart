class BikeModel {
  bool available;
  String brake;
  String color;
  String company;
  int engineCc;
  String extraDetail;
  String gear;
  String model;
  List<String> pictures;
  double price;
  bool roof;
  int seats;
  bool selfStart;
  String transmission;
  String tyreSize;

  BikeModel({
    required this.available,
    required this.brake,
    required this.color,
    required this.company,
    required this.engineCc,
    required this.extraDetail,
    required this.gear,
    required this.model,
    required this.pictures,
    required this.price,
    required this.roof,
    required this.seats,
    required this.selfStart,
    required this.transmission,
    required this.tyreSize,
  });

  factory BikeModel.fromFirestore(Map<String, dynamic> doc) {
    return BikeModel(
      available: doc['available'] as bool,
      brake: doc['brake'] as String,
      color: doc['color'] as String,
      company: doc['company'] as String,
      engineCc: doc['engineCc'] as int,
      extraDetail: doc['extraDetail'] as String,
      gear: doc['gear'] as String,
      model: doc['model'] as String,
      pictures: List<String>.from(doc['pictures'] as List),
      price: doc['price'] as double,
      roof: doc['roof'] as bool,
      seats: doc['seats'] as int,
      selfStart: doc['selfStart'] as bool,
      transmission: doc['transmission'] as String,
      tyreSize: doc['tyreSize'] as String,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'available': available,
      'brake': brake,
      'color': color,
      'company': company,
      'engineCc': engineCc,
      'extraDetail': extraDetail,
      'gear': gear,
      'model': model,
      'pictures': pictures,
      'price': price,
      'roof': roof,
      'seats': seats,
      'selfStart': selfStart,
      'transmission': transmission,
      'tyreSize': tyreSize,
    };
  }
}
