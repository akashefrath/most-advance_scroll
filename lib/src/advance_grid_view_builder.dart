import 'package:flutter/material.dart';

import 'advance_pagination.dart';

class AdvanceGridViewBuilder extends StatelessWidget {
  const AdvanceGridViewBuilder({
    super.key,
    required this.itemBuilder,
    this.loadingChild,
    this.scrollMinOffset = 0,
    this.scrollMaxOffset = 0,
    this.onPageStart,
    this.onPageEnd,
    this.isLoading = false,
    this.controller,
    this.itemCount = 10,
    required this.gridDelegate,
    this.physics,
    this.shrinkWrap = false,
    this.scrollListener,
    this.lastItemOnVisible,
  });

  final Function(BuildContext, int) itemBuilder;
  final Widget? loadingChild;

  /// to advance pagination
  final double scrollMinOffset;
  final double scrollMaxOffset;
  final Function(bool isAdvance)? onPageStart;
  final Function(bool isAdvance)? onPageEnd;
  final bool isLoading;

  ///
  final ScrollController? controller;

  /// to advance pagination
  final int? itemCount;
  final SliverGridDelegate gridDelegate;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final Function(ScrollNotification notification)? scrollListener;
  final Function(int index)? lastItemOnVisible;

  @override
  Widget build(BuildContext context) {
    return AdvancePagination(
      scrollMaxOffset: scrollMaxOffset,
      scrollMinOffset: scrollMinOffset,
      onPageEnd: onPageEnd,
      onPageStart: onPageStart,
      isLoading: isLoading,
      controller: controller,
      scrollListener: scrollListener,
      child: GridView.builder(
        controller: controller,
        itemCount: itemCount,
        gridDelegate: gridDelegate,
        physics: physics,
        shrinkWrap: shrinkWrap,
        itemBuilder: (context, index) {
          final isLast = index + 1 == itemCount;
          if (lastItemOnVisible != null) {
            lastItemOnVisible!(index);
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              itemBuilder(
                context,
                index,
              ),
              if (isLast && isLoading && loadingChild != null) loadingChild!,
            ],
          );
        },
      ),
    );
  }
}