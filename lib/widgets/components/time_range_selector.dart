import 'package:app/utils/style.dart';
import 'package:flutter/material.dart';

class TimeRangeSelector extends StatefulWidget {
  final Function(String) onRangeChange;

  const TimeRangeSelector({super.key, required this.onRangeChange});

  @override
  State<TimeRangeSelector> createState() => _TimeRangeSelectorState();
}

class _TimeRangeSelectorState extends State<TimeRangeSelector> {
  List<String> timeRanges = ['1D', '1W', '1M', "3M", '1Y', 'Custom'];
  @override
  Widget build(BuildContext context) {
    return SegmentedButton(
      style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color?>(
            (states) {
              if (states.contains(WidgetState.selected)) {
                return AppColors.primaryColor;
              } else {
                return AppColors.secondaryColor;
              }
            },
          ),
          foregroundColor: WidgetStatePropertyAll(AppColors.contentColorYellow),
          overlayColor: WidgetStatePropertyAll(
            AppColors.contentColorYellow.withOpacity(0.1),
          ),
          side: WidgetStatePropertyAll(
            BorderSide(color: AppColors.borderColor, width: 1.5),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          elevation: WidgetStatePropertyAll(2)),
      segments: [
        ButtonSegment(
            value: '1D',
            label: Text(
              '1D',
              style: GlobalStyle.textH1BWhite,
            )),
        ButtonSegment(
            value: '1W',
            label: Text(
              '1W',
              style: GlobalStyle.textH1BWhite,
            )),
        // ButtonSegment(value: '3W', label: Text('3W')),
        ButtonSegment(
            value: '1M',
            label: Text(
              '1M',
              style: GlobalStyle.textH1BWhite,
            )),
        ButtonSegment(
            value: '3M',
            label: Text(
              '3M',
              style: GlobalStyle.textH1BWhite,
            )),
        ButtonSegment(
            value: '1Y',
            label: Text(
              '1Y',
              style: GlobalStyle.textH1BWhite,
            )),
      ],
      selected: {'D1'},
      onSelectionChanged: (Set<String> newSelection) {
        widget.onRangeChange(newSelection.first);
      },
    );
  }
}
