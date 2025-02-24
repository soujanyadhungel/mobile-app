import 'dart:async';
import 'dart:developer' as developer;
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class AppLogger {
  static final Logger _logger = Logger('PariyattiApp');
  static bool _initialized = false;
  static File? _logFile;
  static final List<String> _memoryLogs = [];
  static const int _maxMemoryLogs = 1000; // Keep last 1000 logs in memory

  static Future<void> init() async {
    if (_initialized) return;

    // Configure logging
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      String logMessage = '${record.time}: ${record.level.name}: ${record.message}';
      if (record.error != null) {
        logMessage += '\nError: ${record.error}';
      }
      if (record.stackTrace != null) {
        logMessage += '\nStack Trace:\n${record.stackTrace}';
      }

      // Store in memory
      _memoryLogs.add(logMessage);
      if (_memoryLogs.length > _maxMemoryLogs) {
        _memoryLogs.removeAt(0);
      }

      // Write to file
      _writeToFile(logMessage);

      // Print to console in debug mode
      developer.log(
        record.message,
        time: record.time,
        level: record.level.value,
        name: record.loggerName,
        error: record.error,
        stackTrace: record.stackTrace,
      );
    });

    // Initialize log file
    await _initLogFile();
    _initialized = true;
  }

  static Future<void> _initLogFile() async {
    final directory = await getApplicationDocumentsDirectory();
    _logFile = File('${directory.path}/pariyatti.log');
    if (!await _logFile!.exists()) {
      await _logFile!.create();
    }
    // Rotate log file if it's too large (> 5MB)
    final fileSize = await _logFile!.length();
    if (fileSize > 5 * 1024 * 1024) {
      final backupFile = File('${directory.path}/pariyatti.log.bak');
      if (await backupFile.exists()) {
        await backupFile.delete();
      }
      await _logFile!.rename('${directory.path}/pariyatti.log.bak');
      _logFile = File('${directory.path}/pariyatti.log');
      await _logFile!.create();
    }
  }

  static Future<void> _writeToFile(String message) async {
    if (_logFile != null) {
      await _logFile!.writeAsString('$message\n', mode: FileMode.append);
    }
  }

  // Logging methods
  static void info(String message) {
    _logger.info(message);
  }

  static void warning(String message) {
    _logger.warning(message);
  }

  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.severe(message, error, stackTrace);
  }

  static void debug(String message) {
    _logger.fine(message);
  }

  // Get logs for display
  static List<String> getLogs() {
    return List.from(_memoryLogs.reversed); // Return most recent first
  }

  // Clear logs
  static Future<void> clearLogs() async {
    _memoryLogs.clear();
    if (_logFile != null && await _logFile!.exists()) {
      await _logFile!.delete();
      await _initLogFile();
    }
  }
} 