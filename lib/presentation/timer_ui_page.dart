import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/bloc/timer_bloc.dart';
import '../logic/bloc/timer_event.dart';
import '../logic/bloc/timer_state.dart';
class TimerApp extends StatelessWidget {
 // const TimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // appBar: AppBar(title: const Text('Timer')),
      body: BlocProvider(
        create: (_) => TimerBloc(),
        child: TimerPage(),
      ),
    );
  }
}


class TimerPage extends StatelessWidget {
 // const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Timer with Headshot and Screenshot')),
      body: BlocBuilder<TimerBloc, TimerState>(
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  state.formattedDuration,
                  style: TextStyle(fontSize: 48.0),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => context.read<TimerBloc>().add(StartTimer()),
                      child: Text('Start'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => context.read<TimerBloc>().add(StopTimer()),
                      child: Text('Stop'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => context.read<TimerBloc>().add(ResetTimer()),
                      child: Text('Reset'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => context.read<TimerBloc>().add(CaptureHeadshot()),
                      child: Text('Headshot'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => context.read<TimerBloc>().add(CaptureScreenshot()),
                      child: Text('Screenshot'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                if (state.headshot != null)
                  Image.file(state.headshot!, height: 100, width: 100),
                if (state.screenshot != null)
                  Image.file(state.screenshot!, height: 100, width: 100),
              ],
            ),
          );
        },
      ),
    );
  }
}