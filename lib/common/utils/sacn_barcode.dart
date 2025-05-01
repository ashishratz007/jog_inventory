
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../services/tab_view_navigator.dart';
import '../exports/common.dart';

class BarcodeScannerPage extends StatelessWidget {
  BarcodeScannerPage({super.key});

  final double size = 30;
  final Color color = Colours.bgGrey;
  MobileScannerController controller = MobileScannerController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scan Barcode")),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 300,
              child: MobileScanner(
                controller:controller ,
                onDetect: (barcodeCapture) {
                  final barcode = barcodeCapture.barcodes.first;
                  final value = barcode.rawValue;
                  controller.dispose();
                  mainNavigationService.pop(result: value);
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 300,
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.turn_right,
                        size: size,
                        color: color,
                      ),
                      gap(space: 150),
                      RotatedBox(
                          quarterTurns: 4,
                          child: Icon(
                            Icons.turn_left,
                            size: size,
                            color: color,
                          ))
                    ],
                  ),
                  gap(space: 120),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RotatedBox(
                        quarterTurns: 2,
                        child: Icon(
                          Icons.turn_left,
                          size: size,
                          color: color,
                        ),
                      ),
                      gap(space: 150),
                      RotatedBox(
                        quarterTurns: 2,
                        child: Icon(
                          Icons.turn_right,
                          size: size,
                          color: color,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

}
