import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_7/home.dart';
import 'package:practice_7/register/bloc/register_bloc.dart';
import 'package:practice_7/translations/locale_keys.g.dart';
import 'package:practice_7/user.dart';


class RegisterPage extends StatefulWidget {
    final String languageCode;

  const RegisterPage({super.key, required this.languageCode});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //states

  int _lanuage = 0;

  final _formKey = GlobalKey<FormState>();

  String selectedCountry = '';

  bool _hidePass = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  //functions
  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailFocus.dispose();
    _phoneFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  bool _validateEmail(String input) {
    final emailExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailExp.hasMatch(input);
  }

  _validatePassword(String input) {
    if (input.isEmpty) {
      return LocaleKeys.passwordErrorIsEmpty.tr();
    }
    if (input.length <= 8) {
      return LocaleKeys.passwordErrorLenght.tr();
    } else if (_passwordController.text != _confirmPasswordController.text) {
      return LocaleKeys.passwordErrorIsNotEquals.tr();
    }
    return null;
  }

  bool _validatePhoneNumber(String input) {
    final phoneExp = RegExp(r'^\d{11}$');
    print('dada $phoneExp');
    return phoneExp.hasMatch(input);
  }

  void fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    context.setLocale(Locale('${widget.languageCode}'));
  }


  //interface
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(),
      child: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if(state is RegisterSuccess){
            Navigator.push(context, 
              MaterialPageRoute(builder: (context){
                return HomePage(user: NewUser(
                  fullname: 'Жунусова Дана',
                  phone: "87473738747",
                  email: _emailController.text,
                  lifeStory: "аовыфлдоалжвыофлаолвыдожад ыФВЛДАОЛЫВОЖФАОВЛЫФЖОАЛДЖФЫ",
                  country: 'Казахстан',
                ));
              })
            );          
          }
        },
        builder: (context, state) {
          if (state is RegisterLoading) {
            return const Center(
              child: SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  strokeWidth: 4,
                )
              ),
            );
          }
          return Column(
            children: [
              IconButton(
                onPressed: () {
                  if (_lanuage == 0) {
                    context.setLocale(Locale('en'));
                    setState(() {
                      _lanuage = 1;
                    });
                  } else {
                    context.setLocale(Locale('ru'));
                    setState(() {
                      _lanuage = 0;
                    });
                  }
                },
                icon: Icon(Icons.language)
              ),
              Form(
                key: _formKey,
                child: Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    children: [
                      TextFormField(
                        focusNode: _emailFocus,
                        decoration: InputDecoration(
                          labelText: LocaleKeys.email.tr(),
                          hintText: LocaleKeys.emailHint.tr(),
                          prefixIcon: Icon(Icons.email),
                          suffixIcon: IconButton(
                            onPressed: () => setState(() {
                              _emailController.clear();
                            }),
                            icon:
                                Icon(Icons.delete_outline, color: Colors.red),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)),
                            borderSide:
                                BorderSide(color: Colors.black, width: 1),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 1),
                          ),
                          focusedErrorBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)),
                            borderSide:
                                BorderSide(color: Colors.red, width: 1),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)),
                            borderSide:
                                BorderSide(color: Colors.red, width: 1),
                          ),
                        ),
                        controller: _emailController,
                        onFieldSubmitted: (_) {
                          fieldFocusChange(
                              context, _emailFocus, _phoneFocus);
                        },
                        validator: (input) {
                          if (!_validateEmail(input!)) {
                            return LocaleKeys.emailError.tr();
                          }
                          return null;
                        },
                        onChanged: (text) {
                          setState(() {
                            _emailController.text = text;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        focusNode: _phoneFocus,
                        decoration: InputDecoration(
                          labelText: LocaleKeys.phone.tr(),
                          hintText: LocaleKeys.phoneHint.tr(),
                          prefixIcon: Icon(Icons.phone),
                          suffixIcon: IconButton(
                            onPressed: () => setState(() {
                              _phoneController.clear();
                            }),
                            icon: Icon(Icons.delete_outline, color: Colors.red),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Colors.black, width: 1),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Colors.blue, width: 1),
                          ),
                          focusedErrorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Colors.red, width: 1),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Colors.red, width: 1),
                          ),
                        ),
                        controller: _phoneController,
                        onFieldSubmitted: (_) {
                          fieldFocusChange(context, _phoneFocus, _passwordFocus);
                        },
                        validator: (input) {
                          if (!_validatePhoneNumber(input!)) {
                            return LocaleKeys.phoneError.tr();
                          }
                          return null;
                        },
                        keyboardType: TextInputType.phone,
                        inputFormatters:[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onChanged: (text){
                          setState(() {
                            _phoneController.text = text;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        focusNode: _passwordFocus,
                        decoration: InputDecoration(
                          labelText: LocaleKeys.password.tr(),
                          hintText: LocaleKeys.passwordHint.tr(),
                          prefixIcon: const Icon(Icons.shield_sharp),
                          suffixIcon: IconButton(
                              onPressed: () => setState(() {
                                    _hidePass = !_hidePass;
                                  }),
                              icon: _hidePass
                                  ? const Icon(
                                      Icons.visibility_off,
                                      color: Colors.grey,
                                    )
                                  : Icon(Icons.visibility)),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)),
                            borderSide:
                                BorderSide(color: Colors.black, width: 1),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 1),
                          ),
                          focusedErrorBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)),
                            borderSide:
                                BorderSide(color: Colors.red, width: 1),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)),
                            borderSide:
                                BorderSide(color: Colors.red, width: 1),
                          ),
                        ),
                        obscureText: _hidePass,
                        controller: _passwordController,
                        onFieldSubmitted: (_) {
                          fieldFocusChange(
                              context, _passwordFocus, _confirmPasswordFocus);
                        },
                        validator: (input) {
                          return _validatePassword(input!);
                        },
                        onChanged: (text) {
                          setState(() {
                            _passwordController.text = text;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        focusNode: _confirmPasswordFocus,
                        decoration: InputDecoration(
                          labelText: LocaleKeys.passwordConfirm.tr(),
                          hintText: LocaleKeys.passwordConfirmHint.tr(),
                          prefixIcon: Icon(Icons.shield_sharp),
                          suffixIcon: IconButton(
                              onPressed: () => setState(() {
                                    _hidePass = !_hidePass;
                                  }),
                              icon: _hidePass
                                  ? const Icon(
                                      Icons.visibility_off,
                                      color: Colors.grey,
                                    )
                                  : Icon(Icons.visibility)),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)),
                            borderSide:
                                BorderSide(color: Colors.black, width: 1),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 1),
                          ),
                          focusedErrorBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)),
                            borderSide:
                                BorderSide(color: Colors.red, width: 1),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)),
                            borderSide:
                                BorderSide(color: Colors.red, width: 1),
                          ),
                        ),
                        obscureText: _hidePass,
                        controller: _confirmPasswordController,
                        onFieldSubmitted: (_) {
                          _confirmPasswordFocus.unfocus();
                        },
                        validator: (input) {
                          return _validatePassword(input!);
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<RegisterBloc>(context).add(RegisterButtonPressed(_emailController.text, _passwordController.text, _phoneController.text));
                          }
                        },
                        child: Text(LocaleKeys.submit.tr())
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}