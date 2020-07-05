import 'dart:isolate';

Isolate isolate;
String name = 'dart';

void main() {
  _isolateServer();
}

void _isolateServer() async {
  final receive = ReceivePort();
  isolate = await Isolate.spawn(_changeName, receive.sendPort);
  receive.listen((data) {
    print('my name is ${data}');
    print('my name is ${name}');
  });
}

void _changeName(SendPort port) {
  name = 'dart isolate';
  port.send(name);
  print('my name is ${name} in isolate');
}
