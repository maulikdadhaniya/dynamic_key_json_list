import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:manu_complex_list/model/inner_data.dart';
import 'package:manu_complex_list/model/root_date.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var mData =
      "{\"total_count\":17,\"Result\":{\"2022-04-05\":[{\"order_id\":\"409116\",\"payment_method\":\"CashOndelivery\",\"total_amount\":408,\"order_date\":\"2022-04-0514:29:53\"}],\"2022-03-16\":[{\"order_id\":\"395454\",\"payment_method\":\"CashOndelivery\",\"total_amount\":520,\"order_date\":\"2022-03-1614:29:53\"},{\"order_id\":\"784512\",\"payment_method\":\"CashOndelivery\",\"total_amount\":666,\"order_date\":\"2022-03-1614:29:53\"}],\"2022-03-14\":[{\"order_id\":\"111111\",\"payment_method\":\"CashOndelivery\",\"total_amount\":333,\"order_date\":\"2022-03-1414:29:53\"},{\"order_id\":\"878787\",\"payment_method\":\"CashOndelivery\",\"total_amount\":177,\"order_date\":\"2022-03-1414:29:53\"},{\"order_id\":\"664477\",\"payment_method\":\"CashOndelivery\",\"total_amount\":200,\"order_date\":\"2022-03-1414:29:53\"}]}}";
  List<RootDate> rootData = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (context, rootIndex) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                children: <Widget>[
                  Text(
                    rootData[rootIndex].date.toString(),
                  ),
                  ListView.builder(
                    itemBuilder: (context, innerIndex) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: InkWell(
                          onTap: (){
                            print(rootData[rootIndex]
                                .innerDataList![innerIndex]
                                .order_id
                                .toString());
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Order ID -> "+rootData[rootIndex]
                                  .innerDataList![innerIndex]
                                  .order_id
                                  .toString()),
                              SizedBox(height: 10,),
                              Text("payment_method -> "+rootData[rootIndex]
                                  .innerDataList![innerIndex]
                                  .payment_method
                                  .toString()),

                              SizedBox(height: 10,),
                              Text("total_amount -> "+rootData[rootIndex]
                                  .innerDataList![innerIndex]
                                  .total_amount
                                  .toString()),

                              SizedBox(height: 10,),
                              Text("order_date -> "+rootData[rootIndex]
                                  .innerDataList![innerIndex]
                                  .order_date
                                  .toString()),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: rootData[rootIndex].innerDataList?.length,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                  ),
                ],
              ),
            );
          },
          itemCount: rootData.length,
        ),
      ),
    );
  }

  void getData() {
    Map<String, dynamic> valueMap = jsonDecode(mData);
    var result = valueMap["Result"] as Map<String, dynamic>;
    rootData = [];
    result.forEach((key, value) {
      List<InnerData> user = [];
      value.forEach((item) {
        user.add(InnerData(
            order_id: item['order_id'],
            total_amount: item['total_amount'],
            payment_method: item['payment_method'],
            order_date: item['order_date']));
      });
      rootData.add(RootDate(date: key, innerDataList: user));
    });

    rootData.forEach((element) {
      print(element.date! + " : " + '${element.innerDataList?.length}');
      element.innerDataList?.forEach((element) {
        print(element.order_id);
      });
    });
  }
}
