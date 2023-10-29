import 'package:ace_flash/features/auth/controller/auth_controller.dart';
import 'package:ace_flash/features/flash/views/create_flash_view.dart';
import 'package:ace_flash/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SideDrawer extends ConsumerWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final currentUser = ref.watch(currentUserDetailsProvider).value;

    // if (currentUser == null) {
    //   return const Loader();
    // }

    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            const SizedBox(height: 50),
            ListTile(
              leading: const Icon(
                Icons.flash_on,
                size: 30,
                color: Pallete.blueColor,
              ),
              title: const Text(
                'My FlashCards',
                style: TextStyle(fontSize: 22, color: Pallete.whiteColor),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  CreateFlashScreen.route(0),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                size: 30,
                color: Pallete.blueColor,
              ),
              title: const Text(
                'Log Out',
                style: TextStyle(fontSize: 22, color: Pallete.whiteColor),
              ),
              onTap: () {
                ref.read(authControllerProvider.notifier).logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
