import 'dart:io';

import 'package:flix_id/domain/entities/user.dart';
import 'package:flix_id/presentation/extensions/build_context_extension.dart';
import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flix_id/presentation/pages/movie_page/movie_page.dart';
import 'package:flix_id/presentation/pages/profile_page/profile_page.dart';
import 'package:flix_id/presentation/pages/ticket_page/ticket_page.dart';
import 'package:flix_id/presentation/providers/router/router_provider.dart';
import 'package:flix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:flix_id/presentation/widgets/bottom_nav_bar.dart';
import 'package:flix_id/presentation/widgets/bottom_nav_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPage extends ConsumerStatefulWidget {
  final File? imageFile;

  const MainPage({this.imageFile, Key? key}) : super(key: key);

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  PageController pageController = PageController();
  int selectedPage = 0;

  @override
  void initState() {
    super.initState();

    User? user = ref.read(userDataProvider).valueOrNull;

    if (widget.imageFile != null && user != null) {
      ref
          .read(userDataProvider.notifier)
          .uploadProfilePicture(user: user, imageFile: widget.imageFile!);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      userDataProvider,
      (previous, next) {
        if (previous != null && next is AsyncData && next.value == null) {
          ref.read(routerProvider).goNamed('login');
        } else if (next is AsyncError) {
          context.showSnackBar(next.error.toString());
        }
      },
    );

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (value) => setState(() {
              selectedPage = value;
            }),
            children: const [
              MoviePage(),
              TicketPage(),
              ProfilePage(),
            ],
          ),
          BottomNavBar(
              items: [
                BottomNavBarItem(
                    index: 0,
                    isSelected: selectedPage == 0,
                    title: 'Home',
                    icon: const Icon(
                      Icons.home,
                      color: grey,
                    ),
                    selectedIcon: const Icon(
                      Icons.home,
                      color: blue,
                    )),
                BottomNavBarItem(
                    index: 1,
                    isSelected: selectedPage == 1,
                    title: 'Tickets',
                    icon: const Icon(
                      Icons.local_movies_outlined,
                      color: grey,
                    ),
                    selectedIcon: const Icon(
                      Icons.local_movies_outlined,
                      color: blue,
                    )),
                BottomNavBarItem(
                    index: 2,
                    isSelected: selectedPage == 2,
                    title: 'Profile',
                    icon: const Icon(
                      Icons.person,
                      color: grey,
                    ),
                    selectedIcon: const Icon(
                      Icons.person,
                      color: blue,
                    )),
              ],
              onTap: (index) {
                selectedPage = index;

                pageController.animateToPage(selectedPage,
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.easeInOut);
              },
              selectedIndex: 0)
        ],
      ),
    );
  }
}
