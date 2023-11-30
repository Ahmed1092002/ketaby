import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/Views/main_screan.dart';
import 'package:ketaby/Views/register_screan.dart';
import 'package:ketaby/blocs/LoginCubit/login_cubit.dart';
import 'package:ketaby/src/app_root.dart';
import 'package:ketaby/utils/navigator.dart';
import 'package:ketaby/widgets/custom_text_field.dart';
import 'package:ketaby/widgets/logo_image.dart';

import '../src/cashe_helper.dart';
import '../widgets/custoButton.dart';

class LoginScrean extends StatelessWidget {
   LoginScrean({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => LoginCubit(),
  child: Scaffold(
        body: BlocConsumer<LoginCubit, LoginState>(
  listener: (context, state) {
    if (state is LoginSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.userModel.message!),
        ),
      );
      CashHelper.saveData(
          key: 'image', value: state.userModel.data!.user!.image!);
      CashHelper.saveData(
          key: 'email', value: state.userModel.data!.user!.email!);
      CashHelper.saveData(
          key: 'name', value: state.userModel.data!.user!.name!)
          .then((value) {
        navigateToScreenAndExit(context, MainScrean(

        ));
      });


    }
    if (state is LoginError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.error.toString()),
        ),
      );
    }
  },
  builder: (context, state) {
    var cubit = LoginCubit.get(context);
    return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).viewInsets.bottom == 0
                ? MediaQuery.of(context).size.height
                : MediaQuery.of(context).size.height * 0.8,
            child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  autovalidateMode: autovalidateMode,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height/10,
                        ),
                        LogoImage(),
                        SizedBox(
                          height: MediaQuery.of(context).size.height/30,
                        ),
                        Text(
                          'Login now !',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height/50,
                        ),
                        Row(

                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width/10,
                            ),

                            Text(
                              'Don`t have an Account ?',
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            TextButton(

                              onPressed: () {
                               navigateToScreen(context, RegisterScrean());
                              },
                              child: Text(
                                'Register Now !',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ),
                          ],
                        ),

                    Container(
                        width: MediaQuery.of(context).size.width * 5,
                        height: MediaQuery.of(context).size.height / 2.5,
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: mainColor,
                            width: 2,
                          ),
                        ),
                      child: Column(
mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomTextField(
                            hint: 'email',
                            icon: Icons.email,
                            controller: cubit.emailController,
                          ),
                          CustomTextField(
                            hint: 'password',
                            icon: Icons.lock,
                            controller: cubit.passwordController,
                          ),
                          CustomButton(
                            buttonName: 'Login',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                cubit.login(
                                    email: cubit.emailController.text,
                                    password: cubit.passwordController.text,
                                    );
                              } else {
                                autovalidateMode =
                                    AutovalidateMode.onUserInteraction;
                              }

                            },
                          )


                        ],

                      ),


                    ),

                  ]),
                )));
  },
)),
);
  }
}
