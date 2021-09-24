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
      padding: EdgeInsets.symmetric(horizontal: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(widget.status),
          ),
          Row(
            children: [
              Expanded(
                child: LinearPercentIndicator(
                  leading: Text(''),
                  animation: true,
                  lineHeight: 18.0,
                  animationDuration: 2000,
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
        ],
      ),
    );
  }
}
