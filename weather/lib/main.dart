import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weather/bloc_components/internet_cubit/internet_cubit.dart';
import 'package:weather/bloc_components/utility/bloc_observer.dart';
import 'package:weather/config/router/app_router.dart';
import 'package:weather/config/themes/app_themes.dart';
import 'package:weather/constants/routing_constants.dart';
import 'package:weather/constants/string_constants.dart';
import 'package:weather/modules/weather_screen/weather_bloc/weather_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  /* BlocObserver: Debug and Observe the Bloc easily */
  Bloc.observer = AppBlocObserver();

  runApp(
    MyApp(connectivity: Connectivity()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.connectivity,
  });

  final Connectivity connectivity;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
          create: (internetCubitContext) => InternetCubit(
            connectivity: connectivity,
          ),
        ),
        BlocProvider<WeatherBloc>(
          create: (weatherBlocContext) => WeatherBloc(),
        ),
      ],
      child: MaterialApp(
        title: StringConstants.appTitle,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        initialRoute: RoutingConstants.launchScreen,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
