import '../../../common/exports/main_export.dart';

class ForecastDetailScreen extends StatefulWidget {
  const ForecastDetailScreen({super.key});

  @override
  State<ForecastDetailScreen> createState() => _ForecastDetailScreenState();
}

class _ForecastDetailScreenState extends State<ForecastDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomAppBar(title: "Forecast Detail", body: body);
  }

  Widget body(BuildContext context){
    return SingleChildScrollView(
      child: Container(),
    );
  }
}
