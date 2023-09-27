import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart';
import 'package:newsapp/core/data/datasources/local_data_source.dart';
import 'package:newsapp/core/data/datasources/remote_data_source.dart';
import 'package:newsapp/core/remote_name.dart';
import 'package:newsapp/module/home/controller/home_controller_cubit.dart';
import 'package:newsapp/module/home/repository/home_repository.dart';
import 'package:newsapp/module/splash/controller/splash_cubit.dart';
import 'package:newsapp/module/splash/repository/splash_repository.dart';
import 'package:newsapp/utils/my_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';


late final SharedPreferences _sharedPreferences;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  // Hive.registerAdapter(ProductAdapter());
  // Hive.registerAdapter(UpdateProductAdapter());
  // await Hive.openBox<Product>('product');
  // await Hive.openBox<UpdateProduct>('product_update');

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  _sharedPreferences = await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        ///network client
        RepositoryProvider<Client>(
          create: (context) => Client(),
        ),
        RepositoryProvider<SharedPreferences>(
          create: (context) => _sharedPreferences,
        ),

        ///data source repository
        RepositoryProvider<RemoteDataSource>(
          create: (context) => RemoteDataSourceImpl(client: context.read()),
        ),
        RepositoryProvider<LocalDataSource>(
          create: (context) =>
              LocalDataSourceImpl(sharedPreferences: context.read()),
        ),

        ///Main Functionality
        RepositoryProvider<SplashRepository>(
          create: (context) => SplashRepositoryImp(
            remoteDataSource: context.read(),
            localDataSource: context.read(),
          ),
        ),
        RepositoryProvider<HomeRepository>(
          create: (context) => HomeRepositoryImp(
            remoteDataSource: context.read(),
          ),
        ),
      ],

      child: MultiBlocProvider(
        providers: [

          BlocProvider<SplashCubit>(
            create: (BuildContext context) => SplashCubit(context.read()),
          ),
          BlocProvider<HomeControllerCubit>(
            create: (BuildContext context) => HomeControllerCubit(
              context.read(),
              // context.read(),
            ),
          ),
        ],
        child: BlocBuilder<SplashCubit, SplashState> (
            builder: (context, localeState) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: MyTheme.theme,
                onGenerateRoute: RouteNames.generateRoute,
                initialRoute: RouteNames.splashScreen,
                onUnknownRoute: (RouteSettings settings) {
                  return MaterialPageRoute(
                    builder: (_) => Scaffold(
                      body: Center(
                        child: Text('No route defined for ${settings.name}'),
                      ),
                    ),
                  );
                },
                builder: (context, child) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                    child: child!,
                  );
                },
              );
            }
        ),
      ),
    );
  }
}
