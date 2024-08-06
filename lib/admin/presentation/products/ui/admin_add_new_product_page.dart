import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trikecraft/admin/logic/admin_product/admin_product_cubit.dart';
import 'package:trikecraft/models/bike_model.dart';
import 'package:uuid/uuid.dart'; // Make sure to update the path as needed

class AdminAddNewProductPage extends StatefulWidget {
  const AdminAddNewProductPage({super.key});

  @override
  _AdminAddNewProductPageState createState() => _AdminAddNewProductPageState();
}

class _AdminAddNewProductPageState extends State<AdminAddNewProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();
  File? _image;
  final _tyreSizeController = TextEditingController();
  final _engineCcController = TextEditingController();
  final _colorController = TextEditingController();
  final _seatsController = TextEditingController();
  final _brakeController = TextEditingController();
  final _transmissionController = TextEditingController();
  final _kickController = TextEditingController();
  final _priceController = TextEditingController();
  final _extraDetailController = TextEditingController();
  final _modelController = TextEditingController();
  final _gearController = TextEditingController();
  final _companyController = TextEditingController();
  bool _roof = false;
  bool _available = false;
  bool _selfStart = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Product'),
      ),
      body: BlocConsumer<AdminProductCubit, AdminProductState>(
        listener: (context, state) {
          if (state is AdminNewProductSuccessfullyAddedState) {
            Fluttertoast.showToast(
                msg: "New Product is Added", backgroundColor: Colors.green);

            Navigator.pop(context);
          }

          if (state is AdminProductFailureState) {
            Fluttertoast.showToast(
                msg: state.errorMessage, backgroundColor: Colors.red);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        color: Colors.grey[300],
                        child: _image == null
                            ? const Center(child: Text('Tap to pick an image'))
                            : Image.file(_image!),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _tyreSizeController,
                      decoration: const InputDecoration(labelText: 'Tyre Size'),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter the tyre size'
                          : null,
                    ),
                    TextFormField(
                      controller: _engineCcController,
                      decoration: const InputDecoration(labelText: 'Engine CC'),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter the engine CC'
                          : null,
                    ),
                    SwitchListTile(
                      title: const Text('Roof'),
                      value: _roof,
                      onChanged: (value) => setState(() => _roof = value),
                    ),
                    TextFormField(
                      controller: _colorController,
                      decoration: const InputDecoration(labelText: 'Color'),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter the color'
                          : null,
                    ),
                    TextFormField(
                      controller: _seatsController,
                      decoration: const InputDecoration(labelText: 'Seats'),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter the number of seats'
                          : null,
                    ),
                    TextFormField(
                      controller: _brakeController,
                      decoration: const InputDecoration(labelText: 'Brake'),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter the brake type'
                          : null,
                    ),
                    TextFormField(
                      controller: _transmissionController,
                      decoration:
                          const InputDecoration(labelText: 'Transmission'),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter the transmission type'
                          : null,
                    ),
                    TextFormField(
                      controller: _kickController,
                      decoration: const InputDecoration(labelText: 'Kick'),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter the kick type'
                          : null,
                    ),
                    TextFormField(
                      controller: _priceController,
                      decoration: const InputDecoration(labelText: 'Price'),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter the price'
                          : null,
                    ),
                    TextFormField(
                      controller: _extraDetailController,
                      decoration:
                          const InputDecoration(labelText: 'Extra Detail'),
                    ),
                    TextFormField(
                      controller: _modelController,
                      decoration: const InputDecoration(labelText: 'Model'),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter the model'
                          : null,
                    ),
                    SwitchListTile(
                      title: const Text('Self Start'),
                      value: _selfStart,
                      onChanged: (value) => setState(() => _selfStart = value),
                    ),
                    TextFormField(
                      controller: _gearController,
                      decoration: const InputDecoration(labelText: 'Gear'),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter the gear type'
                          : null,
                    ),
                    TextFormField(
                      controller: _companyController,
                      decoration: const InputDecoration(labelText: 'Company'),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter the company'
                          : null,
                    ),
                    SwitchListTile(
                      title: const Text('Available'),
                      value: _available,
                      onChanged: (value) => setState(() => _available = value),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: state is AdminProductLoadingState
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : const Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  ///-----------------   Methods -------------------///

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Uuid uuid = Uuid();
      final String bikeId = uuid.v4();

      if (_image != null) {
        // Create a new BikeModel instance
        final newBike = BikeModel(
          tyreSize: _tyreSizeController.text.trim(),
          engineCc: _engineCcController.text.trim(),
          roof: _roof,
          color: _colorController.text.trim(),
          bikeId: bikeId, // You can generate or assign an ID here
          available: _available,
          picture: "",
          seats: _seatsController.text.trim(),
          brake: _brakeController.text.trim(),
          transmission: _transmissionController.text.trim(),
          kick: _kickController.text.trim(),
          price: _priceController.text.trim(),
          extraDetail: _extraDetailController.text.trim(),
          model: _modelController.text.trim(),
          selfStart: _selfStart,
          gear: _gearController.text.trim(),
          company: _companyController.text.trim(),
        );

        context
            .read<AdminProductCubit>()
            .addNewProduct(bikeModel: newBike, image: _image!);
        context.read<AdminProductCubit>().getProductsList();
      } else {
        Fluttertoast.showToast(
            msg: "Please pick image from gallery", backgroundColor: Colors.red);
      }
    }
  }
}
