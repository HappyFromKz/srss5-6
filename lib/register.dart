import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practice_7/constants.dart';
import 'package:practice_7/home.dart';
import 'package:practice_7/translations/locale_keys.g.dart';
import 'package:practice_7/user.dart';

class RegisterPage extends StatefulWidget {
  final String languageCode;

  const RegisterPage({super.key, required this.languageCode});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _formKey = GlobalKey<FormState>();

  // List<String> _contries = LocaleKeys.languages.tr() as List<String>;
  // List<String> _contries = ["Kazakhstan","USA","Norway","Switzerland"];
  String selectedCountry = '';

  bool _hidePass = true;

  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _lifeStoryController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final FocusNode _fullnameFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _lifeStoryFocus = FocusNode();
  final FocusNode _countryFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  //functions
  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _fullnameController.dispose();
    _lifeStoryController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _fullnameFocus.dispose();
    _phoneFocus.dispose();
    _emailFocus.dispose();
    _lifeStoryFocus.dispose();
    _countryFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  bool _validatePhoneNumber(String input) {
    final phoneExp = RegExp(r'^\d{11}$');
    print('dada $phoneExp');
    return phoneExp.hasMatch(input);
  }

  bool _validateFullName(String input) {
    if (input.isEmpty) {
      return false;
    }
    final nameExp = RegExp(r'^[a-zA-Zа-яА-ЯёЁ]+(?:[ -][a-zA-Zа-яА-ЯёЁ]+)*$');
    return nameExp.hasMatch(input);
  }

  bool _validateEmail(String input) {
    final emailExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailExp.hasMatch(input);
  }

  _validatePassword(String input) {
    if (input.isEmpty){
      return LocaleKeys.passwordErrorIsEmpty.tr();
    }
    if (input.length <= 8){
      return LocaleKeys.passwordErrorLenght.tr();
    } else if (_passwordController.text != _confirmPasswordController.text){
      return LocaleKeys.passwordErrorIsNotEquals.tr();
    }
    return null;
  }

  void fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus){
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  //interface
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                  TextFormField(
                    focusNode: _fullnameFocus,
                    decoration: InputDecoration(
                      labelText: LocaleKeys.fullname.tr(),
                      hintText: LocaleKeys.fullnameHint.tr(),
                      prefixIcon: Icon(Icons.person),
                      suffixIcon: IconButton(
                        onPressed: () => setState(() {
                          _fullnameController.clear();
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
                    controller: _fullnameController,
                    onFieldSubmitted: (_) {
                      fieldFocusChange(context, _fullnameFocus, _phoneFocus);
                    },
                    validator: (input) {
                      if (!_validateFullName(input!)) {
                        return LocaleKeys.fullnameError.tr();
                      }
                      return null;
                    },
                    onChanged: (text){
                      setState(() {
                        _fullnameController.text = text;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    focusNode: _phoneFocus,
                    decoration: InputDecoration(
                      labelText: LocaleKeys.phone.tr(),
                      hintText: LocaleKeys.phoneHint.tr(),
                      helperText: LocaleKeys.phoneHelper.tr(),
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
                      fieldFocusChange(context, _phoneFocus, _emailFocus);
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
                    focusNode: _emailFocus,
                    decoration: InputDecoration(
                      labelText: LocaleKeys.email.tr(),
                      hintText: LocaleKeys.emailHint.tr(),
                      prefixIcon: Icon(Icons.email),
                      suffixIcon: IconButton(
                        onPressed: () => setState(() {
                          _emailController.clear();
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
                    controller: _emailController,
                    onFieldSubmitted: (_) {
                      fieldFocusChange(context, _emailFocus, _lifeStoryFocus);
                    },
                    validator: (input) {
                      if (!_validateEmail(input!)) {
                        return LocaleKeys.emailError.tr();
                      }
                      return null;
                    },
                    onChanged: (text){
                      setState(() {
                        _emailController.text = text;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    focusNode: _lifeStoryFocus,
                    decoration: InputDecoration(
                      labelText: LocaleKeys.lifeStory.tr(),
                      hintText: LocaleKeys.lifeStoryHint.tr(),
                      helperText: LocaleKeys.lifeStoryHelper.tr(),
                      prefixIcon: Icon(Icons.hourglass_bottom),
                      suffixIcon: IconButton(
                        onPressed: () => setState(() {
                          _lifeStoryController.clear();
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
                    maxLines: 3,
                    controller: _lifeStoryController,
                    onChanged: (text){
                      setState(() {
                        _lifeStoryController.text = text;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField(
                    focusNode: _countryFocus,
                    decoration: InputDecoration(
                      labelText: LocaleKeys.country.tr(),
                      hintText: LocaleKeys.countryHint.tr(),
                      prefixIcon: Icon(Icons.map),
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
                    items: [LocaleKeys.Kazakhstan.tr(), LocaleKeys.USA.tr(), LocaleKeys.Norway.tr(), LocaleKeys.Switzerland.tr()].map((country) {
                      return DropdownMenuItem(
                        value: country,
                        child: Text(country, style: Constants.textStyle),
                      );
                    }).toList(), 
                    validator: (val){
                      return val == null ? LocaleKeys.countryError.tr() : null;
                    },
                    onChanged: (data) {
                      setState(() {
                        selectedCountry = data!;
                        fieldFocusChange(context, _countryFocus, _passwordFocus);
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
                        icon: _hidePass ? Icon(Icons.visibility_off, color: Colors.grey,) : Icon(Icons.visibility)
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
                    obscureText: _hidePass,
                    controller: _passwordController,
                    onFieldSubmitted: (_) {
                      fieldFocusChange(context, _passwordFocus, _confirmPasswordFocus);
                    },
                    validator: (input) {
                      return _validatePassword(input!);
                    },
                    onChanged: (text){
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
                        icon: _hidePass ? Icon(Icons.visibility_off, color: Colors.grey,) : Icon(Icons.visibility)
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
                    obscureText: _hidePass,
                    controller: _confirmPasswordController,
                    onFieldSubmitted: (_){
                      _confirmPasswordFocus.unfocus();
                    },
                    validator: (input) {
                      return _validatePassword(input!);
                    },
                    onChanged: (text){
                      setState(() {
                        _confirmPasswordController.text = text;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: (){
                      if (_formKey.currentState!.validate()){
                        Navigator.push(context, 
                          MaterialPageRoute(builder: (context){
                            return HomePage(user: NewUser(
                              fullname: _fullnameController.text,
                              phone: _phoneController.text,
                              email: _emailController.text,
                              lifeStory: _lifeStoryController.text,
                              country: selectedCountry,
                            ));
                          })
                        );
                      }
                    }, 
                    child: Text(LocaleKeys.submit.tr(), style: Constants.textStyle)
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}