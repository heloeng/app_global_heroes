import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PowerstatsWidget extends StatefulWidget {
  final String status;
  final String valor;
  final Color progressoCor;
  PowerstatsWidget({
    required this.status,
    required this.valor,
    required this.progressoCor,
  });

  @override
  _PowerstatsWidgetState createState() => _PowerstatsWidgetState();
}

class _PowerstatsWidgetState extends State<PowerstatsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
            child: Text(widget.status),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
            child: Row(
              children: [
                Expanded(
                  child: LinearPercentIndicator(
                    animation: true,
                    lineHeight: 20.0,
                    animationDuration: 1000,
                    percent: (double.parse(widget.valor) / 100),
                    center: Text(
                      widget.valor,
                      style: TextStyle(
                          color: double.parse(widget.valor) >= 50
                              ? Colors.black
                              : Colors.white),
                    ),
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    progressColor: widget.progressoCor,
                    backgroundColor: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
