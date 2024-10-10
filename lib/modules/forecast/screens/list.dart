import 'package:jog_inventory/modules/forecast/controllers/list.dart';

import '../../../common/exports/common.dart';

class ForecastListScreen extends StatefulWidget {
  const ForecastListScreen({super.key});

  @override
  State<ForecastListScreen> createState() => _ForecastListScreenState();
}

class _ForecastListScreenState extends State<ForecastListScreen> {
  ForeCastListController controller = ForeCastListController.getController();

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(title: "Forecast List", body: body);
  }

  Widget body(BuildContext context){
    return SingleChildScrollView(
      child: Container(),
    );
  }
}
