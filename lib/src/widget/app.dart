import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeumorphicApp extends StatelessWidget {
  const NeumorphicApp({
    super.key,
    this.title = '',
    this.color,
    this.initialRoute,
    this.routes = const {},
    this.home,
    this.debugShowCheckedModeBanner = true,
    this.navigatorKey,
    this.navigatorObservers = const [],
    this.onGenerateRoute,
    this.onGenerateTitle,
    this.onGenerateInitialRoutes,
    this.onUnknownRoute,
    this.theme = neumorphicDefaultTheme,
    this.darkTheme = neumorphicDefaultDarkTheme,
    this.locale,
    this.localizationsDelegates,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.themeMode = ThemeMode.system,
    this.materialDarkTheme,
    this.materialTheme,
    this.builder,
    this.localeResolutionCallback,
    this.highContrastTheme,
    this.highContrastDarkTheme,
    this.localeListResolutionCallback,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowMaterialGrid = false,
    this.shortcuts,
    this.actions,
  })  : routeInformationProvider = null,
        routeInformationParser = null,
        routerDelegate = null,
        backButtonDispatcher = null;

  const NeumorphicApp.router({
    super.key,
    required RouterDelegate<Object> this.routerDelegate,
    required RouteInformationParser<Object> this.routeInformationParser,
    this.routeInformationProvider,
    this.backButtonDispatcher,
    this.title = '',
    this.color,
    this.debugShowCheckedModeBanner = true,
    this.onGenerateTitle,
    this.theme = neumorphicDefaultTheme,
    this.darkTheme = neumorphicDefaultDarkTheme,
    this.locale,
    this.localizationsDelegates,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.themeMode = ThemeMode.system,
    this.materialDarkTheme,
    this.materialTheme,
    this.builder,
    this.localeResolutionCallback,
    this.highContrastTheme,
    this.highContrastDarkTheme,
    this.localeListResolutionCallback,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowMaterialGrid = false,
    this.shortcuts,
    this.actions,
  })  : navigatorObservers = null,
        navigatorKey = null,
        onGenerateRoute = null,
        home = null,
        onGenerateInitialRoutes = null,
        onUnknownRoute = null,
        routes = null,
        initialRoute = null;

  final Widget Function(BuildContext, Widget?)? builder;
  final Locale? Function(Locale?, Iterable<Locale>)? localeResolutionCallback;
  final Map<Type, Action<Intent>>? actions;

  /// {@macro flutter.widgets.widgetsApp.backButtonDispatcher}
  final BackButtonDispatcher? backButtonDispatcher;

  final bool checkerboardOffscreenLayers;
  final bool checkerboardRasterCacheImages;
  final Color? color;
  final NeumorphicThemeData darkTheme;
  final bool debugShowCheckedModeBanner;
  final bool debugShowMaterialGrid;
  final ThemeData? highContrastDarkTheme;
  final ThemeData? highContrastTheme;
  final Widget? home;
  final String? initialRoute;
  final Locale? locale;
  final LocaleListResolutionCallback? localeListResolutionCallback;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final ThemeData? materialDarkTheme;
  final ThemeData? materialTheme;
  final GlobalKey<NavigatorState>? navigatorKey;
  final List<NavigatorObserver>? navigatorObservers;
  final InitialRouteListFactory? onGenerateInitialRoutes;
  final RouteFactory? onGenerateRoute;
  final GenerateAppTitle? onGenerateTitle;
  final RouteFactory? onUnknownRoute;

  /// {@macro flutter.widgets.widgetsApp.routeInformationParser}
  final RouteInformationParser<Object>? routeInformationParser;

  /// {@macro flutter.widgets.widgetsApp.routeInformationProvider}
  final RouteInformationProvider? routeInformationProvider;

  /// {@macro flutter.widgets.widgetsApp.routerDelegate}
  final RouterDelegate<Object>? routerDelegate;

  final Map<String, WidgetBuilder>? routes;
  final Map<LogicalKeySet, Intent>? shortcuts;
  final bool showPerformanceOverlay;
  final bool showSemanticsDebugger;
  final Iterable<Locale> supportedLocales;
  final NeumorphicThemeData theme;
  final ThemeMode themeMode;
  final String title;

  bool get _usesRouter => routerDelegate != null;

  ThemeData _getMaterialTheme(NeumorphicThemeData theme) {
    final color = theme.accentColor;

    if (color is MaterialColor) {
      return ThemeData(
        primarySwatch: color,
        textTheme: theme.textTheme,
        iconTheme: theme.iconTheme,
        scaffoldBackgroundColor: theme.baseColor,
      );
    }

    return ThemeData(
      primaryColor: theme.accentColor,
      iconTheme: theme.iconTheme,
      brightness: ThemeData.estimateBrightnessForColor(theme.baseColor),
      textTheme: theme.textTheme,
      scaffoldBackgroundColor: theme.baseColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final materialTheme = this.materialTheme ?? _getMaterialTheme(theme);
    final materialDarkTheme =
        this.materialDarkTheme ?? _getMaterialTheme(darkTheme);
    return NeumorphicTheme(
      theme: theme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      child: Builder(
        builder: (context) => IconTheme(
          data: NeumorphicTheme.currentTheme(context).iconTheme,
          child: _usesRouter
              ? MaterialApp.router(
                  routeInformationParser: routeInformationParser!,
                  routerDelegate: routerDelegate!,
                  routeInformationProvider: routeInformationProvider,
                  backButtonDispatcher: backButtonDispatcher,
                  title: title,
                  color: color,
                  theme: materialTheme,
                  darkTheme: materialDarkTheme,
                  themeMode: themeMode,
                  localizationsDelegates: localizationsDelegates,
                  supportedLocales: supportedLocales,
                  locale: locale,
                  onGenerateTitle: onGenerateTitle,
                  debugShowCheckedModeBanner: debugShowCheckedModeBanner,
                  builder: builder,
                  localeResolutionCallback: localeResolutionCallback,
                  highContrastTheme: highContrastTheme,
                  highContrastDarkTheme: highContrastDarkTheme,
                  localeListResolutionCallback: localeListResolutionCallback,
                  showPerformanceOverlay: showPerformanceOverlay,
                  checkerboardRasterCacheImages: checkerboardRasterCacheImages,
                  checkerboardOffscreenLayers: checkerboardOffscreenLayers,
                  showSemanticsDebugger: showSemanticsDebugger,
                  shortcuts: shortcuts,
                  actions: actions,
                  debugShowMaterialGrid: debugShowMaterialGrid,
                )
              : MaterialApp(
                  title: title,
                  color: color,
                  theme: materialTheme,
                  darkTheme: materialDarkTheme,
                  initialRoute: initialRoute,
                  routes: routes ?? {},
                  themeMode: themeMode,
                  localizationsDelegates: localizationsDelegates,
                  supportedLocales: supportedLocales,
                  locale: locale,
                  home: home,
                  onGenerateRoute: onGenerateRoute,
                  onUnknownRoute: onUnknownRoute,
                  onGenerateTitle: onGenerateTitle,
                  onGenerateInitialRoutes: onGenerateInitialRoutes,
                  navigatorKey: navigatorKey,
                  navigatorObservers:
                      navigatorObservers ?? const <NavigatorObserver>[],
                  debugShowCheckedModeBanner: debugShowCheckedModeBanner,
                  builder: builder,
                  localeResolutionCallback: localeResolutionCallback,
                  highContrastTheme: highContrastTheme,
                  highContrastDarkTheme: highContrastDarkTheme,
                  localeListResolutionCallback: localeListResolutionCallback,
                  showPerformanceOverlay: showPerformanceOverlay,
                  checkerboardRasterCacheImages: checkerboardRasterCacheImages,
                  checkerboardOffscreenLayers: checkerboardOffscreenLayers,
                  showSemanticsDebugger: showSemanticsDebugger,
                  shortcuts: shortcuts,
                  actions: actions,
                  debugShowMaterialGrid: debugShowMaterialGrid,
                ),
        ),
      ),
    );
  }
}
