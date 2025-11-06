// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [DashBoardScreen]
class DashBoardRoute extends PageRouteInfo<void> {
  const DashBoardRoute({List<PageRouteInfo>? children})
    : super(DashBoardRoute.name, initialChildren: children);

  static const String name = 'DashBoardRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const DashBoardScreen();
    },
  );
}

/// generated route for
/// [JoinedSchemeScreen]
class JoinedSchemeRoute extends PageRouteInfo<JoinedSchemeRouteArgs> {
  JoinedSchemeRoute({
    Key? key,
    required Map<String, dynamic> scheme,
    List<PageRouteInfo>? children,
  }) : super(
         JoinedSchemeRoute.name,
         args: JoinedSchemeRouteArgs(key: key, scheme: scheme),
         initialChildren: children,
       );

  static const String name = 'JoinedSchemeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<JoinedSchemeRouteArgs>();
      return JoinedSchemeScreen(key: args.key, scheme: args.scheme);
    },
  );
}

class JoinedSchemeRouteArgs {
  const JoinedSchemeRouteArgs({this.key, required this.scheme});

  final Key? key;

  final Map<String, dynamic> scheme;

  @override
  String toString() {
    return 'JoinedSchemeRouteArgs{key: $key, scheme: $scheme}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! JoinedSchemeRouteArgs) return false;
    return key == other.key && const MapEquality().equals(scheme, other.scheme);
  }

  @override
  int get hashCode => key.hashCode ^ const MapEquality().hash(scheme);
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginScreen();
    },
  );
}

/// generated route for
/// [PassportKycScreen]
class PassportKycRoute extends PageRouteInfo<void> {
  const PassportKycRoute({List<PageRouteInfo>? children})
    : super(PassportKycRoute.name, initialChildren: children);

  static const String name = 'PassportKycRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PassportKycScreen();
    },
  );
}

/// generated route for
/// [PlaceDetailScreen]
class PlaceDetailRoute extends PageRouteInfo<PlaceDetailRouteArgs> {
  PlaceDetailRoute({
    Key? key,
    required String tag,
    required String imagePath,
    required String place,
    required String quote,
    required String location,
    required Destination datalist,
    List<PageRouteInfo>? children,
  }) : super(
         PlaceDetailRoute.name,
         args: PlaceDetailRouteArgs(
           key: key,
           tag: tag,
           imagePath: imagePath,
           place: place,
           quote: quote,
           location: location,
           datalist: datalist,
         ),
         initialChildren: children,
       );

  static const String name = 'PlaceDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PlaceDetailRouteArgs>();
      return PlaceDetailScreen(
        key: args.key,
        tag: args.tag,
        imagePath: args.imagePath,
        place: args.place,
        quote: args.quote,
        location: args.location,
        datalist: args.datalist,
      );
    },
  );
}

class PlaceDetailRouteArgs {
  const PlaceDetailRouteArgs({
    this.key,
    required this.tag,
    required this.imagePath,
    required this.place,
    required this.quote,
    required this.location,
    required this.datalist,
  });

  final Key? key;

  final String tag;

  final String imagePath;

  final String place;

  final String quote;

  final String location;

  final Destination datalist;

  @override
  String toString() {
    return 'PlaceDetailRouteArgs{key: $key, tag: $tag, imagePath: $imagePath, place: $place, quote: $quote, location: $location, datalist: $datalist}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PlaceDetailRouteArgs) return false;
    return key == other.key &&
        tag == other.tag &&
        imagePath == other.imagePath &&
        place == other.place &&
        quote == other.quote &&
        location == other.location &&
        datalist == other.datalist;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      tag.hashCode ^
      imagePath.hashCode ^
      place.hashCode ^
      quote.hashCode ^
      location.hashCode ^
      datalist.hashCode;
}

/// generated route for
/// [ProfileScreen]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfileScreen();
    },
  );
}

/// generated route for
/// [SignUpScreen]
class SignUpRoute extends PageRouteInfo<void> {
  const SignUpRoute({List<PageRouteInfo>? children})
    : super(SignUpRoute.name, initialChildren: children);

  static const String name = 'SignUpRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SignUpScreen();
    },
  );
}

/// generated route for
/// [SplashScreen1]
class SplashRoute1 extends PageRouteInfo<void> {
  const SplashRoute1({List<PageRouteInfo>? children})
    : super(SplashRoute1.name, initialChildren: children);

  static const String name = 'SplashRoute1';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashScreen1();
    },
  );
}

/// generated route for
/// [SplashScreen2]
class SplashRoute2 extends PageRouteInfo<void> {
  const SplashRoute2({List<PageRouteInfo>? children})
    : super(SplashRoute2.name, initialChildren: children);

  static const String name = 'SplashRoute2';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashScreen2();
    },
  );
}

/// generated route for
/// [SplashScreen3]
class SplashRoute3 extends PageRouteInfo<void> {
  const SplashRoute3({List<PageRouteInfo>? children})
    : super(SplashRoute3.name, initialChildren: children);

  static const String name = 'SplashRoute3';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashScreen3();
    },
  );
}

/// generated route for
/// [SplashScreen4]
class SplashRoute4 extends PageRouteInfo<void> {
  const SplashRoute4({List<PageRouteInfo>? children})
    : super(SplashRoute4.name, initialChildren: children);

  static const String name = 'SplashRoute4';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashScreen4();
    },
  );
}
