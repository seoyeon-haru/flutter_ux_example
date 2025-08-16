// 실제 서버에 날려볼 수 없으니 서버에서 요청했을 때
// 일정한 시간 뒤에 문자열이 return 되게 하는 가상의 레포지토리
class DummyRepository {
  // 메서드 호출했을 때 일정시간 후에 문자열을 리턴해주는 가상의 검색 메서드
  Future<String> search(String query) async {
    await Future.delayed(Duration(milliseconds: 500));
    return "검색결과";
  }

  // 메서드 호출했을 때 일정시간 후에 true 리턴해주는 가상의 닉네임 감시하는 메서드
  Future<bool> nicknameCk(String nickname) async {
    await Future.delayed(Duration(milliseconds: 500));
    return true;
  }
}
