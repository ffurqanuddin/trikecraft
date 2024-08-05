import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trikecraft/logic/payment/payment_cubit.dart';
import 'package:trikecraft/models/bike_model.dart';
import 'package:url_launcher/url_launcher.dart';

class P2PPaymentPage extends StatefulWidget {
  P2PPaymentPage({required this.bike});
  final BikeModel bike;

  @override
  State<P2PPaymentPage> createState() => _P2PPaymentPageState();
}

class _P2PPaymentPageState extends State<P2PPaymentPage> {
  late TextEditingController transactionController;
  late TextEditingController amountController;
  late TextEditingController commentsController;
  late TextEditingController contactInfoController;
  late TextEditingController paymentMethodController;
  late TextEditingController accountNameController;

  @override
  void initState() {
    super.initState();
    transactionController = TextEditingController();
    amountController = TextEditingController(text: "${widget.bike.price}");
    commentsController = TextEditingController(text: "No Comments");
    contactInfoController = TextEditingController();
    paymentMethodController = TextEditingController();
    accountNameController = TextEditingController();
  }

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          title: Text('How P2P Payment Works'),
          content: Text(
              'P2P (Peer-to-Peer) payments allow users to send funds directly to another person without the need for intermediaries like banks. '
              'Here’s how it works:\n\n'
              '1. Transfer the specified amount to the provided account details using your preferred payment method.\n'
              '2. Once the payment is completed, enter the transaction ID provided by your payment method.\n'
              '3. Click on "Confirm Payment" to submit the payment details.\n'
              '4. The payment will be verified and processed by the system.\n\n'
              'This method is secure, and the details are only visible to the involved parties.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _pasteTransactionID() async {
    ClipboardData? clipboardData = await Clipboard.getData('text/plain');
    if (clipboardData != null) {
      transactionController.text = clipboardData.text ?? '';
    }
  }

  void _launchWhatsApp() async {
    final Uri whatsappUri = Uri(
      scheme: 'https',
      host: 'wa.me',
      path: '923201982284',
    );
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri);
    } else {
      Fluttertoast.showToast(
          msg: 'Could not launch WhatsApp', backgroundColor: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Row(
          children: [
            Text('P2P Payment'),
            Spacer(),
            IconButton(
              icon: Icon(Icons.info_outline, color: theme.iconTheme.color),
              onPressed: _showInfoDialog,
            ),
            IconButton(
              icon: FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green),
              onPressed: _launchWhatsApp,
              tooltip: 'Need Help?',
            ),
          ],
        ),
        elevation: 0,
      ),
      body: BlocConsumer<PaymentCubit, PaymentState>(
        listener: (context, pState) {
          if (pState is PaymentSuccessState) {
            Fluttertoast.showToast(
                msg: "Order is submitted", backgroundColor: Colors.green);
            Navigator.pop(context);
            Navigator.pop(context);
          }

          if (pState is PaymentFailureState) {
            Fluttertoast.showToast(
                msg: pState.message, backgroundColor: Colors.red);
          }
        },
        builder: (context, pState) {
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Account Information
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Payment Information',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(Icons.account_circle,
                                color: theme.iconTheme.color),
                            title: Text('Ghulam Mustafa',
                                style: theme.textTheme.bodyLarge),
                            subtitle: Text('Account Name',
                                style: theme.textTheme.labelSmall),
                          ),
                          ListTile(
                            leading: Icon(Icons.account_balance,
                                color: theme.iconTheme.color),
                            title: Text('Easypaisa',
                                style: theme.textTheme.bodyLarge),
                            subtitle: Text('Bank Name',
                                style: theme.textTheme.labelSmall),
                          ),
                          ListTile(
                            leading: Icon(Icons.confirmation_number,
                                color: theme.iconTheme.color),
                            title: Text('03201982284',
                                style: theme.textTheme.bodyLarge),
                            subtitle: Text('Account Number',
                                style: theme.textTheme.labelSmall),
                            trailing: IconButton(
                              icon: Icon(Icons.copy,
                                  color: theme.iconTheme.color),
                              onPressed: () {
                                Clipboard.setData(
                                    ClipboardData(text: '03201982284'));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Account Number copied to clipboard'),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),

                  // User Contact Information
                  TextField(
                    controller: contactInfoController,
                    decoration: InputDecoration(
                      labelText: 'Your Mobile Number or Account Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      prefixIcon:
                          Icon(Icons.phone, color: theme.iconTheme.color),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 20),

                  // Payment Method
                  TextField(
                    controller: paymentMethodController,
                    decoration: InputDecoration(
                      labelText: 'Payment Method',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      prefixIcon:
                          Icon(Icons.payment, color: theme.iconTheme.color),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Account Name
                  TextField(
                    controller: accountNameController,
                    decoration: InputDecoration(
                      labelText: 'Account Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      prefixIcon: Icon(Icons.account_circle,
                          color: theme.iconTheme.color),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Transaction ID Input with Paste Option
                  TextField(
                    controller: transactionController,
                    decoration: InputDecoration(
                      labelText: 'Transaction ID',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      prefixIcon:
                          Icon(Icons.receipt, color: theme.iconTheme.color),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.paste, color: theme.iconTheme.color),
                        onPressed: _pasteTransactionID,
                        tooltip: 'Paste',
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Amount Input
                  TextField(
                    controller: amountController,
                    decoration: InputDecoration(
                      labelText: 'Amount',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      prefixIcon: Icon(FontAwesomeIcons.rupeeSign,
                          color: theme.iconTheme.color),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Comments Input
                  TextField(
                    controller: commentsController,
                    decoration: InputDecoration(
                      labelText: 'Comments (Optional)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      prefixIcon:
                          Icon(Icons.comment, color: theme.iconTheme.color),
                    ),
                  ),
                  SizedBox(height: 30),

                  //loading
                  if (pState is PaymentLoadingState)
                    Center(
                        child: SizedBox(
                      height: 50,
                      width: 50,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )),
                  // Confirm Payment Button
                  if (pState is! PaymentLoadingState)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Trigger payment confirmation process
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                title: Text('Confirm Payment'),
                                content: Text(
                                    'Are you sure you want to confirm this payment?'),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Cancel"),
                                  ),
                                  ElevatedButton(
                                    // In the onPressed of the Confirm button
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      // Implement the payment process logic here
                                      context
                                          .read<PaymentCubit>()
                                          .initializePaymentDetails(
                                            transactionId: transactionController
                                                .text
                                                .trim(),
                                            senderName: accountNameController
                                                .text
                                                .trim(),
                                            contactInfo: contactInfoController
                                                .text
                                                .trim(),
                                            paymentMethod:
                                                paymentMethodController.text
                                                    .trim(),
                                            accountName: accountNameController
                                                .text
                                                .trim(),
                                            amount:
                                                amountController.text.trim(),
                                            bike: widget.bike,
                                          );
                                      context
                                          .read<PaymentCubit>()
                                          .payWithP2P(context);
                                    },

                                    child: Text('Confirm'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: theme.primaryColor,
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text('Confirm Payment'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  SizedBox(height: 20),

                  // Transaction Processing Message
                  Text(
                    'The confirmation of this transaction will take up to 30 minutes. Please be patient and check your order status in the "My Orders" tab. Initially, it will be marked as pending. Our team will contact you shortly.',
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: Colors.grey[700]),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
