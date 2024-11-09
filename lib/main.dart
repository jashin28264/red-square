import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp( 
      home: Padding(
        padding: EdgeInsets.all(32.0),
        child: SquareAnimation(),
      ),
    );
  }
}

class SquareAnimation extends StatefulWidget {
  const SquareAnimation({super.key});

  @override
  State<SquareAnimation> createState() => SquareAnimationState();
}

class SquareAnimationState extends State<SquareAnimation> {
  static const double _squareSize = 50.0;
  double position = 0.0;
  late double maxPosition;
  late double minPosition;
  bool isMoving = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    maxPosition = (screenWidth / 2) - (_squareSize*1.5);
    minPosition = -(screenWidth / 2) + (_squareSize );

    return Column(
      children: [
         SizedBox( 
          width: screenWidth,
          height: 200,
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedPositioned(
                duration: const Duration(seconds: 1),
                left: position + (screenWidth / 2) - (_squareSize),
                onEnd: () {
                  setState(() {
                    isMoving = false;
                  });
                },
                child: Container(
                  width: _squareSize,
                  height: _squareSize,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    border: Border.all(),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: (!isMoving && position > minPosition)
                  ? () {
                      setState(() {
                        isMoving = true;
                        position = minPosition;
                      });
                    }
                  : null,
              child: const Text('To Left'),
            ),
            const SizedBox(width: 18),
            ElevatedButton(
              onPressed: (!isMoving && position < maxPosition)
                  ? () {
                      setState(() {
                        isMoving = true;
                        position = maxPosition;
                      });
                    }
                  : null,
              child: const Text('To Right'),
            ),
          ],
        ),
      ],
    );
  }
}