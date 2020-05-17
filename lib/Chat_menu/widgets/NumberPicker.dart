// TODO Implement this library.


import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:infinite_listview/infinite_listview.dart';
import 'package:flutterapp/Chat_menu/config/Style.dart';


class NumberPicker extends StatelessWidget {

  static const double kDefaultItemExtent = 50.0;



  static const double kDefaultListViewCrossAxisSize = 100.0;

  NumberPicker.horizontal({
    Key key,
    @required int initialValue,
    @required this.minValue,
    @required this.maxValue,
    @required this.onChanged,
    this.itemExtent = kDefaultItemExtent,
    this.listViewHeight = kDefaultListViewCrossAxisSize,
    this.step = 1,
    this.zeroPad = false,
    this.highlightSelectedValue = true,
    this.decoration,
  })  : assert(initialValue != null),
        assert(minValue != null),
        assert(maxValue != null),
        assert(maxValue > minValue),
        assert(initialValue >= minValue && initialValue <= maxValue),
        assert(step > 0),
        selectedIntValue = initialValue,
        selectedDecimalValue = -1,
        decimalPlaces = 0,
        intScrollController = new ScrollController(
          initialScrollOffset: (initialValue - minValue) ~/ step * itemExtent,
        ),
        scrollDirection = Axis.horizontal,
        decimalScrollController = null,
        listViewWidth = 3 * itemExtent,
        infiniteLoop = false,
        integerItemCount = (maxValue - minValue) ~/ step + 1,
        super(key: key);

  NumberPicker.integer({
    Key key,
    @required int initialValue,
    @required this.minValue,
    @required this.maxValue,
    @required this.onChanged,
    this.itemExtent = kDefaultItemExtent,
    this.listViewWidth = kDefaultListViewCrossAxisSize,
    this.step = 1,
    this.scrollDirection = Axis.vertical,
    this.infiniteLoop = false,
    this.zeroPad = false,
    this.highlightSelectedValue = true,
    this.decoration,
  })  : assert(initialValue != null),
        assert(minValue != null),
        assert(maxValue != null),
        assert(maxValue > minValue),
        assert(initialValue >= minValue && initialValue <= maxValue),
        assert(step > 0),
        assert(scrollDirection != null),
        selectedIntValue = initialValue,
        selectedDecimalValue = -1,
        decimalPlaces = 0,
        intScrollController = infiniteLoop
            ? new InfiniteScrollController(
          initialScrollOffset:
          (initialValue - minValue) ~/ step * itemExtent,
        )
            : new ScrollController(
          initialScrollOffset:
          (initialValue - minValue) ~/ step * itemExtent,
        ),
        decimalScrollController = null,
        listViewHeight = 3 * itemExtent,
        integerItemCount = (maxValue - minValue) ~/ step + 1,
        super(key: key);

  NumberPicker.decimal({
    Key key,
    @required double initialValue,
    @required this.minValue,
    @required this.maxValue,
    @required this.onChanged,
    this.decimalPlaces = 1,
    this.itemExtent = kDefaultItemExtent,
    this.listViewWidth = kDefaultListViewCrossAxisSize,
    this.highlightSelectedValue = true,
    this.decoration,
  })  : assert(initialValue != null),
        assert(minValue != null),
        assert(maxValue != null),
        assert(decimalPlaces != null && decimalPlaces > 0),
        assert(maxValue > minValue),
        assert(initialValue >= minValue && initialValue <= maxValue),
        selectedIntValue = initialValue.floor(),
        selectedDecimalValue = ((initialValue - initialValue.floorToDouble()) *
            math.pow(10, decimalPlaces))
            .round(),
        intScrollController = new ScrollController(
          initialScrollOffset: (initialValue.floor() - minValue) * itemExtent,
        ),
        decimalScrollController = new ScrollController(
          initialScrollOffset: ((initialValue - initialValue.floorToDouble()) *
              math.pow(10, decimalPlaces))
              .roundToDouble() *
              itemExtent,
        ),
        listViewHeight = 3 * itemExtent,
        step = 1,
        scrollDirection = Axis.vertical,
        integerItemCount = maxValue.floor() - minValue.floor() + 1,
        infiniteLoop = false,
        zeroPad = false,
        super(key: key);

  final ValueChanged<num> onChanged;

  final int minValue;///maksymlna wartosc ktora moze podac user

  final int maxValue;///minimalna wartosc ktora moze podac user


  /// e.g. 0=>[1,2,3...], 1=>[1.0, 1.1, 1.2...]  2=>[1.00, 1.01, 1.02...]
  final int decimalPlaces;

  final double itemExtent;

  final double listViewHeight;

  final double listViewWidth;

  final ScrollController intScrollController;

  final ScrollController decimalScrollController;

  final int selectedIntValue;

  final int selectedDecimalValue;

  final bool highlightSelectedValue;

  final Decoration decoration;

  final int step;

  final Axis scrollDirection;

  final bool infiniteLoop;

  final bool zeroPad;

  final int integerItemCount;

  //
  //----------------------------- PUBLIC ------------------------------
  //

  void animateInt(int valueToSelect) {
    int diff = valueToSelect - minValue;
    int index = diff ~/ step;
    animateIntToIndex(index);
  }

  void animateIntToIndex(int index) {
    _animate(intScrollController, index * itemExtent);
  }

  void animateDecimal(int decimalValue) {
    _animate(decimalScrollController, decimalValue * itemExtent);
  }

  void animateDecimalAndInteger(double valueToSelect) {
    animateInt(valueToSelect.floor());
    animateDecimal(((valueToSelect - valueToSelect.floorToDouble()) *
        math.pow(10, decimalPlaces))
        .round());
  }

  //
  //----------------------------- VIEWS -----------------------------
  //

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    if (infiniteLoop) {
      return _integerInfiniteListView(themeData);
    }
    if (decimalPlaces == 0) {
      return _integerListView(themeData);
    } else {
      return new Row(
        children: <Widget>[
          _integerListView(themeData),
          _decimalListView(themeData),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      );
    }
  }

  Widget _integerListView(ThemeData themeData) {
    TextStyle defaultStyle = Styles.textLight;
    TextStyle selectedStyle = Styles.numberPickerHeading;

    var listItemCount = integerItemCount + 2;

    return Listener(
      onPointerUp: (ev) {
        if (intScrollController.position.activity is HoldScrollActivity) {
          animateInt(selectedIntValue);
        }
      },
      child: new NotificationListener(
        child: new Container(
          height: listViewHeight,
          width: listViewWidth,
          child: Stack(
            children: <Widget>[
              new ListView.builder(
                scrollDirection: scrollDirection,
                controller: intScrollController,
                itemExtent: itemExtent,
                itemCount: listItemCount,
                cacheExtent: _calculateCacheExtent(listItemCount),
                itemBuilder: (BuildContext context, int index) {
                  final int value = _intValueFromIndex(index);
                  final TextStyle itemStyle =
                  value == selectedIntValue && highlightSelectedValue
                      ? selectedStyle
                      : defaultStyle;

                  bool isExtra = index == 0 || index == listItemCount - 1;

                  return isExtra
                      ? new Container()
                      : new Center(
                    child: new Text(
                      getDisplayedValue(value),
                      style: itemStyle,
                    ),
                  );
                },
              ),
              _NumberPickerSelectedItemDecoration(
                axis: scrollDirection,
                itemExtent: itemExtent,
                decoration: decoration,
              ),
            ],
          ),
        ),
        onNotification: _onIntegerNotification,
      ),
    );
  }

  Widget _decimalListView(ThemeData themeData) {
    TextStyle defaultStyle = themeData.textTheme.body1;
    TextStyle selectedStyle = Styles.numberPickerHeading;

    int decimalItemCount =
    selectedIntValue == maxValue ? 3 : math.pow(10, decimalPlaces) + 2;

    return Listener(
      onPointerUp: (ev) {
        if (decimalScrollController.position.activity is HoldScrollActivity) {
          animateDecimal(selectedDecimalValue);
        }
      },
      child: new NotificationListener(
        child: new Container(
          height: listViewHeight,
          width: listViewWidth,
          child: Stack(
            children: <Widget>[
              new ListView.builder(
                controller: decimalScrollController,
                itemExtent: itemExtent,
                itemCount: decimalItemCount,
                itemBuilder: (BuildContext context, int index) {
                  final int value = index - 1;
                  final TextStyle itemStyle =
                  value == selectedDecimalValue && highlightSelectedValue
                      ? selectedStyle
                      : defaultStyle;

                  bool isExtra = index == 0 || index == decimalItemCount - 1;

                  return isExtra
                      ? new Container()
                      : new Center(
                    child: new Text(
                        value.toString().padLeft(decimalPlaces, '0'),
                        style: itemStyle),
                  );
                },
              ),
              _NumberPickerSelectedItemDecoration(
                axis: scrollDirection,
                itemExtent: itemExtent,
                decoration: decoration,
              ),
            ],
          ),
        ),
        onNotification: _onDecimalNotification,
      ),
    );
  }

  Widget _integerInfiniteListView(ThemeData themeData) {
    TextStyle defaultStyle = themeData.textTheme.body1;
    TextStyle selectedStyle = Styles.numberPickerHeading;

    return Listener(
      onPointerUp: (ev) {
        if (intScrollController.position.activity is HoldScrollActivity) {
          _animateIntWhenUserStoppedScrolling(selectedIntValue);
        }
      },
      child: new NotificationListener(
        child: new Container(
          height: listViewHeight,
          width: listViewWidth,
          child: Stack(
            children: <Widget>[
              InfiniteListView.builder(
                controller: intScrollController,
                itemExtent: itemExtent,
                itemBuilder: (BuildContext context, int index) {
                  final int value = _intValueFromIndex(index);
                  final TextStyle itemStyle =
                  value == selectedIntValue && highlightSelectedValue
                      ? selectedStyle
                      : defaultStyle;

                  return new Center(
                    child: new Text(
                      getDisplayedValue(value),
                      style: itemStyle,
                    ),
                  );
                },
              ),
              _NumberPickerSelectedItemDecoration(
                axis: scrollDirection,
                itemExtent: itemExtent,
                decoration: decoration,
              ),
            ],
          ),
        ),
        onNotification: _onIntegerNotification,
      ),
    );
  }

  String getDisplayedValue(int value) {
    return zeroPad
        ? value.toString().padLeft(maxValue.toString().length, '0')
        : value.toString();
  }

  //
  // ----------------------------- LOGIC -----------------------------
  //

  int _intValueFromIndex(int index) {
    index--;
    index %= integerItemCount;
    return minValue + index * step;
  }

  bool _onIntegerNotification(Notification notification) {
    if (notification is ScrollNotification) {
      int intIndexOfMiddleElement =
      (notification.metrics.pixels / itemExtent).round();
      if (!infiniteLoop) {
        intIndexOfMiddleElement =
            intIndexOfMiddleElement.clamp(0, integerItemCount - 1);
      }
      int intValueInTheMiddle = _intValueFromIndex(intIndexOfMiddleElement + 1);
      intValueInTheMiddle = _normalizeIntegerMiddleValue(intValueInTheMiddle);

      if (_userStoppedScrolling(notification, intScrollController)) {
        animateIntToIndex(intIndexOfMiddleElement);
      }

      if (intValueInTheMiddle != selectedIntValue) {
        num newValue;
        if (decimalPlaces == 0) {
          newValue = (intValueInTheMiddle);
        } else {
          if (intValueInTheMiddle == maxValue) {
            newValue = (intValueInTheMiddle.toDouble());
            animateDecimal(0);
          } else {
            double decimalPart = _toDecimal(selectedDecimalValue);
            newValue = ((intValueInTheMiddle + decimalPart).toDouble());
          }
        }
        onChanged(newValue);
      }
    }
    return true;
  }

  bool _onDecimalNotification(Notification notification) {
    if (notification is ScrollNotification) {
      int indexOfMiddleElement =
          (notification.metrics.pixels + listViewHeight / 2) ~/ itemExtent;
      int decimalValueInTheMiddle = indexOfMiddleElement - 1;
      decimalValueInTheMiddle =
          _normalizeDecimalMiddleValue(decimalValueInTheMiddle);

      if (_userStoppedScrolling(notification, decimalScrollController)) {
        animateDecimal(decimalValueInTheMiddle);
      }

      if (selectedIntValue != maxValue &&
          decimalValueInTheMiddle != selectedDecimalValue) {
        double decimalPart = _toDecimal(decimalValueInTheMiddle);
        double newValue = ((selectedIntValue + decimalPart).toDouble());
        onChanged(newValue);
      }
    }
    return true;
  }

  double _calculateCacheExtent(int itemCount) {
    double cacheExtent = 250.0;
    if ((itemCount - 2) * kDefaultItemExtent <= cacheExtent) {
      cacheExtent = ((itemCount - 3) * kDefaultItemExtent);
    }
    return cacheExtent;
  }

  int _normalizeMiddleValue(int valueInTheMiddle, int min, int max) {
    return math.max(math.min(valueInTheMiddle, max), min);
  }

  int _normalizeIntegerMiddleValue(int integerValueInTheMiddle) {
    int max = (maxValue ~/ step) * step;
    return _normalizeMiddleValue(integerValueInTheMiddle, minValue, max);
  }

  int _normalizeDecimalMiddleValue(int decimalValueInTheMiddle) {
    return _normalizeMiddleValue(
        decimalValueInTheMiddle, 0, math.pow(10, decimalPlaces) - 1);
  }

  bool _userStoppedScrolling(
      Notification notification,
      ScrollController scrollController,
      ) {
    return notification is UserScrollNotification && notification.direction == ScrollDirection.idle && scrollController.position.activity is! HoldScrollActivity;
  }


  void _animateIntWhenUserStoppedScrolling(int valueToSelect) {
    int currentlySelectedElementIndex = intScrollController.offset ~/ itemExtent;

    if (intScrollController.offset > 0 &&
        intScrollController.offset % itemExtent > itemExtent / 2) {
      currentlySelectedElementIndex++;
    } else if (intScrollController.offset < 0 &&
        intScrollController.offset % itemExtent < itemExtent / 2) {
      currentlySelectedElementIndex--;
    }

    animateIntToIndex(currentlySelectedElementIndex);
  }

  double _toDecimal(int decimalValueAsInteger) {
    return double.parse((decimalValueAsInteger * math.pow(10, -decimalPlaces))
        .toStringAsFixed(decimalPlaces));
  }

  _animate(ScrollController scrollController, double value) {
    scrollController.animateTo(value,
        duration: new Duration(seconds: 1), curve: new ElasticOutCurve());
  }
}

class _NumberPickerSelectedItemDecoration extends StatelessWidget {
  final Axis axis;
  final double itemExtent;
  final Decoration decoration;

  const _NumberPickerSelectedItemDecoration(
      {Key key,
        @required this.axis,
        @required this.itemExtent,
        @required this.decoration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new IgnorePointer(
        child: new Container(
          width: isVertical ? double.infinity : itemExtent,
          height: isVertical ? itemExtent : double.infinity,
          decoration: decoration,
        ),
      ),
    );
  }

  bool get isVertical => axis == Axis.vertical;
}

class NumberPickerDialog extends StatefulWidget {
  final int minValue;
  final int maxValue;
  final int initialIntegerValue;
  final double initialDoubleValue;
  final int decimalPlaces;
  final Widget title;
  final EdgeInsets titlePadding;
  final Widget confirmWidget;
  final Widget cancelWidget;
  final int step;
  final bool infiniteLoop;
  final bool zeroPad;
  final bool highlightSelectedValue;
  final Decoration decoration;

  NumberPickerDialog.integer({
    @required this.minValue,
    @required this.maxValue,
    @required this.initialIntegerValue,
    this.title,
    this.titlePadding,
    this.step = 1,
    this.infiniteLoop = false,
    this.zeroPad = false,
    this.highlightSelectedValue = true,
    this.decoration,
    Widget confirmWidget,
    Widget cancelWidget,
  })  : confirmWidget = confirmWidget ?? new Text("OK"),
        cancelWidget = cancelWidget ?? new Text("CANCEL"),
        decimalPlaces = 0,
        initialDoubleValue = -1.0;

  NumberPickerDialog.decimal({
    @required this.minValue,
    @required this.maxValue,
    @required this.initialDoubleValue,
    this.decimalPlaces = 1,
    this.title,
    this.titlePadding,
    this.highlightSelectedValue = true,
    this.decoration,
    Widget confirmWidget,
    Widget cancelWidget,
  })  : confirmWidget = confirmWidget ?? new Text("OK"),
        cancelWidget = cancelWidget ?? new Text("CANCEL"),
        initialIntegerValue = -1,
        step = 1,
        infiniteLoop = false,
        zeroPad = false;

  @override
  State<NumberPickerDialog> createState() =>
      new _NumberPickerDialogControllerState(
          initialIntegerValue, initialDoubleValue);
}

class _NumberPickerDialogControllerState extends State<NumberPickerDialog> {
  int selectedIntValue;
  double selectedDoubleValue;

  _NumberPickerDialogControllerState(
      this.selectedIntValue, this.selectedDoubleValue);

  void _handleValueChanged(num value) {
    if (value is int) {
      setState(() => selectedIntValue = value);
    } else {
      setState(() => selectedDoubleValue = value);
    }
  }

  NumberPicker _buildNumberPicker() {
    if (widget.decimalPlaces > 0) {
      return new NumberPicker.decimal(
          initialValue: selectedDoubleValue,
          minValue: widget.minValue,
          maxValue: widget.maxValue,
          decimalPlaces: widget.decimalPlaces,
          highlightSelectedValue: widget.highlightSelectedValue,
          decoration: widget.decoration,
          onChanged: _handleValueChanged);
    } else {
      return new NumberPicker.integer(
        initialValue: selectedIntValue,
        minValue: widget.minValue,
        maxValue: widget.maxValue,
        step: widget.step,
        infiniteLoop: widget.infiniteLoop,
        zeroPad: widget.zeroPad,
        highlightSelectedValue: widget.highlightSelectedValue,
        decoration: widget.decoration,
        onChanged: _handleValueChanged,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: widget.title,
      titlePadding: widget.titlePadding,
      content: _buildNumberPicker(),
      actions: [
        new FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: widget.cancelWidget,
        ),
        new FlatButton(
            onPressed: () => Navigator.of(context).pop(widget.decimalPlaces > 0
                ? selectedDoubleValue
                : selectedIntValue),
            child: widget.confirmWidget),
      ],
    );
  }
}