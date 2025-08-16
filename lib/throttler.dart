import 'dart:async';

class Throttler {
  Throttler({
    required this.duration,
    required this.callback,
  });
  final Duration duration;
  Timer? _timer;
  bool _isThrottling = false;
  void Function() callback;

  void run() {
    if (_isThrottling) {
      return;
    }
    callback();
    _isThrottling = true;
    _timer = Timer(duration, () {
      /// duration 이 끝나고 callback 을 실행시켜 주는게 아니라
      /// _isThrottling 상태를 false 로 바꿔줘서
      /// 이 시간이 지나서 다시 run 메서드를 호출했을 때
      /// callback 이 실행되게 만들어 줌
      _isThrottling = false;
    });
  }

  void dispose() {
    _timer?.cancel();
  }
}
