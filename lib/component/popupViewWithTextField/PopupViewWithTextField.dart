import 'package:flutter/material.dart';

import '../../Utilities/res/color.dart';

class PopupViewWithTextField extends StatefulWidget {
  final Function? onTapSubmit;

  const PopupViewWithTextField({super.key, this.onTapSubmit});

  @override
  State<PopupViewWithTextField> createState() => _PopupViewWithTextFieldState();
}

class _PopupViewWithTextFieldState extends State<PopupViewWithTextField> {
  TextEditingController txtFldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            8.0,
          ),
        ),
      ),
      contentPadding: const EdgeInsets.only(
        top: 10.0,
      ),
      title: const Center(
        child: Text(
          "Cancel Ride",
          style: TextStyle(fontSize: 20.0),
        ),
      ),
      content: SizedBox(
        height: 195,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                controller: txtFldController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Write a reason',
                    labelText: 'Write a reason'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 150,
                  height: 60,
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBackgroundColor,
                      // fixedSize: Size(250, 50),
                    ),
                    child: const Text(
                      "No",
                    ),
                  ),
                ),
                Container(
                  width: 150,
                  height: 60,
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: (() => {
                          print('SUBMIT CALLED'),
                          widget.onTapSubmit!(txtFldController.text),
                          Navigator.of(context).pop(),
                        }),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBackgroundColor,
                      // fixedSize: Size(250, 50),
                    ),
                    child: const Text(
                      "Submit",
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
