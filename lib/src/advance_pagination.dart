import 'package:flutter/material.dart';

/// AdvancePagination widget to detect scroll start and end based on given offset
class AdvancePagination extends StatelessWidget {
  const AdvancePagination({
    super.key,
    required this.child,
    this.scrollMinOffset = 0,
    this.scrollMaxOffset = 0,
    this.onPageStart,
    this.onPageEnd,
    this.isLoading = false,
    this.controller,
    this.scrollListener,
  });

  /// child widget
  final Widget child;

  /// scroll min offset
  final double scrollMinOffset;

  /// scroll max offset
  final double scrollMaxOffset;

  /// call back function when scroll start
  final Function(bool isAdvance)? onPageStart;

  /// call back function when scroll end
  final Function(bool isAdvance)? onPageEnd;

  /// is loading
  final bool isLoading;

  /// scroll controller
  final ScrollController? controller;

  /// custom scroll listener
  final Function(ScrollNotification notification)? scrollListener;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      child: child,
      onNotification: (notification) {
        /// if scroll listener is not null call it
        if (scrollListener != null) {
          scrollListener!(notification);
        }

        /// if both call back functions is null don't need to send call back  and find page offset
        if (onPageStart == null && onPageEnd == null) {
          return true;
        }

        /// only update the scroll event if scroll update notification is received
        if (notification is ScrollUpdateNotification) {
          /// if current pixel is less than or equal to min offset call page start
          if (notification.metrics.pixels <= scrollMinOffset) {
            callPageStart(isAdvance: true);
          }

          /// if current pixel is greater than or equal to max offset call page end
          if (notification.metrics.pixels >=
              notification.metrics.maxScrollExtent - scrollMaxOffset) {
            callPageEnd(isAdvance: true);
          }

          return true;
        }

        /// only update the scroll event if scroll end notification is received
        if (notification is ScrollEndNotification) {
          /// if max pixel == current pixel its end
          if (notification.metrics.maxScrollExtent == notification.metrics.pixels) {
            callPageEnd();
          }

          /// if min pixel === current pixel its start
          if (notification.metrics.minScrollExtent == notification.metrics.pixels) {
            callPageStart();
          }

          return true;
        }

        return false;
      },
    );
  }

  /// call back function when scroll start
  void callPageStart({bool isAdvance = false}) {
    if (onPageStart != null) {
      onPageStart!(isAdvance);
    }
  }

  /// call back function when scroll end
  void callPageEnd({bool isAdvance = false}) {
    if (onPageEnd != null) {
      onPageEnd!(isAdvance);
    }
  }
}