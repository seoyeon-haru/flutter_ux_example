// 재사용 하기 위해서 디바운싱 기능하는 클래스 만들어줌!
import 'dart:async';

class Debouncer {
  Debouncer({
    required this.duration,
    required this.callback,
  });
  // 제일 마지막 이벤트만 실행됨
  // 디바운싱 시간을 설정할 객체
  final Duration duration;

  /// 전달받은 duration 을 카운팅을 진행해서 전달받은 callback 함수 실행시켜줄 객체
  // _를 붙이면 외부에서 접근 불가능한 프라이빗 한 상태가 됨
  /// 프라이빗으로 만든 이유는 Debouncer 클래스 내에서 Timer 할당해주고
  /// Timer 카운팅 해주는 기능을 내부적으로만 움직이게 구현하기 위해서 프라이빗으로 구현
  /// timer 는 내부적으로 생성을 시켜줘야해서 final 빼줌
  Timer? _timer;
  // 시간이 되면 실행될 함수 정의
  final Function() callback;

  /// run 은 외부에서 debouncer 객체 생성해서 호출할 함수
  /// Duration 후 callback 이 실행되게 구현!
  void run() {
    /// run 을 호출하고 duration 기간이 지나기 전에 다시 run 호출해 줬을 때
    /// _timer 를 취소 시켜주는 역할을 해야됨
    _timer?.cancel();

    /// Timer 역할은 duration 이 끝나면 뒤에 전달받은 함수를 호출해 주는 역할을 하게 됨
    _timer = Timer(duration, callback);
  }

  /// 사용자가 더 이상 Debouncer 클래스가 필요하지 않을 때 dispose 를 호출해 줘서
  /// 기존에 등록된 timer 가 취소될 수 있게 구현
  void dispose() {
    _timer?.cancel();
  }
}
