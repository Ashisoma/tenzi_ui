import 'package:cashbook/ui/home/add_customer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_switch/flutter_switch.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({Key? key}) : super(key: key);
  static const routeName = '/customer-list';

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  bool toggle = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _theme.primaryColor,
        // title: Text("Help & Support"),
        actions: [mySwitch()],
      ),
      body: toggle ? CreditView() : ToReceiveView(),
      // body:
    );
  }

  ToReceiveView() {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: Container(
          padding: EdgeInsets.all(12.0),
          child: SingleChildScrollView(
              child: Column(children: [
            // _bookAndTimeFilter(context),
            const SizedBox(height: 10.0),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Observer(
                builder: (_) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 250,
                            child: Column(
                              children: [
                                FittedBox(
                                  child: Text(
                                    'Total Amount to be Received',
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                ),
                                FittedBox(
                                  child: Text(
                                    'KES 2,453',
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      // cashInOutStatus(context),
                      // const SizedBox(height: 5.0),
                    ],
                  );
                },
              ),
            ),
            // customListVIew(),
            const SizedBox(height: 5.0),
            const Divider(),
            customListView1(),
            // const SizedBox(height: 30.0),
          ])),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: floatingActionButton(),
      ),
    );
  }

  CreditView() {
    ThemeData _theme = Theme.of(context);
    return Container(
      // backgroundColor:,
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: Container(
          // color: _theme.backgroundColor,
          padding: EdgeInsets.all(12.0),
          child: SingleChildScrollView(
              child: Column(children: [
            // _bookAndTimeFilter(context),
            const SizedBox(height: 10.0),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Observer(
                builder: (_) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 250,
                            child: Column(
                              children: [
                                FittedBox(
                                  child: Text(
                                    'Total Amount to Pay',
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                ),
                                FittedBox(
                                  child: Text(
                                    'KES 2,453',
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      // cashInOutStatus(context),
                      // const SizedBox(height: 5.0),
                    ],
                  );
                },
              ),
            ),
            // customListVIew(),
            const SizedBox(height: 5.0),
            const Divider(),
            customListView2(),
            // Expanded(
            //   child: Icon(Icons.add),
            // ),

            // const SizedBox(height: 30.0),
          ])),
        ),
        floatingActionButton: floatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  Widget floatingActionButton() {
    ThemeData _theme = Theme.of(context);
    return FloatingActionButton.extended(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.of(context).pushNamed(CustomerScreen.routeName);
        },
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
        label: Text(
          "Add Customer",
          style: TextStyle(color: Colors.white),
        ));
  }

  Widget mySwitch() {
    return FlutterSwitch(
      showOnOff: true,
      activeText: "To Pay",
      valueFontSize: 10.0,
      width: 110,
      inactiveText: "To Receive",
      activeColor: Colors.red,
      borderRadius: 20.0,
      value: toggle,
      inactiveColor: Colors.green,
      onToggle: (value) {
        setState(() {
          toggle = value;
        });
      },
    );
  }

  Widget customListView2() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 2, //_transactionsList.length,
        itemBuilder: (ctx, index) {
          // final Transaction _currentTransaction = _transactionsList[index];

          // String? currentDate =
          // DateFormat('d MMM y').format(_currentTransaction.date);

          double _balanceStatus = 0;

          // if (previousDate != currentDate || index == 0) {
          //   previousDate = currentDate;
          //   FunctionResponse _fResponse =
          //       _homeScreenStore.findBalanceStatusByDate(currentDate);
          //   // print('---- ${_fResponse.message}');
          //   _balanceStatus = _fResponse.data;
          // } else {
          //   currentDate = null;
          // }

          return GestureDetector(
            onTap: () {},
            //Navigator.of(context)
            // .pushNamed(TransactionDetailsScreen.routeName
            //arguments: {
            // 'transactionStore': _transactionStore,
            // 'transaction': _currentTransaction,
            // 'isCashIn': _currentTransaction.isCashIn,
            //}
            // ),
            child: Card(
                // key: ValueKey(_currentTransaction.id),
                child: Column(
              children: [
                // if (currentDate != null)
                // Container(
                //   padding: const EdgeInsets.all(8.0),
                //   color: Theme.of(context).primaryColorLight,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //         // currentDate,
                //         "12-12-12",
                //         style: const TextStyle(fontWeight: FontWeight.bold),
                //       ),
                //       Text("Balance KES 125.00"
                //           //'Balance ${_transactionStore.selectedCurrency} ${_balanceStatus.toStringAsFixed(2).priceCommas()}',
                //           )
                //     ],
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                            onTap: () {},
                            // child: ClipRRect(
                            //   borderRadius: BorderRadius.circular(30),
                            //   child: Image.asset(
                            //       'assets/images/default_user_image.png'),
                            // ),
                            // child: Image.asset(
                            //     'assets/images/default_user_image.png'),
                            child: CircleAvatar(
                              backgroundColor: Colors.green,
                              child: Center(
                                child: Text(
                                  "JD",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Column(
                            // crossAxisAlignment:
                            //     CrossAxisAlignment.center,
                            children: [
                              Text(
                                "John Doe",
                                // _currentTransaction.remarks
                                // .capitalize(),
                                // softWrap: true,
                                // maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              Chip(
                                backgroundColor: Colors.white,
                                //     .primaryColor
                                //     .withAlpha(10),
                                label: SizedBox(
                                  // width: 50,
                                  child: Text(
                                    // _cashCategoryStore
                                    //     .findCashCategoryById(
                                    //         _currentTransaction
                                    //             .category,
                                    //         _currentTransaction
                                    //             .isCashIn)
                                    //     .title
                                    //     .capitalize(),
                                    "+2547123456789",
                                    textAlign: TextAlign.center,
                                    // overflow: TextOverflow.ellipsis,
                                    // style: TextStyle(
                                    //   color: Colors.purple.shade200,
                                    // ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Column(
                            children: [
                              Observer(builder: (_) {
                                return Text(
                                  "KES 200",
                                  // '  ${_transactionStore.selectedCurrency} ${_currentTransaction.amount.toStringAsFixed(2).priceCommas()}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(
                                        color:
                                            // _currentTransaction.isCashIn
                                            // ? Colors.green
                                            Colors.red,
                                      ),
                                );
                              }),
                              Chip(
                                backgroundColor: Colors.white,
                                //     .primaryColor
                                //     .withAlpha(10),
                                label: SizedBox(
                                  // width: 50,
                                  child: Text(
                                    "21st May 2022",
                                    // _paymentModeStore
                                    //     .findPaymentModeById(
                                    //         _currentTransaction
                                    //             .paymentMode)
                                    //     .title
                                    //     .capitalize(),
                                    textAlign: TextAlign.center,
                                    // overflow: TextOverflow.ellipsis,
                                    // style: const TextStyle(
                                    //   color: Colors.brown,
                                    // ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
          );
        });
  }

  Widget customListView1() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 2, //_transactionsList.length,
        itemBuilder: (ctx, index) {
          // final Transaction _currentTransaction = _transactionsList[index];

          // String? currentDate =
          // DateFormat('d MMM y').format(_currentTransaction.date);

          double _balanceStatus = 0;

          // if (previousDate != currentDate || index == 0) {
          //   previousDate = currentDate;
          //   FunctionResponse _fResponse =
          //       _homeScreenStore.findBalanceStatusByDate(currentDate);
          //   // print('---- ${_fResponse.message}');
          //   _balanceStatus = _fResponse.data;
          // } else {
          //   currentDate = null;
          // }

          return GestureDetector(
            onTap: () {},
            //Navigator.of(context)
            // .pushNamed(TransactionDetailsScreen.routeName
            //arguments: {
            // 'transactionStore': _transactionStore,
            // 'transaction': _currentTransaction,
            // 'isCashIn': _currentTransaction.isCashIn,
            //}
            // ),
            child: Card(
                // key: ValueKey(_currentTransaction.id),
                child: Column(
              children: [
                // if (currentDate != null)
                // Container(
                //   padding: const EdgeInsets.all(8.0),
                //   color: Theme.of(context).primaryColorLight,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //         // currentDate,
                //         "12-12-12",
                //         style: const TextStyle(fontWeight: FontWeight.bold),
                //       ),
                //       Text("Balance KES 125.00"
                //           //'Balance ${_transactionStore.selectedCurrency} ${_balanceStatus.toStringAsFixed(2).priceCommas()}',
                //           )
                //     ],
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                            onTap: () {},
                            // child: ClipRRect(
                            //   borderRadius: BorderRadius.circular(30),
                            //   child: Image.asset(
                            //       'assets/images/default_user_image.png'),
                            // ),
                            // child: Image.asset(
                            //     'assets/images/default_user_image.png'),
                            child: CircleAvatar(
                              backgroundColor: Colors.green,
                              child: Center(
                                child: Text(
                                  "JD",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Column(
                            // crossAxisAlignment:
                            //     CrossAxisAlignment.center,
                            children: [
                              Text(
                                "John Doe",
                                // _currentTransaction.remarks
                                // .capitalize(),
                                // softWrap: true,
                                // maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              Chip(
                                backgroundColor: Colors.white,
                                //     .primaryColor
                                //     .withAlpha(10),
                                label: SizedBox(
                                  // width: 50,
                                  child: Text(
                                    // _cashCategoryStore
                                    //     .findCashCategoryById(
                                    //         _currentTransaction
                                    //             .category,
                                    //         _currentTransaction
                                    //             .isCashIn)
                                    //     .title
                                    //     .capitalize(),
                                    "+2547123456789",
                                    textAlign: TextAlign.center,
                                    // overflow: TextOverflow.ellipsis,
                                    // style: TextStyle(
                                    //   color: Colors.purple.shade200,
                                    // ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Column(
                            children: [
                              Observer(builder: (_) {
                                return Text(
                                  "KES 200",
                                  // '  ${_transactionStore.selectedCurrency} ${_currentTransaction.amount.toStringAsFixed(2).priceCommas()}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(
                                        color:
                                            // _currentTransaction.isCashIn
                                            // ? Colors.green
                                            Colors.green,
                                      ),
                                );
                              }),
                              Chip(
                                backgroundColor: Colors.white,
                                //     .primaryColor
                                //     .withAlpha(10),
                                label: SizedBox(
                                  // width: 50,
                                  child: Text(
                                    "21st May 2022",
                                    // _paymentModeStore
                                    //     .findPaymentModeById(
                                    //         _currentTransaction
                                    //             .paymentMode)
                                    //     .title
                                    //     .capitalize(),
                                    textAlign: TextAlign.center,
                                    // overflow: TextOverflow.ellipsis,
                                    // style: const TextStyle(
                                    //   color: Colors.brown,
                                    // ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
          );
        });
  }

  Widget customListVIew() {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.all(20),
          leading: Observer(builder: (_) {
            return InkWell(
              onTap: () async {
                // await _uploadImage(context);
              },
              // child: _profileStore.image != ''
              child:
                  //  ?CircleAvatar(
                  //     radius: 30,
                  //     backgroundImage:
                  //         NetworkImage(_profileStore.image),
                  //     backgroundColor: Colors.transparent,
                  //   ):
                  ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset('assets/images/default_user_image.png'),
              ),
            );
          }),
          title: Observer(builder: (_) {
            // return Text(_profileStore.name);
            return Text(" cust_ name");
          }),
          // subtitle: Text(_profileStore.phone),
          subtitle: Text("phone number"),
          trailing: IconButton(
            onPressed: () {
              // showDialog(
              //     context: context,
              //     builder: (ctx) => AlertDialog(
              //           content: Column(
              //             mainAxisSize: MainAxisSize.min,
              //             children: [
              //               const Text('Update Name'),
              //               const SizedBox(height: 10),
              //               TextField(
              //                 controller: _nameController,
              //                 decoration: const InputDecoration(
              //                   hintText: 'Full Name ',
              //                   contentPadding:
              //                       EdgeInsets.symmetric(
              //                           vertical: 2.0,
              //                           horizontal: 8.0),
              //                   enabledBorder:
              //                       OutlineInputBorder(
              //                     borderRadius:
              //                         BorderRadius.all(
              //                             Radius.circular(
              //                                 20.0)),
              //                     borderSide: BorderSide(
              //                       color: Colors.grey,
              //                     ),
              //                   ),
              //                   focusedBorder:
              //                       OutlineInputBorder(
              //                     borderRadius:
              //                         BorderRadius.all(
              //                             Radius.circular(
              //                                 20.0)),
              //                     borderSide: BorderSide(
              //                         color: Colors.blue),
              //                   ),
              //                 ),
              //               ),
              //               const SizedBox(height: 10),
              //               Observer(builder: (_) {
              //                 return ElevatedButton(
              //                     onPressed: () async {
              //                       //Show Loader
              //                       _customAlerts
              //                           .showLoaderDialog(
              //                               context);
              //                       FunctionResponse _response =
              //                           await _profileStore
              //                               .updateProfileName(
              //                                   _nameController
              //                                       .text);
              //                       //Pop Loader
              //                       Navigator.of(context).pop();
              //                       _customAlerts.showSnackBar(
              //                           _response.message,
              //                           context,
              //                           success:
              //                               _response.success);

              //                       Navigator.of(context).pop();
              //                     },
              //                     child: const Text('Update'));
              //               }),
              //             ],
              //           ),
              // ));
            },
            icon: const Icon(Icons.edit),
          ),
        ),
      ],
    );
  }
}
