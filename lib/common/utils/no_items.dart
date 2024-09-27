import '../exports/common.dart';

class NoItems extends StatelessWidget {
  const NoItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.hourglass_empty,
            size: 100,
            color: Colours.border,
          ),
          const SizedBox(height: 16),
          Text(
            "No Items",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colours.black,
            ),
          ),
        ],
      ),
    );
  }
}
