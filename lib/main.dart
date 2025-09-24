import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sci_mobile/source/repository/repositoryAuth.dart';
import 'package:sci_mobile/source/repository/repositoryStockOpname.dart';
import 'package:sci_mobile/source/router/router.dart';
import 'package:sci_mobile/source/service/Auth/cubit/auth_cubit.dart';
import 'package:sci_mobile/source/service/StockOpname/cubit/get_stock_opname_cubit.dart';
import 'package:sci_mobile/source/service/StockOpname/cubit/insert_stock_opname_cubit.dart';

void main() {
  runApp(MyApp(router: RouterNavigation()));
}

class MyApp extends StatelessWidget {
  RouterNavigation? router;
  MyApp({super.key, this.router});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => RepositoryAuth()),
        RepositoryProvider(create: (context) => RepositoryStockOpname()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthCubit(repository: RepositoryAuth())),
          // STOCK OPNAME
          BlocProvider(create: (context) => GetStockOpnameCubit(repository: RepositoryStockOpname())),
          BlocProvider(create: (context) => InsertStockOpnameCubit(repository: RepositoryStockOpname())),
        ],
        child: MaterialApp(
          builder: EasyLoading.init(),
          onGenerateRoute: router!.generateRoute,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: const ColorScheme(
              primary: Color(0XFF10439F), // warna oranye
              secondary: Color(0XFF10439F), // warna biru tua
              surface: Colors.white, // warna putih
              background: Colors.white, // warna putih
              error: Color(0XFFC40C0C), // warna merah untuk kesalahan
              onPrimary: Colors.white, // warna teks pada latar belakang utama
              onSecondary: Color(0XFF10439F), // warna teks pada latar belakang sekunder
              onSurface: Colors.black, // warna teks pada permukaan
              onBackground: Colors.black, // warna teks pada latar belakang
              onError: Colors.red, // warna teks untuk kesalahan
              brightness: Brightness.light, // mode terang
            ),
            useMaterial3: true,
          ),
        ),
      ),
    );
  }
}
