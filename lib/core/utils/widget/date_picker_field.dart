import 'package:flutter/material.dart';
import 'package:perk_app/core/theme/color_theme.dart';
import 'package:perk_app/core/utils/widget/text.dart';

class DatePickerField extends StatefulWidget {
  final String hint;
  final Function(DateTime)? onDateChanged;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final TextEditingController? controller;

  const DatePickerField({
    Key? key,

    this.hint = 'Pick a date',
    this.onDateChanged,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.controller,
  }) : super(key: key);

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  late TextEditingController _controller;
  late DateTime _selectedDate;
  late DateTime _firstDate;
  late DateTime _lastDate;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _selectedDate = widget.initialDate ?? DateTime.now();
    _firstDate = widget.firstDate ?? DateTime(2000);
    _lastDate = widget.lastDate ?? DateTime(2100);

    if (_controller.text.isEmpty) {
      _controller.text = _formatDate(_selectedDate);
    } else {
      // Parse existing date if controller has text
      try {
        _selectedDate = DateTime.parse(_controller.text);
      } catch (e) {
        _selectedDate = DateTime.now();
      }
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: _firstDate,
      lastDate: _lastDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: ColorTheme.primaryColor,
              onPrimary: ColorTheme.primaryText,
              surface: ColorTheme.secondarySurface,
              onSurface: ColorTheme.primaryText,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _controller.text = _formatDate(picked);
      });
      widget.onDateChanged?.call(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: ColorTheme.secondarySurface,
          border: Border.all(
            color: ColorTheme.primaryColor.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: TextField(
          controller: _controller,
          enabled: false,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: ColorTheme.primaryText,
          ),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(
              color: ColorTheme.primaryText.withOpacity(0.5),
              fontSize: 15,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: InputBorder.none,
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Icon(
                Icons.calendar_today_outlined,
                color: ColorTheme.primaryColor,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
