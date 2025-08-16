import 'package:flutter/material.dart';
import 'package:flutter_ux_example/debouncer.dart';
import 'package:flutter_ux_example/dummy_repository.dart';
import 'package:flutter_ux_example/throttler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final nicknameController = TextEditingController();
  final searchController = TextEditingController();

  /// dummyRepository 접근하기 위해서
  final dummyRepository = DummyRepository();

  /// Homepage 내에서 정의한 멤버 변수들에 접근을 하고 있는데
  /// 이 클래스가 초기화 되지 않았는데 멤버 변수들에 접근을 하고 있어서 에러가 발생하기 때문에 late 붙임
  late final throttler = Throttler(
    duration: Duration(seconds: 3),
    callback: () async {
      /// dummy Repository 에서 검색 서치 메서드 호출해서 검색하는 거 호출
      final result = await dummyRepository.search(searchController.text);
      print('Throttler $result');
    },
  );

  late final debouncer = Debouncer(
    duration: Duration(seconds: 3),
    callback: () async {
      final result = await dummyRepository.nicknameCk(nicknameController.text);
      print('Debouncer $result');
    },
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text('닉네임 체크'),
          TextField(
            controller: nicknameController,
            onChanged: (value) {
              print('debouncer.run()');
              debouncer.run();
            },
          ),
          Text('검색'),
          TextField(
            controller: searchController,
            onSubmitted: (value) {
              print('throttler.run()');
              throttler.run();
            },
          ),
        ],
      ),
    );
  }
}
