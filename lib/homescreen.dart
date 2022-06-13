import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeData _theme = ThemeData.light();
    // return SafeArea(
    //   child: GestureDetector(
    //     onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
    //     child: _homeScreenStore.isDownloadingAllData
    //         ? Scaffold(
    //             body: Center(
    //                 child: Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 Text(
    //                   _homeScreenStore.needDataDownload
    //                       ? 'Syncing Data with Cloud'
    //                       : 'Fetching Books',
    //                   style: Theme.of(context).textTheme.headline5,
    //                 ),
    //                 const SizedBox(width: 10),
    //                 const CircularProgressIndicator(),
    //               ],
    //             )),
    //           )
    //         : _homeScreenContents(context, _theme),
    //   ),
    // );
    return _homeScreenContents(context, _theme);
  }

    Scaffold _homeScreenContents(BuildContext context, ThemeData _theme) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
      //   actions: [
      //     IconButton(
      //       onPressed: () {}
      //       // Navigator.of(context).push(
      //         MaterialPageRoute(
      //           // builder: (ctx) => ReportingScreen(),
      //         ),
      //       ),
      //       icon: const Icon(Icons.pie_chart_rounded),
      //     ),
      //   ],
      // ),
      // drawer: CustomDrawer(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // _bookAndTimeFilter(context),
              const SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  // builder: (_) {
                     child:Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 250,
                              child: FittedBox(
                                child: Text(
                                  'Balance KES 123.00',
                                  // 'Balance ${_transactionStored.selectedCurrency} ${_homeScreenStore.balance.toStringAsFixed(2).priceCommas()}',
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30.0),
                        // cashInOutStatus(context),
                        const SizedBox(height: 5.0),
                      ],
                    ),
                )
              ),
                  
                
              
              const SizedBox(height: 30.0),
              const Divider(),
              // _searchAndFilter(context),
              const Divider(),
              const SizedBox(height: 20.0),
              // TransactionsView(
              //     //Transaction ListViewBuilder
              //     // transactionStore: transactionStore,
              //     ),
              const SizedBox(height: 80.0),
            ],
          ),
          ),
          
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
      // floatingActionButton: _homeScreenStore.bookStore.selectedBook == null
      //     ? null
      //     : _floatingButtons(context),
    
  }

  Widget _floatingButtons(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 15.0),
        Expanded(
          child: ElevatedButton.icon(
            // key: _cashInBtnKey,
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                )),
            onPressed: () {
              // _homeScreenStore.setTransactionDefaults(
              //     true, null, null, null, null, null, null);
              // _homeScreenStore.selectedTransactionCategoryType(true);
              // Navigator.of(context)
              //     .pushNamed(ManageTransaction.routeName, arguments: {
              //   'transactionStore': getIt<TransactionStore>(),
              //   'isCashIn': true,
              //   'id': null,
              // });
            },
            icon: const Icon(
              Icons.arrow_circle_down,
              color: Colors.white70,
            ),
            label: const Text(
              'Cash In',
            ),
          ),
        ),
        const SizedBox(width: 15.0),
        Expanded(
          child: ElevatedButton.icon(
            // key: _cashOutBtnKey,
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                )),
            onPressed: () {
              // _homeScreenStore.setTransactionDefaults(
              //     false, null, null, null, null, null, null);
              // _homeScreenStore.selectedTransactionCategoryType(false);

              // Navigator.of(context)
              //     .pushNamed(ManageTransaction.routeName, arguments: {
              //   'transactionStore': getIt<TransactionStore>(),
              //   'isCashIn': false,
              //   'id': null,
              // });
            },
            icon: const Icon(
              Icons.arrow_circle_up,
              color: Colors.white70,
            ),
            label: const Text(
              'Cash Out',
            ),
          ),
        ),
        const SizedBox(width: 15.0),
      ],
    );
  }
}
