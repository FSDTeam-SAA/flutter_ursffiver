import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/features/auth/model/interest_model.dart';

class SelectInterestTile extends StatefulWidget {
  final InterestModel interest;
  final bool isSelected;
  final VoidCallback onTap;
  const SelectInterestTile({
    super.key,
    required this.interest,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<SelectInterestTile> createState() => _SelectInterestTileState();
}

class _SelectInterestTileState extends State<SelectInterestTile> {

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
          widget.onTap();
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
            ? widget.interest.color.softColor
            : Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            spacing: 8,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.5,
                    color: !isSelected ? Color(0xFFD0D5DD) : widget.interest.color.deepColor
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SizedBox(
                  height: 26,
                  width: 26,
                  child: isSelected ? Icon(
                    Icons.check,
                    color: widget.interest.color.deepColor,
                  ) : Container(
                    
                  ),
                )
              ),
              Text(widget.interest.name),
            ],
          ),
        ),
      ),
    );
  }
}
