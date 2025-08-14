import 'package:flutter/material.dart';

class SchemeEditor extends StatefulWidget {
  final List<String> currentSchemes;
  final Function(List<String>) onSchemesUpdated;
  
  const SchemeEditor({
    super.key,
    required this.currentSchemes,
    required this.onSchemesUpdated,
  });

  @override
  State<SchemeEditor> createState() => _SchemeEditorState();
}

class _SchemeEditorState extends State<SchemeEditor> {
  late List<String> _schemes;
  final _newSchemeController = TextEditingController();
  final List<String> _commonSchemes = [
    'Ayushman Bharat',
    'Aarogyasri',
    'Employee Health Scheme',
    'Central Government Health Scheme',
    'ESIC',
  ];

  @override
  void initState() {
    super.initState();
    _schemes = List.from(widget.currentSchemes);
  }

  void _addScheme(String scheme) {
    if (scheme.trim().isNotEmpty && !_schemes.contains(scheme)) {
      setState(() {
        _schemes.add(scheme);
      });
      widget.onSchemesUpdated(_schemes);
      _newSchemeController.clear();
    }
  }

  void _removeScheme(String scheme) {
    setState(() {
      _schemes.remove(scheme);
    });
    widget.onSchemesUpdated(_schemes);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 8,
          children: _schemes
              .map((scheme) => Chip(
                    label: Text(scheme),
                    onDeleted: () => _removeScheme(scheme),
                  ))
              .toList(),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _newSchemeController,
                decoration: const InputDecoration(
                  labelText: 'Add a scheme',
                  hintText: 'e.g., Aarogyasri',
                ),
                onSubmitted: _addScheme,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _addScheme(_newSchemeController.text),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: _commonSchemes
              .where((scheme) => !_schemes.contains(scheme))
              .map((scheme) => ActionChip(
                    label: Text(scheme),
                    onPressed: () => _addScheme(scheme),
                  ))
              .toList(),
        ),
      ],
    );
  }
}