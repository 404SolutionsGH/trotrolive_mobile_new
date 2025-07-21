import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:trotrolive_mobile_new/helpers/widgets/custom_button.dart';
import '../../../helpers/text_widgets.dart';
import '../../../utils/constants/color constants/colors.dart';
import '../../../utils/constants/image constants/image_constants.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      bottomNavigationBar: SizedBox(
        height: 40,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Version 2.0.1",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: whiteColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 8,
                  ),
            ),
            Text(
              "Copyright @ 404 Solutions",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: whiteColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 8,
                  ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: primaryColor,
            child: Image.asset(
              trotroStationImg,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [
                  primaryColor.withOpacity(0.85),
                  primaryColor.withOpacity(0.98),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(22.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    width: 130,
                    height: 130,
                    logo,
                  ),
                ),
                const Text(
                  "TrotroLive",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(
                              style: TextStyle(fontSize: 15),
                              children: [
                                TextSpan(
                                  text: "By proceeding you agree to our ",
                                ),
                                TextSpan(
                                  style: TextStyle(color: secondaryColor),
                                  text: "terms ",
                                ),
                                TextSpan(
                                  text: "of use ",
                                ),
                                TextSpan(
                                  text: "and ",
                                ),
                                TextSpan(
                                  style: TextStyle(color: secondaryColor),
                                  text: "privacy ",
                                ),
                                TextSpan(
                                  text: "policies",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    CustomButton(
                      text: 'Create Account',
                      onpressed: () {
                        _displayBottomSheet(context);
                      },
                      color: secondaryColor,
                      textColor: primaryColor,
                    ),
                    const SizedBox(height: 13),
                    CustomButton(
                      text: 'Proceed',
                      onpressed: () {
                        Navigator.pushNamed(context, '/mainhome');
                      },
                      color: Colors.blue,
                      offset: Colors.blue,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future _displayBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      showDragHandle: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      headingTextMedium(
                        context,
                        'Create Account',
                        FontWeight.w600,
                        20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Center(
                    child: subheadingTextMediumIntro(
                      context,
                      'Enter your details to create an account, Access to trips and stations info requires authentication',
                      14,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Form(
                    child: Column(
                      children: [
                        TextFormField(
                          //  controller: destinationController,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 15,
                                    color: blackColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                          //onChanged: (value) => (),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Username';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            //destination = value!.trim();
                          },
                          decoration: InputDecoration(
                            hintText: "Username",
                            hintStyle: TextStyle(
                                color: iconGrey.withOpacity(0.7), fontSize: 13),
                            prefixIcon: const Icon(
                              MingCute.user_2_line,
                              color: iconGrey,
                              size: 22,
                            ),
                            filled: true,
                            isDense: true,
                            fillColor: whiteColor,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(color: Colors.green),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: outlineGrey),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                        SizedBox(height: 13),
                        TextFormField(
                          //  controller: destinationController,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 15,
                                    color: blackColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                          //onChanged: (value) => (),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Email';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            //destination = value!.trim();
                          },
                          decoration: InputDecoration(
                            hintText: "Email",
                            hintStyle: TextStyle(
                                color: iconGrey.withOpacity(0.7), fontSize: 13),
                            prefixIcon: const Icon(
                              MingCute.mail_line,
                              color: iconGrey,
                              size: 22,
                            ),
                            filled: true,
                            isDense: true,
                            fillColor: whiteColor,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(color: Colors.green),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: outlineGrey),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                        SizedBox(height: 13),
                        TextFormField(
                          obscureText: true,
                          //  controller: destinationController,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 15,
                                    color: blackColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                          //onChanged: (value) => (),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Password';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            //destination = value!.trim();
                          },
                          decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(
                                color: iconGrey.withOpacity(0.7), fontSize: 13),
                            prefixIcon: const Icon(
                              MingCute.lock_line,
                              color: iconGrey,
                              size: 22,
                            ),
                            filled: true,
                            isDense: true,
                            fillColor: whiteColor,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(color: Colors.green),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: outlineGrey),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),

                        // Form(
                        //   key: formKey,
                        //   child: InternationalPhoneNumberInput(
                        //     betweenPadding: 5,
                        //     controller: controller.phone,
                        //     validator: (value) {
                        //       if (value.rawFullNumber.isEmpty) {
                        //         return errorMessage;
                        //       }
                        //       //||
                        //       return null;
                        //     },
                        //     initCountry: CountryCodeModel(
                        //       name: 'Ghana',
                        //       dial_code: '+233',
                        //       code: 'GH',
                        //     ),
                        //     onInputChanged: (value) {},
                        //     phoneConfig: PhoneConfig(
                        //       textInputAction: TextInputAction.done,
                        //       borderWidth: 0.5,
                        //       textStyle: const TextStyle(
                        //         color: Colors.black,
                        //         letterSpacing: 4,
                        //         //fontWeight: FontWeight.bold,
                        //       ),
                        //       popUpErrorText: true,
                        //       errorColor: Colors.red,
                        //       autovalidateMode: AutovalidateMode.always,
                        //       enabledColor: Colors.black,
                        //       focusedColor: Colors.black,
                        //       showCursor: true,
                        //     ),
                        //     countryConfig: CountryConfig(
                        //       flatFlag: true,
                        //       flagSize: 20,
                        //       textStyle: const TextStyle(
                        //         color: Colors.black,
                        //         letterSpacing: 4,
                        //         //fontWeight: FontWeight.bold,
                        //       ),
                        //       decoration: BoxDecoration(
                        //         border: Border.all(
                        //           width: 0.5,
                        //           color: Colors.black,
                        //         ),
                        //         borderRadius: BorderRadius.circular(5),
                        //         //color: Colors.white,
                        //       ),
                        //     ),
                        //     dialogConfig: DialogConfig(
                        //       selectedItemColor: kSecondaryColor,
                        //       topBarColor: kPrimaryColor,
                        //       searchBoxBackgroundColor: kPrimaryColor,
                        //       backgroundColor: Colors.white,
                        //       textStyle: const TextStyle(color: Colors.black),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      /*setState(() {
                          isLoading = true;
                        });*/

                      // if (formKey.currentState!.validate()) {
                      //   NewauthController.instance
                      //       .phoneAuthentication(controller.phone.text.trim());
                      //   Get.to(() => const OTPScreen());
                      // }
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: primaryColor,
                      ),
                      child: Center(
                        child: Text(
                          "Continue",
                          style:
                              Theme.of(context).textTheme.labelMedium!.copyWith(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // TextDivider.horizontal(
                      //   text: const Text(
                      //     "OR",
                      //     style: TextStyle(
                      //       fontSize: 12,
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () {
                          //AuthenticationRepository.instance.signInWithGoogle();
                        },
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Brand(
                                Brands.google,
                                size: 25,
                              ),
                              const SizedBox(width: 5),
                              const Text(
                                "Sign In with Google",
                                style: TextStyle(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
