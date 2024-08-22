import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'timer_event.dart';
import 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  static const int _initialDuration = 0;
  Timer? _timer;
  final ImagePicker _picker = ImagePicker();
  final ScreenshotController _screenshotController = ScreenshotController();

  TimerBloc() : super(const TimerState(duration: _initialDuration)) {
    on<StartTimer>(_onStart);
    on<StopTimer>(_onStop);
    on<ResetTimer>(_onReset);
    on<Tick>(_onTick);
    on<CaptureHeadshot>(_onCaptureHeadshot);
    on<CaptureScreenshot>(_onCaptureScreenshot);
  }

  void _onStart(StartTimer event, Emitter<TimerState> emit) {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      add(Tick(state.duration + 1));
    });
  }

  void _onStop(StopTimer event, Emitter<TimerState> emit) {
    _timer?.cancel();
  }

  void _onReset(ResetTimer event, Emitter<TimerState> emit) {
    _timer?.cancel();
    emit(const TimerState(duration: _initialDuration));
  }

  void _onTick(Tick event, Emitter<TimerState> emit) {
    emit(state.copyWith(duration: event.duration));
  }

  Future<void> _onCaptureHeadshot(CaptureHeadshot event, Emitter<TimerState> emit) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      emit(state.copyWith(headshot: File(pickedFile.path)));
    }
  }

  Future<void> _onCaptureScreenshot(CaptureScreenshot event, Emitter<TimerState> emit) async {
    final image = await _screenshotController.capture();
    print('image $image');
    if (image != null) {
      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/screenshot.png').create();
      file.writeAsBytesSync(image);
      emit(state.copyWith(screenshot: file));
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}