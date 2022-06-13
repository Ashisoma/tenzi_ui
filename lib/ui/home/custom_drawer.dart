import 'dart:io';

import 'package:cashbook/constants/function_response.dart';
import 'package:cashbook/helpers/shared_preferences_helper.dart';
import 'package:cashbook/stores/book_store.dart';
import 'package:cashbook/stores/home_screen_store.dart';
import 'package:cashbook/stores/profile_store.dart';
import 'package:cashbook/stores/transaction_store.dart';
import 'package:cashbook/ui/auth_screen/login_screen.dart';
import 'package:cashbook/ui/auth_screen/validate_phone_screen.dart';
import 'package:cashbook/ui/home/credit_screen.dart';
import 'package:cashbook/ui/profile/help_screen.dart';
import 'package:cashbook/ui/profile/user_profile_screen.dart';
import 'package:cashbook/utils/connectivity_helper.dart';
import 'package:cashbook/utils/custom_alerts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../service_locator.dart';

class CustomDrawer extends StatefulWidget {
  CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
//Stores
  final HomeScreenStore _homeScreenStore = getIt<HomeScreenStore>();
  final BookStore _bookStore = getIt<BookStore>();
  final TransactionStore _transactionStore = getIt<TransactionStore>();
  final ProfileStore _profileStore = getIt<ProfileStore>();

  //Storage Helpers
  final SharedPreferencesHelper _sharedPreferencesHelper =
      getIt<SharedPreferencesHelper>();
//Utilities
  final CustomAlerts _customAlerts = getIt<CustomAlerts>();
  final ConnectivityHelper _connectivityHelper = getIt<ConnectivityHelper>();

  Future<void> _userLogout(BuildContext context) async {
    FunctionResponse _fResponse = getIt<FunctionResponse>();

    _customAlerts.showLoaderDialog(context);

    _fResponse = await _connectivityHelper.checkInternetConnection();
    if (_fResponse.success) {
      _fResponse = await _homeScreenStore.userLogout();
      if (_fResponse.success) {
        _fResponse.message = 'Logout successful';

        //popLoader
        Navigator.of(context).pop();
        _customAlerts.showSnackBar(_fResponse.message, context,
            success: _fResponse.success);
        Navigator.of(context)
            .pushReplacementNamed(ValidatePhoneScreen.routeName);
      }
    } else {
      //popLoader
      Navigator.of(context).pop();
      //popDrawer
      Navigator.of(context).pop();

      _customAlerts.showSnackBar(_fResponse.message, context,
          success: _fResponse.success);
    }
  }

  Future<void> _backupData(BuildContext context) async {
    FunctionResponse _fResponse = getIt<FunctionResponse>();
    String syncDate = 'No record';

    _customAlerts.showLoaderDialog(context);

    _fResponse = await _connectivityHelper.checkInternetConnection();
    if (_fResponse.success) {
      _fResponse = await _sharedPreferencesHelper.getLastSync();
      if (_fResponse.success) {
        syncDate = _fResponse.data;
      }
      _fResponse = await _customAlerts.confirmAction(
        context: context,
        title: 'Backup Confirmation',
        message: 'Last Sync Date : $syncDate',
      );
      print(_fResponse.message);
      if (_fResponse.success) {
        await _homeScreenStore.uploadAllData();
        _transactionStore.clearTransactions();
        _bookStore.downloadedBookList.clear();
        //set sync date
        await _sharedPreferencesHelper
            .setLastSync(DateFormat('h:mm a d MMM y').format(DateTime.now()));

        await _transactionStore.fetchAndSetTransactions();
        _fResponse.success = true;
        _fResponse.message = 'Data Backup successful';
      }
    }
    //pop loader
    Navigator.of(context).pop();
    //popDrawer
    Navigator.of(context).pop();

    _customAlerts.showSnackBar(_fResponse.message, context,
        success: _fResponse.success);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              height: 150,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              width: double.infinity,
              child: Center(
                  child: Image.asset(
                'assets/images/tenziBook_splash_image.png',
                fit: BoxFit.contain,
              )),
              // color: Theme.of(context).primaryColor,
            ),
            InkWell(
              onTap: () =>
                  Navigator.of(context).pushNamed(UserProfileScreen.routeName),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListTile(
                  // contentPadding:
                  //     EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
                  leading: const Icon(Icons.manage_accounts),
                  title: Text(
                    'Settings',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Share.share(
                    'Try TenziBook to manage your cash flow. https://play.google.com/store/apps/details?id=com.tenzilabs.tenzibook',
                    subject: 'Check out this amazing app!');
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListTile(
                  // contentPadding:
                  //     EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
                  leading: const Icon(Icons.group_add),
                  title: Text(
                    'Share App',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              ),
            ),
            Observer(builder: (_) {
              return InkWell(
                onTap: () async {
                  await _backupData(context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListTile(
                    // contentPadding:
                    //     EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
                    leading: const Icon(Icons.upload),
                    title: Text(
                      'Backup Data',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ),
              );
            }),
            InkWell(
              onTap: _showBottomSheet,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListTile(
                  // contentPadding:
                  //     EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
                  leading: const Icon(Icons.feedback),
                  title: Text(
                    'Feedback',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              ),
            ),
            // InkWell(
            //   onTap: () =>
            //       Navigator.of(context).pushNamed(CreditScreen.routeName),
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //     child: ListTile(
            //       // contentPadding:
            //       //     EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
            //       leading: const Icon(Icons.manage_accounts),
            //       title: Text(
            //         'CreditScreen',
            //         style: Theme.of(context).textTheme.headline5,
            //       ),
            //     ),
            //   ),
            // ),
            InkWell(
              onTap: () async {
                await _userLogout(context);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListTile(
                  // contentPadding:
                  //     EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
                  leading: const Icon(Icons.logout),
                  title: Text(
                    'Logout',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              ),
            ),
            // const SizedBox.expand(),
            const Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: Text('Version 1.0.4'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _buildBottomNavigation() {
    return Column(
      children: <Widget>[
        const Center(
          child: ListTile(
            dense: true,
            title: Text("Submit Feedback"),
          ),
        ),
        ListTile(
          dense: true,
          leading: const Icon(
            Icons.email_outlined,
            color: Colors.redAccent,
          ),
          title: const Text("Email"),
          onTap: sendEmailFeedback,
        ),
        ListTile(
          dense: true,
          leading: const Icon(
            Icons.whatsapp_outlined,
            color: Colors.green,
          ),
          title: const Text("Whatsapp"),
          onTap: openWhatsapp,
        )
      ],
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            // color: Color(0xFF737373),
            height: 150,
            child: Container(
              child: _buildBottomNavigation(),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              )),
            ),
          );
        });
  }

  openWhatsapp() async {
    var whatsapp = "+254794791532";
    var whatsappURlAndroid =
        "whatsapp://send?phone=" + whatsapp + "&text=Hello";
    var whatappURLIos = "https://wa.me/$whatsapp?text=${Uri.parse("Hello")}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappURLIos)) {
        await launch(whatappURLIos, forceSafariVC: false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("Whatsapp not installed")));
      }
    } else {
      // android , web
      if (await canLaunch(whatsappURlAndroid)) {
        await launch(whatsappURlAndroid);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("Whatsapp not installed")));
      }
    }
    Navigator.pop(context);
  }

  sendEmailFeedback() async {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'tenzilabs@gmail.com',
      query: encodeQueryParameters(<String, String>{'subject': 'FeedBack '}),
    );

    launch(emailLaunchUri.toString());
    Navigator.pop(context);
  }
}
