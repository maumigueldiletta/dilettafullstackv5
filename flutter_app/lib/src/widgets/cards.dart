import 'package:flutter/material.dart';

class KpiCard extends StatelessWidget {
  final String title; final String value; final String? subtitle;
  const KpiCard({super.key, required this.title, required this.value, this.subtitle});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280, height: 120,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white70)),
            const Spacer(),
            Text(value, style: Theme.of(context).textTheme.headlineSmall),
            if (subtitle != null) Text(subtitle!, style: Theme.of(context).textTheme.bodySmall),
          ]),
        ),
      ),
    );
  }
}
