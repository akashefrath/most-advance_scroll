Advanced Scroll Pagination

An advanced scroll pagination package for Flutter that simplifies the implementation of paginated data loading as you scroll. Perfect for large datasets with smooth infinite scrolling.

Features
Infinite scrolling with pagination
Support for loading data asynchronously
Customizable loading indicators
Easy to integrate with existing Flutter projects


## Usage

A simple usage example:
```dart
import 'package:most_advance_scroll/most_advance_scroll.dart';
AdvanceListViewBuilder(

scrollListener: (ScrollNotification notification) {
_onScroll();
},
onPageEnd: (bool isAdvance) async {
// return;
if (!isAdvance) {


setState(() {});
}
},
controller: scrollController,
itemCount: x.length,
itemBuilder: (c, i) {
return Text(x[i]);
},
),

```