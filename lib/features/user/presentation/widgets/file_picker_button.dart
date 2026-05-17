import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:perk_app/core/theme/color_theme.dart';
import 'package:perk_app/core/utils/widget/text.dart';

class FilePickerButton extends StatefulWidget {
  final String label;
  final String hint;
  final Function(String filePath) onFilePicked;

  final String? pickedFileName;
  final VoidCallback? onClear;
  final bool allowMultiple;

  const FilePickerButton({
    Key? key,
    this.label = 'Upload File',
    this.hint = 'Choose a file',
    required this.onFilePicked,

    this.pickedFileName,
    this.onClear,
    this.allowMultiple = false,
  }) : super(key: key);

  @override
  State<FilePickerButton> createState() => _FilePickerButtonState();
}

class _FilePickerButtonState extends State<FilePickerButton> {
  String? _selectedFileName;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedFileName = widget.pickedFileName;
  }

  String _getFileExtension(String filePath) {
    return filePath.split('.').last.toUpperCase();
  }

  String _getFileName(String filePath) {
    return filePath.split('/').last;
  }

  Future<void> _pickFile() async {
    try {
      setState(() => _isLoading = true);

      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'jpeg', 'jpg', 'png'],
        allowMultiple: widget.allowMultiple,
      );

      if (result != null && result.files.isNotEmpty) {
        final filePath = result.files.first.path;
        if (filePath != null) {
          setState(() {
            _selectedFileName = filePath;
            _isLoading = false;
          });
          widget.onFilePicked(filePath);
        } else {
          setState(() => _isLoading = false);
        }
      } else {
        setState(() => _isLoading = false);
      }
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking file: $e'),
          backgroundColor: Colors.red.shade400,
        ),
      );
    }
  }

  void _clearSelection() {
    setState(() => _selectedFileName = null);
    widget.onClear?.call();
  }

  @override
  Widget build(BuildContext context) {
    final hasFile = _selectedFileName != null;
    final fileName = hasFile ? _getFileName(_selectedFileName!) : widget.hint;
    final fileExtension = hasFile ? _getFileExtension(_selectedFileName!) : '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label.isNotEmpty)
          CustomText(
            widget.label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: ColorTheme.primaryText,
            ),
          ),
        if (widget.label.isNotEmpty) const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: hasFile
                ? ColorTheme.primaryColor.withOpacity(0.1)
                : ColorTheme.primaryText.withOpacity(0.05),
            border: Border.all(
              color: hasFile
                  ? ColorTheme.primaryColor.withOpacity(0.5)
                  : ColorTheme.primaryColor.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                // File Icon
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [
                        ColorTheme.primaryColor.withOpacity(0.2),
                        ColorTheme.primaryColor.withOpacity(0.1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: _isLoading
                        ? SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                ColorTheme.primaryColor,
                              ),
                            ),
                          )
                        : Icon(
                            hasFile ? Icons.check_circle : Icons.cloud_upload,
                            color: hasFile
                                ? ColorTheme.primaryColor
                                : ColorTheme.primaryColor.withOpacity(0.6),
                            size: 24,
                          ),
                  ),
                ),
                const SizedBox(width: 12),

                // File Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        hasFile ? 'File Selected' : 'No File',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: ColorTheme.primaryText.withOpacity(0.6),
                        ),
                      ),
                      const SizedBox(height: 4),
                      CustomText(
                        fileName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: ColorTheme.primaryText,
                        ),
                      ),
                      if (hasFile)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: CustomText(
                            fileExtension,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: ColorTheme.primaryColor.withOpacity(0.7),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // Action Buttons
                if (hasFile)
                  GestureDetector(
                    onTap: _isLoading ? null : _clearSelection,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.red.withOpacity(0.1),
                      ),
                      child: Icon(
                        Icons.close,
                        color: Colors.red.shade400,
                        size: 18,
                      ),
                    ),
                  )
                else
                  GestureDetector(
                    onTap: _isLoading ? null : _pickFile,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                          colors: [
                            ColorTheme.primaryColor,
                            ColorTheme.primaryColor.withOpacity(0.8),
                          ],
                        ),
                      ),
                      child: Icon(
                        Icons.add,
                        color: ColorTheme.primaryText,
                        size: 18,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
