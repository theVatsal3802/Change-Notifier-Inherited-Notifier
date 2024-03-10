import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const HomeScreen(),
    );
  }
}

class SliderData extends ChangeNotifier {
  double _value = 0;

  double get value => _value;

  set value(double newValue) {
    if (newValue != value) {
      _value = newValue;
      notifyListeners();
    }
  }
}

final sliderData = SliderData();

class SliderInheritedNotifier extends InheritedNotifier<SliderData> {
  const SliderInheritedNotifier({
    super.key,
    required super.notifier,
    required super.child,
  });

  static double of(BuildContext context) {
    return context
            .dependOnInheritedWidgetOfExactType<SliderInheritedNotifier>()
            ?.notifier
            ?.value ??
        0;
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          textScaler: TextScaler.noScaling,
        ),
      ),
      body: SliderInheritedNotifier(
        notifier: sliderData,
        child: Builder(
          builder: (builderContext) {
            return Column(
              children: [
                Slider.adaptive(
                  value: SliderInheritedNotifier.of(builderContext),
                  onChanged: (value) {
                    sliderData.value = value;
                  },
                ),
                Row(
                  children: [
                    Opacity(
                      opacity: SliderInheritedNotifier.of(builderContext),
                      child: Container(
                        height: MediaQuery.of(context).size.width * 0.5,
                        width: MediaQuery.of(context).size.width * 0.5,
                        color: Colors.green,
                      ),
                    ),
                    Opacity(
                      opacity: SliderInheritedNotifier.of(builderContext),
                      child: Container(
                        height: MediaQuery.of(context).size.width * 0.5,
                        width: MediaQuery.of(context).size.width * 0.5,
                        color: Colors.purple,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
