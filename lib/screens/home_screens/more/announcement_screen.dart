import 'package:csi_app/utils/colors.dart';
import 'package:flutter/material.dart';

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({super.key});

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  TextEditingController _textController = TextEditingController();
  bool _isLoading = false;
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _textController.addListener(updateButtonState);
  }

  void updateButtonState() {
    setState(() {
      isButtonEnabled = _textController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _textController.removeListener(updateButtonState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.theme['backgroundColor'],
        appBar: AppBar(
          surfaceTintColor: AppColors.theme['secondaryColor'],
          elevation: 0,
          centerTitle: true,
          backgroundColor: AppColors.theme['secondaryColor'],
          title: Text("Announcement",
              style: TextStyle(
                  color: AppColors.theme['tertiaryColor'],
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.keyboard_arrow_left_outlined,
                size: 32,
              )),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: !_isLoading ? 7.0 : 20),
              //todo add inkwell and store description and userId
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                height: 40,
                width: !_isLoading ? 100 : 70,
                child: !_isLoading
                    ? Center(
                        child: Text(
                        "Send",
                        style: TextStyle(
                          color: isButtonEnabled
                              ? AppColors.theme['secondaryColor']
                              : AppColors.theme['tertiaryColor']
                                  .withOpacity(0.5),
                        ),
                      ))
                    : Center(
                        child: Container(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.6,
                              color: AppColors.theme['primaryColor'],
                            ))),
                decoration: BoxDecoration(
                  color: isButtonEnabled
                      ? AppColors.theme['primaryColor']
                      : AppColors.theme['disableButtonColor'],
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 600,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.theme['secondaryColor']),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _textController,
                      cursorColor: AppColors.theme['primaryColor'],
                      maxLines: null,
                      decoration: InputDecoration(
                          hintText: 'Start writing here...',
                          border: InputBorder.none),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
