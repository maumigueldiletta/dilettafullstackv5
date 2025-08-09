
import 'package:flutter/material.dart';

class BrandLogo extends StatelessWidget {
  const BrandLogo({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(children:[
      Container(width: 36, height: 36, decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(10),
      )),
      const SizedBox(width: 10),
      Text('Diletta Sales HQ', style: Theme.of(context).textTheme.titleLarge),
    ]);
  }
}
