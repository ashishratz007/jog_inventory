import 'package:intl/intl.dart';

class _AppDateTimeFormat {
  var _ddMMYYFormat = DateFormat('d MMMM yyyy');
  var _MMDDYYFormat = DateFormat('MMMM, d, yyyy');
  var _YYMMDDFormat = DateFormat('yyyy-MM-dd');
  var _YYMMDDTimeFormat = DateFormat('yyyy-MM-dd h:mm a');
  var _ddMMTimeFormat = DateFormat('dd MMMM h:mm a');
  var _ddMMTimeDividerFormat = DateFormat('dd \n MMMM \n h:mm a');

  String? ddMMYYString(DateTime? dateTime) {
    if (dateTime == null) return null;
    return _ddMMYYFormat.format(dateTime);
  }

  String? yyMMDDFormat(DateTime? dateTime) {
    if (dateTime == null) return null;
    return _YYMMDDFormat.format(dateTime);
  }

  String? MMDDYYString(DateTime? dateTime) {
    if (dateTime == null) return null;
    return _MMDDYYFormat.format(dateTime);
  }

  String? YYMMDDTimeFormat(DateTime? dateTime) {
    if (dateTime == null) return null;
    return _YYMMDDTimeFormat.format(dateTime);
  }

  String? ddMMTime(
    DateTime? dateTime, {
    bool useNextLine = false,
  }) {
    if (dateTime == null) return null;
    if (useNextLine) return _ddMMTimeDividerFormat.format(dateTime);
    return _ddMMTimeFormat.format(dateTime);
  }

  String toYYMMDDHHMMSS({
    DateTime? dateTime,
    bool useNextLine = false,
  }) {
    dateTime ??= DateTime.now();
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
  }
}

var appDateTimeFormat = _AppDateTimeFormat();
