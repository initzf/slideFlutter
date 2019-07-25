import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  double _value = 0.75; //控制右边显示的大小
  double _left = 0; //计算横向滑动的距离，默认为0不展开
  double _width; //屏幕的宽度

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;

    return WillPopScope(
      //监听返回按钮
      onWillPop: () async {
        if (_left > 0) {
          setState(() {
            _left = 0;
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              sidemenu(context),
              contentView(context),
            ],
          ),
        ),
      ),
    );
  }

  ///主体内容
  Widget contentView(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 200),
      top: _left / 4.5,
      bottom: _left / 4.5,
      left: _left,

      ///距离左边的距离，默认是0
      right: -_left,

      ///距离右边的距离，取反就好
      child: GestureDetector(
        onTap: () {
          if (_left > 0) {
            _left = 0;
          }
          setState(() {});
        },
        onHorizontalDragUpdate: (DragUpdateDetails e) {
          ///横向滑动计算
          double temp = _left + e.delta.dx;

          ///判断边界
          if (temp <= 0 || temp > _width * _value) {
            return;
          }
          setState(() {
            _left = temp;
          });
        },
        onHorizontalDragEnd: (e) {
          ///滑动结束时，当滑动到一定的距离的时候，自动展开、或者关闭
          if (_left >= _width / 2) {
            _left = _width * _value;
          } else {
            _left = 0;
          }
          setState(() {});
        },
        child: Material(
          elevation: _left <= 0 ? 0 : 4,
          color: Colors.white,
          borderRadius: BorderRadius.circular(_left <= 0 ? 0 : 15),
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
                padding: EdgeInsets.only(left: 15, right: 15),
                decoration: BoxDecoration(
                    border: Border(bottom: Divider.createBorderSide(context))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      child:
                          Icon(_left <= 0 ? Icons.menu : Icons.arrow_back_ios),
                      onTap: () {
                        if (_left <= 0) {
                          _left = _width * _value;
                        } else {
                          _left = 0;
                        }
                        setState(() {});
                      },
                    ),
                    Text(
                      "标题",
                      style: TextStyle(fontSize: 20),
                    ),
                    Icon(Icons.add)
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, top: 10, bottom: 10),
                        child: GestureDetector(
                            onTap: () {
                              if (_left > 0) {
                                _left = 0;
                                setState(() {});
                                return;
                              }
                              print("$index");
                            },
                            child: Text("item $index")),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 侧滑的menu
  Widget sidemenu(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 200),
      top: 0,
      bottom: 0,
      left: -(_width * _value) + _left,
      right: (_width * (1 - _value)) - _left,
      child: Container(
        padding: EdgeInsets.only(left: 10, top: 20),
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              /*decoration: BoxDecoration(
                color: Colors.white
              ),*/
              currentAccountPicture: CircleAvatar(
                radius: 8.0,
                backgroundColor: Colors.brown.shade800,
                child: Text('A'),
              ),
              accountName: Text(
                "这个是用户名",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              accountEmail: Text(
                "initzf@126.com",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            Offstage(
              offstage: false,
              child: ListTile(
                title: Text(
                  "我的设备",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                leading: Icon(
                  Icons.build,
                  color: Colors.white,
                ),
              ),
            ),
            Offstage(
              offstage: false,
              child: ListTile(
                title: Text(
                  "我的设备",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                leading: Icon(
                  Icons.build,
                  color: Colors.white,
                ),
              ),
            ),
            Offstage(
              offstage: false,
              child: ListTile(
                title: Text(
                  "我的设备",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                leading: Icon(
                  Icons.build,
                  color: Colors.white,
                ),
              ),
            ),
            Offstage(
              offstage: false,
              child: ListTile(
                title: Text(
                  "我的设备",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                leading: Icon(
                  Icons.build,
                  color: Colors.white,
                ),
              ),
            ),
            Offstage(
              offstage: false,
              child: ListTile(
                title: Text(
                  "我的设备",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                leading: Icon(
                  Icons.build,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
