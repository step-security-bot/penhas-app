import 'dart:async';

import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:meta/meta.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import 'durations.dart';
import 'golden_test_widget_app.dart';

final testDevices = [
  const Device(
    name: 'iPhone 6',
    size: Size(375, 667),
  ),
  const Device(
    name: 'iPhone Pro',
    size: Size(390, 844),
    safeArea: EdgeInsets.only(top: 47, bottom: 34),
  ),
  const Device(
    name: 'iPhone Pro Max',
    size: Size(428, 926),
    safeArea: EdgeInsets.only(top: 47, bottom: 34),
  ),
];

@isTest
Future<void> screenshotTest(
  String description, {
  required String fileName,
  FutureOr<void> Function()? setUp,
  required Widget Function() pageBuilder,
  List<Device>? devices,
  bool skip = false,
  List<String> tags = const ['golden'],
  Duration timeout = const Duration(seconds: 5),
}) async {
  goldenTest(
    description,
    fileName: fileName,
    builder: () {
      setUp?.call();

      return GoldenTestGroup(
        columns: 3,
        children: (devices ?? testDevices)
            .map((it) => GoldenTestWidgetApp(device: it, builder: pageBuilder))
            .toList(),
      );
    },
    tags: tags,
    skip: skip,
    pumpBeforeTest: (tester) async {
      // first round of pre-caching for images that are available immediately
      await mockNetworkImages(() => precacheImages(tester));
      // this will allow all the UI to properly settle before caching images
      await tester.pump(const LongDuration());
      // second round of pre-caching for images that are available a bit later, after first frame
      return mockNetworkImages(() => precacheImages(tester)).timeout(timeout);
    },
    pumpWidget: (tester, widget) =>
        mockNetworkImages(() => tester.pumpWidget(widget)).timeout(timeout),
  ).timeout(timeout);
}

@isTest
Future<void> widgetScreenshotTest(
  String description, {
  required String fileName,
  FutureOr<void> Function()? setUp,
  required WidgetBuilder widgetBuilder,
  List<Device>? devices,
  bool skip = false,
  List<String> tags = const ['golden'],
  Duration timeout = const Duration(seconds: 5),
}) async {
  goldenTest(
    description,
    fileName: fileName,
    tags: tags,
    skip: skip,
    builder: () {
      setUp?.call();

      return DefaultAssetBundle(
        bundle: TestAssetBundle(),
        child: Builder(builder: widgetBuilder),
      );
    },
    pumpBeforeTest: (tester) async {
      // first round of pre-caching for images that are available immediately
      await mockNetworkImages(() => precacheImages(tester));
      // this will allow all the UI to properly settle before caching images
      await tester.pump(const LongDuration());
      // second round of pre-caching for images that are available a bit later, after first frame
      return mockNetworkImages(() => precacheImages(tester)).timeout(timeout);
    },
    pumpWidget: (tester, widget) =>
        mockNetworkImages(() => tester.pumpWidget(widget)).timeout(timeout),
  ).timeout(timeout);
}
