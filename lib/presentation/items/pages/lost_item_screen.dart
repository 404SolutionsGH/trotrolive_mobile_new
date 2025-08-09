import 'dart:io';
import 'package:flutter/material.dart';
import 'package:trotrolive_mobile_new/utils/constants/color%20constants/colors.dart';
import '../../../helpers/text_widgets.dart';
import '../../../helpers/widgets/custom_button.dart';

class LostItemScreen extends StatefulWidget {
  const LostItemScreen({super.key});

  @override
  State<LostItemScreen> createState() => _LostItemScreenState();
}

class _LostItemScreenState extends State<LostItemScreen> {
  final _formKey = GlobalKey<FormState>();
  String? selectedStation;
  String? selectedCarType;
  File? imageFile;

  final List<String> stations = [
    'Tech Junction',
    'Adum',
    'Kejetia',
    'Ahodwo',
    'Airport Roundabout'
  ];

  final List<String> carTypes = ['Trotro', 'Taxi'];

  Future<void> _pickImage() async {
    // final picker = ImagePicker();
    // final pickedFile =
    //     await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    // if (pickedFile != null) {
    //   setState(() {
    //     imageFile = File(pickedFile.path);
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [
                primaryColor.withOpacity(0.95),
                primaryColorDeep,
              ],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 5,
                top: -180,
                right: -50,
                child: Icon(
                  Icons.phone_android_rounded,
                  size: 200,
                  color: const Color.fromRGBO(255, 255, 255, 0.05),
                ),
              ),
              Positioned(
                bottom: -190,
                top: 5,
                left: -50,
                child: Icon(
                  Icons.luggage_rounded,
                  size: 280,
                  color: whiteColor.withOpacity(0.05),
                ),
              ),
              Positioned(
                bottom: 20,
                top: 20,
                right: 20,
                left: 20,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      headingTextMedium(
                        context,
                        "Report lost or stolen items",
                        FontWeight.bold,
                        20,
                        whiteColor,
                      ),
                      const SizedBox(height: 2),
                      subheadingText(
                        context,
                        'File a report to the station master!!',
                        size: 12,
                        color: secondaryColor4,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                Container(
                  height: 30,
                  width: 230,
                  decoration: BoxDecoration(
                    color: subtitleColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: headingTextMedium(
                      context,
                      'Complete the form below',
                      FontWeight.w600,
                      14,
                      whiteColor,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                _buildInputLabel(context, 'Your Full Name'),
                _buildTextField(hintText: 'e.g. Patrick Boat'),
                const SizedBox(height: 8),
                _buildInputLabel(context, 'Phone Number'),
                _buildTextField(
                  hintText: 'e.g. 0541234567',
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 8),
                _buildInputLabel(context, 'Date Item Was Lost'),
                _buildTextField(
                  hintText: 'e.g. 2025-07-20',
                  keyboardType: TextInputType.datetime,
                ),
                const SizedBox(height: 8),
                _buildInputLabel(context, 'Item Description'),
                _buildTextField(
                  hintText: 'Describe the lost item in detail...',
                  maxLines: 4,
                ),
                const SizedBox(height: 8),
                _buildInputLabel(context, 'Last Seen Location'),
                _buildTextField(hintText: 'e.g. Tech Junction Station'),
                const SizedBox(height: 8),
                _buildInputLabel(context, 'Station'),
                DropdownButtonFormField<String>(
                  value: selectedStation,
                  decoration: _dropdownDecoration(),
                  items: stations
                      .map((station) => DropdownMenuItem(
                            value: station,
                            child: Text(station),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedStation = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Please select a station' : null,
                ),
                const SizedBox(height: 8),
                _buildInputLabel(context, 'Car Type'),
                DropdownButtonFormField<String>(
                  value: selectedCarType,
                  decoration: _dropdownDecoration(),
                  items: carTypes
                      .map((type) => DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCarType = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Please select car type' : null,
                ),
                const SizedBox(height: 8),
                _buildInputLabel(context, 'Car Number (Optional)'),
                _buildTextField(hintText: 'e.g. AS 1234 - 20'),
                const SizedBox(height: 8),
                _buildInputLabel(context, 'Upload Image of Item (optional)'),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: outlineGrey),
                      borderRadius: BorderRadius.circular(12),
                      color: whiteColor,
                    ),
                    child: imageFile != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(imageFile!, fit: BoxFit.cover),
                          )
                        : Center(
                            child: subheadingText(
                              context,
                              'Tap to select an image',
                              size: 13,
                              color: secondaryColor4,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 30),
                CustomButton(
                  text: 'Submit Report',
                  onpressed: () {
                    if (_formKey.currentState!.validate()) {}
                  },
                  color: secondaryColor,
                  textColor: blackColor,
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _dropdownDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: whiteColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: outlineGrey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: outlineGrey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.green, width: 1.2),
      ),
    );
  }

  Widget _buildInputLabel(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, top: 12),
      child: subheadingText(
        context,
        label,
        size: 13,
        color: blackColor,
      ),
    );
  }

  Widget _buildTextField({
    required String hintText,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: (value) => (value == null || value.trim().isEmpty)
          ? 'This field is required'
          : null,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: iconGrey, fontSize: 13),
        filled: true,
        fillColor: whiteColor,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: outlineGrey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: outlineGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.green, width: 1.2),
        ),
      ),
    );
  }
}
