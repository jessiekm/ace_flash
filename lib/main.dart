import 'package:ace_flash/common/error_page.dart';
import 'package:ace_flash/common/loading_page.dart';
import 'package:ace_flash/features/auth/controller/auth_controller.dart';
import 'package:ace_flash/features/auth/view/signup_view.dart';
import 'package:ace_flash/features/home/view/home_view.dart';
import 'package:ace_flash/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Ace Flash -- AP Computer Science',
      theme: AppTheme.theme,
      home: ref.watch(currentUserAccountProvider).when(
            data: (user) {
              if (user != null) {
                return const HomeView();
              }
              return const SignUpView();
            },
            error: (error, st) => ErrorPage(
              error: error.toString(),
            ),
            loading: () => const LoadingPage(),
          ),
    );
  }
}
