
import 'package:flutter/material.dart';
import '../widgets/kpi_loader.dart';
import '../widgets/assistant_panel.dart';
import '../widgets/deals_table.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(24),
      child: KpiLoader(),
    );
  }
}

class DealsView extends StatelessWidget {
  const DealsView({super.key});
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(24),
      child: DealsTable(),
    );
  }
}

class AssistantView extends StatelessWidget {
  const AssistantView({super.key});
  @override
  Widget build(BuildContext context) {
    return const Padding(padding: EdgeInsets.all(24), child: AssistantPanel());
  }
}

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(24),
      child: Text('Settings — v0.5.2'),
    );
  }
}
