import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/features/auth/model/create_custom_interest_req_param.dart';
import '../../../../core/common/controller/select_interest_controller.dart';
import '../../../../core/common/enum/interest_color.dart';

void showCreateCustomInterest(
  BuildContext context,
  InterestSelectionController controller,
) {
  final TextEditingController nameCtl = TextEditingController();
  List<InterestColor> interestColors = InterestColor.values;
  InterestColor _selectedColor = InterestColor.red;

  showDialog(
    context: context,
    builder: (_) => StatefulBuilder(
      builder: (context, setLocal) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
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
              // Obx(
              //   () => controller.error.value.isNotEmpty
              //       ? Text(
              //           controller.error.value,
              //           style: const TextStyle(color: Colors.red),
              //         )
              //       : const SizedBox.shrink(),
              // ),
              Wrap(
                children: interestColors.map(
                  (e) {
                    return SizedBox(
                      height: 50,
                      width: 50,
                      child: GestureDetector(
                        onTap: () {
                          setLocal(() {
                            _selectedColor = e;
                          });
                        },
                        child: Container(
                          
                          margin: const EdgeInsets.all(4),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: e.deepColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: e == _selectedColor ? const Icon(Icons.check, color: Colors.white,) : const Icon(Icons.check, color: Colors.transparent,)
                        ),
                      ),
                    );
                  }
                ).toList(),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 44,
                child: ElevatedButton(
                  onPressed: () {
                    controller.addCustomInterest(
                          CreateCustomInterestReqParam(name: nameCtl.text, color: _selectedColor),
                        );
                        Navigator.pop(context);
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
    ),
  );
}
