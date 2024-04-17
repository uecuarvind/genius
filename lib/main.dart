import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_bank/Widgets/list_scroll_behavior.dart';
import 'package:genius_bank/app_helper/app_bloc_observer.dart';
import 'package:genius_bank/config/dependency.dart';
import 'package:genius_bank/controllers/app_controller/bloc/app_controller_bloc.dart';
import 'package:genius_bank/controllers/app_controller/bloc/app_controller_state.dart';
import 'package:genius_bank/controllers/share_helper.dart';
import 'package:genius_bank/routes/app_pages.dart';
import 'package:genius_bank/theme/app_theme.dart';
import 'package:genius_bank/utils/app_constant.dart';
import 'package:injectable/injectable.dart';

@injectable
GlobalKey<NavigatorState> navigatorKey = GlobalKey();

BuildContext get appContext => navigatorKey.currentContext!;

AppLocalizations appLanguage([BuildContext? context])=> AppLocalizations.of(context ?? appContext)!;

ThemeData appTheme([BuildContext? context]) => Theme.of(context ?? appContext);

Size appSize([BuildContext? context]) => MediaQuery.of(context ?? appContext).size;

Future goToPage(String routeName,{dynamic arguments}) async => await navigatorKey.currentState!.pushNamed(routeName,arguments: arguments);

Future goAndReplacePage(String routeName,{dynamic arguments}) async => await navigatorKey.currentState!.pushReplacementNamed(routeName,arguments: arguments);

Future goAndRemoveAllPages(String routeName,{dynamic arguments}) async => await navigatorKey.currentState!.pushNamedAndRemoveUntil(routeName, (Route<dynamic> route) => false,arguments: arguments);

void backPage([dynamic result]) => navigatorKey.currentState!.pop(result);

RouteSettings settings(BuildContext context)=> ModalRoute.of(context)!.settings;



class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
    // ..maxConnectionsPerHost = 2
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async{
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await ShareHelper.init();
  await ScreenUtil.ensureScreenSize();
  configureInjection();
  runZonedGuarded(() async {
        Bloc.observer = AppBlocObserver();
        runApp(const MyApp());
      }, (error, stackTrace) async {
        log(error.runtimeType.toString());
        log(error.toString(), stackTrace: stackTrace);
      },
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AppControllerBloc()),
      ],
      child: BlocBuilder<AppControllerBloc, AppControllerState>(
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: AppConstant.defaultScreenSize,
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context , child) {
              return MaterialApp(
                navigatorKey: navigatorKey,
                builder: (context,child) {
                  return ScrollConfiguration(
                    behavior: ListScrollBehavior(),
                    child: child!,
                  );
                },
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.lightTheme,
                routes: AppPages.routes,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: state.supportedLocales,
                localeListResolutionCallback: state.localeResolutionCallBack,
                locale: state.locale,
                title: AppConstant.AppName,
                initialRoute: AppPages.INITIAL,
                themeMode: state.themeMode,
              );
            },
          );
        },
      )
    );
  }

}
bool isBangla([BuildContext? context])=>(context ?? appContext).read<AppControllerBloc>().state.locale.languageCode.toLowerCase() == 'bn';
void dPrint(var data){
  if (kDebugMode) {
    print(data);
  }
}
