import 'package:dollarax/config/config.dart';
import 'package:dollarax/constants/app_colors.dart';
import 'package:dollarax/ui/widgets/on_click.dart';
import 'package:dollarax/ui/widgets/search_field.dart';
import 'package:flutter/material.dart';

class CountryDialog extends StatefulWidget {
  final List<String> countries;
  final Function(String)? onSelect;

  const CountryDialog(
      {super.key, required this.countries, required this.onSelect});

  @override
  State<CountryDialog> createState() => _CountryDialogState();
}

class _CountryDialogState extends State<CountryDialog> {
  List<String> countriesList = [];
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    countriesList = widget.countries;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(20),
      child: Stack(
        children: [
          Align(
              alignment: Alignment.topRight,
              child: IconButton(onPressed: () {
                NavRouter.pop(context);
              }, icon: Icon(Icons.close))),
          Container(
            padding: EdgeInsets.only(top: 30),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                  child: SearchField(
                      controller: controller,
                      label: 'Search country',
                      onChange: (value) {
                        if (value.isNotEmpty) {
                          countriesList = widget.countries
                              .where((item) => item
                                  .toString()
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .toList();
                        } else {
                          countriesList = widget.countries;
                        }
                        setState(() {});
                      },
                      textInputAction: TextInputAction.done),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: countriesList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return OnClick(
                            onTap: () {
                              widget.onSelect!(countriesList[index]);
                              NavRouter.pop(context);
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 4) +
                                  EdgeInsets.symmetric(horizontal: 20),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              decoration: BoxDecoration(
                                  color: AppColors.fieldColor,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Text(countriesList[index]),
                            ),
                          );
                        })),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
