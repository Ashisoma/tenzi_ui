import 'package:cashbook/ui/home/credit_screen.dart';
import 'package:cashbook/ui/home/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

// todo: change this name to customerprofilesecreen
class CustomerScreen extends StatefulWidget {
  const CustomerScreen({Key? key}) : super(key: key);
  static const routeName = '/customer-screen';

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: _theme.primaryColor,
        // title: Text("Help & Support"),
        // actions: [mySwitch()],

        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => HomeScreen(),
                    ),
                  ),
              icon: const Icon(Icons.home)),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: Stack(
                children: [
                  Positioned(
                      // top: 0,
                      left: 0,
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      child: Container(
                          height: 30,
                          padding: EdgeInsetsDirectional.all(35),
                          child: SizedBox(
                            child: ListTile(
                              leading: Observer(builder: (_) {
                                return InkWell(
                                  onTap: () {},
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image.asset(
                                        'assets/images/default_user_image.png'),
                                  ),
                                );
                              }),
                              title: Observer(builder: (_) {
                                return Text(
                                  "John Smith",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                );
                              }),
                              subtitle: Text(
                                "254712345678",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            // borderRadius: BorderRadius.circular(20),
                            // border: Border.all(width: 3.0, color: Colors.black),
                          ))),
                  Positioned(
                      top: 120,
                      // left: 100,
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 50),
                                  Center(
                                      child: Text(
                                    "Outstanding Amount KES 4500.00",
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ))
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MaterialButton(
                                    onPressed: () {},
                                    color: Colors.blue,
                                    textColor: Colors.white,
                                    child: Icon(Icons.message),
                                    padding: EdgeInsets.all(3),
                                    shape: CircleBorder(),
                                  ),
                                  MaterialButton(
                                    onPressed: () {},
                                    color: Colors.green,
                                    textColor: Colors.white,
                                    child: Icon(Icons.whatsapp),
                                    padding: EdgeInsets.all(3),
                                    shape: CircleBorder(),
                                  ),
                                  MaterialButton(
                                    onPressed: () {},
                                    color: Colors.red,
                                    textColor: Colors.white,
                                    child: Icon(Icons.mail),
                                    padding: EdgeInsets.all(3),
                                    shape: CircleBorder(),
                                  ),
                                ],
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      )),
                ],
              ),
            ),

            // child: Text("Hello world"),
            Flexible(
              child: ListView.builder(
                  itemCount: 2, //_transactionsList.length,
                  itemBuilder: (ctx, index) {
                    return GestureDetector(
                      child: Card(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Text(
                                        "28",
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                      ),
                                      Text(
                                        "May",
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                      ),
                                      // Text("May")
                                    ],
                                  ),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Container(
                                    color: Colors.red,
                                    height: 50,
                                    width: 3,
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Balance:   KES 2500",
                                            // _currentTransaction.remarks
                                            // .capitalize(),
                                            // softWrap: true,
                                            // maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Total:   KES 2500",
                                            // _currentTransaction.remarks
                                            // .capitalize(),
                                            // softWrap: true,
                                            // maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Due date:   8 June 2022",
                                            // _currentTransaction.remarks
                                            // .capitalize(),
                                            // softWrap: true,
                                            // maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: floatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget debtList() {
    return Container(
      child: ListView.builder(
          // shrinkWrap: true,
          // physics: const NeverScrollableScrollPhysics(),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
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
          }),
    );
  }

  Widget floatingActionButton() {
    ThemeData _theme = Theme.of(context);
    return FloatingActionButton.extended(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.of(context).pushNamed(CreditScreen.routeName);
        },
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
        label: Text(
          "Add Transaction",
          style: TextStyle(color: Colors.white),
        ));
  }
}
