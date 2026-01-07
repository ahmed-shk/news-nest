import 'package:algoocean/core/provider/app_provider.dart';
import 'package:algoocean/ui/category/category_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (_, child) {
        final data = MediaQuery.of(context);

        return MediaQuery(
            data: data.copyWith(textScaler: TextScaler.linear(1)),
            child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'First Method',
          theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme().copyWith(
              bodyMedium: GoogleFonts.poppins(
                color: Colors.white,
              ),
              titleLarge: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              titleMedium:  GoogleFonts.poppins(
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
              titleSmall: GoogleFonts.poppins(
                fontWeight: FontWeight.w200,
                color: Colors.white,
              ),
            ),
          ),
          home: child,
        ));
      },
      child: const CategoryPage(),
    );
  }
}
