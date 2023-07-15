import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final duration = Duration(milliseconds: 400);

void contproviders(WidgetRef ref) {}
final borderprovider = StateProvider<double>((ref) => Random().nextInt(1) * 64);
final colorprovider = StateProvider<Color>(
  (ref) => Color.fromARGB(
    Random().nextInt(250),
    Random().nextInt(250),
    Random().nextInt(250),
    Random().nextInt(250),
  ),
);
final marginprovider = StateProvider((ref) => Random().nextDouble() * 64);

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProviderScope(
        child: mainapp(),
      ),
    ),
  );
}

class mainapp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final margin = ref.watch(marginprovider);
    final borda = ref.watch(borderprovider);
    final colorz = ref.watch(colorprovider);
    return Column(
      children: [
        const SizedBox(
          height: 70,
        ),
        AnimatedContainer(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(borda),
              ),
            ),
            margin: EdgeInsets.all(margin),
            color: colorz,
            duration: duration),
        const SizedBox(
          height: 70,
        ),
        IconButton(
          onPressed: () {
            ref.read(colorprovider.notifier).update((state) => colorz);
            ref.read(borderprovider.notifier).update((state) => borda);
            ref.watch(marginprovider.notifier).update((state) => margin);
          },
          icon: const Icon(Icons.change_circle),
        ),
      ],
    );
  }
}
