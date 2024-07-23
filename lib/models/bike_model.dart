class BikeModel {
  final String tyreSize;
  final String engineCc;
  final bool roof;
  final String color;
  final String bikeId;
  final bool available;
  final String picture;
  final String seats;
  final String brake;
  final String transmission;
  final String kick;
  final String price;
  final String extraDetail;
  final String model;
  final bool selfStart;
  final String gear;
  final String company; // Optional field, as not all bikes have this

  BikeModel({
    required this.tyreSize,
    required this.engineCc,
    required this.roof,
    required this.color,
    required this.bikeId,
    required this.available,
    required this.picture,
    required this.seats,
    required this.brake,
    required this.transmission,
    required this.kick,
    required this.price,
    required this.extraDetail,
    required this.model,
    required this.selfStart,
    required this.gear,
    required this.company,
  });

  // Factory method to create a BikeModel from Firestore data
  factory BikeModel.fromFirestore(Map<String, dynamic> data) {
    return BikeModel(
      tyreSize: data['tyreSize']??"tyresize",
      engineCc: data['engineCc']??"enginecc",
      roof: data['roof']??"roof",
      color: data['color']??"color",
      bikeId: data['bikeId']??"bikeid",
      available: data['available']??"available",
      picture: data['picture']??"picture",
      seats: data['seats']??"seats",
      brake: data['brake']??"brake",
      transmission: data['transmission']??"transmission",
      kick: data['kick']??"kick",
      price: data['price']??"price",
      extraDetail: data['extraDetail']??"extraDetail",
      model: data['model']??"model",
      selfStart: data['selfStart']??"selfstart",
      gear: data['gear']??"gear",
      company: data['company']??"company", 
    );
  }

  // Method to convert a BikeModel to a map for Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'tyreSize': tyreSize,
      'engineCc': engineCc,
      'roof': roof,
      'color': color,
      'bikeId': bikeId,
      'available': available,
      'picture': picture,
      'seats': seats,
      'brake': brake,
      'transmission': transmission,
      'kick': kick,
      'price': price,
      'extraDetail': extraDetail,
      'model': model,
      'selfStart': selfStart,
      'gear': gear,
      'company': company,
    };
  }
}
