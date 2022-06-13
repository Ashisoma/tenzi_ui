import 'package:cashbook/constants/function_response.dart';
import 'package:cashbook/helpers/api_helpers/profile_api_helper.dart';
import 'package:cashbook/models/api_response/profile_response.dart';
import 'package:mobx/mobx.dart';

import '../service_locator.dart';
part 'profile_store.g.dart';

class ProfileStore = _ProfileStore with _$ProfileStore;

class HelpQNA {
  String id;
  String category;
  String question;
  String answer;
  HelpQNA(
      {required this.id,
      required this.category,
      required this.question,
      required this.answer});
}

abstract class _ProfileStore with Store {
  late ProfileApiHelper _profileApiHelper;
  _ProfileStore(this._profileApiHelper);

  @observable
  String name = 'undefined';
  @observable
  String image = '';

  @observable
  ProfileResponse _profileResponse = ProfileResponse(
      imageUrl: "Undefined",
      logo: null,
      custId: "Undefined",
      organizationName: "Undefined",
      fullnames: "Undefined",
      primaryPhone: "Undefined",
      secondaryPhone: null,
      primaryEmail: "a10@a.co",
      secondaryEmail: null,
      website: null,
      imageFile: null,
      city: null,
      address: null,
      addressCode: null,
      country: "Undefined",
      location: null,
      businessType: null);

  @observable
  String phone = 'undefined';

  Future<void> getProfileInfo() async {
    //TODO: use db to store user info
    try {
      ProfileResponse? _profileInfo =
          await _profileApiHelper.getProfile() ?? _profileResponse;

      name = _profileInfo.fullnames!;
      phone = _profileInfo.primaryPhone!;
      if (_profileInfo.logo != null && _profileInfo.logo!.isNotEmpty) {
        image = _profileInfo.logo!;
        print('Image was Update');
      }
      _profileResponse = _profileInfo;
    } catch (e) {
      print('Error getting profile info : $e');
    }
  }

  Future<FunctionResponse> updateProfileName(String _name) async {
    try {
      FunctionResponse _response = await _profileApiHelper.updateProfileName(
          profile: _profileResponse, name: _name);

      if (_response.success) {
        name = _name;
      }

      return _response;
    } catch (e) {
      return FunctionResponse(
          success: false,
          message: 'Error Processing Update Request Profile: $e');
    }
  }

  Future<FunctionResponse> updateProfileImage(String _image) async {
    try {
      FunctionResponse _response = await _profileApiHelper.updateProfileImage(
          profile: _profileResponse, image: _image);

      if (_response.success) {
        print('Image was Update');

        image = _image;
      }

      return _response;
    } catch (e) {
      return FunctionResponse(
          success: false,
          message: 'Error Processing Update Request Profile: $e');
    }
  }

  @observable
  ObservableList<HelpQNA> helpQNA = ObservableList<HelpQNA>.of([
    HelpQNA(
        id: '1',
        category: 'About',
        question: 'What is Tenzi Book',
        answer: 'TenziBook is a simple ledger to help you manage your cash records. It helps you track your cash flow and calculate your balance automatically. \n \n'
            'You can create multiple books to manage different accounts such as personal, business, travel etc.\n \n'
            'TenziBook can be used by individuals or small and mid-sized businesses.'),
    HelpQNA(
        id: '2',
        category: 'How to',
        question: 'Key features',
        answer: 'Simple ledger for Cash In/Income and Cash Out/Sale entries\n\n'
            'Multiple books to help you manage different accounts separately\n\n'
            'Multiple currencies. Change currency to suit your country\n\n'
            'Balance is automatically displayed on the dashboard with advance options for sorting by time\n\n'
            'Categories help you group both your income and expenses\n\n'
            'Generate PDF of cash records and share on WhatsApp or email\n\n'
            'Search through your records easily\n\n'
            'Filter cash records by date, entry type, payment mode and categories\n\n'
            'Data Backup so that you never lose your database. Your data is 100% secure and can be backup by syncing your app to the server'),
    HelpQNA(
        id: '3',
        category: 'How to',
        question: 'How to add a new entry?',
        answer: 'Tap on Cash In button (to record income) or the Cash Out button (to record expenses).\n\n'
            '(Optional) Edit date and time to backdate an entry to the correct transaction date.\n\n'
            'Add the transaction amount you would like to record\n\n'
            'Add remarks or descriptions to help you keep track of your transaction amount.  The 3 dash icon helps you to add remarks quickly by including remarks from history\n\n'
            '(Optional) Add a category to help you group your transactions. Your reports will be displayed according to category. By default, all transactions are added to the General category.\n\n'
            '(Optional) Tap on Attach Image to add images of receipts if needed\n\n'
            '(Optional) Choose Payment Mode to record payment type by selecting from the listed options. You can add new payment modes by tapping on the + button or edit the payment mode with the selected name by taping on the pencil button or delete a payment mode you added by tapping on the delete button.\n\n'
            'Tap on Save to add the entry to your records'),
    HelpQNA(
        id: '7',
        category: 'How to',
        question: 'How to edit/change entries?',
        answer: 'Tap on the entry from the list of entries on the cashbook to view more details.\n\n'
            'Tap on Edit Entry.\n\n'
            'Make changes as to Cash In/Out, Date and Time, Amount, Remarks, Category, Image or Payment Mode as needed.\n\n'
            'Tap on the Save button to save changes.\n\n'),
    HelpQNA(
        id: '8',
        category: 'How to',
        question: 'How to do search entries?',
        answer: 'Tap on the entry from the list of entries on the cashbook to view more details.\n\n'
            'Tap on Edit Entry.\n\n'
            'Make changes as to Cash In/Out, Date and Time, Amount, Remarks, Category, Image or Payment Mode as needed.\n\n'
            'Tap on the Save button to save changes.\n\n'),
    HelpQNA(
        id: '9',
        category: 'How to',
        question: 'How to create, save and share PDF?',
        answer: 'Tap on the Book icon to select the book you want to generate a PDF.\n\n'
            'Customize the PDF by duration (Tap on All-Time for duration options) or filter by Entry Type, Category or Payment (Tap on the Funnel icon next to the Search box for options). Your transaction list will be updated according to your selection.\n\n'
            'Tap on the PDF icon next to the Search box to generate PDF.\n\n'
            'Save the PDF to your phone documents by clicking on the blue PDF icon, rename (optional) and save.\n\n'
            'Attach PDF to email or WhatsApp and share.\n\n'),
    HelpQNA(
        id: '10',
        category: 'How to',
        question: 'How to use filters?',
        answer: 'Tap on the Book icon to select the book you want to filter.\n\n'
            'Tap on All-Time for duration options or Tap on the Funnel icon (next to the Search box for options) to filter by Entry Type, Category or Payment.\n\n'
            'Tap on Apply. Your entry list will be updated according to your selection.\n\n'
            'Clear filters to view all entries\n\n'),
    HelpQNA(
        id: '11',
        category: 'How to',
        question: 'How to use and add Category?',
        answer: 'Tap on Cash In button (to record income) or the Cash Out button (to record expenses).\n\n'
            'When adding a new entry tap General to select Category (optional). Categories help to group your transactions. Your entries and reports are filtered/displayed according to category. By default, all transactions are added to the General category.\n\n'
            'To add a new Category - Tap on General to view a list of categories. Tap on the + button at the bottom of the screen. Type new Category and tap Submit.\n\n'
            'Note: Added category is associated with Cash In (Income category) or Cash Out (Expense category). Predefined Category options cannot be edited or deleted – General, Sales and Purchases\n\n'
            'To edit a Category - Tap the pencil icon next to the category item you would like to edit. Edit category name and tap Submit.\n\n'
            'To delete a Category - Tap the delete icon next to the category item you would like to delete. Tap on the delete button.'),
    HelpQNA(
        id: '12',
        category: 'How to',
        question: 'How to use filters?',
        answer: 'Tap on the Book icon to select the book you want to filter.\n\n'
            'Tap on All-Time for duration options or Tap on the Funnel icon (next to the Search box for options) to filter by Entry Type, Category or Payment.\n\n'
            'Tap on Apply. Your entry list will be updated according to your selection.\n\n'
            'Clear filters to view all entries\n\n'),
    HelpQNA(
        id: '13',
        category: 'How to',
        question: 'How to use and add Payment Modes?',
        answer: 'Tap on Cash In button (to record income) or Cash Out button (to record expenses).\n\n'
            'When adding a new entry select Payment Mode (optional).\n\n'
            'To add a new Payment Mode - Tap on the + button. Type new Payment Mode and tap Submit.\n\n'
            'Note: Predefined Payment Modes options cannot be edited or deleted – None, Mpesa, Cash, Bank\n\n'
            'To edit a Payment Mode - Tap the Payment Mode you would like to edit to select the mode. Tap on the pencil button. Edit Payment Mode name and tap Submit.\n\n'
            'To delete a Payment Mode - Tap the Payment Mode you would like to delete to select the mode. Tap on the delete button.\n\n'),
    HelpQNA(
        id: '14',
        category: 'How to',
        question: 'How to use reporting?',
        answer: 'Tap on Reporting icon (pie chart) at the top right of the app\n\n'
            'Tap on All Time for duration options. You can filter by date or date range.\n\n'
            'Select Cash In or Cash Out to view income or expense reports.\n\n'
            'Tap on any category in the list below the chart to view entries in that category.\n\n'),
    HelpQNA(
        id: '15',
        category: 'How to',
        question: 'How to share app?',
        answer: 'Tap on the Menu icon (3 dashes) at the top left of the app\n\n'
            'Tap Share App and select a contact on whatsapp to share the link\n\n'
            ),
    // HelpQNA(
    //     id: '15',
    //     category: 'How to',
    //     question: 'Tenzi Book Tutorial',
    //     answer: ''
    // ),


  ]);
}
