import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/animated_entrance.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _emailController;
  late TextEditingController _messageController;
  late TextEditingController _nameController;
  late TextEditingController _subjectController;
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey();
    _emailController = TextEditingController();
    _messageController = TextEditingController();
    _nameController = TextEditingController();
    _subjectController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _messageController.dispose();
    _nameController.dispose();
    _subjectController.dispose();
    super.dispose();
  }

  Future<void> _sendEmail() async {
    if (_isSending) return;
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() {
      _isSending = true;
    });

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final subject = _subjectController.text.trim().isEmpty
        ? 'New Portfolio Contact Message'
        : _subjectController.text.trim();
    final message = _messageController.text.trim();

    final payload = jsonEncode({
      'name': name,
      'email': email,
      'subject': subject,
      'message': message,
    });

    bool success = false;
    String errorMsg = 'Failed to send message. Please try again later.';

    try {
      final response = await html.HttpRequest.request(
        AppStrings.contactApiUrl,
        method: 'POST',
        requestHeaders: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        sendData: payload,
      );
      if (response.status == 200) {
        final body = response.responseText ?? '';
        success = body.contains('"success":true') || body.contains('"success": true');
        if (!success) {
          errorMsg = 'Server error. Please try again.';
        }
      } else if (response.status == 500) {
        errorMsg = 'Email server not configured. Please contact me directly at mdaman5797@gmail.com';
      } else if (response.status == 400) {
        errorMsg = 'Invalid form data. Please check your inputs.';
      }
    } catch (e) {
      errorMsg = 'Unable to connect. Please check your internet connection.';
    }

    if (mounted) {
      if (success) {
        _nameController.clear();
        _emailController.clear();
        _subjectController.clear();
        _messageController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Message sent successfully! I will get back to you soon.'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 4),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMsg),
            backgroundColor: Colors.redAccent,
            duration: const Duration(seconds: 5),
          ),
        );
      }
      setState(() {
        _isSending = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedEntrance(
      delay: const Duration(milliseconds: 150),
      child: Container(
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: AppColors.glassBg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.glassBorder),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Send a Message',
                style: AppStyles.s20.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                enabled: !_isSending,
                style: AppStyles.s14.copyWith(color: AppColors.white),
                validator: (val) {
                  if ((val?.trim().length ?? 0) < 2) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Name *',
                  prefixIcon: Icon(Icons.person_outline, size: 20),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                enabled: !_isSending,
                style: AppStyles.s14.copyWith(color: AppColors.white),
                validator: (val) {
                  if (!RegExp(
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                      .hasMatch(val?.trim() ?? '')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Email *',
                  prefixIcon: Icon(Icons.email_outlined, size: 20),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _subjectController,
                enabled: !_isSending,
                style: AppStyles.s14.copyWith(color: AppColors.white),
                decoration: const InputDecoration(
                  labelText: 'Subject',
                  prefixIcon: Icon(Icons.subject_outlined, size: 20),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _messageController,
                enabled: !_isSending,
                maxLines: 4,
                style: AppStyles.s14.copyWith(color: AppColors.white),
                validator: (val) {
                  if ((val?.trim().length ?? 0) < 5) {
                    return 'Please enter a message';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Message *',
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 24),
              _SubmitButton(
                onPressed: _sendEmail,
                isLoading: _isSending,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SubmitButton extends StatefulWidget {
  const _SubmitButton({required this.onPressed, required this.isLoading});
  final VoidCallback onPressed;
  final bool isLoading;

  @override
  State<_SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<_SubmitButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: widget.isLoading ? SystemMouseCursors.forbidden : SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.isLoading ? null : widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            gradient: AppColors.accentGradient,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              if (_isHovered && !widget.isLoading)
                BoxShadow(
                  color: AppColors.primaryColor.withValues(alpha: 0.5),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.isLoading
                ? const [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.white,
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Sending...',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                      ),
                    ),
                  ]
                : [
                    const Icon(Icons.send_rounded, color: AppColors.white, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      'Send Message',
                      style: AppStyles.s16.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                      ),
                    ),
                  ],
          ),
        ),
      ),
    );
  }
}
