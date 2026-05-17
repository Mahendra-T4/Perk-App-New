import 'package:flutter/material.dart';
import 'custom_tf.dart';

class CustomDatePicker extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final void Function(DateTime?)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool enabled;

  const CustomDatePicker({
    Key? key,
    this.labelText,
    this.hintText,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.onChanged,
    this.validator,
    this.controller,
    this.enabled = true,
  }) : super(key: key);

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    if (widget.initialDate != null) {
      _controller.text = _formatDate(widget.initialDate!);
    }
  }

  String _formatDate(DateTime date) {
    return "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.initialDate ?? DateTime.now(),
      firstDate: widget.firstDate ?? DateTime(1900),
      lastDate: widget.lastDate ?? DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
              onPrimary: Colors.white,
              onSurface: Colors.black87,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      _controller.text = _formatDate(picked);
      if (widget.onChanged != null) widget.onChanged!(picked);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: _controller,
      labelText: widget.labelText ?? 'Date',
      hintText: widget.hintText ?? 'yyyy-mm-dd',
      readOnly: true,
      enabled: widget.enabled,
      onTap: _pickDate,
      validator: widget.validator,
      suffixIcon: const Icon(Icons.calendar_today_rounded),
      keyboardType: TextInputType.datetime,
    );
  }
}
