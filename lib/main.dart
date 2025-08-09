
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'src/theme.dart';
import 'src/views/shell.dart';
import 'src/views/views.dart'; // <-- adicionada

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: DilettaApp()));
}

class DilettaApp extends ConsumerWidget {
  const DilettaApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = createRouter();
    final mode = ref.watch(themeModeProvider);
    return MaterialApp.router(
      title: 'Diletta Sales HQ',
      theme: buildTheme(ref, isDark: false),
      darkTheme: buildTheme(ref, isDark: true),
      themeMode: mode,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}

GoRouter createRouter() => GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) => Shell(child: child),
      routes: [
        GoRoute(path: '/', builder: (_, __) => const DashboardView()),
        GoRoute(path: '/deals', builder: (_, __) => const DealsView()),
        GoRoute(path: '/assistant', builder: (_, __) => const AssistantView()),
        GoRoute(path: '/settings', builder: (_, __) => const SettingsView()),
      ],
    ),
  ],
);
