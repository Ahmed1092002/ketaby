import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/Views/login_screan.dart';
import 'package:ketaby/src/app_root.dart';
import 'package:ketaby/utils/navigator.dart';
import 'package:ketaby/widgets/check_out_screan_text_form_field.dart';
import 'package:ketaby/widgets/custoButton.dart';

import '../blocs/ProfileCubit/profile_cubit.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: MediaQuery.of(context).viewInsets.bottom == 0
          ? ScrollPhysics()
          : NeverScrollableScrollPhysics(),
      child: Container(
        width: MediaQuery.of(context)
            .size
            .width, // this will take the width of the screen
        height: MediaQuery.of(context)
            .size
            .height*0.9,
        // this will take the height of the screen
        color: Colors.white,

        child: BlocConsumer<ProfileCubit, ProfileState>(
  listener: (context, state) {

  },
  builder: (context, state) {
    var cubit = ProfileCubit.get(context);


    if (state is GetProfileLoading || cubit.userModel == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (cubit.userModel!.data!.address != null) {
      cubit.addressController.text = cubit.userModel!.data!.address!;
    }
    if (cubit.userModel!.data!.city != null) {
      cubit.cityController.text = cubit.userModel!.data!.city!;
    }
    cubit.emailController.text = cubit.userModel!.data!.email!;
    cubit.nameController.text = cubit.userModel!.data!.name!;
    if (cubit.userModel!.data!.phone != null) {
      cubit.phoneController.text = cubit.userModel!.data!.phone!;
    }
    return Stack(
          alignment: Alignment.center,
        clipBehavior: Clip.hardEdge,
          fit: StackFit.loose,

          children: [
            Positioned(

                bottom: 525,


                child: CircleAvatar(
                  radius: 250,
          backgroundColor: mainColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 260,
                      ),
                      Row(

                        children: [
                          SizedBox(
                            width: 170,
                          ),
                          Text(
                            'Ketaby',
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                        IconButton(
                          onPressed: () {
                            cubit.logout(context);
                            navigateToScreenAndExit(context, LoginScrean());
                          },
                          icon: Icon(
                            Icons.logout,
                            color: Colors.white,
                          ),
                        ),
                        ],
                      ),
                    ],
                  ),
                ),
                ),
            Positioned(child: CircleAvatar(
              radius: 100,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 90,
                backgroundImage:cubit.imageFile != null ?
                FileImage(cubit.imageFile!)
                  : NetworkImage(cubit.userModel!.data!.image!) as ImageProvider,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(

                    backgroundColor: mainColor,
                    child: IconButton(
                      color: Colors.white, onPressed: () {
                        cubit.pickProfileImage();

                    }, icon: Icon(Icons.camera_alt_outlined),),
                  ),
                )
              ),
            ),
              bottom: 410,
              left: 100,
            ),


            Positioned(
              bottom: 5,
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    height: MediaQuery.of(context).size.height*0.45,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10)
                    ),
                    margin: EdgeInsets.only(top: 350),
                    child: Column(
                      children: [
                       CheckOutScreanTextFormField(
                         hint: 'Name',
                         icon: Icons.person,
                         controller: cubit.nameController,
                        ),
                       CheckOutScreanTextFormField(
                         hint: 'email',
                         icon: Icons.email,
                          controller: cubit.emailController,
                        ),
                       CheckOutScreanTextFormField(
                         hint: 'phone',
                         icon: Icons.phone,
                          controller: cubit.phoneController,
                        ),
                       CheckOutScreanTextFormField(
                         hint: 'city',
                         icon: Icons.location_city,
                          controller: cubit.cityController,
                        ),
                       CheckOutScreanTextFormField(
                         hint: 'address',
                         icon: Icons.location_on_outlined,
                          controller: cubit.addressController,
                        ),




                      ],),
                  ),
                  SizedBox(height: 10,),
                  CustomButton(
                    buttonName: 'Edit Profile ',
                    onPressed: () async {

                      await cubit.updateProfileData();
                      await cubit.getProfileData();
                      cubit.imageFile = null;
                      cubit.pickedFilename = null;

                    },
                  )
                ],
              ),
            )



          ],
        );
  },
)

      ),
    );
  }
}
