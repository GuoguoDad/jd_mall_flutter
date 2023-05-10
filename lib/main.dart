import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jd_mall_flutter/redux/app_state.dart';
import 'package:jd_mall_flutter/redux/app_store.dart';
import 'package:jd_mall_flutter/page/home/home_page.dart';

void main() {
  runApp(
    StoreProvider<AppState>(
      store: store,
      child: const MallApp()
    )
  );
}

class MallApp extends StatelessWidget {
  const MallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
      RefreshConfiguration(
        footerTriggerDistance: 15,
        dragSpeedRatio: 0.91,
        headerTriggerDistance: 88,
        headerBuilder: () => const ClassicHeader(),
        footerBuilder: () => const ClassicFooter(),
        enableLoadingWhenNoData: false,
        enableRefreshVibrate: false,
        enableLoadMoreVibrate: false,
        enableBallisticLoad: true,
        shouldFooterFollowWhenNotFull: (state) {
          // If you want load more with noMoreData state ,may be you should return false
          return true;
        },
        child: MaterialApp(
          theme: ThemeData(
            brightness: Brightness.light,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          initialRoute: HomePage.name,
          routes: {
            HomePage.name: (context) => const HomePage()
          },
          home: const HomePage(),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            // this line is important
            RefreshLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('zh'),
          ],
        )
      );
  }
}
