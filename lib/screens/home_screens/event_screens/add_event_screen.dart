import 'package:csi_app/utils/widgets/buttons/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/admob/v1.dart';
import 'package:provider/provider.dart';

import '../../../apis/FireStoreAPIs/event_store.dart';
import '../../../apis/notification_apis/notifications_api.dart';
import '../../../main.dart';
import '../../../models/event_model/event_model.dart';
import '../../../models/notification_model/Announcement.dart';
import '../../../providers/CurrentUser.dart';
import '../../../utils/colors.dart';
import '../../../utils/helper_functions/function.dart';
import '../../../utils/widgets/event/event_card.dart';
import '../../../utils/widgets/text_feilds/auth_text_feild.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({Key? key}) : super(key: key);

  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isButtonEnabled = false;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _registerUrlController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  int _notificationHour = 12;

  bool _isLoading = false;


  @override
  void initState() {
    super.initState();
    _nameController.addListener(updateButtonState);
    _registerUrlController.addListener(updateButtonState);
  }

  void updateButtonState() {
    bool isStartDateAfterEndDate =
        _startDate != null && _endDate != null && _startDate!.isAfter(_endDate!);
    setState(() {
      isButtonEnabled = _nameController.text.isNotEmpty &&
          _registerUrlController.text.isNotEmpty &&
          _startDate != null &&
          _endDate != null &&
          _startTime != null &&
          _endTime != null &&
          _startTime!.hour <= _endTime!.hour &&
          !isStartDateAfterEndDate &&
          (_startDate!.isBefore(DateTime.now()) || _startDate!.isAtSameMomentAs(DateTime.now()));
    });

    if (isStartDateAfterEndDate) {
      HelperFunctions.showToast("Start date cannot be after end date");
    }
  }


  @override
  void dispose() {
    super.dispose();
    _nameController.removeListener(updateButtonState);
    _registerUrlController.removeListener(updateButtonState);
  }

  String? _validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter required details';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Consumer<AppUserProvider>(builder: (context,appUserProvider,child){return Scaffold(
      backgroundColor: AppColors.theme['backgroundColor'],
      appBar: AppBar(
        surfaceTintColor: AppColors.theme['secondaryColor'],
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.theme['secondaryColor'],
        title: Text(
          "Add Event",
          style: TextStyle(
            color: AppColors.theme['tertiaryColor'],
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.keyboard_arrow_left_outlined,
            size: 32,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Event Name",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomAuthTextField(
                  hintText: 'Enter Event',
                  isNumber: false,
                  prefixicon: Icon(Icons.drive_file_rename_outline),
                  controller: _nameController,
                  obsecuretext: false,
                  validator: _validate,
                ),
                SizedBox(height: 10),
                Text(
                  "Register URL",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomAuthTextField(
                  hintText: 'Enter Register URL',
                  isNumber: false,
                  prefixicon: Icon(Icons.link),
                  controller: _registerUrlController,
                  obsecuretext: false,
                  validator: _validate,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Event Start Date",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () async {
                            DateTime? selectedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100),
                              builder: (BuildContext context, Widget? child) {
                                return Theme(
                                  data: ThemeData.light().copyWith(
                                    primaryColor: AppColors.theme['secondaryBgColor'],
                                    colorScheme: ColorScheme.light(primary:AppColors.theme['primaryColor']),
                                    buttonTheme: ButtonThemeData(
                                      textTheme: ButtonTextTheme.primary,
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );
                            if (selectedDate != null) {
                              setState(() {
                                _startDate = selectedDate;
                                updateButtonState();
                              });
                            }
                          },
                          child: Container(
                            width: mq.width * 0.4,
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: _startDate != null
                                ? Center(
                              child: Text(
                                '${_startDate!.day}/${_startDate!.month}/${_startDate!.year}',
                                style: TextStyle(fontSize: 16),
                              ),
                            )
                                : Center(
                              child: Text(
                                'Select Date',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Event End Date",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () async {
                            DateTime? selectedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100),
                              builder: (BuildContext context, Widget? child) {
                                return Theme(
                                  data: ThemeData.light().copyWith(
                                    primaryColor: AppColors.theme['secondaryBgColor'],
                                    colorScheme: ColorScheme.light(primary:AppColors.theme['primaryColor']),
                                    buttonTheme: ButtonThemeData(
                                      textTheme: ButtonTextTheme.primary,
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );
                            if (selectedDate != null) {
                              setState(() {
                                _endDate = selectedDate;
                                updateButtonState();
                              });
                            }
                          },
                          child: Container(
                            width: mq.width * 0.4,
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: _endDate != null
                                ? Center(
                              child: Text(
                                '${_endDate!.day}/${_endDate!.month}/${_endDate!.year}',
                                style: TextStyle(fontSize: 16),
                              ),
                            )
                                : Center(
                              child: Text(
                                'Select Date',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Event Start Time",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        InkWell(
                          onTap: () async {
                            TimeOfDay? selectedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              builder: (BuildContext context, Widget? child) {
                                return Theme(
                                  data: ThemeData.light().copyWith(
                                    primaryColor: AppColors.theme['secondaryBgColor'],
                                    colorScheme: ColorScheme.light(primary:AppColors.theme['primaryColor']),
                                    buttonTheme: ButtonThemeData(
                                      textTheme: ButtonTextTheme.primary,
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );
                            if (selectedTime != null) {
                              setState(() {
                                _startTime = selectedTime;
                                updateButtonState();
                              });
                            }
                          },
                          child: Container(
                            width: mq.width * 0.4,
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: _startTime != null
                                ? Center(
                              child: Text(
                                '${_startTime!.hour}:${_startTime!.minute}',
                                style: TextStyle(fontSize: 16),
                              ),
                            )
                                : Center(
                              child: Text(
                                'Select Time',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Event End Time",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        InkWell(
                          onTap: () async {
                            TimeOfDay? selectedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              builder: (BuildContext context, Widget? child) {
                                return Theme(
                                  data: ThemeData.light().copyWith(
                                    primaryColor: AppColors.theme['secondaryBgColor'],
                                    colorScheme: ColorScheme.light(primary:AppColors.theme['primaryColor']),
                                    buttonTheme: ButtonThemeData(
                                      textTheme: ButtonTextTheme.primary,
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );
                            if (selectedTime != null) {
                              setState(() {
                                _endTime = selectedTime;
                                updateButtonState();
                              });
                            }
                          },
                          child: Container(
                            width: mq.width * 0.4,
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: _endTime != null
                                ? Center(
                              child: Text(
                                '${_endTime!.hour}:${_endTime!.minute}',
                                style: TextStyle(fontSize: 16),
                              ),
                            )
                                : Center(
                              child: Text(
                                'Select Time',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 10),
                // Text(
                //   "Notify Users Every (hours)",
                //   style: TextStyle(
                //     fontSize: 16,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                // SizedBox(height: 10),
                // DropdownButton<int>(
                //   value: _notificationHour,
                //   onChanged: (value) {
                //     setState(() {
                //       _notificationHour = value!;
                //       updateButtonState();
                //     });
                //   },
                //   items: List.generate(
                //     24,
                //         (index) => DropdownMenuItem<int>(
                //       value: index + 1,
                //       child: Text('${index + 1} hours'),
                //     ),
                //   ),
                // ),
                SizedBox(height: 20),

                AuthButton(
                  onpressed: isButtonEnabled
                      ? () async {
                    FocusScope.of(context).unfocus();
                    if (_formKey.currentState!.validate()) {

                      print("Name: ${_nameController.text}");
                      print("Register URL: ${_registerUrlController.text}");
                      print("Start Date: $_startDate (${_startDate?.millisecondsSinceEpoch})");
                      print("End Date: $_endDate (${_endDate?.millisecondsSinceEpoch})");
                      print("Start Time: $_startTime (${_startTime != null ? (_startTime!.hour * 3600 + _startTime!.minute * 60) * 1000 : null})");
                      print("End Time: $_endTime (${_endTime != null ? (_endTime!.hour * 3600 + _endTime!.minute * 60) * 1000 : null})");
                      print("NotifyHour :${_notificationHour.toString()}");

                      setState(() {
                        _isLoading = true;
                      });

                      Announcement announcement  = Announcement(
                        message: "${_nameController.text} Alert! Join us for an exciting competition. Stay updated and be part of the action!",
                        fromUserId: appUserProvider.user?.userID,
                        toUserId: "ALL",
                        time: DateTime.now().millisecondsSinceEpoch.toString(),
                        fromUserName: appUserProvider.user?.name,
                      );

                      await NotificationApi.sendMassNotificationToAllUsers("${_nameController.text} Alert! Join us for an exciting competition. Stay updated and be part of the action!") ;
                      await NotificationApi.storeNotification(announcement,false) ;

                      await EventStore.storeEvent(
                        _nameController.text,
                        _registerUrlController.text,
                        ((_startTime!.hour * 3600 + _startTime!.minute * 60) * 1000).toString(),
                        ((_endTime!.hour * 3600 + _endTime!.minute * 60) * 1000).toString(),
                        _startDate!.millisecondsSinceEpoch.toString(),
                        _endDate!.millisecondsSinceEpoch.toString(),
                        _notificationHour.toString(),
                      ).then((_) {
                        setState(() {
                          _isLoading = false;
                        });
                        HelperFunctions.showToast("Event Added") ;
                        Navigator.pop(context);
                      });
                    }
                  }
                      : () async {},
                  name: !_isLoading ? "Add Event" : "Adding...",
                  bcolor: isButtonEnabled
                      ? AppColors.theme['primaryColor']
                      : AppColors.theme['disableButtonColor'].withOpacity(0.4),
                  tcolor: isButtonEnabled
                      ? AppColors.theme['secondaryColor']
                      : AppColors.theme['tertiaryColor'].withOpacity(0.5),
                  isLoading: _isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );});
  }
}
