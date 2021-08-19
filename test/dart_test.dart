import 'dart:async';
import 'dart:io';
import 'dart:isolate';


void main() {
  //------------基本数据类型-------------------------------
  String name = "name";
  String name2 = '‘name2’';
  int i = 13;
  String title = "Hello world = ${i / 2}";
  print(title);

  var num;
  num = "";
  num = 0;
  num++;
  print(num);

  var result;
  result = "newStr";
  print(result.runtimeType);
  result = 123;
  print(result.runtimeType);

  var test = Test();
  test
    ..arg1 = "123"
    ..arg2 = 123;

  // test ?? new Test();
  // test ??= new Test();

  //---------------list-----------------------------------
  List list1 = [1, 2, 3, "23", "str", Test()];
  var list3 = null;
  var list4 = ["1", "2", ...?list3];
  print(list1);
  for (int i = 0; i < list1.length; i++) {
    // print(list1[i]);
  }
  for (int i = 0; i < list4.length; i++) {
    // print(list4[i]);
  }

  //------------set   具有唯一性---------------------------------------
  Set<String> names = {"hello", "world"};
  names.add("value");
  names.add("value");
  print(names.lookup("value"));
  print(names);

  //--------------------map key唯一------------------------------
  Map<String, String> maps = {'key': 'value', 'key2': 'value2', 'key': 'value'};
  maps['key2'] = 'new Key';
  maps["key3"] = 'new key3';

  print(maps);

  //*---------------------函数*------------------
  void testFun(String arg1, String arg2, {branch = "dev"}) {
    print(arg1 + arg2 + branch);
  }

  testFun("arg1", "arg2", branch: "tsts");
  //
  // doWhat(String name) {
  //   return "$name";
  // }
  //
  // void doNext(int next) {
  //   next += 1;
  // }

  doSomeThing(bool check()) {
    if (check()) {}
  }

  doSomeThing(() => false);

  init();
  init2();

  //*----------------------- 线程 ------------------------------------
  //async/await 属于假异步通过任务调度实现  而不是并发   isolate是真异步
  request() async {
    await Future.delayed(Duration(seconds: 2));
    return "ok!";
  }

  doSomeThings() async {
    String str = await request();
    str = "ok from requset";
    return str;
  }

  renderSome() {
    doSomeThings().then((value) => print(value));
  }

  renderSome();
  //*****************---------------扩展------------------
  // extension ExtendsFun onString{
  //
  // }
}

Future<String> dataRequest() async {
  sleep(Duration(seconds: 5));
  return "ok";
}

void deIsolate() async {
  Isolate isolate;

  var receivePort = ReceivePort();
  isolate = await Isolate.spawn(echoResult, receivePort.sendPort);
  receivePort.listen((message) {
    print(message);
  });
}

void echoResult(SendPort port) {
  Timer.periodic(const Duration(seconds: 1), (timer) {
    port.send("do u konw me？");
  });
}

class Test {
  var arg1;
  var arg2;
}

//抽象类 可以只申明不实现
abstract class Interface {
  void doA();

  void doB();
}

class InterfaceClass {
  void doC() {}

  void doD() {}
}

class Name implements Interface, InterfaceClass {
  @override
  void doA() {
    // TODO: implement doA
  }

  @override
  void doB() {
    // TODO: implement doB
  }

  @override
  void doC() {
    // TODO: implement doC
  }

  @override
  void doD() {
    // TODO: implement doD
  }
}

//默认call函数 如果类实现了call()方法，则该类的对象可以作为方法使用
class CallObject {
  call(int i, double e) {
    print("$i xxx $e");
  }

  calllll(int i, double e) {
    print("$i xxx $e");
  }
}

//混入  从右到左依次执行
class NoneName extends Name with Interface {}

class NoName {
  String name;
  String age;

  NoName(this.name, this.age);

  NoName.name(this.name, this.age);
}

init() {
  var callObject = CallObject();
  print(callObject(11, 11.0));
  print(callObject.calllll(11, 11.0));
}

typedef void ValueFunction(int i);

ValueFunction vt = (int i) {
  print("zzz $i");
};

init2() {
  vt(666);
  vt.call(777);
}
