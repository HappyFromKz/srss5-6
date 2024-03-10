import 'package:flutter/material.dart';
import 'package:practice_7/login.dart';
import 'package:practice_7/register.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AuthPage extends StatefulWidget {
  final String languageCode;

  const AuthPage({Key? key, required this.languageCode}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    String languageCode = widget.languageCode;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.purple
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Colors.white
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 330.sp,
                    child: DefaultTabController(
                      length: 2,
                      initialIndex: 0,
                      child: TabBarView(
                        children: [LoginPage(languageCode: languageCode), RegisterPage(languageCode: languageCode)]
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}
