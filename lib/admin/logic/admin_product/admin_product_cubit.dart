import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:trikecraft/admin/data/repository/admin_products_repository.dart';
import 'package:trikecraft/models/bike_model.dart';
import 'package:trikecraft/presentation/home/widgets/error_message.dart';

part 'admin_product_state.dart';

class AdminProductCubit extends Cubit<AdminProductState> {
  final AdminProductsRepository adminProductsRepository;

  AdminProductCubit({required this.adminProductsRepository})
      : super(AdminProductInitialState());

  Future<void> getProductsList() async {
    emit(AdminProductLoadingState());

    try {
      List<BikeModel> productsList =
          await adminProductsRepository.getAllProductsList();

      if (productsList.isNotEmpty) {
        emit(AdminGetProductSuccessState(products: productsList));
      } else {
        emit(AdminProductEmptyState());
      }
    } catch (e) {
      emit(AdminProductFailureState(errorMessage: e.toString()));
    }
  }

  Future<void> addNewProduct(
      {required BikeModel bikeModel, required File image}) async {
    emit(AdminProductLoadingState());

    try {
      final imageDownloadUrl =
          await _uploadImageToFirebaseStorage(bikeModel.bikeId, image);

      final _bikeModel = bikeModel.copyWith(picture: imageDownloadUrl);

      await adminProductsRepository.addNewProduct(bikeModel: _bikeModel);

      emit(AdminNewProductSuccessfullyAddedState());
    } catch (e) {
      emit(AdminProductFailureState(errorMessage: e.toString()));
    }
  }

  Future<void> updateProduct(
      {required String bikeId, required BikeModel bikeModel}) async {
    emit(AdminProductLoadingState());

    try {
      await adminProductsRepository.updateProduct(
          bikeId: bikeId, bikeModel: bikeModel);

      emit(AdminUpdateProductSuccessState());
    } catch (e) {
      emit(AdminProductFailureState(errorMessage: e.toString()));
    }
  }

  Future<void> deleteProduct(String bikeId) async {
    emit(AdminProductLoadingState());
    try {
      await adminProductsRepository.deleteProduct(bikeId: bikeId);
      emit(AdminDeletedProductSuccessState());
    } catch (e) {
      emit(AdminProductFailureState(errorMessage: e.toString()));
    }
  }

//---- Upload Image To Firebase Storage ---------------///
  _uploadImageToFirebaseStorage(String bikeId, File image) async {
    final firebaseStorage = FirebaseStorage.instance;

    // Upload the image to Firebase Storage
    String fileName = 'products/$bikeId.jpg';
    Reference storageReference = FirebaseStorage.instance.ref().child(fileName);

    UploadTask uploadTask = storageReference.putFile(image);
    await uploadTask;

    String downloadURL = await storageReference.getDownloadURL();

    return downloadURL;
  }
}
