class BikesDataProvider {
  final List<AvailableBikeModel> available = [
    AvailableBikeModel(
      comapanyName: "Yamaha",
      model: "YZF-R1",
      price: 17399.00,
      picture:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfhayBgbwlvhW3IeAlv8OcdCV2EUUcY8FnxA&s",
    ),
    AvailableBikeModel(
      comapanyName: "Honda",
      model: "CBR1000RR-R Fireblade",
      price: 28199.00,
      picture:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjddcJKirv29ujpvDPI0ENXsqtaqoNvKc6KDkcpliZkOuDhY7KiEU_EcVz7vlOr-5UpbI&usqp=CAU",
    ),
    AvailableBikeModel(
      comapanyName: "Ducati",
      model: "Panigale V4",
      price: 28495.00,
      picture:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxh8k91xON4mDI2eAzhwjqhV4i6BZMwooEcQ&s",
    ),
    AvailableBikeModel(
      comapanyName: "Kawasaki",
      model: "Ninja ZX-10R",
      price: 16399.00,
      picture:
          "https://imgd.aeplcdn.com/1280x720/n/cw/ec/155279/ninja-h2-sx-se-right-side-view.png?isig=0",
    ),
    AvailableBikeModel(
      comapanyName: "Suzuki",
      model: "GSX-R1000",
      price: 15799.00,
      picture:
          "https://imgd.aeplcdn.com/664x374/bw/ec/29684/Suzuki-GSXR1000-Side-100079.jpg?v=201711021421&q=80",
    ),
  ];
}

class AvailableBikeModel {
  final String model;
  final double price;
  final String picture;
  final String comapanyName;

  AvailableBikeModel({
    required this.model,
    required this.price,
    required this.picture,
    required this.comapanyName,
  });
}
