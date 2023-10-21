import 'package:caroby/caroby.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../title_switch.dart';

part 'date_text.dart';
part 'text_field.dart';

class CDatePicker extends StatefulWidget {
  const CDatePicker({
    super.key,
    required this.onDateChange,
    this.initValue,
  });

  final ValueChanged<DateTime?> onDateChange;
  final DateTime? initValue;

  @override
  State<CDatePicker> createState() => _CDatePickerState();
}

class _CDatePickerState extends State<CDatePicker> {
  bool _switch = false;

  String? _reminderError;

  late ValueNotifier<DateTime?> _date;

  @override
  void initState() {
    super.initState();
    if (widget.initValue != null) {
      _date = ValueNotifier(widget.initValue);
      _switch = true;
    } else {
      _date = ValueNotifier(null);
    }
  }

  void _onChange(String value) {
    if (value.length != 10) {
      _date.value = null;
      return;
    }

    List<int> nums = value.split("/").map((e) => e.toInt).toList();

    final date = DateTime(nums[2], nums[1], nums.first);

    if (DateTime.now().isAfter(date)) {
      setState(() {
        _reminderError = "Reminder can't be in past!";
      });
      return;
    }

    _reminderError = null;

    _date.value = date;

    widget.onDateChange.call(date);
  }

  void _onSwitch(bool val) {
    if (!_switch) {
      _date.value = null;
      widget.onDateChange.call(null);
    }
    setState(() {
      _switch = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleSwitch(switchVal: _switch, onSwitch: _onSwitch, title: "Reminder"),
        if (_switch)
          Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: context.colorScheme.primary.withOpacity(0.2),
              borderRadius:
                  BorderRadius.all(Radius.circular(Values.radiusLargeXX)),
            ),
            padding: EdgeInsets.all(
                Values.paddingWidthSmall.toDynamicWidth(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Select Date"),
                context.sizedBox(height: Values.paddingHeightSmallX),
                ValueListenableBuilder(
                  valueListenable: _date,
                  builder: (context, value, _) {
                    String text = "Enter Date";
                    if (value != null) {
                      final f = DateFormat('EEE, d MMM y');
                      text = f.format(value);
                    }
                    return _DateText(
                      text,
                      error: _reminderError,
                    );
                  },
                ),
                const Divider(
                  color: Colors.white,
                ),
                context.sizedBox(height: Values.paddingHeightSmallXX),
                Form(
                  child: _TextField(_onChange),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
