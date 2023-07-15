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
final heightprovider = StateProvider((ref) => Random().nextDouble() * 64);
final widthprovider = StateProvider((ref) => Random().nextDouble() * 64);

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
    var margin = ref.watch(marginprovider);
    var borda = ref.watch(borderprovider);
    var colorz = ref.watch(colorprovider);
    var height = ref.watch(heightprovider);
    var width = ref.watch(widthprovider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod morph test'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 70,
            ),
            AnimatedContainer(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  color: colorz,
                  borderRadius: BorderRadius.all(
                    Radius.circular(borda),
                  ),
                ),
                margin: EdgeInsets.all(margin),
                duration: duration),
            const SizedBox(
              height: 70,
            ),
            IconButton(
              onPressed: () {
                ref.read(colorprovider.notifier).update(
                      (state) => Color.fromARGB(
                        Random().nextInt(250),
                        Random().nextInt(250),
                        Random().nextInt(250),
                        Random().nextInt(250),
                      ),
                    );
                ref
                    .read(borderprovider.notifier)
                    .update((state) => borda + Random().nextDouble());
                ref.read(marginprovider.notifier).update(
                      (state) => margin + Random().nextDouble(),
                    );

                ref
                    .read(heightprovider.notifier)
                    .update((state) => height = Random().nextDouble() * 100);
                ref
                    .read(widthprovider.notifier)
                    .update((state) => width = Random().nextDouble() * 100);
              },
              icon: const Icon(Icons.change_circle),
            ),
          ],
        ),
      ),
    );
  }
}
