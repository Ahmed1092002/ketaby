import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/Views/login_screan.dart';
import 'package:ketaby/Views/main_screan.dart';
import 'package:ketaby/blocs/RegisterCubit/register_cubit.dart';
import 'package:ketaby/src/cashe_helper.dart';
import 'package:ketaby/utils/navigator.dart';
import 'package:ketaby/widgets/logo_image.dart';
import 'package:ketaby/src/app_root.dart';
import 'package:ketaby/widgets/custoButton.dart';
import 'package:ketaby/widgets/custom_text_field.dart';

class RegisterScrean extends StatelessWidget {
   RegisterScrean({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => RegisterCubit(),
  child: BlocConsumer<RegisterCubit, RegisterState>(
  listener: (context, state) {


  },
  builder: (context, state) {
    var cubit = RegisterCubit.get(context);
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context)
            .size
            .width, // to make the container take the whole width of the screen
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
  height: MediaQuery.of(context).size.height/20,
),
                LogoImage(),
                SizedBox(
                  height: MediaQuery.of(context).size.height/30,
                ),
                Text(
                  'join us',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height/50,
                ),
                Row(

                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'already have an account?',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    TextButton(

                      onPressed: () {
                        navigateToScreen(context, LoginScrean());
                      },
                      child: Text(
                        'Login',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height/300,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 5,
                  height: MediaQuery.of(context).size.height * 0.6,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                        hint: 'name',
                        icon: Icons.person,
                        controller: cubit.nameController,
                      ),
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
                      CustomTextField(
                        hint: 'confirm password',
                        icon: Icons.lock,
                        controller: cubit.confirmPasswordController,
                      ),
                      if (state is RegisterLoading)
                        CircularProgressIndicator()
                      else
                      CustomButton(
                        buttonName: 'Register',
                        onPressed: () async {
if (formKey.currentState!.validate()) {
  formKey.currentState!.save();

  await cubit.register(

    name: cubit.nameController.text,
    email: cubit.emailController.text,
    password: cubit.passwordController.text,
    confirmPassword: cubit.confirmPasswordController.text,
  );

  Future.delayed(Duration(seconds: 1), () {
    if ( cubit.userModel==null){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error invalid data '),
        ),
      );

    }
    else if (cubit.userModel!=null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Register Success'),
        ),
      );
      navigateToScreenAndExit(context, MainScrean(  ) );

    }
  });




}else{
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('please enter valid data'),
    ),
  );

}

                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  },
),
);
  }
}
