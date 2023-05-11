import 'package:intl/intl.dart';

String duTimeLineFormat(DateTime dt) {
  var now = DateTime.now();
  var difference = now.difference(dt);
  if (difference.inMinutes < 60) {
    return "${difference.inMinutes}m Atrás";
  }
  if (difference.inHours < 24) {
    return "${difference.inHours}h Atrás";
  } else if (difference.inDays < 30) {
    return "${difference.inDays} d Atrás";
  } else if (difference.inDays < 365) {
    final dtFormat = new DateFormat('MM-dd');
    return dtFormat.format(dt);
  } else {
    final dtFormat = new DateFormat('yyyy-MM-dd');
    var str = dtFormat.format(dt);
    return str;
  }
}
