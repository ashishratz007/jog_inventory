import 'package:jog_inventory/common/animations/ease_out_animation.dart';
import 'package:jog_inventory/services/tab_view_navigator.dart';

import '../../../common/exports/main_export.dart';


void infoDialogPopup(BuildContext context,
    {required String title, required String subtitle}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: EdgeInsets.all(15),
        backgroundColor: Colors.transparent,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Material(
          type: MaterialType.transparency,
          child: CustomPopup(
            title: title,
            subtitle: subtitle,
          ),
        ),
      );
    },
  );
}

class CustomPopup extends StatefulWidget {
  final String title;
  final String subtitle;

  const CustomPopup({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  State<CustomPopup> createState() => _CustomPopupState();
}

class _CustomPopupState extends State<CustomPopup> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      mainNavigationService.pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: 25),
          decoration: BoxDecoration(
            color: Color(0xff1E1E1E),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              gap(space: 50),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  widget.title,
                  style: appTextTheme.titleLarge
                      ?.copyWith(color: Colors.white, fontSize: 20),
                  maxLines: 1,
                ),
              ),
              gap(space: 10),
              Divider(
                color: Colors.white.withOpacity(0.1),
              ),
              gap(space: 10),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  widget.subtitle,
                  style: appTextTheme.bodySmall?.copyWith(color: Colors.white),
                ),
              ),
              gap(space: 20),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          child: CircleAvatar(
            backgroundColor: Color(0xff272727),
            radius: 35,
            child: CircleAvatar(
                backgroundColor: Color(0xff34C759),
                radius: 18,
                child: EaseOutAnimation(
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 30,
                  ),
                )),
          ),
        ),
      ],
    );
  }
}

void inputTextPopup(BuildContext context, {required String title, String? initialValue,String? buttonText, required Function(String text) onSave, Widget? addon, }) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: EdgeInsets.all(15),
        backgroundColor: Colors.transparent,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Material(
          type: MaterialType.transparency,
          child: GestureDetector(
            onTap: (){
              hideKeyboard(context);
            },
            child: _TextFromFieldWidget(
              title: title,
              onSave: onSave,
              initialValue: initialValue,
              buttonText: buttonText,
              addon: addon,
            ),
          ),
        ),
      );
    },
  );
}

class _TextFromFieldWidget extends StatelessWidget {
  final String title;
  final String? initialValue;
  final String? buttonText;
  final Widget? addon;
  final Function(String) onSave;
   _TextFromFieldWidget({
    required this.title,
     this.initialValue,
     this.buttonText,
     this.addon,
    required this.onSave,
  });

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    textEditingController.text = initialValue??"";

    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colours.blueDark,width: 1.5)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          gap(),
          TextFieldWithLabel(labelText: title,controller:textEditingController),
          Visibility(
              visible: addon != null,
              child: addon??SizedBox()),
          gap(space: 30),
          PrimaryButton(
            title: buttonText??'Save',
            onTap: () {
              onSave(textEditingController.text);
            },
            color: Colours.blueDark,
            isFullWidth: false,
            textSize: 14,
            padding:
                EdgeInsets.only(left: 15, right: 15, top: 7, bottom: 7),
          ),
          gap(space: 20),
        ],
      ),
    );
  }
}
