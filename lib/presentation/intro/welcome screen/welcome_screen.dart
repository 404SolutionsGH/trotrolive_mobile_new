import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:toastification/toastification.dart';
import 'package:trotrolive_mobile_new/helpers/widgets/custom_button.dart';
import '../../../helpers/text_widgets.dart';
import '../../../utils/constants/color constants/colors.dart';
import '../../../utils/constants/image constants/image_constants.dart';
import '../../authentication screens/bloc/auth_bloc.dart';
import '../../authentication screens/components/signup_textediting_controllers.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isRememberme = false;
  bool isSignupScreen = true;
  bool isSigninScreen = false;
  bool isChecked = false;
  bool isLoading = false;
  bool isToggeled = true;
  bool isVisible = true;

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (BuildContext context, AuthState state) {
        if (state is AuthLoadingState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() => isLoading = true);
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() => isLoading = false);
          });
        }
        if (state is AuthFailureState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            toastification.show(
              showProgressBar: false,
              description: Column(
                children: [
                  headingTextMedium(
                    context,
                    state.errorMessage,
                    FontWeight.w500,
                    12,
                    whiteColor,
                  ),
                ],
              ),
              autoCloseDuration: const Duration(seconds: 7),
              style: ToastificationStyle.fillColored,
              type: ToastificationType.error,
            );
          });
        } else if (state is AuthenticatedState) {
          Navigator.pushReplacementNamed(context, '/mainhome');
          WidgetsBinding.instance.addPostFrameCallback((_) {
            toastification.show(
              showProgressBar: false,
              description: Column(
                children: [
                  headingTextMedium(
                    context,
                    state.message,
                    FontWeight.w500,
                    12,
                    whiteColor,
                  ),
                ],
              ),
              autoCloseDuration: const Duration(seconds: 7),
              style: ToastificationStyle.fillColored,
              type: ToastificationType.success,
            );
          });
        }
      },
      builder: (BuildContext context, AuthState state) {
        if (state is AuthLoadingState) {
          isLoading == false;
        }
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
                  "assets/images/trotro1.jpeg",
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
                          onpressed: () async {
                            await _registerBottomSheet(context);
                          },
                          color: secondaryColor,
                          textColor: primaryColor,
                        ),
                        const SizedBox(height: 13),
                        CustomButton(
                          text: 'Login',
                          onpressed: () async {
                            await _loginBottomSheet(context);
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
      },
    );
  }

  Future _registerBottomSheet(BuildContext context) {
    bool isLoading = false;
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
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
          return BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthLoadingState) {
                setModalState(() => isLoading = true);
              } else if (state is AuthLogoutSuccesState) {
                Navigator.pop(context);
              } else if (state is AuthFailureState) {
                setModalState(() => isLoading = false);
              }
            },
            child: SingleChildScrollView(
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
                          key: formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: SignupController.username,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontSize: 15,
                                      color: blackColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter Username';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: "Username",
                                  hintStyle: TextStyle(
                                      color: iconGrey.withOpacity(0.7),
                                      fontSize: 13),
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
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              ),
                              SizedBox(height: 13),
                              TextFormField(
                                controller: SignupController.phone,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontSize: 15,
                                      color: blackColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter Phone Number';
                                  }
                                  if (value.length != 10) {
                                    return 'Phone number should be 10 digits long !!';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: "Phone Number",
                                  hintStyle: TextStyle(
                                      color: iconGrey.withOpacity(0.7),
                                      fontSize: 13),
                                  prefixIcon: const Icon(
                                    MingCute.phone_line,
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
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              ),
                              SizedBox(height: 13),
                              TextFormField(
                                controller: SignupController.email,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontSize: 15,
                                      color: blackColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter Email';
                                  }
                                  return null;
                                },
                                onSaved: (value) {},
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  hintStyle: TextStyle(
                                      color: iconGrey.withOpacity(0.7),
                                      fontSize: 13),
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
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              ),
                              SizedBox(height: 13),
                              TextFormField(
                                // obscureText: isVisible,
                                controller: SignupController.password,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontSize: 15,
                                      color: blackColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter Password';
                                  } else if (SignupController
                                          .password.text.length <
                                      6) {
                                    return 'Password should be at least 6 characters ';
                                  }
                                  return null;
                                },
                                onSaved: (value) {},
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                      color: iconGrey.withOpacity(0.7),
                                      fontSize: 13),
                                  prefixIcon: const Icon(
                                    MingCute.lock_line,
                                    color: iconGrey,
                                    size: 22,
                                  ),
                                  // suffixIcon: GestureDetector(
                                  //   onTap: () {
                                  //     // setState(() {
                                  //     //   isVisible = !isVisible;
                                  //     // });
                                  //     // setState(() {});
                                  //   },
                                  //   child: !isVisible
                                  //       ? const Icon(Icons.visibility)
                                  //       : const Icon(Icons.visibility_off),
                                  // ),
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
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        GestureDetector(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              final _username =
                                  SignupController.username.text.trim();
                              final _phone = SignupController.phone.text.trim();
                              final _email = SignupController.email.text.trim();
                              final _password =
                                  SignupController.password.text.trim();
                              context.read<AuthBloc>().add(
                                    SignupEvent(
                                      username: _username,
                                      phone: _phone,
                                      email: _email,
                                      password: _password,
                                    ),
                                  );
                            }
                          },
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: isLoading
                                  ? primaryColor.withOpacity(0.8)
                                  : primaryColor,
                            ),
                            child: Center(
                              child: isLoading
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Creating account ...",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium!
                                              .copyWith(
                                                color: secondaryColor4,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        SizedBox(width: 8),
                                        SizedBox(
                                          height: 20,
                                          width: 20,
                                          child:
                                              const CircularProgressIndicator(
                                                  color: secondaryColor4),
                                        ),
                                      ],
                                    )
                                  : Text(
                                      "Create Account",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .copyWith(
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
                            const SizedBox(height: 12),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border:
                                      Border.all(color: Colors.grey.shade400),
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
        },
      ),
    );
  }

  Future _loginBottomSheet(BuildContext context) {
    final formKey2 = GlobalKey<FormState>();
    bool isLoading = false;
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
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
          return BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthLoadingState) {
                setModalState(() => isLoading = true);
              } else if (state is AuthLogoutSuccesState) {
                Navigator.pop(context);
              } else if (state is AuthFailureState) {
                setModalState(() => isLoading = false);
              }
            },
            child: SingleChildScrollView(
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
                              'Login',
                              FontWeight.w600,
                              20,
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Center(
                          child: subheadingTextMediumIntro(
                            context,
                            'Enter your details to login into your account, Access to trips and stations info requires authentication',
                            14,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Form(
                          key: formKey2,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: SignupController.email,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontSize: 15,
                                      color: blackColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter Email';
                                  }
                                  return null;
                                },
                                onSaved: (value) {},
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  hintStyle: TextStyle(
                                      color: iconGrey.withOpacity(0.7),
                                      fontSize: 13),
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
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              ),
                              SizedBox(height: 13),
                              TextFormField(
                                // obscureText: isVisible,
                                controller: SignupController.password,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontSize: 15,
                                      color: blackColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter Password';
                                  } else if (SignupController
                                          .password.text.length <
                                      6) {
                                    return 'Password should be at least 6 characters ';
                                  }
                                  return null;
                                },
                                onSaved: (value) {},
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                      color: iconGrey.withOpacity(0.7),
                                      fontSize: 13),
                                  prefixIcon: const Icon(
                                    MingCute.lock_line,
                                    color: iconGrey,
                                    size: 22,
                                  ),
                                  // suffixIcon: GestureDetector(
                                  //   onTap: () {
                                  //     // setState(() {
                                  //     //   isVisible = !isVisible;
                                  //     // });
                                  //     // setState(() {});
                                  //   },
                                  //   child: !isVisible
                                  //       ? const Icon(Icons.visibility)
                                  //       : const Icon(Icons.visibility_off),
                                  // ),
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
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        GestureDetector(
                          onTap: () {
                            if (formKey2.currentState!.validate()) {
                              formKey2.currentState!.save();

                              final _email = SignupController.email.text.trim();
                              final _password =
                                  SignupController.password.text.trim();
                              context.read<AuthBloc>().add(
                                    LoginEvent(
                                      email: _email,
                                      password: _password,
                                    ),
                                  );
                            }
                          },
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: isLoading
                                  ? primaryColor.withOpacity(0.8)
                                  : primaryColor,
                            ),
                            child: Center(
                              child: isLoading
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Logging in...",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium!
                                              .copyWith(
                                                color: secondaryColor4,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        SizedBox(width: 8),
                                        SizedBox(
                                          height: 20,
                                          width: 20,
                                          child:
                                              const CircularProgressIndicator(
                                                  color: secondaryColor4),
                                        ),
                                      ],
                                    )
                                  : Text(
                                      "Login",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .copyWith(
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
                            const SizedBox(height: 12),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border:
                                      Border.all(color: Colors.grey.shade400),
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
        },
      ),
    );
  }
}
