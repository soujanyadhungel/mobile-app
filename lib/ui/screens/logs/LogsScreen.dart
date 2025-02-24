import 'package:flutter/material.dart';
import 'package:patta/app/I18n.dart';
import 'package:patta/app/logger.dart';

/// A screen that displays application logs with color-coded entries based on severity
/// and provides options to refresh and clear logs.
class LogsScreen extends StatefulWidget {
  const LogsScreen({Key? key}) : super(key: key);

  @override
  State<LogsScreen> createState() => _LogsScreenState();
}

class _LogsScreenState extends State<LogsScreen> {
  List<String> _logs = [];

  @override
  void initState() {
    super.initState();
    _loadLogs();
  }

  void _loadLogs() {
    setState(() {
      _logs = AppLogger.getLogs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(I18n.get('logs')),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadLogs,
            tooltip: I18n.get('refresh_logs'),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () async {
              await AppLogger.clearLogs();
              _loadLogs();
            },
            tooltip: I18n.get('clear_logs'),
          ),
        ],
      ),
      body: _logs.isEmpty
          ? Center(
              child: Text(
                I18n.get('logs_empty'),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            )
          : ListView.builder(
              itemCount: _logs.length,
              itemBuilder: (context, index) {
                final log = _logs[index];
                final isError = log.contains('ERROR') || log.contains('SEVERE');
                final isWarning = log.contains('WARNING');
                
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: isError
                        ? Theme.of(context).colorScheme.errorContainer
                        : isWarning
                            ? Theme.of(context).colorScheme.secondaryContainer
                            : Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: isError
                          ? Theme.of(context).colorScheme.error
                          : isWarning
                              ? Theme.of(context).colorScheme.secondary
                              : Theme.of(context).colorScheme.outline,
                      width: 1.0,
                    ),
                  ),
                  child: Text(
                    log,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isError
                              ? Theme.of(context).colorScheme.onErrorContainer
                              : isWarning
                                  ? Theme.of(context).colorScheme.onSecondaryContainer
                                  : Theme.of(context).colorScheme.onSurface,
                          fontFamily: 'monospace',
                        ),
                  ),
                );
              },
            ),
    );
  }
} 