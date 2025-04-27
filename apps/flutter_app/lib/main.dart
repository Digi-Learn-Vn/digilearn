import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:seo/seo.dart';
import 'core/routing/routing.dart';

void main() {
  usePathUrlStrategy();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return SeoController(
      enabled: true,
      tree: WidgetTree(context: context),
      child: MaterialApp.router(
        title: 'Digilearn',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerDelegate: AppRoutes.router.routerDelegate,
        routeInformationParser: AppRoutes.router.routeInformationParser,
        routeInformationProvider: AppRoutes.router
            .routeInformationProvider, // Explicitly set the routeInformationProvider
      ),
    );
  }
}
