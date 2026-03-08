import 'package:book_store_app_bloc_cubit/core/di/injection.dart';
import 'package:book_store_app_bloc_cubit/ui/auth/controllers/auth_form_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/strings/strings.dart';
import '../../core/themes/colors.dart';
import '../../core/themes/dimens.dart';
import '../../core/themes/theme.dart';
import '../../core/utils/auth_validators.dart';
import '../home/home_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends State<AuthScreen> {
  var _isLogin = true;
  final _formKey = GlobalKey<FormState>();
  var _enteredEmail = '';
  var _enteredPassword = '';

  void _submit(BuildContext context) async {
    var authFormCubit = context.read<AuthFormCubit>();
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    if (_isLogin) {
      await authFormCubit.login(_enteredEmail.trim(), _enteredPassword.trim());
    } else {
      await authFormCubit.signup(_enteredEmail.trim(), _enteredPassword.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    var currentMode = MediaQuery.platformBrightnessOf(context);
    return BlocProvider(
      create: (context) => getIt<AuthFormCubit>(),
      child: BlocConsumer<AuthFormCubit, AuthFormState>(
        listener: (context, state) {
          if (state is AuthFormSuccess) {
            if (state.user.data != null) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            }
          }
          if (state is AuthFormFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: currentMode == Brightness.light
                ? Colors.white
                : Colors.black,
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset('assets/images/stack_books.png'),
                    Card(
                      margin: const EdgeInsets.all(Dimens.padding20),
                      color: currentMode == Brightness.light
                          ? AppColors.bizarreApprox
                          : Colors.black,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.kabulApprox,
                                  ),
                                ),
                                labelText: Strings.emailAddress,
                                labelStyle: AppThemes.regular12.copyWith(
                                  color: AppColors.kabulApprox,
                                ),
                              ),
                              cursorColor: AppColors.kabulApprox,
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                var validationResult =
                                    AuthValidators.validateEmail(value);
                                if (validationResult != null) {
                                  return validationResult;
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _enteredEmail = value!;
                              },
                            ),
                            SizedBox(height: Dimens.padding8),
                            TextFormField(
                              decoration: InputDecoration(
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.kabulApprox,
                                  ),
                                ),
                                labelText: Strings.password,
                                labelStyle: AppThemes.regular12.copyWith(
                                  color: AppColors.kabulApprox,
                                ),
                              ),
                              cursorColor: AppColors.kabulApprox,
                              obscureText: true,
                              validator: (value) {
                                var validationResult =
                                    AuthValidators.validatePassword(value);
                                if (validationResult != null) {
                                  return validationResult;
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _enteredPassword = value!;
                              },
                            ),
                            SizedBox(height: Dimens.padding24),
                            if (state is AuthFormLoading)
                              const CircularProgressIndicator(
                                color: AppColors.chestnutRoseApprox,
                              )
                            else
                              ElevatedButton(
                                onPressed: () {
                                  _submit(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      Dimens.padding10,
                                    ),
                                  ),
                                  backgroundColor: AppColors.chestnutRoseApprox,
                                ),
                                child: Text(
                                  _isLogin ? Strings.login : Strings.signup,
                                  style: AppThemes.bold14.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            if (state is! AuthFormLoading)
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _isLogin = !_isLogin;
                                  });
                                },
                                child: Text(
                                  _isLogin
                                      ? Strings.createAccount
                                      : Strings.haveAccount,
                                  style: AppThemes.regular14.copyWith(
                                    color: AppColors.chestnutRoseApprox,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
