import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '/core/services/controllers/contact_controller.dart';
import '/core/utils/constants/extensions.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key, this.showHeader = true});

  final bool showHeader;

  @override
  Widget build(BuildContext context) {
    late final ContactController controller;
    try {
      controller = Get.find<ContactController>();
    } catch (_) {
      // Fallback to ensure the widget doesn't crash if DI order changes
      controller = Get.put(ContactController(), permanent: true);
    }
    final inputDecoration = InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
      ),
      filled: true,
      fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      isDense: true,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'about_body'.tr,
            style: TextStyle(
              color: context.textDarkColor,
              fontFamily: 'cairo',
              fontSize: 18,
              height: 1.6,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
        const Gap(16),
        Divider(color: context.theme.colorScheme.outlineVariant),
        const Gap(12),
        if (showHeader) ...[
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .primary
                      .withValues(alpha: 0.12),
                  borderRadius: const BorderRadius.all(Radius.circular(999)),
                ),
                child: Text('contact_title'.tr,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontFamily: 'cairo')),
              ),
              const Gap(10),
              Text('contact_head'.tr,
                  style: const TextStyle(
                      fontFamily: 'cairo',
                      fontWeight: FontWeight.w700,
                      fontSize: 18)),
            ],
          ),
          const Gap(12),
        ],
        Card(
          elevation: 0,
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: controller.formKey,
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    SizedBox(
                      width: 260,
                      child: TextFormField(
                        controller: controller.nameController,
                        decoration: inputDecoration.copyWith(
                          labelText: 'contact_name'.tr,
                          prefixIcon: const Icon(Icons.person_outline),
                        ),
                        validator: controller.requiredValidator,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    SizedBox(
                      width: 260,
                      child: TextFormField(
                        controller: controller.emailController,
                        decoration: inputDecoration.copyWith(
                          labelText: 'contact_email'.tr,
                          prefixIcon: const Icon(Icons.email_outlined),
                        ),
                        validator: controller.emailValidator,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    SizedBox(
                      width: 260,
                      child: TextFormField(
                        controller: controller.subjectController,
                        decoration: inputDecoration.copyWith(
                          labelText: 'contact_subject'.tr,
                          prefixIcon: const Icon(Icons.subject_outlined),
                        ),
                        validator: controller.requiredValidator,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    SizedBox(
                      width: 540,
                      child: TextFormField(
                        controller: controller.messageController,
                        minLines: 4,
                        maxLines: 6,
                        decoration: inputDecoration.copyWith(
                          labelText: 'contact_message'.tr,
                          prefixIcon: const Icon(Icons.message_outlined),
                        ),
                        validator: controller.requiredValidator,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.newline,
                      ),
                    ),
                    Obx(() {
                      final isSending = controller.isSending;
                      final isEnabled = controller.isFormValid && !isSending;
                      return _SubmitButton(
                        label: isSending ? 'sending'.tr : 'send'.tr,
                        isLoading: isSending,
                        isEnabled: isEnabled,
                        onPressed: isEnabled ? controller.send : null,
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isEnabled,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool? isEnabled; // if null, fallback to onPressed state

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final enabled = (isEnabled ?? (onPressed != null)) && !isLoading;

    return Opacity(
      opacity: enabled ? 1 : 0.7,
      child: Material(
        color: scheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          onTap: enabled ? onPressed : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Stack(
              alignment: AlignmentDirectional.centerStart,
              children: [
                // الدائرة البيضاء بالسهم
                Container(
                  height: 32,
                  width: 32,
                  margin: const EdgeInsetsDirectional.only(start: 56),
                  decoration: BoxDecoration(
                    color: scheme.surface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.arrow_right_alt_rounded,
                    color: scheme.onSurface,
                    size: 20,
                  ),
                ),
                // جزء النص الداكن
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                  decoration: BoxDecoration(
                    color: scheme.primary,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: scheme.onPrimary.withValues(alpha: 0.2),
                        blurRadius: 5,
                        spreadRadius: 2,
                        offset: const Offset(0, 0),
                      )
                    ],
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: isLoading
                        ? SizedBox(
                            key: const ValueKey('ld'),
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation(
                                  scheme.onTertiaryContainer),
                            ),
                          )
                        : Text(
                            key: const ValueKey('lb'),
                            label,
                            style: TextStyle(
                              fontFamily: 'cairo',
                              color: scheme.onTertiaryContainer,
                              fontWeight: FontWeight.w600,
                            ),
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
}
