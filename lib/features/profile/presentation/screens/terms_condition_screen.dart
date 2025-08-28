import 'package:flutter/material.dart';

import '../../../../core/theme/text_style.dart';

class TermsConditionScreen extends StatelessWidget {
  const TermsConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Terms & Conditions",
          style: AppText.xlSemiBold_20_600.copyWith(color: Colors.black),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
  child: SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16.0), // Add padding here
      child: Column(
        children: const [
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean non convallis ex, mattis vehicula magna. Proin luctus quis velit eu bibendum. In eget massa vestibulum, feugiat nisl sed, varius diam. Etiam tincidunt rhoncus justo vitae cursus. Pellentesque ac lectus ac felis pharetra dapibus sed sit amet purus. Cras odio erat, sodales ac arcu eget, tincidunt pretium nibh. Phasellus ornare efficitur mi id blandit. ",
          ),
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean non convallis ex, mattis vehicula magna. Proin luctus quis velit eu bibendum. In eget massa vestibulum, feugiat nisl sed, varius diam. Etiam tincidunt rhoncus justo vitae cursus. Pellentesque ac lectus ac felis pharetra dapibus sed sit amet purus. Cras odio erat, sodales ac arcu eget, tincidunt pretium nibh. Phasellus ornare efficitur mi id blandit. ",
          ),
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean non convallis ex, mattis vehicula magna. Proin luctus quis velit eu bibendum. In eget massa vestibulum, feugiat nisl sed, varius diam. Etiam tincidunt rhoncus justo vitae cursus. Pellentesque ac lectus ac felis pharetra dapibus sed sit amet purus. Cras odio erat, sodales ac arcu eget, tincidunt pretium nibh. Phasellus ornare efficitur mi id blandit. ",
          ),
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean non convallis ex, mattis vehicula magna. Proin luctus quis velit eu bibendum. In eget massa vestibulum, feugiat nisl sed, varius diam. Etiam tincidunt rhoncus justo vitae cursus. Pellentesque ac lectus ac felis pharetra dapibus sed sit amet purus. Cras odio erat, sodales ac arcu eget, tincidunt pretium nibh. Phasellus ornare efficitur mi id blandit. ",
          ),
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean non convallis ex, mattis vehicula magna. Proin luctus quis velit eu bibendum. In eget massa vestibulum, feugiat nisl sed, varius diam. Etiam tincidunt rhoncus justo vitae cursus. Pellentesque ac lectus ac felis pharetra dapibus sed sit amet purus. Cras odio erat, sodales ac arcu eget, tincidunt pretium nibh. Phasellus ornare efficitur mi id blandit. ",
          ),
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean non convallis ex, mattis vehicula magna. Proin luctus quis velit eu bibendum. In eget massa vestibulum, feugiat nisl sed, varius diam. Etiam tincidunt rhoncus justo vitae cursus. Pellentesque ac lectus ac felis pharetra dapibus sed sit amet purus. Cras odio erat, sodales ac arcu eget, tincidunt pretium nibh. Phasellus ornare efficitur mi id blandit. ",
          ),
        ],
      ),
    ),
  ),
),

    );
  }
}
