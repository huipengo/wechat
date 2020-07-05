import 'dart:async';
import 'dart:io';

void main() {
  _testTask();
}

/// 代码的实际运行过程如下：
/// 首先还是依次执行打印 flow start ；
/// 执行 Timer 为事件任务，添加事件任务队列中；
/// 执行 scheduleMicrotask 为微任务，添加到微任务队列中；
/// 打印 end ；
/// 执行微任务队列，打印 microtask ，其中包括了事件任务，将事件任务插入到事件任务中；
/// 执行事件任务队列，打印 event ，其中包括了微任务，将微任务插入到微任务队列中；
/// 微任务队列存在微任务，执行微任务队列，打印 microtask in event；
/// 微任务队列为空，存在事件任务队列，执行事件任务队列，打印 event in microtask；
/// *
_testTask() {
  print('1 flow start'); // 执行打印开始
  // 执行判断为事件任务，添加到事件任务队列
  Timer.run(() {
    print('4 event'); // 执行事件任务，打印事件任务标记
    // 执行判断为微任务，添加到微任务队列
    scheduleMicrotask(() {
      print('5 microtask in event'); // 执行微任务，打印微任务标记
    });
  });
  // 执行判断为微任务，添加到微任务队列
  scheduleMicrotask(() {
    print('3 microtask'); // 执行微任务，打印微任务执行标记
    // 执行判断为事件任务，添加到事件任务队列
    Timer.run(() {
      print('6 event in microtask'); // 执行事件任务，打印事件任务标记
    });
  });
  print('2 flow end'); // 打印结束标记
}

/// 代码的实际运行过程如下：
/// 首先主线程逻辑，执行打印 start ；
/// 执行 Timer，为事件任务，将其增加到事件任务队列中；
/// 执行 scheduleMicrotask，为微任务队列，将其增加到微任务队列中；
/// 执行打印 flow end；
/// 判断是否存在微任务队列，存在则执行微任务队列，打印 mcrotask；
/// 判断是否还存在微任务队列，无则判断是否存在事件任务队列，存在执行事件任务队列，打印 event。
/// *
_testTask1() {
  print('1 flow start'); // 执行打印开始
  // 执行判断为事件任务，添加到事件任务队列
  Timer.run(() {
    print('4 event'); // 执行事件任务，打印标记
  });
  // 执行判断为微任务，添加到微任务队列
  scheduleMicrotask(() {
    print('3 microtask'); // 执行微任务，打印标记
  });
  print('2 flow end'); // 打印结束标记
}

void _testFuture() {
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

void _testFuture2() {
  print('外部代码1');
  Future(() => print('A')).then((value) => print('A 结束'));
  Future(() => print('B')).then((value) => print('B 结束'));
  Future(() => print('C')).then((value) => print('C 结束'));
  scheduleMicrotask(() {
    print('微任务 A');
  });
  print('外部代码 2');
}

void _testFuture3() {
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

void _testFuture4() {
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
