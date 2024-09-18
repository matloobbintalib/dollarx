import 'package:candlesticks/candlesticks.dart';
import 'package:dollarax/ui/widgets/on_click.dart';
import 'package:dollarax/utils/utils.dart';
import 'package:flutter/material.dart';

class CandleChartWidget extends StatefulWidget {
  final Function(String interval) onSelectedTime;
  final List<Candle> candles;

  const CandleChartWidget(
      {super.key, required this.onSelectedTime, required this.candles});

  @override
  State<CandleChartWidget> createState() => _CandleChartWidgetState();
}

class _CandleChartWidgetState extends State<CandleChartWidget> {
  List<String> timeList = [
    'Time',
    '1s',
    '1m',
    '5m',
    '30m',
    '1h',
    '1d',
    '1w',
    '1M',
  ];
  String selectedTime = '1s';

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
                      // context.read<BtcToUsdtCubit>()
                      //   ..btcToUsdtData(BtcToUsdtInput(
                      //       interval: selectedTime, limit: 200));
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
        /*Container(
          height: 300,
          color: Color(0xFF1f2630),
          child: BlocBuilder<BtcToUsdtCubit, BtcToUsdtState>(
            builder: (context, btcGraphState) {
              if (btcGraphState.btcToUsdtStatus ==
                  BtcToUsdtStatus.loading) {
                return Center(child: LoadingIndicator());
              }
              if (btcGraphState.btcToUsdtStatus ==
                  BtcToUsdtStatus.success) {
                List<CandleData> candles = btcGraphState
                    .btcToUsdtList
                    .map((graph) => CandleData(
                    timestamp: graph.openTime,
                    open: double.parse(graph.openPrice),
                    close: double.parse(graph.closePrice),
                    high: double.parse(graph.highPrice),
                    low: double.parse(graph.lowPrice)))
                    .toList();

                return InteractiveChart(
                  candles: candles,
                );
              }
              return Container();
            },
          ),
        )*/
      ],
    );
  }
}
