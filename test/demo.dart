import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/home_page.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class FocusTestRoute extends StatefulWidget {
  @override
  _FocusTestRouteState createState() => new _FocusTestRouteState();
}

class _FocusTestRouteState extends State<FocusTestRoute> {
  FocusNode focusNode1 = new FocusNode();
  FocusNode focusNode2 = new FocusNode();
  FocusScopeNode? focusScopeNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            autofocus: true,
            autovalidateMode: AutovalidateMode.always,
            focusNode: focusNode1,
            //关联focusNode1
            decoration: InputDecoration(labelText: "input1"),
            validator: (v) {
              return v!.trim().length > 0 ? null : "yonghu";
            },
          ),
          TextField(
            focusNode: focusNode2, //关联focusNode2
            decoration: InputDecoration(labelText: "input2"),
          ),
          Builder(
            builder: (ctx) {
              return Column(
                children: <Widget>[
                  RaisedButton(
                    child: Text("移动焦点"),
                    onPressed: () {
                      //将焦点从第一个TextField移到第二个TextField
                      // 这是一种写法 FocusScope.of(context).requestFocus(focusNode2);
                      // 这是第二种写法
                      if (null == focusScopeNode) {
                        focusScopeNode = FocusScope.of(context);
                      }
                      focusScopeNode?.requestFocus(focusNode2);
                    },
                  ),
                  RaisedButton(
                    child: Text("隐藏键盘"),
                    onPressed: () {
                      // 当所有编辑框都失去焦点时键盘就会收起
                      focusNode1.unfocus();
                      focusNode2.unfocus();
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class WillPopScopeTestRoute extends StatefulWidget {
  @override
  WillPopScopeTestRouteState createState() {
    return new WillPopScopeTestRouteState();
  }
}

class WillPopScopeTestRouteState extends State<WillPopScopeTestRoute> {
  DateTime? _lastPressedAt; //上次点击时间

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () async {
          if (_lastPressedAt == null ||
              DateTime.now().difference(_lastPressedAt!) >
                  Duration(seconds: 1)) {
            //两次点击间隔超过1秒则重新计时
            _lastPressedAt = DateTime.now();
            return false;
          }
          return true;
        },
        child: Container(
          alignment: Alignment.center,
          child: Text("1秒内连续按两次返回键退出"),
        ));
  }
}

class ListWidget extends StatefulWidget {
  @override
  _ListWidget createState() => _ListWidget();
}

class CustomScrollViewTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //因为本路由没有使用Scaffold，为了让子级Widget(如Text)使用
    //Material Design 默认的样式风格,我们使用Material作为本路由的根。
    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          //AppBar，包含一个导航栏
          SliverAppBar(
            pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Demo'),
              background: Image.asset(
                "./images/avatar.png",
                fit: BoxFit.cover,
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: new SliverGrid(
              //Grid
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, //Grid按两列显示
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 4.0,
              ),
              delegate: new SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  //创建子widget
                  return new Container(
                    alignment: Alignment.center,
                    color: Colors.cyan[100 * (index % 9)],
                    child: new Text('grid item $index'),
                  );
                },
                childCount: 20,
              ),
            ),
          ),
          //List
          new SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: new SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  //创建列表项
                  return new Container(
                    alignment: Alignment.center,
                    color: Colors.lightBlue[100 * (index % 9)],
                    child: new Text('list item $index'),
                  );
                }, childCount: 50 //50个列表项
            ),
          ),
        ],
      ),
    );
  }
}

class _ListWidget extends State<ListWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Expanded(flex: 2, child: ListTile(title: Text("商品列表"))),
      Expanded(
        flex: 1,
        child: ListView.builder(itemBuilder: (BuildContext context, int index) {
          return ListTile(title: Text("$index"));
        }),
      ),
    ]);
  }
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _unameController = TextEditingController();
  PointerEvent? _event;
  String _operation = "No Gesture detected!"; //保存事件名
  @override
  void initState() {
    _unameController.text = "hello flutter";
    _unameController.selection = TextSelection(
        baseOffset: 2, extentOffset: _unameController.text.length);
    _unameController.addListener(() {
      print(_unameController.text);
    });
  }

  Future<String> mockNetworkData() async {
    return Future.delayed(Duration(seconds: 2), () => "我是从互联网上获取的数据");
  }

  Stream<int> counter() {
    return Stream.periodic(Duration(seconds: 1), (i) {
      return i;
    });
  }

  void updateText(String text) {
    //更新显示的事件名
    setState(() {
      _operation = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget divider1 = Divider(
      color: Colors.blue,
    );
    Widget divider2 = Divider(color: Colors.green);
    //   Scrollbar(child: SingleChildScrollView(
    //   padding: EdgeInsets.all(16),
    //   child: Center(
    //     child: Column(
    //       children: "abcdefglishjqkipqrstyuvwxyz".split("").map((e) => Text(e,textScaleFactor: 2.0,)).toList(),
    //     ),
    //   ),
    // ));
    // Scaffold(
    //   appBar: AppBar(
    //     title: Text("New route"),
    //   ),
    //   body: Column(
    //     children: <Widget>[
    //       TextField(
    //         autofocus: true,
    //         decoration: InputDecoration(
    //             labelText: "用户名",
    //             hintText: "用户名或邮箱",
    //             prefixIcon: Icon(Icons.person)),
    //         controller: _unameController,
    //       ),
    //       TextField(
    //         decoration: InputDecoration(
    //             labelText: "密码",
    //             hintText: "您的登录密码",
    //             prefixIcon: Icon(Icons.lock)),
    //         obscureText: true,
    //       ),
    //       ElevatedButton.icon(
    //         icon: Icon(Icons.ac_unit),
    //         label: Text("This is new route"),
    //         onPressed: () {
    //           Navigator.pushNamed(context, "new_page");
    //           // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //           //   return SwitchAndCheckBoxTestRoute();
    //           // }));
    //         },
    //       ),
    //       ConstrainedBox(
    //         constraints: BoxConstraints(minWidth: double.infinity),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           children: <Widget>[
    //             Container(
    //               color: Colors.green,
    //               child: Padding(
    //                 padding: const EdgeInsets.all(16.0),
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   mainAxisSize: MainAxisSize.max, //有效，外层Colum高度为整个屏幕
    //                   children: <Widget>[
    //                     Expanded(
    //                       child: Container(
    //                         color: Colors.red,
    //                         child: Column(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           //垂直方向居中对齐
    //                           children: <Widget>[
    //                             Text("hello world "),
    //                             Text("I am Jack "),
    //                           ],
    //                         ),
    //                       ),
    //                     )
    //                   ],
    //                 ),
    //               ),
    //             ),
    //             Text("hi"),
    //             Text("world"),
    //           ],
    //         ),
    //       )
    //     ],
    //   )
    //   // body: IconButton(
    //   //   icon: Icon(Icons.add),
    //   //   onPressed: () {
    //   //     Navigator.pushNamed(context, "new_page");
    //   //     // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   //     //   return HomePage();
    //   //     // }));
    //   //   },
    //   // ),
    //   // body: ListView(
    //   //   children: <Widget>[
    //   //     Column(
    //   //       children: <Widget>[
    //   //         Image.asset(
    //   //           'assets/imgs/nothing.png',
    //   //           fit: BoxFit.contain,
    //   //           width: MediaQuery.of(context).size.width / 2,
    //   //         ),
    //   //         Text('暂无收藏，赶紧去收藏一个吧!'),
    //   //       ],
    //   //     ),
    //   //   ],
    //   // ),
    //   // body: ParentWidgetC(),
    //   );

    return Material(
      // body: ListView.separated(
      //   itemCount: 100,
      //   //列表项构造器
      //   itemBuilder: (BuildContext context, int index) {
      //     return ListTile(title: Text("$index"));
      //   },
      //   //分割器构造器
      //   separatorBuilder: (BuildContext context, int index) {
      //     return index % 2 == 0 ? divider1 : divider2;
      //   },
      // ),
      // body: new ListWidget(),
      // body: new CustomScrollViewTestRoute(),
      // child: new WillPopScopeTestRoute(),
      // child: Center(
      //   child: FutureBuilder<String>(
      //     future: mockNetworkData(),
      //     builder: (context, snapshot) {
      //       if(snapshot.connectionState == ConnectionState.done){
      //         if(snapshot.hasError){
      //           return Text("${snapshot.error}");
      //         }else {
      //           // 请求成功，显示数据
      //           return Text("Contents: ${snapshot.data}");
      //         }
      //       }
      //       return CircularProgressIndicator();
      //     },
      //   ),
      // ),
      // child: StreamBuilder<int>(
      //   stream: counter(), //
      //   //initialData: ,// a Stream<int> or null
      //   builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
      //     if (snapshot.hasError)
      //       return Text('Error: ${snapshot.error}');
      //     switch (snapshot.connectionState) {
      //       case ConnectionState.none:
      //         return Text('没有Stream');
      //       case ConnectionState.waiting:
      //         return Text('等待数据...');
      //       case ConnectionState.active:
      //         return Text('active: ${snapshot.data}');
      //       case ConnectionState.done:
      //         return Text('Stream已关闭');
      //     }
      //   },
      // ),
      // child: Listener(
      //   child: Container(
      //     alignment: Alignment.center,
      //     color: Colors.blue,
      //     width: 300.0,
      //     height: 150.0,
      //     child: Text(_event?.toString() ?? "",
      //         style: TextStyle(color: Colors.white)),
      //   ),
      //   onPointerDown: (event) =>
      //       setState(() => _event = event),
      //   onPointerMove: (PointerMoveEvent event) =>
      //       setState(() => _event = event),
      //   onPointerUp: (PointerUpEvent event) => setState(() => _event = event),
      // ),
      // child: Center(
      //   child: GestureDetector(
      //     child: Container(
      //       alignment: Alignment.center,
      //       color: Colors.blue,
      //       width: 200.0,
      //       height: 100.0,
      //       child: Text(_operation,
      //         style: TextStyle(color: Colors.white),
      //       ),
      //     ),
      //     onTap: () => updateText("Tap"),//点击
      //     onDoubleTap: () => updateText("DoubleTap"), //双击
      //     onLongPress: () => updateText("LongPress"), //长按
      //   ),
      // ),
      // child: BothDirectionTestRoute(),
      // child: NotificationRoute(),
      child: ScaleAnimationRoute(),
    );
  }
}

class HeroAnimationRouteB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
        tag: "avatar", //唯一标记，前后两个路由页Hero的tag必须相同
        child: Image.asset("images/avatar.png"),
      ),
    );
  }
}

class HeroAnimationRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: InkWell(
        child: Hero(
          tag: "avatar", //唯一标记，前后两个路由页Hero的tag必须相同
          child: ClipOval(
            child: Image.asset("images/avatar.png",
              width: 50.0,
            ),
          ),
        ),
        onTap: () {
          // //打开B路由
          // Navigator.push(context, PageRouteBuilder(
          //     pageBuilder: (BuildContext context, Animation animation,
          //         Animation secondaryAnimation) {
          //       return new FadeTransition(
          //         opacity: animation,
          //         child: Scaffold(
          //           appBar: AppBar(
          //             title: Text("原图"),
          //           ),
          //           body: HeroAnimationRouteB(),
          //         ),
          //       );
          //     })
          // );
        },
      ),
    );
  }
}

class ScaleAnimationRoute extends StatefulWidget {
  @override
  _ScaleAnimationRouteState createState() => new _ScaleAnimationRouteState();
}

class _ScaleAnimationRouteState extends State<ScaleAnimationRoute> with SingleTickerProviderStateMixin{

  Animation<double>? animation;
  AnimationController? controller;

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(seconds: 3), vsync: this);
    //图片宽高从0变到300
    animation=CurvedAnimation(parent: controller!, curve: Curves.bounceIn);
    animation = new Tween(begin: 0.0, end: 300.0).animate(animation!)
      ..addListener(() {
        setState(()=>{});
      });
    //启动动画(正向执行)
    controller?.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Image.asset("./assets/imgs/nothing.png",
          width: animation!.value,
          height: animation!.value
      ),
    );
  }

  dispose() {
    //路由销毁时需要释放动画资源
    controller?.dispose();
    super.dispose();
  }
}

class NotificationRoute extends StatefulWidget {
  @override
  NotificationRouteState createState() {
    return new NotificationRouteState();
  }
}

class NotificationRouteState extends State<NotificationRoute> {
  String _msg="";
  @override
  Widget build(BuildContext context) {
    //监听通知
    return NotificationListener<MyNotification>(
      onNotification: (notification) {
        setState(() {
          _msg+=notification.msg+"  ";
        });
        return true;
      },
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
//          RaisedButton(
//           onPressed: () => MyNotification("Hi").dispatch(context),
//           child: Text("Send Notification"),
//          ),
            Builder(
              builder: (context) {
                return RaisedButton(
                  //按钮点击时分发通知
                  onPressed: () => MyNotification("Hi").dispatch(context),
                  child: Text("Send Notification"),
                );
              },
            ),
            Text(_msg)
          ],
        ),
      ),
    );
  }
}

class MyNotification extends Notification {
  MyNotification(this.msg);
  final String msg;
}

class BothDirectionTestRoute extends StatefulWidget {
  @override
  BothDirectionTestRouteState createState() =>
      new BothDirectionTestRouteState();
}

class BothDirectionTestRouteState extends State<BothDirectionTestRoute> {
  double _top = 0.0;
  double _left = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: _top,
          left: _left,
          child: GestureDetector(
            child: CircleAvatar(child: Text("A")),
            //垂直方向拖动事件
            onVerticalDragUpdate: (DragUpdateDetails details) {
              setState(() {
                _top += details.delta.dy;
              });
            },
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              setState(() {
                _left += details.delta.dx;
              });
            },
          ),
        )
      ],
    );
  }
}
class _Drag extends StatefulWidget {
  @override
  _DragState createState() => new _DragState();
}

class _ScaleTestRoute extends StatefulWidget {
  @override
  _ScaleTestRouteState createState() => new _ScaleTestRouteState();
}

class _ScaleTestRouteState extends State<_ScaleTestRoute> {
  double _width = 200.0; //通过修改图片宽度来达到缩放效果

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        //指定宽度，高度自适应
        child: Image.asset("./assets/imgs/nothing.png", width: _width),
        onScaleUpdate: (ScaleUpdateDetails details) {
          setState(() {
            //缩放倍数在0.8到10倍之间
            _width = 200 * details.scale.clamp(.8, 10.0);
          });
        },
      ),
    );
  }
}

class _DragVertical extends StatefulWidget {
  @override
  _DragVerticalState createState() => new _DragVerticalState();
}

class _DragVerticalState extends State<_DragVertical> {
  double _top = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: _top,
          child: GestureDetector(
              child: CircleAvatar(child: Text("A")),
              //垂直方向拖动事件
              onVerticalDragUpdate: (DragUpdateDetails details) {
                setState(() {
                  _top += details.delta.dy;
                });
              }),
        )
      ],
    );
  }
}

class _DragState extends State<_Drag> with SingleTickerProviderStateMixin {
  double _top = 0.0; //距顶部的偏移
  double _left = 0.0; //距左边的偏移

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: _top,
          left: _left,
          child: GestureDetector(
            child: CircleAvatar(child: Text("A")),
            //手指按下时会触发此回调
            onPanDown: (DragDownDetails e) {
              //打印手指按下的位置(相对于屏幕)
              print("用户手指按下：${e.globalPosition}");
            },
            //手指滑动时会触发此回调
            onPanUpdate: (DragUpdateDetails e) {
              //用户手指滑动时，更新偏移，重新构建
              setState(() {
                _left += e.delta.dx;
                _top += e.delta.dy;
              });
            },
            onPanEnd: (DragEndDetails e) {
              //打印滑动结束时在x、y轴上的速度
              print(e.velocity);
            },
          ),
        )
      ],
    );
  }
}

class SwitchAndCheckBoxTestRoute extends StatefulWidget {
  @override
  _SwitchAndCheckBoxTestRouteState createState() =>
      new _SwitchAndCheckBoxTestRouteState();
}

class _SwitchAndCheckBoxTestRouteState
    extends State<SwitchAndCheckBoxTestRoute> {
  bool _switchSelected = true; //维护单选开关状态
  bool _checkboxSelected = true; //维护复选框状态
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Switch(
          value: _switchSelected, //当前状态
          onChanged: (value) {
            //重新构建页面
            setState(() {
              _switchSelected = value;
            });
          },
        ),
        Checkbox(
          value: _checkboxSelected,
          activeColor: Colors.red, //选中时的颜色
          onChanged: (value) {
            setState(() {
              _checkboxSelected = value!;
            });
          },
        )
      ],
    );
  }
}

class ParentWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ParWidgetState();
}

class _ParWidgetState extends State<ParentWidget> {
  bool _active = false;

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TapboxB(active: _active, onChanged: _handleTapboxChanged),
    );
  }
}

class TapboxB extends StatelessWidget {
  final bool active;
  final ValueChanged<bool> onChanged;

  TapboxB({Key? key, this.active: false, required this.onChanged})
      : super(key: key);

  void _handleTap() {
    onChanged(!active);
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: _handleTap,
      child: new Container(
        child: new Center(
          child: new Text(
            active ? 'Active' : 'Inactive',
            style: new TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: new BoxDecoration(
          color: active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
      ),
    );
  }
}

//---------------------------- ParentWidget ----------------------------

class ParentWidgetC extends StatefulWidget {
  @override
  _ParentWidgetCState createState() => new _ParentWidgetCState();
}

class _ParentWidgetCState extends State<ParentWidgetC> {
  bool _active = false;

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new TapboxC(
        active: _active,
        onChanged: _handleTapboxChanged,
      ),
    );
  }
}

//----------------------------- TapboxC ------------------------------

class TapboxC extends StatefulWidget {
  TapboxC({Key? key, this.active: false, required this.onChanged})
      : super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  @override
  _TapboxCState createState() => new _TapboxCState();
}

class _TapboxCState extends State<TapboxC> {
  bool _highlight = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTap() {
    widget.onChanged(!widget.active);
  }

  @override
  Widget build(BuildContext context) {
    // 在按下时添加绿色边框，当抬起时，取消高亮
    return new GestureDetector(
      onTapDown: _handleTapDown,
      // 处理按下事件
      onTapUp: _handleTapUp,
      // 处理抬起事件
      onTap: _handleTap,
      onTapCancel: _handleTapCancel,
      child: new Container(
        child: new Center(
          child: new Text(widget.active ? 'Active' : 'Inactive',
              style: new TextStyle(fontSize: 32.0, color: Colors.white)),
        ),
        width: 200.0,
        height: 200.0,
        decoration: new BoxDecoration(
          color: widget.active ? Colors.lightGreen[700] : Colors.grey[600],
          border: _highlight
              ? new Border.all(
            color: Colors.teal,
            width: 10.0,
          )
              : null,
        ),
      ),
    );
  }
}
