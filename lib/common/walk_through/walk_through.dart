import '../exports/main_export.dart';

class WalkThroughScreen extends StatefulWidget {
  @override
  _WalkThroughScreenState createState() => _WalkThroughScreenState();
}

class _WalkThroughScreenState extends State<WalkThroughScreen> {
  int _currentValue = 0;
  int _dotCount = 3;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [Colours.primaryDark, Colours.primary],
        stops: [0.25, 0.75],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      )),
      child: Material(
        // backgroundColor: Colours.primary,
        type: MaterialType.transparency,
        child: SafeArea(
          child: Container(
            child: CustomSlider(
              value: _currentValue,
              dotCount: _dotCount,
              onChanged: (value) {
                setState(() {
                  _currentValue = value;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}

class CustomSlider extends StatelessWidget {
  final int value;
  final int dotCount;
  final ValueChanged<int> onChanged;

  const CustomSlider({
    Key? key,
    required this.value,
    required this.dotCount,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: value);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(15),
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(dotCount, (index) {
                      bool isSelected = (value.round() == index);
                      return AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.linearToEaseOut,
                        margin: EdgeInsets.symmetric(horizontal: 4.0),
                        width: isSelected ? 25.0 : 7.0,
                        height: 7,
                        decoration: BoxDecoration(
                          color: !isSelected ? Colours.primaryLite : Colors.white,
                          borderRadius: BorderRadius.circular(7.5),
                        ),
                      );
                    }),
                  ),
                  TextButton(onPressed: (){
                    Get.offAllNamed(AppRoutesString.login);
                  }, child: Text("Skip",style: TextStyle(color: Colors.white, fontSize: 14,fontWeight: FontWeight.w500),)),
                ],
              ),
              gap(space: 10),

              /// Title
              Container(
                width: Get.width,
                padding: EdgeInsets.only(right: 100),
                child: Text(
                  "Choose the right Car for you !",
                  style: appTextTheme.titleMedium
                      ?.copyWith(color: Colors.white, fontSize: 24),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              gap(),

              /// Title
              Container(
                width: Get.width,
                padding: EdgeInsets.only(right: 15),
                child: Text(
                  "Find the perfect match with our trusted valuation and seamless buying process.",
                  style:
                      appTextTheme.labelMedium?.copyWith(color: Colors.white,fontSize: 13),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              gap(),
            ],
          ),
        ),
        Center(
          child: Container(
            height: 350,
            child: PageView(
              controller: controller,
              onPageChanged: (value) {
                onChanged(value);
              },
              children: [
                Image.asset("assets/images/car1.png"),
                Image.asset("assets/images/car1.png",width: Get.width,height: 350,),
                Image.asset("assets/images/car3.png",width: Get.width,height: 350,),
              ],
            ),
          ),
        ),
        Expanded(child: SizedBox()),
        AnimatedVisibility(isVisible: value == 2, child: Padding(
          padding: const EdgeInsets.only(left: 15,right: 15),
          child: PrimaryButton(
              color: Colours.secondary,
              title: "Get Started", onTap: (){
            Get.offAllNamed(AppRoutesString.login);
          }),
        )),
        gap(),
        safeAreaBottom(context),
      ],
    );
  }
}
