import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nawel/app/app.dart';
import 'package:nawel/bloc_observer.dart';
import 'package:nawel/domain/models/restaurants_model.dart';
import 'package:nawel/domain/models/service_model.dart';
import 'package:nawel/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  Hive.registerAdapter(ServiceModelAdapter());
  Hive.registerAdapter(RestaurantsModelAdapter());
  await Hive.openBox('settings');
  await Hive.openBox<ServiceModel>('servicesBox');
  await Hive.openBox<RestaurantsModel>('restaurantsBox');
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}
