import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/theme/app_gap.dart';

class InterestPickerSheet extends StatefulWidget {
  const InterestPickerSheet({super.key, 
    required this.initialSelection,
    required this.brandGradient,
  });

  final Set<String> initialSelection;
  final Gradient brandGradient;

  @override
  State<InterestPickerSheet> createState() => InterestPickerSheetState();
}

class InterestPickerSheetState extends State<InterestPickerSheet> {
  static const int kMax = 15;

  final TextEditingController _search = TextEditingController();
  late final Set<String> _selected = {...widget.initialSelection};

  // Mutable example data — replace with your backend data as needed.
  final Map<String, List<String>> _groups = {
    'Adventure': [
      'BASE Jumping',
      'Bungee Jumping',
      'Cultural Immersion',
      'Expedition Travel',
    ],
    'Creative Arts': [
      'Acting/Theater',
      'Animation',
      'Art',
      'Calligraphy/Lettering',
      'Ceramics/Pottery',
    ],
    'Entertainment': [
      'Arcade Gaming',
      'Board Games',
      'Concerts',
      'Escape Rooms',
      'Karaoke',
    ],
  };

  void _toggle(String item) {
    setState(() {
      if (_selected.contains(item)) {
        _selected.remove(item);
      } else if (_selected.length < kMax) {
        _selected.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DraggableScrollableSheet(
      initialChildSize: 0.92,
      minChildSize: 0.6,
      maxChildSize: 0.98,
      builder: (context, scrollCtrl) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                blurRadius: 24,
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, -8),
              ),
            ],
          ),
          child: Column(
            children: [
              const SizedBox(height: 8),
              Container(
                width: 46,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color(0xFFE6E6E9),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(height: 12),

              // Header + Search + Custom link
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select Your Interests",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Select interests to help find compatible people nearby. Choose up to 15.",
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.black54,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _search,
                      onChanged: (_) => setState(() {}),
                      decoration: InputDecoration(
                        hintText: "Search interests",
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFE6E6E9),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFE6E6E9),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFBAC0FF),
                          ),
                        ),
                        prefixIcon: const Icon(Icons.search),
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: showCreateCustomInterest,
                      child: Text(
                        "Create Custom Interests",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF4C5CFF),
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // Interest list
              Expanded(
                child: ListView.builder(
                  controller: scrollCtrl,
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                  itemCount: _groups.length,
                  itemBuilder: (_, idx) {
                    final group = _groups.keys.elementAt(idx);
                    final items = _groups[group]!;
                    final query = _search.text.trim().toLowerCase();
                    final visibles = items
                        .where(
                          (e) =>
                              query.isEmpty || e.toLowerCase().contains(query),
                        )
                        .toList();
                    if (visibles.isEmpty) return const SizedBox.shrink();

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          Text(
                            group,
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: Colors.black54,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 6),
                          ...visibles.map((it) {
                            final selected = _selected.contains(it);
                            return InkWell(
                              onTap: () => _toggle(it),
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 0,
                                ),
                                decoration: BoxDecoration(
                                  color: selected
                                      ? const Color(0xFFF5F6FF)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: selected
                                        ? const Color(0xFFBAC0FF)
                                        : const Color(0xFFE6E6E9),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: selected,
                                      onChanged: (_) => _toggle(it),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(child: Text(it)),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Bottom bar (sticky)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: Color(0xFFE6E6E9))),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Selected: ${_selected.length}/$kMax",
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(width: 8),
                        if (_selected.isEmpty)
                          const Text(
                            "Please select at least 1",
                            style: TextStyle(color: Colors.red),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _selected.isEmpty
                            ? null
                            : () => Navigator.pop(context, _selected),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4C5CFF),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Text(
                          "Save interest (${_selected.length}/$kMax)",
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Gap.h40,
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Small dialog to create a custom interest (per Figma)
  void showCreateCustomInterest() {
    showDialog(
      context: context,
      builder: (_) {
        final TextEditingController nameCtl = TextEditingController();
        final TextEditingController descCtl = TextEditingController();
        String? error;

        return StatefulBuilder(
          builder: (context, setLocal) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            content: SizedBox(
              width: 360,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Text(
                        "Create Custom Interest",
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: nameCtl,
                    decoration: const InputDecoration(
                      hintText: "Search interests",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (error != null)
                    Text(error!, style: const TextStyle(color: Colors.red)),
                  TextField(
                    controller: descCtl,
                    minLines: 3,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      hintText: "Brief description (optional, max 100 chars)",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 44,
                    child: ElevatedButton(
                      onPressed: () {
                        final name = nameCtl.text.trim();
                        if (name.length < 3) {
                          setLocal(
                            () => error =
                                "Interest name must be at least 3 characters",
                          );
                          return;
                        }
                        setState(() {
                          final list = _groups['Custom'] ?? <String>[];
                          if (!list.contains(name)) {
                            _groups['Custom'] = [...list, name];
                          }
                          if (_selected.length < kMax) {
                            _selected.add(name);
                          }
                        });
                        Navigator.pop(context); // close dialog
                      },
                      child: const Text(
                        "Create interests",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


class RulesBox extends StatelessWidget {
  const RulesBox({super.key, required this.checks});
  final Map<String, bool> checks;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE6E6E9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: checks.entries.map((e) {
          final text = e.key;
          final valid = e.value;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              children: [
                Icon(
                  valid ? Icons.check_circle : Icons.radio_button_unchecked,
                  size: 16,
                  color: valid ? Colors.green : Colors.black45,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: valid ? Colors.green : Colors.black87,
                      fontWeight: valid ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}