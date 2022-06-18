





//   @action
//   Future<FunctionResponse> addTransaction(
//       {required transaction.Transaction formData, bool isCashIn = true}) async {
//     FunctionResponse _fResponse = FunctionResponse();

//     try {
//       DateTime date = DateTime(
//           transactionDate.year,
//           transactionDate.month,
//           transactionDate.day,
//           transactionTime.hour,
//           transactionTime.minute,
//           transactionDate.second);

//       //DB Add 'Transaction'
//       _fResponse = await _dbHelper.addNewDbTransaction(
//         id: null,
//         bookId: _bookStore.selectedBook!.id,
//         remarks: formData.remarks,
//         category: _cashCategoryStore.selectedCategory?.id ?? 0,
//         amount: formData.amount,
//         paymentMode: _paymentModeStore.selectedPaymentMode?.id ?? 0,
//         date: date,
//         imagePath: imagePath,
//         // balanceLeft: balanceLeft,
//         isCashIn: isCashIn,
//         isSynced: false,
//         isEdited: false,
//       );

//       //Memory Add 'Transaction' at first Location
//       if (_fResponse.success) {
//         final int transactionId = _fResponse.data;
//         _transactions.insert(
//           0,
//           transaction.Transaction(
//             id: transactionId,
//             bookId: _bookStore.selectedBook!.id,
//             remarks: formData.remarks,
//             category: _cashCategoryStore.selectedCategory?.id ?? 0,
//             amount: formData.amount,
//             paymentMode: _paymentModeStore.selectedPaymentMode?.id ?? 0,
//             date: date,
//             imagePath: imagePath,
//             isCashIn: isCashIn,
//             isSynced: false,
//             isEdited: false,
//           ),
//         );

//         _fResponse = await _remarkStore.addOrUpdateRemark(
//             _bookStore.selectedBook!.id, formData.remarks, isCashIn);
//         print(_fResponse.message);

//         print('after adding remarks');
//         await fetchAndSetTransactions();
//         _homeScreenStore.filterTransactions();
//       }
//     } catch (e) {
//       _fResponse.success = false;
//       _fResponse.message = 'Error adding new transaction: $e';
//     }
//     return _fResponse;
//   }

// @action
//   Future<FunctionResponse> editTransaction({
//     required transaction.Transaction formData,
//   }) async {
//     FunctionResponse _fResponse = FunctionResponse();

//     print('edit called for ${formData.id} isSynced: ${formData.isSynced}');

//     try {
//       // CONVERT ('Date' & 'Time') into 'DateTime'
//       DateTime date = DateTime(
//           transactionDate.year,
//           transactionDate.month,
//           transactionDate.day,
//           transactionTime.hour,
//           transactionTime.minute,
//           transactionDate.second);
//       final transaction.Transaction _newTransaction = transaction.Transaction(
//         id: formData.id,
//         bookId: formData.bookId,
//         remarks: formData.remarks,
//         category: _cashCategoryStore.selectedCategory?.id ?? 3,
//         amount: formData.amount,
//         paymentMode: _paymentModeStore.selectedPaymentMode?.id ?? 1,
//         date: date,
//         isCashIn: _cashCategoryStore.selectedTransactionCategoryType,
//         imagePath: imagePath,
//         isSynced: formData.isSynced,
//         isEdited: true,
//       );

//       // if (_newTransaction.isSynced) {
//       //   _fResponse =
//       //       await _transactionsApiHelper.editTransactionApi(_newTransaction);
//       // }

//       // if (_fResponse.success || !_newTransaction.isSynced) {
//       //DB UPDATE 'Transaction'
//       _fResponse = await _dbHelper.updateDbTransaction(
//         id: _newTransaction.id,
//         bookId: _newTransaction.bookId,
//         remarks: _newTransaction.remarks,
//         category: _newTransaction.category,
//         amount: _newTransaction.amount,
//         paymentMode: _newTransaction.paymentMode,
//         date: date,
//         imagePath: _newTransaction.imagePath,
//         isCashIn: _newTransaction.isCashIn,
//         isSynced: _newTransaction.isSynced,
//         isEdited: true,
//       );

//       if (_fResponse.success) {
//         //Memory UPDATE 'Transaction'

//         final insertIndex = _transactions
//             .indexWhere((element) => element.id == _newTransaction.id);

//         _transactions[insertIndex] = _newTransaction;
//       }
//       // }
//       await _remarkStore.addOrUpdateRemark(_bookStore.selectedBook!.id,
//           _newTransaction.remarks, _newTransaction.isCashIn);

//       await fetchAndSetTransactions();
//       _homeScreenStore.filterTransactions();
//     } catch (e) {
//       _fResponse.success = false;
//       _fResponse.message = 'Error adding transaction : $e';
//     }
//     return _fResponse;
//   }


//   @action
//   Future<void> deleteTransaction(transaction.Transaction transaction) async {
//     try {
//       if (transaction.isSynced) {
//         // call the api here.

//         ConnectivityHelper connectivityHelper = getIt<ConnectivityHelper>();
//         final AuthResponse? _userData =
//             await getIt<AuthApiHelper>().getCurrentUser();

//         FunctionResponse internetConnectionResponse =
//             await connectivityHelper.checkInternetConnection();
//         if (internetConnectionResponse.success) {
//           ApiClient _apiClient = await getIt<AuthApiHelper>().getNewToken();
//           final _response = await _apiClient
//               .apiCashBookDeleteCashbookTransactionBusinessidBookIdDelete(
//             businessid: _userData!.businessId,
//             bookId: transaction.bookId.toString(),
//             body: [LedgerBookDTODelete(id: transaction.id)],
//           );
//           if (_response.isSuccessful) {
//             print('transaction deleted - ${_response.body.toString()}');
//           }
//         }
//       }

//       final deleteIndex =
//           _transactions.indexWhere((element) => element.id == transaction.id);
//       if (deleteIndex == -1) {
//         return;
//       }

//       // DB DELETE 'Transaction'
//       _dbHelper.deleteDbTransaction(id: transaction.id);

//       // Memory DELETE 'Transaction'
//       _transactions.removeAt(deleteIndex);

//       _homeScreenStore.filterTransactions();
//     } catch (e) {
//       print(e);
//     }
//   }