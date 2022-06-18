import 'package:cashbook/ui/home/customer_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class PhoneBookScreen extends StatefulWidget {
  const PhoneBookScreen({Key? key}) : super(key: key);
  static const routeName = '/phonebook-screen';

  @override
  State<PhoneBookScreen> createState() => _PhoneBookScreenState();
}

class _PhoneBookScreenState extends State<PhoneBookScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: _theme.primaryColor,
        title: Text("Add Customer"),
        // actions: [mySwitch()],

        actions: [
          // IconButton(
          //     onPressed: () => Navigator.of(context).push(
          //           MaterialPageRoute(
          //             builder: (ctx) => HomeScreen(),
          //           ),
          //         ),
          //     icon: const Icon(Icons.home)),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(children: [
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Customer Name',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Phone Number',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // TextFormField(
            //   decoration: const InputDecoration(
            //     hintText: 'Remark',
            //     contentPadding:
            //         EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
            //     enabledBorder: OutlineInputBorder(
            //       borderRadius: BorderRadius.all(Radius.circular(20.0)),
            //       borderSide: BorderSide(
            //         color: Colors.grey,
            //       ),
            //     ),
            //     focusedBorder: OutlineInputBorder(
            //       borderRadius: BorderRadius.all(Radius.circular(20.0)),
            //       borderSide: BorderSide(color: Colors.blue),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            // Divider(),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     InkWell(
            //       child: Text(
            //         "Due Date :",
            //         style: Theme.of(context).textTheme.headline4,
            //       ),
            //     ),
            //     SizedBox(
            //       width: 50,
            //     ),
            //     InkWell(
            //       onTap: () async {
            //         final date = await showDatePicker(
            //             context: context,
            //             initialDate: DateTime.now(),
            //             firstDate: DateTime(2000, 8),
            //             lastDate: DateTime(2101));

            //         // transactionStore.setTransactionDate(date);
            //       },
            //       child: InkWell(
            //         // width: 10,
            //         child: Row(
            //           children: [
            //             const Icon(Icons.calendar_today),
            //             Observer(builder: (_) {
            //               return Padding(
            //                 padding:
            //                     const EdgeInsets.symmetric(horizontal: 3.0),
            //                 child: Text("27-5-2022"
            //                     // DateFormat('d-M-y')
            //                     //   .format(transactionStore.transactionDate)
            //                     ),
            //               );
            //             }),
            //             const Icon(Icons.arrow_drop_down_sharp),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // Divider()
            // payment(),
          ]),
        ),
      ),
      floatingActionButton: floatingActionButton2(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  floatingActionButton2() {
    ThemeData _theme = Theme.of(context);
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(CustomerList.routeName),
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Text('Save',
              style: _theme.textTheme.headline4!.copyWith(
                  // color: Colors.red,
                  ))),
    );
  }
}
