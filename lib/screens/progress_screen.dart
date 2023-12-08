import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p4h_mobile/appstate/nav_bloc/nav_bloc.dart';
import 'package:p4h_mobile/appstate/nav_bloc/nav_events.dart';
import 'package:p4h_mobile/appstate/user_bloc/user__state_bloc.dart';
import 'package:p4h_mobile/models/progress_model.dart';
import 'package:p4h_mobile/models/resource.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              BlocProvider.of<NavigationBloc>(context).add(
                PopRoute(target: Target.mainStack),
              );
            },
          ),
          automaticallyImplyLeading: true,
        ),
        body: BlocBuilder<UserStateBloc, UserState>(builder: (
          context,
          state,
        ) {
          if (state is UserStateLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final nextState = state as UserStateSuccess;

          final progress = nextState.progress;

          // final submitCount =
          //     progress.where((element) => element.hasSubmission).length;

          return buildLinearChart(progress.toList());
        }),
      ),
    );
  }
}

Widget buildLinearChart(List<MyProgress> progressList) {
  return SfCartesianChart(
    primaryXAxis: NumericAxis(
      title: AxisTitle(text: 'Index'),
    ),
    primaryYAxis: NumericAxis(
      title: AxisTitle(text: 'Progress'),
      minimum: 0,
      maximum: 10,
      interval: 1,
    ),
    series: <ChartSeries>[
      LineSeries<MyProgress, int>(
        dataSource: progressList,
        xValueMapper: (MyProgress progress, _) => progress.id,
        yValueMapper: (MyProgress progress, _) =>
            progress.hasSubmission ? 1 : 0,
        dataLabelSettings: const DataLabelSettings(isVisible: true),
      ),
    ],
  );
}
