import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:practice_7/constants.dart';
import 'package:practice_7/home.dart';
import 'package:practice_7/translations/locale_keys.g.dart';
import 'package:practice_7/user.dart';



class LoginPage extends StatefulWidget {
  final String languageCode;

  const LoginPage({super.key, required this.languageCode});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  //states


  final _formKey = GlobalKey<FormState>();


  bool _hidePass = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  //functions
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
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
    }
    return null;
  }

  void fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus){
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.setLocale(Locale('${widget.languageCode}'));
  }
  //interface
  @override
  Widget build(BuildContext context) {

      return Container(
        margin: EdgeInsets.symmetric(vertical: 30),
        color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center, 
              children: [
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Column(
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
                            fieldFocusChange(context, _emailFocus, _passwordFocus);
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
                        ElevatedButton(
                          onPressed: (){
                            if (_formKey.currentState!.validate()){
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
                          child: Text(LocaleKeys.submit.tr(), style: Constants.textStyle)
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
    }
  }