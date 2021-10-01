import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

final Provider<int> valueProvider = Provider<int>(
  (ref) {
    return 36;
  },
);

final StateProvider<int> counterStateProvider = StateProvider<int>((ref) {
  return 0;
});

class MyHomePage extends ConsumerWidget {
  @override
  Widget build(
    BuildContext context,
    ScopedReader watch,
  ) {
    final int value = watch(valueProvider);
    final StateController<int> counter = watch(counterStateProvider);

    return ProviderListener<StateController<int>>(
      provider: counterStateProvider,
      onChange: (context, counterState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Value is ${counterState.state}'),
            duration: Duration(
              milliseconds: 500,
            ),
          ),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Riverpod examples'),
        ),
        body: Center(
          child: Text(
            'ValueCounter: ${counter.state}, \nValue: $value',
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read(counterStateProvider).state++;
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
