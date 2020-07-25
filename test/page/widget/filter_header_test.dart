import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterdryve/cubit/cars_feed/cars_feed_cubit.dart';
import 'package:flutterdryve/cubit/cars_filter/cars_filter_cubit.dart';
import 'package:flutterdryve/page/widget/filter_header.dart';
import 'package:mockito/mockito.dart';

import '../../mocks.dart';

void main() {
  group('FilterHeader tests', () {
    testWidgets('should close when click icon', (tester) async {
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
              body: FilterHeader(),
            ),
          ),
        ),
      );
      final closeBtn = find.byKey(const ValueKey('close-sliding'));
      expect(closeBtn, findsOneWidget);
      await tester.tap(closeBtn);
      verify(mockCarsFeedCubit.closeSlidingPanel()).called(1);
    });
  });
}
