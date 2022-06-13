import 'dart:io';

import 'package:cashbook/stores/payment_mode_store.dart';
import 'package:cashbook/stores/transaction_store.dart';
import 'package:cashbook/ui/home/customer_list.dart';
import 'package:cashbook/utils/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:cashbook/models/transaction.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../service_locator.dart';
import '../../stores/cash_category_store.dart';
import '../../utils/connectivity_helper.dart';
import '../../utils/custom_alerts.dart';
import '../../utils/image_helper.dart';
import '../manage_transaction/add_payment_mode.dart';
import '../manage_transaction/choose_remark_screen.dart';
import '../manage_transaction/image_view_screen.dart';

class CreditScreen extends StatefulWidget {
  CreditScreen({Key? key}) : super(key: key);
  static const routeName = '/credit-screen';

  final PaymentModeStore _paymentModeStore = getIt<PaymentModeStore>();
  final CustomImageHelper _customImageHelper = getIt<CustomImageHelper>();
  final CustomAlerts _customAlerts = getIt<CustomAlerts>();
  final ConnectivityHelper _connectivityHelper = getIt<ConnectivityHelper>();

  @override
  State<CreditScreen> createState() => _CreditScreenState();
}

class _CreditScreenState extends State<CreditScreen> {
  final _formKey = GlobalKey<FormState>();
  TransactionStore? transactionStore;
  bool? isCashIn;
  Transaction? transaction;
  bool toggle = false;

//Stores
  final CashCategoryStore _categoryStore = getIt<CashCategoryStore>();

  Transaction formData = Transaction(
    id: 0,
    bookId: 0,
    remarks: '',
    category: 0,
    amount: 0,
    paymentMode: 0,
    date: DateTime.now(),
    isCashIn: false,
    imagePath: '',
    isSynced: false,
    isEdited: false,
  );

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
      floatingActionButton: floatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget floatingActionButton() {
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

  Widget _selectDateAndTime() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () async {
            final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000, 8),
                lastDate: DateTime(2101));

            // transactionStore.setTransactionDate(date);
          },
          child: Row(
            children: [
              const Icon(Icons.calendar_today),
              Observer(builder: (_) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: Text("27-5-2022"
                      // DateFormat('d-M-y')
                      //   .format(transactionStore.transactionDate)
                      ),
                );
              }),
              const Icon(Icons.arrow_drop_down_sharp),
            ],
          ),
        ),
        InkWell(
          onTap: () async {
            final time = await showTimePicker(
              context: context,
              // initialTime: transactionStore.transactionTime,
              initialTime: TimeOfDay.now(),
            );
            // transactionStore.setTransactionTime(time);
          },
          child: Row(
            children: [
              const Icon(Icons.access_time_sharp),
              Observer(builder: (_) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: Text("11:46 AM"
                      // transactionStore.transactionTime.format(context)
                      ),
                );
              }),
              const Icon(Icons.arrow_drop_down_sharp),
            ],
          ),
        ),
      ],
    );
  }

  Widget _form()
  // BuildContext context,
  // TransactionStore transactionStore,
  // bool isCashIn,
  // Transaction? transaction,
  // ThemeData _theme,
  // CustomImageHelper _)
  {
    ThemeData _theme = Theme.of(context);

    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              validator: (String? val) {
                if (val == null) {
                  return ' Enter and amount';
                } else if (double.tryParse(val) == null) {
                  return "Enter a valid amount";
                }
              },
              onSaved: (String? val) {
                formData.amount = double.tryParse(val!) ?? 0;
              },
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              initialValue: transaction?.amount.toStringAsFixed(2),
              decoration: const InputDecoration(
                hintText: 'Amount',
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
            const SizedBox(height: 20),
            Observer(builder: (_) {
              // print('text field observer ${transactionStore.currentRemark}');
              return TextFormField(
                // key: Key(transactionStore.currentRemark),
                // initialValue: transactionStore.currentRemark,
                validator: (String? val) {
                  if (val == null || val.isEmpty) {
                    return 'Please Enter remarks';
                  }
                },
                onSaved: (String? val) {
                  formData.remarks = val ?? '';
                },
                inputFormatters: [
                  // UpperCaseTextFormatter(),
                ],
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () => showModalBottomSheet(
                      context: context,
                      builder: (context) => ChooseRemarkScreen(
                        isCashIn: _categoryStore
                            .selectedTransactionCategoryType, // widget
                        // ._categoryStore.selectedTransactionCategoryType,
                      ),
                    ),
                    icon: const Icon(Icons.menu),
                  ),
                  hintText: 'Remark',
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 2.0, horizontal: 8.0),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              );
            }),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {},
              // Navigator.of(context)
              //     .pushNamed(ChooseCategoryView.routeName, arguments: {
              //   'transactionStore': transactionStore,
              //   'isCashIn':
              //       widget._categoryStore.selectedTransactionCategoryType,
              // }),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 8.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Observer(builder: (_) {
                        return Row(
                          // mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 100,
                              child: Text(""
                                  // widget._categoryStore.selectedCategory?.title
                                  //         .capitalize() ??
                                  //     'Undefined',
                                  // overflow: TextOverflow.ellipsis,
                                  // style: _theme.textTheme.headline6),
                                  ),
                            ),
                            const Icon(Icons.arrow_drop_down_sharp),
                          ],
                        );
                      }),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(top: 12.0, right: 8.0),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              // await _pickUserImage(context, transactionStore);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Attach Image',
                                  // style: _theme.textTheme.headline5
                                ),
                                const SizedBox(width: 8.0),
                                const Icon(Icons.camera_alt_outlined),
                              ],
                            ),
                          ),
                          Observer(builder: (_) {
                            return showImage(context, _theme, transactionStore!,
                                widget._customImageHelper);
                          }),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Observer(
              builder: (_) {
                return Column(
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Payment Modes',
                          style: _theme.textTheme.headline3,
                        ),
                        const Expanded(child: SizedBox()),
                        IconButton(
                          onPressed: widget._paymentModeStore.isLoading
                              ? null
                              : () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => AddPaymenModeScreen(
                                            editablePaymentMode: null,
                                          )));
                                },
                          icon: Icon(
                            Icons.add,
                            color: Colors.green.shade700,
                          ),
                        ),
                        IconButton(
                          onPressed: widget._paymentModeStore.isLoading
                              ? null
                              : () {
                                  if (widget._paymentModeStore
                                          .selectedPaymentMode ==
                                      null) {
                                    widget._customAlerts.showSnackBar(
                                        'Please select a Payment Mode to edit',
                                        context);
                                  } else if (widget._paymentModeStore
                                          .selectedPaymentMode!.id ==
                                      1) {
                                    widget._customAlerts.showSnackBar(
                                        'Cannot edit default Payment Mode',
                                        context);
                                  } else {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                AddPaymenModeScreen(
                                                  editablePaymentMode: widget
                                                      ._paymentModeStore
                                                      .selectedPaymentMode,
                                                )));
                                  }
                                },
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: widget._paymentModeStore.isLoading
                              ? null
                              : () async {
                                  if (widget._paymentModeStore
                                          .selectedPaymentMode ==
                                      null) {
                                    widget._customAlerts.showSnackBar(
                                        'Please select a category to delete',
                                        context);
                                  } else if (widget._paymentModeStore
                                          .selectedPaymentMode!.id ==
                                      1) {
                                    widget._customAlerts.showSnackBar(
                                        'Cannot delete default Payment Mode',
                                        context);
                                  } else {
                                    // await _deletePaymentMode(context);
                                  }
                                },
                          icon: Icon(Icons.delete,
                              color: _theme.colorScheme.error),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Wrap(
                            spacing: 3.0, // gap between adjacent chips
                            runSpacing: 1.0,

                            children: <Widget>[
                              ...widget._paymentModeStore.paymentModeList
                                  .map((e) => GestureDetector(
                                        onTap: () => widget._paymentModeStore
                                            .setSelectedPaymentMode(e),
                                        child: Observer(builder: (_) {
                                          return Chip(
                                            padding: const EdgeInsets.all(1),
                                            labelPadding:
                                                const EdgeInsets.all(2),
                                            key: ValueKey(e.id),
                                            label: SizedBox(
                                              width: 60,
                                              child: Text(
                                                e.title.capitalize(),
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                                style: _theme
                                                    .textTheme.headline6!
                                                    .copyWith(
                                                        color: Colors.white),
                                              ),
                                            ),
                                            backgroundColor: e.id ==
                                                    widget._paymentModeStore
                                                        .selectedPaymentMode?.id
                                                ? Colors.blueAccent
                                                : Colors.grey.shade700,
                                          );
                                        }),
                                      ))
                                  .toList()
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ));
  }

  Widget payment() {
    ThemeData _theme = Theme.of(context);
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Payment Modes',
              style: _theme.textTheme.headline3,
            ),
            const Expanded(child: SizedBox()),
            IconButton(
              onPressed: widget._paymentModeStore.isLoading
                  ? null
                  : () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => AddPaymenModeScreen(
                                editablePaymentMode: null,
                              )));
                    },
              icon: Icon(
                Icons.add,
                color: Colors.green.shade700,
              ),
            ),
            IconButton(
              onPressed: widget._paymentModeStore.isLoading
                  ? null
                  : () {
                      if (widget._paymentModeStore.selectedPaymentMode ==
                          null) {
                        widget._customAlerts.showSnackBar(
                            'Please select a Payment Mode to edit', context);
                      } else if (widget
                              ._paymentModeStore.selectedPaymentMode!.id ==
                          1) {
                        widget._customAlerts.showSnackBar(
                            'Cannot edit default Payment Mode', context);
                      } else {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => AddPaymenModeScreen(
                                  editablePaymentMode: widget
                                      ._paymentModeStore.selectedPaymentMode,
                                )));
                      }
                    },
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: widget._paymentModeStore.isLoading
                  ? null
                  : () async {
                      if (widget._paymentModeStore.selectedPaymentMode ==
                          null) {
                        widget._customAlerts.showSnackBar(
                            'Please select a category to delete', context);
                      } else if (widget
                              ._paymentModeStore.selectedPaymentMode!.id ==
                          1) {
                        widget._customAlerts.showSnackBar(
                            'Cannot delete default Payment Mode', context);
                      } else {
                        // await _deletePaymentMode(context);
                      }
                    },
              icon: Icon(Icons.delete, color: _theme.colorScheme.error),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Wrap(
                spacing: 3.0, // gap between adjacent chips
                runSpacing: 1.0,

                children: <Widget>[
                  ...widget._paymentModeStore.paymentModeList
                      .map((e) => GestureDetector(
                            onTap: () => widget._paymentModeStore
                                .setSelectedPaymentMode(e),
                            child: Observer(builder: (_) {
                              return Chip(
                                padding: const EdgeInsets.all(1),
                                labelPadding: const EdgeInsets.all(2),
                                key: ValueKey(e.id),
                                label: SizedBox(
                                  width: 60,
                                  child: Text(
                                    e.title.capitalize(),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: _theme.textTheme.headline6!
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                                backgroundColor: e.id ==
                                        widget._paymentModeStore
                                            .selectedPaymentMode?.id
                                    ? Colors.blueAccent
                                    : Colors.grey.shade700,
                              );
                            }),
                          ))
                      .toList()
                ],
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ],
    );
  }

  Widget showImage(BuildContext context, ThemeData _theme,
      TransactionStore transactionStore, CustomImageHelper _customImageHelper) {
    // print('------- image observer');
    if (!(transactionStore.imagePath == null)) {
      if (transactionStore.imagePath!.isNotEmpty) {
        ImageType _imageIsNetwork =
            _customImageHelper.imageType(transactionStore.imagePath!).data ??
                ImageType.unknown;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ImageViewScreen(
                        imagePath: transactionStore.imagePath!))),
                child: _imageIsNetwork == ImageType.network
                    ? Image.network(
                        transactionStore.imagePath!,
                        height: 50,
                        width: 60,
                        fit: BoxFit.cover,
                        frameBuilder: (BuildContext context, Widget child,
                            int? frame, bool wasSynchronouslyLoaded) {
                          if (wasSynchronouslyLoaded) {
                            return child;
                          }
                          return AnimatedOpacity(
                            child: child,
                            opacity: frame == null ? 0 : 1,
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeOut,
                          );
                        },
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return Icon(
                            Icons.error,
                            color: _theme.colorScheme.error,
                          );
                        },
                      )
                    : Image.file(
                        File(transactionStore.imagePath!),
                        height: 50,
                        width: 60,
                        fit: BoxFit.cover,
                        frameBuilder: (BuildContext context, Widget child,
                            int? frame, bool wasSynchronouslyLoaded) {
                          if (wasSynchronouslyLoaded) {
                            return child;
                          }
                          return AnimatedOpacity(
                            child: child,
                            opacity: frame == null ? 0 : 1,
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeOut,
                          );
                        },
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return Icon(
                            Icons.error,
                            color: _theme.colorScheme.error,
                          );
                        },
                      )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () => transactionStore.removeImage(),
                    child: const Text('delete')),
              ],
            ),
          ],
        );
        //   ],
        // );
      }
    }
    return const SizedBox();
  }

  Widget ToReceiveView() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: Form(
        key: _formKey,
        child: Column(children: [
          SizedBox(
            height: 20.0,
          ),
          _selectDateAndTime(),
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
              hintText: 'Amount',
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
              hintText: 'Remark',
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
            height: 10,
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                child: Text(
                  "Due Date :",
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              SizedBox(
                width: 50,
              ),
              InkWell(
                onTap: () async {
                  final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000, 8),
                      lastDate: DateTime(2101));

                  // transactionStore.setTransactionDate(date);
                },
                child: InkWell(
                  // width: 10,
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today),
                      Observer(builder: (_) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3.0),
                          child: Text("27-5-2022"
                              // DateFormat('d-M-y')
                              //   .format(transactionStore.transactionDate)
                              ),
                        );
                      }),
                      const Icon(Icons.arrow_drop_down_sharp),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Divider()
          // payment(),
        ]),
      ),
    );
  }

  Widget CreditView() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: Form(
        key: _formKey,
        child: Column(children: [
          SizedBox(
            height: 20.0,
          ),
          _selectDateAndTime(),
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
              hintText: 'Amount',
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
              hintText: 'Remark',
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
            height: 10,
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                child: Text(
                  "Due Date :",
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              SizedBox(
                width: 50,
              ),
              InkWell(
                onTap: () async {
                  final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000, 8),
                      lastDate: DateTime(2101));

                  // transactionStore.setTransactionDate(date);
                },
                child: InkWell(
                  // width: 10,
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today),
                      Observer(builder: (_) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3.0),
                          child: Text("27-5-2022"
                              // DateFormat('d-M-y')
                              //   .format(transactionStore.transactionDate)
                              ),
                        );
                      }),
                      const Icon(Icons.arrow_drop_down_sharp),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Divider(),
          // payment(),
        ]),
      ),
    );
  }
}
