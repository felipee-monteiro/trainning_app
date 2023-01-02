import 'package:flutter/material.dart';
import './controller.dart';

class Counter extends StatelessWidget {
  const Counter({super.key, required this.time, required this.interval});
  final String time;
  final String interval;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: double.infinity,
      width: 230,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircularProgressIndicator(value: 12),
          ValueListenableBuilder(
            valueListenable: clockState.counter,
            builder: (context, value, _) {
              return Text(
                value,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              );
            },
          ),
          SizedBox(
            width: double.infinity,
            child: ValueListenableBuilder(
              valueListenable: clockState.buttonText,
              builder: (context, String value, _) {
                return ElevatedButton(
                    onPressed: value == 'Iniciar'
                        ? () => clockState.clock(
                            int.parse(time), int.parse(interval))
                        : () => clockState.stop(),
                    child: Text(value));
              },
            ),
          ),
        ],
      ),
    );
  }
}
