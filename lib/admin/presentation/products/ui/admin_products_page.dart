import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trikecraft/admin/logic/admin_product/admin_product_cubit.dart';
import 'package:trikecraft/base/assets/app_fonts.dart';
import 'package:trikecraft/base/routes/app_routes.dart';
import '../../../../models/bike_model.dart';

class AdminProductsPage extends StatefulWidget {
  @override
  State<AdminProductsPage> createState() => _AdminProductsPageState();
}

class _AdminProductsPageState extends State<AdminProductsPage> {
  @override
  void initState() {
    super.initState();
    context.read<AdminProductCubit>().getProductsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Products'),
        backgroundColor: Colors.black,
      ),
      body: BlocConsumer<AdminProductCubit, AdminProductState>(
        listener: (context, state) {
          if (state is AdminProductFailureState) {
            Fluttertoast.showToast(msg: state.errorMessage);
          }
        },
        builder: (context, state) {
          if (state is AdminProductLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is AdminGetProductSuccessState) {
            final bikes = state.products;

            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.sp),
                  child: Text(
                    "Total Products Available : ${state.products.length}",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: bikes.length,
                    itemBuilder: (context, index) {
                      final bike = bikes[index];
                      return Card(
                        elevation: 8,
                        margin: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ///---- Delete Button
                              Align(
                                alignment: Alignment.topRight,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Delete the Product",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        context
                                            .read<AdminProductCubit>()
                                            .deleteProduct(bike.bikeId);
                                        context
                                            .read<AdminProductCubit>()
                                            .getProductsList();
                                      },
                                      icon: Icon(Icons.delete),
                                    ),
                                  ],
                                ),
                              ),

                              ///----------------------- Image ---------------------///
                              CachedNetworkImage(
                                imageUrl: bike.picture,
                                progressIndicatorBuilder:
                                    (context, url, progress) => Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) => Center(
                                  child: Text(error.toString()),
                                ),
                              ),

                              ///------------------------ Details -----------------------------///
                              Card(
                                elevation: 5, // Adds shadow for a 3D effect
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10.sp,
                                    vertical: 20.sp), // Margin around the card
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      12), // Rounded corners
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30.sp,
                                      vertical:
                                          10.sp), // Padding inside the card
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Model :  ${bike.model}",
                                        style: TextStyle(
                                          fontFamily: AppFonts.poppins,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      buildDetailText(
                                          'Tyre Size: ${bike.tyreSize}'),
                                      buildDetailText(
                                          'Engine CC: ${bike.engineCc}'),
                                      buildDetailText('Color: ${bike.color}'),
                                      buildDetailText('Seats: ${bike.seats}'),
                                      buildDetailText('Brake: ${bike.brake}'),
                                      buildDetailText(
                                          'Transmission: ${bike.transmission}'),
                                      buildDetailText('Kick: ${bike.kick}'),
                                      buildDetailText('Roof: ${bike.roof}'),
                                      buildDetailText(
                                          'Self Start: ${bike.selfStart}'),
                                      buildDetailText('Price: ${bike.price}'),
                                      buildDetailText(
                                          'Extra Detail: ${bike.extraDetail}'),
                                      buildDetailText('Gear: ${bike.gear}'),
                                      buildDetailText(
                                          'Company: ${bike.company}'),
                                      buildDetailText(
                                          'Availability: ${bike.available}'),
                                    ],
                                  ),
                                ),
                              ),
                             

                             Center(child:  ElevatedButton(
                              style: ElevatedButton.styleFrom(fixedSize: Size(0.8.sw, 50)),
                                    onPressed: () =>
                                        _showEditDialog(context, bike),
                                    child: Text('Edit'),
                                  ),)
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return Center(child: Text('No products available.'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.adminAddNewProductRoute);
        },
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  ///------------------ Methods ---------------------///

  //------------------ Dialog -------------------------///
  void _showEditDialog(BuildContext context, BikeModel bike) {
    final TextEditingController tyreSizeController =
        TextEditingController(text: bike.tyreSize);
    final TextEditingController engineCcController =
        TextEditingController(text: bike.engineCc);
    final TextEditingController colorController =
        TextEditingController(text: bike.color);
    final TextEditingController seatsController =
        TextEditingController(text: bike.seats);
    final TextEditingController brakeController =
        TextEditingController(text: bike.brake);
    final TextEditingController transmissionController =
        TextEditingController(text: bike.transmission);
    final TextEditingController kickController =
        TextEditingController(text: bike.kick);
    final TextEditingController priceController =
        TextEditingController(text: bike.price);
    final TextEditingController extraDetailController =
        TextEditingController(text: bike.extraDetail);
    final TextEditingController modelController =
        TextEditingController(text: bike.model);
    final TextEditingController gearController =
        TextEditingController(text: bike.gear);
    final TextEditingController companyController =
        TextEditingController(text: bike.company);

    bool selfStart = bike.selfStart;
    bool roofAvailable = bike.roof;
    bool bikeAvailable = bike.available;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
           builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: Text('Edit Bike'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  _buildTextField('Tyre Size', tyreSizeController),
                  _buildTextField('Engine CC', engineCcController),
                  _buildTextField('Color', colorController),
                  _buildTextField('Seats', seatsController),
                  _buildTextField('Brake', brakeController),
                  _buildTextField('Transmission', transmissionController),
                  _buildTextField('Kick', kickController),
                  _buildTextField('Price', priceController),
                  _buildTextField('Extra Detail', extraDetailController),
                  _buildTextField('Model', modelController),
                  _buildTextField('Gear', gearController),
                  _buildTextField('Company', companyController),
          
           
             ///-------------- All COde is good but switch listtile setstae is not rebuilding ui
          
                  SwitchListTile(
                  
                      title: Text("Roof availability"),
                      value: roofAvailable,
                      onChanged: (bool newValue) {
                        setState(() {
                          roofAvailable = newValue;
                        });
                      }),
                  SwitchListTile(
                      title: Text("Self Start"),
                      value: selfStart,
                     onChanged: (value) => setState(() => selfStart = value)),
                  SwitchListTile(
                      title: Text("Bike availability"),
                      value: bikeAvailable,
                      onChanged: (value) => setState(() => bikeAvailable = value)),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  _updateButtonMethod(context,
                      bike: bike,
                      tyreSize: tyreSizeController.text.trim(),
                      engineCc: engineCcController.text.trim(),
                      color: colorController.text.trim(),
                      seats: seatsController.text.trim(),
                      brake: brakeController.text.trim(),
                      transmission: transmissionController.text.trim(),
                      kick: kickController.text.trim(),
                      price: priceController.text.trim(),
                      extraDetail: extraDetailController.text.trim(),
                      model: modelController.text.trim(),
                      selfStart: selfStart,
                      gear: gearController.text,
                      company: companyController.text.trim(),
                      available: bikeAvailable,
                      roof: roofAvailable);
                },
                child: Text('Update'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
            ],
          );
          }
        );
      },
    );
  }

  Widget buildDetailText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0), // Spacing between lines
      child: Text(
        text,
        style: TextStyle(
          fontFamily: AppFonts.poppins,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}

///------------- Update Button -------------////

void _updateButtonMethod(BuildContext context,
    {required BikeModel bike,
    required String tyreSize,
    required String engineCc,
    required String color,
    required String seats,
    required String brake,
    required transmission,
    required String kick,
    required String price,
    required String extraDetail,
    required String model,
    required bool selfStart,
    required String gear,
    required String company,
    required bool available,
    required bool roof}) {
  final BikeModel bikeModel = BikeModel(
      tyreSize: tyreSize,
      engineCc: engineCc,
      roof: roof,
      color: color,
      bikeId: bike.bikeId,
      available: available,
      picture: bike.picture,
      seats: seats,
      brake: brake,
      transmission: transmission,
      kick: kick,
      price: price,
      extraDetail: extraDetail,
      model: model,
      selfStart: selfStart,
      gear: gear,
      company: company);
  context
      .read<AdminProductCubit>()
      .updateProduct(bikeId: bike.bikeId, bikeModel: bikeModel);

  context.read<AdminProductCubit>().getProductsList();

  Navigator.pop(context);
}

///----------------- TextField--------------------///

Widget _buildTextField(String label, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: TextField(
      onTapOutside: (p) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
    ),
  );
}
