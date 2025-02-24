import 'package:flutter/material.dart';
import 'package:patta/app/I18n.dart';
import 'package:patta/app/logger.dart';
import 'package:patta/ui/common/pariyatti_icons.dart';

class ErrorBoundary extends StatefulWidget {
  final Widget child;

  const ErrorBoundary({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<ErrorBoundary> createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<ErrorBoundary> {
  Error? _error;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return _buildErrorDisplay(context, _error!);
    }

    return ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
      AppLogger.error(
        'Flutter error caught by ErrorBoundary',
        errorDetails.exception,
        errorDetails.stack,
      );
      return _buildErrorDisplay(context, errorDetails.exception as Error);
    };
  }

  Widget _buildErrorDisplay(BuildContext context, Error error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              PariyattiIcons.get(IconName.error),
              color: Theme.of(context).colorScheme.error,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              I18n.get("error"),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              I18n.get("try_again_later"),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (error.stackTrace != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  error.toString(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onErrorContainer,
                      ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
} 