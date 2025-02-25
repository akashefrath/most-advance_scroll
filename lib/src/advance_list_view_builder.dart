import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../most_advance_scroll.dart';

class AdvanceListViewBuilder extends StatelessWidget {
  const AdvanceListViewBuilder({
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
    this.scrollDirection = Axis.vertical,
    this.physics,
    this.shrinkWrap = false,
    this.scrollListener,
    this.lastItemOnVisible,
    this.totalCount,
    this.needRefreshIndicator = false,
    this.onRefresh,
    this.padding,
    this.reverse = false,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    this.clipBehavior = Clip.hardEdge,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.semanticChildCount,
    this.findChildIndexCallback,
    this.hitTestBehavior = HitTestBehavior.deferToChild,
    this.itemExtent,
    this.itemExtentBuilder,
    this.primary = false,
    this.prototypeItem,
  });

  final Function(BuildContext, int) itemBuilder;
  final Widget? loadingChild;

  /// to advance pagination
  final double scrollMinOffset;
  final double scrollMaxOffset;
  final Function(bool isAdvance)? onPageStart;
  final Function(bool isAdvance, [bool onEndCount])? onPageEnd;
  final bool isLoading;

  ///
  final ScrollController? controller;

  /// to advance pagination
  final int? itemCount;
  final Axis scrollDirection;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final Function(ScrollNotification notification)? scrollListener;
  final Function(int index)? lastItemOnVisible;
  final EdgeInsetsGeometry? padding;
  final bool reverse;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double? cacheExtent;
  final Clip clipBehavior;
  final DragStartBehavior dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final String? restorationId;
  final int? semanticChildCount;
  final int? Function(Key)? findChildIndexCallback;
  final HitTestBehavior hitTestBehavior;
  final double? itemExtent;
  final ItemExtentBuilder? itemExtentBuilder;
  final bool primary;
  final Widget? prototypeItem;

  /// this will prevent pagination if list reach total count or page
  final int? totalCount;

  /// to enable refresh indicator for refresh page
  final bool needRefreshIndicator;

  /// call back for refresh
  final Function? onRefresh;
  @override
  Widget build(BuildContext context) {
    return AdvancePagination(
      needRefreshIndicator: needRefreshIndicator,
      onRefresh: onRefresh,
      scrollMaxOffset: scrollMaxOffset,
      scrollMinOffset: scrollMinOffset,
      onPageEnd: (bool isAdvance) {
        onPageEnd!(
          isAdvance,
          totalCount != null && totalCount! >= (itemCount ?? 0),
        );
      },
      onPageStart: onPageStart,
      isLoading: isLoading,
      controller: controller,
      scrollListener: scrollListener,
      child: ListView.builder(
        key: key,
        reverse: reverse,
        padding: padding,
        addAutomaticKeepAlives: addAutomaticKeepAlives,
        addRepaintBoundaries: addRepaintBoundaries,
        addSemanticIndexes: addSemanticIndexes,
        cacheExtent: cacheExtent,
        clipBehavior: clipBehavior,
        dragStartBehavior: dragStartBehavior,
        keyboardDismissBehavior: keyboardDismissBehavior,
        restorationId: restorationId,
        semanticChildCount: semanticChildCount,
        findChildIndexCallback: findChildIndexCallback,
        hitTestBehavior: hitTestBehavior,
        itemExtent: itemExtent,
        itemExtentBuilder: itemExtentBuilder,
        primary: primary,
        prototypeItem: prototypeItem,
        controller: controller,
        itemCount: itemCount,
        scrollDirection: scrollDirection,
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
