import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/Views/login_screan.dart';
import 'package:ketaby/Views/order_history_screan.dart';
import 'package:ketaby/blocs/ChangePasswordAndDeleteAccount/change_password_and_delete_account_cubit.dart';
import 'package:ketaby/src/app_root.dart';
import 'package:ketaby/src/cashe_helper.dart';
import 'package:ketaby/utils/navigator.dart';
import 'package:ketaby/widgets/custom_text_field.dart';

class MainScreanDrawer extends StatefulWidget {

   MainScreanDrawer({
    super.key,



  });

  @override
  State<MainScreanDrawer> createState() => _MainScreanDrawerState();
}

class _MainScreanDrawerState extends State<MainScreanDrawer> {
String? name=CashHelper.getData(key: 'name').toString();

String? image=CashHelper.getData(key: 'image').toString();

String ? email=CashHelper.getData(key: 'email').toString();

TextEditingController oldPasswordController = TextEditingController();

TextEditingController newPasswordController = TextEditingController();

TextEditingController confirmPasswordController = TextEditingController();
TextEditingController passwordOfDeleteAccountController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return Drawer(

        child: ListView(
          children: [
            DrawerHeader(
              curve: Curves.easeIn,
              decoration: BoxDecoration(
                color: mainColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 CircleAvatar(
                   radius: 40,
                   backgroundImage: NetworkImage(image!),
                 ),

                  Text(
                    name!,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
                  ),

                  Text(
                    email!,
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.history_edu_outlined),
              title: Text('Order History'),
              onTap: () {

                Navigator.pop(context);
                navigateToScreen(context, OrderHistoryScrean());

              },
            ),
            Divider(
              color: Colors.grey,
              height: 2,
              thickness: 2,
              endIndent: 20,
              indent: 20,
            ),
            ListTile(
              leading: Icon(Icons.change_circle_outlined),
              title: Text('Change Password'),
              onTap: () {
                Navigator.pop(context);
                showAdaptiveDialog(context: context,
                    builder: (context) => BlocProvider(
  create: (context) => ChangePasswordAndDeleteAccountCubit(),
  child: BlocConsumer<ChangePasswordAndDeleteAccountCubit, ChangePasswordAndDeleteAccountState>(
    listener: (context, state) {
      // TODO: implement listener
    },
    builder: (context, state) {
      var cubit = ChangePasswordAndDeleteAccountCubit.get(context);
      return AlertDialog(
                      titleTextStyle: TextStyle(color: mainColor,fontSize: 20),
                      scrollable: true,
                      surfaceTintColor: mainColor,
                      backgroundColor: Colors.white,
                      title: Text('Change Password',style: TextStyle(color: mainColor),),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                        CustomTextField(
                         hint: 'Old Password',
                          icon: Icons.lock_outline,
                          controller: oldPasswordController,
                        ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            hint: 'New Password',
                            icon: Icons.lock_outline,
                            controller: newPasswordController,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            hint: 'Confirm Password',
                            icon: Icons.lock_outline,
                            controller: confirmPasswordController,
                          ),

                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            cubit.changePassword(context: context,
                                oldPassword: oldPasswordController.text,
                                newPassword: newPasswordController.text,
                                confirmPassword: confirmPasswordController.text);

                          },
                          child: Text('Change'),
                        ),
                      ],
                    );
    },
    ),
));
              },
            ),
            Divider(
              color: Colors.grey,
              height: 2,
              thickness: 2,
              endIndent: 20,
              indent: 20,
            ),
            ListTile(
              leading: Icon(Icons.delete_forever_outlined),
              title: Text('Delete Account'),
              onTap: () {
                Navigator.pop(context);
                showAdaptiveDialog(context: context,
                    builder: (context) => BlocProvider(
  create: (context) => ChangePasswordAndDeleteAccountCubit(),
  child: BlocConsumer<ChangePasswordAndDeleteAccountCubit, ChangePasswordAndDeleteAccountState>(
                        listener: (context, state) {
                          // TODO: implement listener
                        },
                        builder: (context, state) {
                          var cubit = ChangePasswordAndDeleteAccountCubit.get(context);
                          return AlertDialog(
                            titleTextStyle: TextStyle(color: mainColor,fontSize: 20),
                            scrollable: true,
                            surfaceTintColor: mainColor,
                            backgroundColor: Colors.white,
                            title: Text('Delete Account',style: TextStyle(color: mainColor),),
                            content: Text('Are you sure you want to delete your account?'),
                            actions: [
                              Text('enter your password to confirm the deletion'),
                              CustomTextField(
                                hint: 'Password',
                                icon: Icons.lock_outline,
                                controller: passwordOfDeleteAccountController,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      cubit.deleteAccount(context: context,
                                          currentPassword: passwordOfDeleteAccountController.text);
                                      navigateToScreenAndExit(context, LoginScrean());
                                    },
                                    child: Text('Delete'),
                                  ),
                                ],
                              )

                            ],
                          );
                        },
                    ),
));
              },
            ),


          ],
        ),
      );
  }
}
