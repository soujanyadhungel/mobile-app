import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum IconName {
  share,
  bookmark,
  bookmarkFilled,
  today,
  heart,
  person,
  error,
  networkError,
  play,
  pause,
  stop,
  refresh,
  delete,
  none
}

const _iosMissing = CupertinoIcons.multiply_circle;
const _androidMissing = Icons.broken_image;

const Map<String, IconData> _iconMissing = {
  'default': _androidMissing,
  'ios': _iosMissing,
};

const Map<IconName, Map<String, IconData>> _iconMap = {
  IconName.share: {
    'default': Icons.share,
    'ios': CupertinoIcons.share,
  },
  IconName.bookmark: {
    'default': Icons.bookmark_border,
    'ios': CupertinoIcons.bookmark,
  },
  IconName.bookmarkFilled: {
    'default': Icons.bookmark,
    'ios': CupertinoIcons.bookmark_solid,
  },
  IconName.today: {
    'default': Icons.today,
  },
  IconName.heart: {
    'default': Icons.favorite,
    'ios': CupertinoIcons.heart_fill,
  },
  IconName.person: {
    'default': Icons.person,
    'ios': CupertinoIcons.person_solid,
  },
  IconName.error: {
    'default': Icons.error_outline,
    'ios': CupertinoIcons.info,
  },
  IconName.networkError: {
    'default': Icons.cloud_off_outlined,
    'ios': Icons.cloud_off_outlined
  },
  IconName.play: {
    'default': Icons.play_circle_fill,
    'ios': CupertinoIcons.play_circle_fill
  },
  IconName.pause: {
    'default': Icons.pause_circle_filled,
    'ios': CupertinoIcons.pause_circle_fill
  },
  IconName.stop: {
    'default': Icons.stop_circle,
    'ios': CupertinoIcons.stop_circle_fill
  },
  IconName.refresh: {
    'default': Icons.refresh,
    'ios': CupertinoIcons.refresh
  },
  IconName.delete: {
    'default': Icons.delete_outline,
    'ios': CupertinoIcons.delete
  },
  IconName.none: _iconMissing
};

class PariyattiIcons {
  static IconData get(IconName name) {
    final icons = _iconMap[name] ?? _iconMissing;
    if (icons.containsKey(Platform.operatingSystem)) {
      return icons[Platform.operatingSystem] ?? _iosMissing;
    } else {
      return icons['default'] ?? _androidMissing;
    }
  }
} 