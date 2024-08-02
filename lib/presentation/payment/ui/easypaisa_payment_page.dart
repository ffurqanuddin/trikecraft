import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trikecraft/logic/new_bike_order/new_bike_order_bloc.dart';
import 'package:trikecraft/logic/new_bike_order/new_bike_order_event.dart';
import 'package:trikecraft/logic/payment/payment_cubit.dart';
import 'package:trikecraft/models/bike_model.dart';
import 'package:trikecraft/models/order_model.dart';
import 'package:trikecraft/utils/amount_to_words_extension.dart';

class EasypaisaPaymentPage extends StatefulWidget {
  final BikeModel bike;

  EasypaisaPaymentPage({super.key, required this.bike});

  @override
  State<EasypaisaPaymentPage> createState() => _EasypaisaPaymentPageState();
}

class _EasypaisaPaymentPageState extends State<EasypaisaPaymentPage> {
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController(text: "");
  TextEditingController addressController = TextEditingController(text: "None");

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    int paymentAmount = int.tryParse(widget.bike.price) ?? 0;
    String amountInWords = paymentAmount.toWords();

    // Use theme-based colors
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Easypaisa Payment',
            ),
            SizedBox(height: 2),
            Text(
              'Pay PKR $amountInWords only',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: BlocConsumer<PaymentCubit, PaymentState>(
        listener: (context, paymentState) {
          if (paymentState is PaymentSuccessState) {
           
          }
          if (paymentState is PaymentFailureState) {
          
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Pay Amount',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'PKR ${widget.bike.price}',
                          style: TextStyle(
                            color: theme.primaryColor,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                  _buildInputField(
                    controller: accountNumberController,
                    label: 'Account Number',
                    hint: 'Enter your Easypaisa account number',
                    icon: Icons.account_circle,
                    theme: theme,
                  ),
                  SizedBox(height: 20),
                  _buildInputField(
                    controller: emailController,
                    label: 'Email',
                    hint: 'Enter your email address',
                    icon: Icons.email,
                    theme: theme,
                  ),
                  SizedBox(height: 20),
                  _buildInputField(
                    controller: contactController,
                    label: 'Additional Contact Info',
                    hint: 'Enter your contact info (optional)',
                    icon: Icons.person,
                    theme: theme,
                  ),
                  SizedBox(height: 20),
                  _buildInputField(
                    controller: addressController,
                    label: 'Address',
                    hint: 'Enter your address (optional)',
                    icon: Icons.home,
                    theme: theme,
                  ),
                  SizedBox(height: 50),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: _loading
                            ? EdgeInsets.symmetric(vertical: 15.sp)
                            : EdgeInsets.symmetric(
                                horizontal: 40.sp, vertical: 18.sp),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        elevation: 5,
                        backgroundColor: theme.primaryColor,
                      ),
                      onPressed: () {
                        if (accountNumberController.text.isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Please enter account number",
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                          );
                        } else if (emailController.text.isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Please enter email",
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                          );
                        } else {
                          makePayment();
                        }
                      },
                      child: _loading
                          ? Center(
                              child: CircularProgressIndicator(
                                  color: Colors.black))
                          : Text(
                              'Pay PKR ${widget.bike.price}',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: theme.buttonTheme.colorScheme?.onPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  ///------------- Widgets --------------------------///

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required ThemeData theme,
  }) {
    return TextField(
      controller: controller,
      onTapOutside: (p) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: 16),
        hintText: hint,
        hintStyle: TextStyle(color: theme.hintColor),
        prefixIcon: Icon(icon, color: theme.iconTheme.color),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      ),
    );
  }

  ///----------- Methods -------------///
  void makePayment() async {
     
      // context.read<PaymentCubit>().payWithEasypaisaAndStoreOrderDataToFirestore(
      //       context,
      //       accountNumber: accountNumberController,
      //       email: emailController,
      //       payment: widget.bike.price,
      //       bike: widget.bike,
      //       address: addressController,
      //       contact: contactController,
      //     );
  }
}
