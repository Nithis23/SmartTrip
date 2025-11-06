import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartrip/Common/Toast/commonToast.dart' show ToastHelper;
import 'package:smartrip/Providers/bottomNavigationProvider.dart';
import 'package:smartrip/features/DashBoard/CustomWidgets/bottomNav.dart';
import 'package:smartrip/features/DashBoard/indexes/HomeScreen/CustomWidgets/mainHomeContents.dart';
import 'package:smartrip/features/DashBoard/indexes/HomeScreen/homeMainScreen.dart';
import 'package:smartrip/features/DashBoard/indexes/ExploreScreen/exploreMainScreen.dart';
import 'package:smartrip/features/DashBoard/indexes/SchemesScreen/schemesMainScreen.dart';
import 'package:smartrip/features/DashBoard/indexes/Wishlist/wishListMainScreen.dart';

final scrollControllerProvider = Provider<ScrollController>((ref) {
  final controller = ScrollController();
  ref.onDispose(() => controller.dispose());
  return controller;
});

@RoutePage()
class DashBoardScreen extends ConsumerStatefulWidget {
  const DashBoardScreen({super.key});

  @override
  ConsumerState<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends ConsumerState<DashBoardScreen>
    with WidgetsBindingObserver {
  DateTime? _lastPressedAt;
  final List<Widget> _screens = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _screens.addAll([
      HomeScreen(),
      ExploreScreen(),
      WishListScreen(),
      MySchemeScreen(),
    ]);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(bottomNavProvider);
    var toggle = ref.watch(toggleSearch);
    var toggleAction = ref.read(toggleSearch.notifier);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Stack(
        children: [
          Scaffold(
            key: _scaffoldKey,
            body: SafeArea(
              top: false,
              child: Column(
                children: [
                  Expanded(
                    child: PopScope(
                      canPop: false,
                      onPopInvokedWithResult: (didPop, result) {
                        if (didPop) return;
                        // Check if drawer is open and close it
                        if (toggle) {
                          toggleAction.state = false;
                          return;
                        }
                        if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
                          Navigator.of(context).pop();
                          return;
                        }

                        if (selectedIndex == 0) {
                          final scroll = ref.watch(scrollControllerProvider);
                          if (scroll.offset != 0) {
                            // Scroll after short delay to ensure rebuild is done
                            Future.delayed(Duration(milliseconds: 100), () {
                              if (scroll.hasClients) {
                                scroll.animateTo(
                                  0,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                              }
                            });
                            return;
                          }
                          if (_lastPressedAt == null ||
                              DateTime.now().difference(_lastPressedAt!) >
                                  Duration(seconds: 2)) {
                            _lastPressedAt = DateTime.now();
                            ToastHelper.showToast(
                              context: context,
                              message: 'Press again to exit',
                            );
                          } else {
                            Future.microtask(() {
                              // context.pop();
                              // context.replaceRoute(const LoginRoute());
                            });
                            if (Platform.isAndroid) {
                              SystemNavigator.pop(); // Works for Android
                            } else if (Platform.isIOS) {
                              exit(
                                0,
                              ); // Not recommended for iOS, but technically possible
                            }
                          }
                        } else {
                          ref.read(bottomNavProvider.notifier).state = 0;
                        }
                      },
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          if (scrollInfo.metrics.axis == Axis.vertical) {
                            // print("Scrollllllllllll");
                          }
                          return false;
                        },
                        child: _screens[selectedIndex],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              // padding: EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.grey.shade300, width: 1),
                ),
              ),
              child: BottomNavigationbar(
                currentIndex: selectedIndex,
                onTap: (index) {
                  ref.read(bottomNavProvider.notifier).state = index;
                  if (index == 0) {
                    final scroll = ref.read(scrollControllerProvider);
                    // Scroll after short delay to ensure rebuild is done
                    Future.delayed(Duration(milliseconds: 100), () {
                      if (scroll.hasClients) {
                        scroll.animateTo(
                          0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      }
                    });
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
