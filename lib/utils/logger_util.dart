import 'package:logger/logger.dart';

class Log {
  static final Logger logger = Logger(printer: PrettyPrinter());

  static void e(String msg) {
    logger.e(e);
  }

  static void i(String msg) {
    logger.i(msg);
  }

  static void d(String msg) {
    logger.d(msg);
  }

  static void w(String msg) {
    logger.w(msg);
  }
}
