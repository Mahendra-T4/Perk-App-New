import 'package:flutter/material.dart';
import 'package:perk_app/core/components/appbar.dart';
import 'package:perk_app/core/utils/widget/custom_button.dart';
import 'package:perk_app/core/utils/widget/custom_tf.dart';

class LedgeComplaint extends StatefulWidget {
  const LedgeComplaint({super.key});
  static const String routeName = '/ledge-complaint';

  @override
  State<LedgeComplaint> createState() => _LedgeComplaintState();
}

class _LedgeComplaintState extends State<LedgeComplaint> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'Complaint'),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            CustomTextFormField(
              controller: _subjectController,
              labelText: 'Subject',
              hintText: 'Enter complaint subject',
              suffixIcon: Icon(Icons.subject, color: Colors.redAccent),
            ),
            SizedBox(height: 16),
            CustomTextFormField(
              controller: _descriptionController,
              labelText: 'Description',
              hintText: 'Describe your complaint in detail',
              maxLines: 5,
              suffixIcon: Icon(Icons.description, color: Colors.redAccent),
            ),
            SizedBox(height: 30),
            CustomButton(
              label: 'Submit Complaint',
              onPressed: () {
                // Handle complaint submission logic
                print('Subject: ${_subjectController.text}');
                print('Description: ${_descriptionController.text}');
              },
            ),
          ],
        ),
      ),
    );
  }
}
