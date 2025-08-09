import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../theme.dart';
import 'views.dart';

class Shell extends StatelessWidget {
  final Widget child;
  const Shell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const _Sidebar(),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: child,
            ),
          )
        ],
      ),
    );
  }
}

class _Sidebar extends ConsumerWidget {
  const _Sidebar({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = [
      ('/','Dashboard', Icons.dashboard_outlined),
      ('/deals','Deals', Icons.handshake_outlined),
      ('/assistant','Assistant', Icons.smart_toy_outlined),
      ('/settings','Configurações', Icons.settings_outlined),
    ];
    final isDark = ref.watch(themeModeProvider) != ThemeMode.light;
    return Container(
      width: 260,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: Colors.white.withOpacity(0.06))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Diletta Sales HQ', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 24),
          ...items.map((e) => _NavItem(path: e.$1, label: e.$2, icon: e.$3)),
          const Spacer(),
          Row(children:[
            Icon(isDark ? Icons.dark_mode : Icons.light_mode, size: 18),
            const SizedBox(width: 8),
            Expanded(child: Text(isDark ? 'Tema escuro' : 'Tema claro', style: Theme.of(context).textTheme.bodySmall)),
            Switch(
              value: isDark,
              onChanged: (v){ ref.read(themeModeProvider.notifier).state = v ? ThemeMode.dark : ThemeMode.light; },
            )
          ]),
          Text('v0.5.2', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white54)),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String path; final String label; final IconData icon;
  const _NavItem({required this.path, required this.label, required this.icon});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: ListTile(
        leading: Icon(icon),
        title: Text(label),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        onTap: () => context.go(path),
      ),
    );
  }
}
