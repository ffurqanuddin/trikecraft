import 'package:get_it/get_it.dart';
import 'package:trikecraft/data/providers/bikes_data_provider.dart';
import 'package:trikecraft/data/providers/firebase_auth_providers.dart';
import 'package:trikecraft/data/providers/firestore_orders_provider.dart';
import 'package:trikecraft/data/providers/firestore_user_data_provider.dart';
import 'package:trikecraft/data/repository/auth_repository.dart';
import 'package:trikecraft/data/repository/bikes_data_repository.dart';
import 'package:trikecraft/data/repository/firestore_order_data_repository.dart';
import 'package:trikecraft/data/repository/firestore_user_data_repository.dart';
import 'package:trikecraft/logic/auth/auth_bloc.dart';
import 'package:trikecraft/logic/current_user/current_user_bloc.dart';

final GetIt getIt = GetIt.instance;

void getItSetup() {
  //Register data provider
  getIt.registerLazySingleton<FirebaseAuthProviders>(
    () => FirebaseAuthProviders(),
  );

  //Register firestore provider
  getIt.registerLazySingleton<FirestoreUserDataProvider>(
    () => FirestoreUserDataProvider(),
  );

  //Register data repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(firebaseAuthProviders: getIt<FirebaseAuthProviders>()),
  );

  //Register data repository
  getIt.registerLazySingleton<FirestoreUserDataRepository>(
    () => FirestoreUserDataRepository(
        firestoreProvider: getIt<FirestoreUserDataProvider>()),
  );

  //Register auth bloc
  getIt.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
        authRepository: getIt<AuthRepository>(),
        firestoreRepository: getIt<FirestoreUserDataRepository>()),
  );

  //Register Current User bloc
  getIt.registerLazySingleton<CurrentUserBloc>(
    () => CurrentUserBloc(
        firestoreRepository: getIt<FirestoreUserDataRepository>()),
  );

    getIt.registerLazySingleton<BikesDataProvider>(
    () => BikesDataProvider(),
  );

  getIt.registerLazySingleton<BikesDataRepository>(() => BikesDataRepository(bikesDataProvider: getIt<BikesDataProvider>()));
  getIt.registerLazySingleton<FirestoreOrdersProvider>(
      () => FirestoreOrdersProvider());

  getIt.registerLazySingleton<FirestoreOrdersDataRepository>(() =>
      FirestoreOrdersDataRepository(
          firestoreOrdersProvider: getIt<FirestoreOrdersProvider>()));



}
