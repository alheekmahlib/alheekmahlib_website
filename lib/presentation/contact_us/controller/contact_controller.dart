import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

/// Contact form controller
/// Contract:
/// - Inputs: name, email, subject, message (non-empty, valid email)
/// - Output: success/failure boolean, user feedback via Get.snackbar
/// - Errors: network issues, non-200, invalid response
class ContactController extends GetxController {
  static ContactController get instance =>
      GetInstance().putOrFind(() => ContactController());
  final formKey = GlobalKey<FormState>();

  // Controllers for the fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  final RxBool _isSending = false.obs;
  bool get isSending => _isSending.value;

  // Track form validity reactively to avoid calling validate() during build
  final RxBool _isFormValid = false.obs;
  bool get isFormValid => _isFormValid.value;

  static final _emailRegExp = RegExp(
    r'^[A-Za-z0-9._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$',
  );

  static bool isValidEmail(String? email) {
    if (email == null || email.trim().isEmpty) return false;
    return _emailRegExp.hasMatch(email.trim());
  }

  String? requiredValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'required_field'.tr;
    return null;
  }

  String? emailValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'required_field'.tr;
    if (!isValidEmail(v)) return 'invalid_email'.tr;
    return null;
  }

  void _bindFormListeners() {
    void recompute() => _recomputeValidity();
    nameController.addListener(recompute);
    emailController.addListener(recompute);
    subjectController.addListener(recompute);
    messageController.addListener(recompute);
    _recomputeValidity();
  }

  void _recomputeValidity() {
    final valid = nameController.text.trim().isNotEmpty &&
        isValidEmail(emailController.text) &&
        subjectController.text.trim().isNotEmpty &&
        messageController.text.trim().isNotEmpty;
    _isFormValid.value = valid;
  }

  Future<void> send() async {
    // Validate form
    final currentState = formKey.currentState;
    if (currentState == null) return;
    if (!currentState.validate()) return;

    _isSending.value = true;

    try {
      // Endpoint using FormSubmit AJAX API to avoid opening mail apps
      final uri = Uri.parse('https://formsubmit.co/ajax/haozo89@gmail.com');

      final body = jsonEncode({
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'subject': subjectController.text.trim(),
        'message': messageController.text.trim(),
        '_captcha': 'false',
        '_cc': 'solteam.contact@gmail.com',
      });

      final response = await http
          .post(
            uri,
            headers: const {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: body,
          )
          .timeout(const Duration(seconds: 20));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Consider 2xx as success by default; only treat as error if JSON explicitly says so
        bool ok = true;
        try {
          final Map<String, dynamic> data = jsonDecode(response.body);
          final status = data['status']?.toString().toLowerCase();
          final successVal = data['success'];
          final hasErrorKey = data.containsKey('error');
          // If provider clearly indicates failure
          if (hasErrorKey == true) ok = false;
          if (status == 'error' || status == 'failed' || status == 'failure') {
            ok = false;
          }
          if (successVal is bool && successVal == false) {
            ok = false;
          }
          if (successVal is String && successVal.toLowerCase() == 'false') {
            ok = false;
          }
        } catch (_) {
          // ignore parse errors; assume success
        }

        if (ok) {
          _showSuccess();
          _clearForm();
        } else {
          _showError();
        }
      } else {
        _showError();
      }
    } catch (e) {
      _showError();
    } finally {
      _isSending.value = false;
    }
  }

  void _clearForm() {
    nameController.clear();
    emailController.clear();
    subjectController.clear();
    messageController.clear();
    formKey.currentState?.reset();
    _recomputeValidity();
  }

  void _showSuccess() {
    BotToast.showText(
      text: 'contact_success'.tr,
      align: Alignment.bottomCenter,
      duration: const Duration(seconds: 3),
      contentColor: const Color(0xFF2E7D32), // dark green
      textStyle: const TextStyle(color: Colors.white),
    );
  }

  void _showError() {
    BotToast.showText(
      text: 'contact_error'.tr,
      align: Alignment.bottomCenter,
      duration: const Duration(seconds: 4),
      contentColor: const Color(0xFFC62828), // dark red
      textStyle: const TextStyle(color: Colors.white),
    );
  }

  @override
  void onInit() {
    super.onInit();
    _bindFormListeners();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    subjectController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
