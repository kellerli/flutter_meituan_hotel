import 'package:flutter/material.dart';
import 'package:hotel/common/constant.dart';
import '../../widget/MyDivider.dart';
import '../../widget/bottom_pop/bottompop.dart';
import '../../widget/bottom_pop/timebottompop.dart';
import '../../../route/routes.dart';
import '../../../config/application.dart';
import 'package:city_pickers/city_pickers.dart';

class InlandPage extends StatefulWidget {
  _InlandPageState createState() => _InlandPageState();
}

class _InlandPageState extends State<InlandPage> {

  bool _loading = false;
  Result result = new Result();
//  List<DateTime> datelist = [DateTime.now(),DateTime.now().add(Duration(days: 1))];

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return _mainpage(context);
  }

  showMap() async {
    result = await CityPickers.showCityPicker(
      context: context,
    );
    if(result == null){
      result = new Result();
    }
    setState(() {
      print(result);
    });
  }
  _mainpage(context){

    final _media = MediaQuery.of(context).size;

    return Column(
      children: <Widget>[
        InkWell(
            onTap: (){
              showMap();
            },
            child: Container(
              height: 65,
              child:Row(
                children: <Widget>[
                  Container(
                    width: _media.width * 0.85,
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            '目的地',
                            style: TextStyle(
                                fontFamily: 'jindian',
                                fontSize: 13,
                                color: Colors.grey
                            ),
                          ),
                          padding: EdgeInsets.only(left: 20,top: 10),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child:Text(
                            result.cityName == null ? "请选择城市" : result.cityName,
                            style:TextStyle(
                                fontFamily: 'jindian',
                                fontSize: result.cityName == null ? 15 : 18,
                                color: result.cityName == null ? Colors.grey : Colors.black
                            ),
                          ),
                          padding: EdgeInsets.only(left: 20,top: 5),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 0),
                        child:Icon(
                            Icons.keyboard_arrow_right,
                            size: 20,
                            color: Colors.grey),
                      )
                  ),
                ],
              ),
            )
        ),
        MyDivider(height: 0,indent: 400 / 30.0,endindent: 400 / 30.0,),
        InkWell(
            onTap: (){
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context){
                    //showModalBottomSheet默认点击子widget收起，加一个GestureDetector并设置onTap为false阻断点击事件
                    return GestureDetector(
                      onTap: () => false,
                      child: TimeBottomPop(
                        onChange: (m){
                          print(m);
                        },
                      ),
                    );
                  }
              ).then((value){
                setState(() {
                  if(value!=null && !value.isEmpty){
                    selectDate = value[0];
                    secselectDate = value[1];
                  }
                });
              });
            },
            child: Container(
              height: 65,
              child:Row(
                children: <Widget>[
                  Container(
                    width:_media.width * 0.85,
                    child: Row(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          width: _media.width * 0.85 * 0.4,
                          child: Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  checksameday(selectDate,DateTime.now())? '今天入住' : '入住',
                                  style: TextStyle(
                                      fontFamily: 'jindian',
                                      fontSize: 13,
                                      color: Colors.red
                                  ),
                                ),
                                padding: EdgeInsets.only(left: 20,top: 10),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  selectDate.month.toString() + "月" + selectDate.day.toString() + "日",
                                  style:TextStyle(
                                    fontFamily: 'jindian',
                                    fontSize: 18,
                                  ),
                                ),
                                padding: EdgeInsets.only(left:20,top: 3),
                              ),

                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          width:_media.width * 0.85 * 0.4,
                          child: Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  checksameday(secselectDate,DateTime.now().add(Duration(days: 1)))?'明天离店': '离店' ,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: 'jindian',
                                      color: Colors.red
                                  ),
                                ),
                                padding: EdgeInsets.only(left: 10,top: 10),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                child:Text(
                                  secselectDate.month.toString() + "月" + secselectDate.day.toString() + "日",
                                  style:TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'jindian',
                                  ),
                                ),
                                padding: EdgeInsets.only(left: 10,top: 3),
                              ),

                            ],
                          ),
                        ),
                        Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '共'+ secselectDate.difference(selectDate).inDays.toString() +'晚',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 11,
                                  fontFamily: 'jindian',
                                ),
                              ),
                            )
                        )
                      ],
                    ) ,
                  ),
                  Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 0),
                        child:Icon(
                            Icons.keyboard_arrow_right,
                            size: 20,
                            color: Colors.grey),
                      )
                  ),
                ],
              ),
            )
        ),
        MyDivider(height: 0,indent: 400 / 30.0,endindent: 400 / 30.0,),
        InkWell(
            onTap: (){
              setState(() {
                print(1);
              });
            },
            child: Container(
              height: 65,
              child:Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.only(left: 400 / 30.0,top: 20),
                          width: _media.width * 0.85,
                          child:Text(
                            '搜索酒店/地名/关键字',
                            style:TextStyle(
                              fontFamily: 'jindian',
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          )
                      )
                    ],
                  ),
                  Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 0),
                        child:Icon(
                            Icons.keyboard_arrow_right,
                            size: 20,
                            color: Colors.grey),
                      )
                  ),
                ],
              ),
            )
        ),
        MyDivider(height: 0,indent: 400 / 30.0,endindent: 400 / 30.0,),
        InkWell(
            onTap: (){
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context){
                    return GestureDetector(
                      onTap: () => false,
                      child: BottomPop(),
                    );
                  }
              );
            },
            child: Container(
              height: 65,
              child:Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.only(left: 400 / 30.0,top: 20),
                          width: _media.width * 0.85,
                          child:Text(
                            '设置我喜欢的星级/价格',
                            style:TextStyle(
                              fontFamily: 'jindian',
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          )
                      )
                    ],
                  ),
                  Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 0),
                        child:Icon(
                            Icons.keyboard_arrow_right,
                            size: 20,
                            color: Colors.grey),
                      )
                  ),
                ],
              ),
            )
        ),
        MyDivider(height: 0,indent: 400 / 30.0,endindent: 400 / 30.0,),
        Container(
            height:50,
            width: 300,
            margin: EdgeInsets.only(left:10.0,top: 30, right:10.0),
            child: new FlatButton(
              child: new Padding(
                padding: EdgeInsets.all(8.0),
                child: new Text(
                  "查找酒店",
                  style: new TextStyle(
                      fontFamily: 'jindian',
                      color: Colors.white,
                      fontSize: 25.0),
                ),
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)), //圆角大小
              onPressed: () {
                _navigate(context, "${Routes.hotelpage}");
              },
            ),
            decoration: new BoxDecoration(
              //渐变色
                borderRadius: BorderRadius.all(Radius.circular(3)),
                gradient: new LinearGradient(
                    colors: [
                      Colors.deepOrangeAccent,
                      Colors.redAccent.withAlpha(220),
                    ],
                    begin: const FractionalOffset(0.2, 0.0),
                    end: const FractionalOffset(1.0, 1.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp
                )
            )
        ),
      ],
    );
  }

  bool checksameday(DateTime datetime,DateTime ct){

    if(datetime.month == ct.month) {
      if (datetime.day == ct.day){
        return true;
      }
    }
    return false;

  }

  _navigate(BuildContext context, String route) {
    Application.navigateTo(context: context, route: route);
  }


  Widget bottompage(){
    return Container(
      height: 500,
      child: Column(
        children: <Widget>[
          Text('特惠精选',
            style: TextStyle(
                fontSize: 30
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  height:100,
                  width: 100,
                  child: Card(
                    color: Colors.redAccent,
                  ),
                ),
                Card()
              ],
            ),
          ),
          Text('推荐榜单',
            style: TextStyle(
                fontSize: 30
            ),
          ),
          Text('猜你喜欢',
            style: TextStyle(
                fontSize: 30
            ),
          )
        ],
      ),
    );
  }

}