import 'package:get_it/get_it.dart';
import 'package:trikecraft/data/providers/firebase_auth_providers.dart';
import 'package:trikecraft/data/providers/firestore_provider.dart';
import 'package:trikecraft/data/repository/auth_repository.dart';
import 'package:trikecraft/data/repository/bikes_data_repository.dart';
import 'package:trikecraft/data/repository/firestore_repository.dart';
import 'package:trikecraft/logic/auth/auth_bloc.dart';
import 'package:trikecraft/logic/current_user/current_user_bloc.dart';

final GetIt getIt = GetIt.instance;

void getItSetup() {
  //Register data provider
  getIt.registerLazySingleton<FirebaseAuthProviders>(
    () => FirebaseAuthProviders(),
  );

  //Register firestore provider
  getIt.registerLazySingleton<FirestoreProvider>(
    () => FirestoreProvider(),
  );

  //Register data repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(firebaseAuthProviders: getIt<FirebaseAuthProviders>()),
  );

  //Register data repository
  getIt.registerLazySingleton<FirestoreRepository>(
    () => FirestoreRepository(firestoreProvider: getIt<FirestoreProvider>()),
  );

  //Register auth bloc
  getIt.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
        authRepository: getIt<AuthRepository>(),
        firestoreRepository: getIt<FirestoreRepository>()),
  );


   //Register Current User bloc
  getIt.registerLazySingleton<CurrentUserBloc>(
    () => CurrentUserBloc(
        firestoreRepository: getIt<FirestoreRepository>()),
  );

  getIt.registerLazySingleton<BikesDataRepository>(() => BikesDataRepository());

}
