import 'package:candlesticks/candlesticks.dart';
import 'package:dollarax/ui/widgets/on_click.dart';
import 'package:dollarax/utils/utils.dart';
import 'package:flutter/material.dart';

class GoldGraphWidget extends StatefulWidget {
  final Function(String interval) onSelectedTime;
  final List<Candle> candles;

  const GoldGraphWidget(
      {super.key, required this.onSelectedTime, required this.candles});

  @override
  State<GoldGraphWidget> createState() => _GoldGraphWidgetState();
}

class _GoldGraphWidgetState extends State<GoldGraphWidget> {
  /*List<String> timeList = [
    'Time',
    '1Min',
    '5Min',
    '30Min',
    '1H',
    '3D',
    '1W',
  ];*/

  List<String> timeList = [
    'Time',
    '1min',
    '5mins',
    '30mins',
    '1day',
    '1week',
  ];
  String selectedTime = '1min';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 10),
          color: Color(0xFF1f2630),
          width: double.infinity,
          height: 34,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: timeList.length,
              itemBuilder: (BuildContext context, int index) {
                return OnClick(
                  onTap: () {
                    if (timeList[index] == 'Time') {
                    } else {
                      selectedTime = timeList[index];
                      setState(() {});
                      widget.onSelectedTime(selectedTime);
                    }
                  },
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    child: Text(timeList[index],
                        style: context.textTheme.bodyMedium?.copyWith(
                            color: selectedTime == timeList[index]
                                ? Colors.white
                                : Colors.grey,
                            fontWeight: FontWeight.w400)),
                  ),
                );
              }),
        ),
        Theme(data: ThemeData.dark(), child: Container(
          height: 300,
          color: Color(0xFF1f2630),
          child: Candlesticks(
            candles: widget.candles,
          ),
        ))
      ],
    );
  }
}
