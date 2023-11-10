import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Focus effect',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Scaffold(
          backgroundColor: Colors.black,
          body: Center(child: Focus(text: 'FOCUS'))),
    );
  }
}

class Focus extends StatefulWidget {
  final String text;
  final int? durationInMilliseconds;
  const Focus({super.key, required this.text, this.durationInMilliseconds});

  @override
  State<Focus> createState() => _FocusState();
}

class _FocusState extends State<Focus> {
  int? _selectedIndex;
  late final int _durationInMilliseconds;
  final TextStyle textStyle = const TextStyle(
      fontSize: 180,
      color: Colors.white,
      fontWeight: FontWeight.w500,
      letterSpacing: 40);
  late final ImageFilter filter = ImageFilter.blur(sigmaX: 12, sigmaY: 6);
  @override
  void initState() {
    _durationInMilliseconds = widget.durationInMilliseconds ?? 150;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
          widget.text.length,
          (index) => Stack(
                children: [
                  AnimatedOpacity(
                    opacity: _selectedIndex == index ? 0 : 1,
                    duration: Duration(milliseconds: _durationInMilliseconds),
                    child: Text(
                      widget.text[index],
                      style: textStyle,
                    ),
                  ),
                  ClipRect(
                    child: BackdropFilter(
                      filter: filter,
                      child: MouseRegion(
                        onEnter: (onEnter) =>
                            setState(() => _selectedIndex = index),
                        onHover: (onHover) =>
                            setState(() => _selectedIndex = index),
                        onExit: (onExit) =>
                            setState(() => _selectedIndex = null),
                        child: AnimatedOpacity(
                          duration:
                              Duration(milliseconds: _durationInMilliseconds),
                          opacity: _selectedIndex == index ? 1 : 0,
                          child: AnimatedScale(
                            duration:
                                Duration(milliseconds: _durationInMilliseconds),
                            scale: _selectedIndex == index ? 1.1 : 1,
                            child: Text(
                              widget.text[index],
                              style: textStyle,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
    );
  }
}
