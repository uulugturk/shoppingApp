import 'package:bitirme_projesi/data/entity/userManager.dart';
import 'package:bitirme_projesi/ui/cubit/homePageCubit.dart';
import 'package:bitirme_projesi/ui/cubit/loginPageCubit.dart';
import 'package:bitirme_projesi/ui/cubit/cartPageCubit.dart';
import 'package:bitirme_projesi/ui/views/homePage.dart';
import 'package:bitirme_projesi/ui/views/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final userManager = UserManager();
  String? userName = await userManager.getUserName();

  runApp(MyApp(
    initialRoute: userName != null ? const HomePage() : const LoginPage(),
  ));
}

class MyApp extends StatelessWidget {
  final Widget initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomePageCubit()),
        BlocProvider(create: (context) => LoginPagecubit()),
        BlocProvider(create: (context) => CartPageCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const LoginPage(),
      ),
    );
  }
}
