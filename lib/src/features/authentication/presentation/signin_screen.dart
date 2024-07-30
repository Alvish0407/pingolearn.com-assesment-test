import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import '../../../constants/app_sizes.dart';
import '../../../routing/app_router.dart';
import '../../../utils/app_theme.dart';
import 'validations.dart';

class SignInScreen extends StatefulHookWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final passwordVisible = useState(false);
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xffF5F9FD),
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'e-Shop',
          style: context.theme.appBarTheme.titleTextStyle?.copyWith(
            color: context.theme.primaryColor,
          ),
        ),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: Sizes.p16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 200),
              TextFormField(
                controller: emailController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: "Email",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'required';
                  } else if (!value.isValidEmail) {
                    return 'Please enter valid email';
                  }
                  return null;
                },
              ),
              gapH16,
              TextFormField(
                controller: passwordController,
                obscureText: !passwordVisible.value,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  errorMaxLines: 5,
                  hintText: "Password",
                  suffixIcon: switch (passwordVisible.value) {
                    false => IconButton(
                        icon: const Icon(CupertinoIcons.eye_slash_fill),
                        onPressed: () => passwordVisible.value = true,
                      ),
                    _ => IconButton(
                        color: context.colorScheme.primary,
                        icon: const Icon(CupertinoIcons.eye_fill),
                        onPressed: () => passwordVisible.value = false,
                      ),
                  },
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'required';
                  } else if (!value.isPasswordStrong) {
                    return '1. At least 8 characters long.\n2. Contains both uppercase and lowercase letters.\n3. Includes at least one numeric digit.\n4. Has at least one special character (e.g., @, #, \$, etc.).';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(Sizes.p16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FilledButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  context.successSnackBar('Success');
                } else {
                  context.errorSnackBar('Error');
                }
              },
              child: const Text('Login'),
            ),
            gapH12,
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "New here? ",
                    style: context.theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: context.colorScheme.secondary,
                    ),
                  ),
                  TextSpan(
                    text: "Signup",
                    style: context.theme.textTheme.bodyLarge?.copyWith(
                      color: context.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => context.goNamed(AppRoute.signUp.name),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
