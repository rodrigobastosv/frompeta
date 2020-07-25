import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterdryve/cubit/cars_feed/cars_feed_cubit.dart';
import 'package:flutterdryve/cubit/cars_filter/cars_filter_cubit.dart';
import 'package:flutterdryve/page/widget/settings_button.dart';
import 'package:mockito/mockito.dart';

import '../../mocks.dart';

void main() {
  group('SettingsButton tests', () {
    testWidgets('should build without exploding', (tester) async {
      final mockCarsFeedCubit = MockCarsFeedCubit();
      final mockCarsFilterCubit = MockCarsFilterCubit();
      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<CarsFeedCubit>(
                create: (_) => mockCarsFeedCubit,
              ),
              BlocProvider<CarsFilterCubit>(
                create: (_) => mockCarsFilterCubit,
              ),
            ],
            child: Scaffold(
              body: SettingsButton(),
            ),
          ),
        ),
      );
    });

    testWidgets('should open the sliding panel', (tester) async {
      final mockCarsFeedCubit = MockCarsFeedCubit();
      final mockCarsFilterCubit = MockCarsFilterCubit();
      final mockPanelController = MockPanelController();
      when(mockPanelController.isAttached).thenReturn(true);
      when(mockPanelController.isPanelOpen).thenReturn(false);
      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<CarsFeedCubit>(
                create: (_) => mockCarsFeedCubit,
              ),
              BlocProvider<CarsFilterCubit>(
                create: (_) => mockCarsFilterCubit,
              ),
            ],
            child: Scaffold(
              body: SettingsButton(
                panelController: mockPanelController,
              ),
            ),
          ),
        ),
      );
      final btn = find.byType(IconButton);
      expect(btn, findsOneWidget);
      await tester.tap(btn);
      verify(mockPanelController.open()).called(1);
      verify(mockCarsFeedCubit.openSlidingPanel()).called(1);
    });

    testWidgets('should close the sliding panel', (tester) async {
      final mockCarsFeedCubit = MockCarsFeedCubit();
      final mockCarsFilterCubit = MockCarsFilterCubit();
      final mockPanelController = MockPanelController();
      when(mockPanelController.isAttached).thenReturn(true);
      when(mockPanelController.isPanelOpen).thenReturn(true);
      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<CarsFeedCubit>(
                create: (_) => mockCarsFeedCubit,
              ),
              BlocProvider<CarsFilterCubit>(
                create: (_) => mockCarsFilterCubit,
              ),
            ],
            child: Scaffold(
              body: SettingsButton(
                panelController: mockPanelController,
              ),
            ),
          ),
        ),
      );
      final btn = find.byType(IconButton);
      expect(btn, findsOneWidget);
      await tester.tap(btn);
      verify(mockPanelController.close()).called(1);
    });
  });
}
