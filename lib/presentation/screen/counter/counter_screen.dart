//counter_screen
// + Icons.add

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/presentation/providers/counter_provider.dart';
import 'package:widgets_app/presentation/providers/theme_provider.dart';

//class CounterScreen extends StatelessWidget {
class CounterScreen extends ConsumerWidget  {
  static const name = 'counter_screen';
  const CounterScreen({super.key});

  @override
  // Widget build(BuildContext context) {
  Widget build(BuildContext context, WidgetRef ref) {

    //* Nunca usar el watch dentro de métodos
    final int clickCounter = ref.watch( counterProvider );
    final bool isDarkMode = ref.watch(isDarkModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Screen'),
        actions: [
          IconButton(
            // icon: Icon(Icons.light_mode_outlined),
            icon: Icon(isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined),
            onPressed: (){
              ref.read(isDarkModeProvider.notifier).update((state) => !state);
            }, 
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Valor $clickCounter', style: Theme.of(context).textTheme.titleLarge,)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        //*forma 1
        //ref.read(counterProvider.notifier).update((state) => state + 1);
        //*forma 2
        ref.read(counterProvider.notifier).state++; //devuelve lo que se especifica en el provider, en este caso un int


      }, child: const Icon(Icons.add),),
    );
  }
}