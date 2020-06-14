import 'dart:async';
import 'dart:io';

void testFuture() {
  Future(() {
    sleep(Duration(seconds: 2));
    return '任务 1';
  }).then((value) {
    print('$value 结束');
    return '$value 任务 2';
  }).then((value) {
    print('$value 结束');
    return '$value 任务 3';
  });
  print('任务添加完毕');
}

void testFuture2() {
  print('外部代码1');
  Future(() => print('A')).then((value) => print('A 结束'));
  Future(() => print('B')).then((value) => print('B 结束'));
  Future(() => print('C')).then((value) => print('C 结束'));
  scheduleMicrotask(() {
    print('微任务 A');
  });
  print('外部代码 2');
}

void testFuture3() {
  print('任务开始');
  Future.wait([
    Future(() {
      return '任务 1';
    }),
    Future(() {
     return '任务 2';
  }),
  ]).then((value) {
    print(value[0] + value[1]);
  });
  print('任务结束');
}

void testFuture4() {
  Future x1 = Future(() => null);
  x1.then((value) {
    print(6);
    scheduleMicrotask(() => print(7));
  }).then((value) => print(8));

  Future x = Future(() => print('1'));
  x.then((value) {
    print(4);
    Future(() => print(9));
  }).then((value) => print(10));

  Future(() => print(2));
  scheduleMicrotask(() => print(3));

  print(5);
}