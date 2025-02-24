import 'logger.dart';

void log2(String msg) {
  AppLogger.debug(msg);
}

void logError(Object error, [StackTrace? stackTrace]) {
  AppLogger.error("An error occurred", error, stackTrace);
} 