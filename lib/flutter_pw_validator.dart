library flutter_pw_validator;

import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/Utilities/ConditionsHelper.dart';
import 'package:flutter_pw_validator/Utilities/Validator.dart';
import 'Components/ValidationTextWidget.dart';
import 'Resource/MyColors.dart';
import 'Resource/Strings.dart';
import 'Utilities/SizeConfig.dart';

class FlutterPwValidator extends StatefulWidget {
  final int minLength,
      number,
      capitalLetters,
      smallLetters,
      specialCharCount;
  final Color defaultColor, successColor, failureColor;
  final double width, height;
  final Function onSuccess;
  final Function? onFail;
  final TextEditingController controller;
  final FlutterPwValidatorStrings? strings;

  FlutterPwValidator(
      {required this.width,
      required this.height,
      required this.minLength,
      required this.onSuccess,
      required this.controller,
      this.capitalLetters = 0,
      this.smallLetters = 0,
      this.specialCharCount = 0,
      this.number = 0,
      this.defaultColor = MyColors.grey,
      this.successColor = MyColors.green,
      this.failureColor = MyColors.error,
      this.strings,
      this.onFail,}) {
    //Initial entered size for global use
    SizeConfig.width = width;
    SizeConfig.height = height;
  }

  @override
  State<StatefulWidget> createState() => _FlutterPwValidatorState();

  FlutterPwValidatorStrings get translatedStrings =>
      strings ?? FlutterPwValidatorStrings();
}

class _FlutterPwValidatorState extends State<FlutterPwValidator> {


  /// Estimate that this the first run or not
  late bool isFirstRun;

  /// Variables that hold current condition states
  dynamic hasMinLength,
      hasMinLowercaseChar,
      hasMinUppercaseChar,
      hasMinNumericChar,
      hasMinSpecialChar;

  //Initial instances of ConditionHelper and Validator class
  late final ConditionsHelper conditionsHelper;
  Validator validator = Validator();

  /// Get called each time that user entered a character in EditText
  void validate() {
    /// For each condition we called validators and get their new state
    hasMinLength = conditionsHelper.checkCondition(
        widget.minLength,
        validator.hasMinLength,
        widget.controller,
        widget.translatedStrings.minLength,
        hasMinLength);

    hasMinLowercaseChar = conditionsHelper.checkCondition(
        widget.smallLetters,
        validator.hasMinLowercase,
        widget.controller,
        widget.translatedStrings.smallLetters,
        hasMinLowercaseChar);

    hasMinUppercaseChar = conditionsHelper.checkCondition(
        widget.capitalLetters,
        validator.hasMinUppercase,
        widget.controller,
        widget.translatedStrings.capitalLetters,
        hasMinUppercaseChar);

    hasMinNumericChar = conditionsHelper.checkCondition(
        widget.number,
        validator.hasMinNumericChar,
        widget.controller,
        widget.translatedStrings.number,
        hasMinNumericChar);

    hasMinSpecialChar = conditionsHelper.checkCondition(
        widget.specialCharCount,
        validator.hasMinSpecialChar,
        widget.controller,
        widget.translatedStrings.specialCharacters,
        hasMinSpecialChar);

    /// Checks if all condition are true then call the onSuccess and if not, calls onFail method
    int conditionsCount = conditionsHelper.getter()!.length;
    int trueCondition = 0;
    for (bool value in conditionsHelper.getter()!.values) {
      if (value == true) trueCondition += 1;
    }
    if (conditionsCount == trueCondition) {
      widget.onSuccess();
      widget.successColor.green;
    } else if (widget.onFail != null) {

      widget.onFail!();
      widget.failureColor.red;
    }

    //To prevent from calling the setState() after dispose()
    if (!mounted) return;

    //Rebuild the UI
    setState(() => null);
    trueCondition = 0;
  }

  @override
  void initState() {
    super.initState();
    isFirstRun = true;

    conditionsHelper = ConditionsHelper(widget.translatedStrings);


    /// Sets user entered value for each condition
    conditionsHelper.setSelectedCondition(
        widget.minLength,
        widget.number,
        widget.capitalLetters,
        widget.smallLetters,
        widget.specialCharCount);

    /// Adds a listener callback on TextField to run after input get changed
    widget.controller.addListener(() {
      isFirstRun = false;
      validate();
    });
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.width,
      height: SizeConfig.height,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
          //Iterate through the condition map entries and generate new ValidationTextWidget for each item in Green or Red Color
          children: conditionsHelper.getter()!.entries.map((entry) {
            int? value;
            if (entry.key == widget.translatedStrings.minLength) {
              value = widget.minLength;
            }
            if (entry.key == widget.translatedStrings.capitalLetters) {
              value = widget.number;
            }
            if (entry.key == widget.translatedStrings.smallLetters) {
              value = widget.capitalLetters;
            }
            if (entry.key == widget.translatedStrings.number) {
              value = widget.smallLetters;
            }
            if (entry.key == widget.translatedStrings.specialCharacters) {
              value = widget.specialCharCount;
            }
            return ValidationTextWidget(
              color: isFirstRun
                  ? widget.defaultColor
                  : entry.value
                      ? widget.successColor
                      : widget.failureColor,
              text: entry.key,
              value: value,
            );
          }).toList()),
    );
  }
}
