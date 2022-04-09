import 'package:currency_app/modules/home/controllers/home_controller.dart';
import 'package:currency_app/modules/home/screens/historical_data_chart.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget
{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (_) {
            if(_.isLoaded) {
              return  Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 40),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.60,
                            height: 37,
                            child: DropdownButtonFormField2<String>(
                              isExpanded: true,
                               iconSize: 0,
                               value: _.dropdownValue,
                               items: _.currency.map<DropdownMenuItem<String>>((curr) =>
                                DropdownMenuItem<String>(
                                  value: curr.assetId,
                                  child: Text(curr.assetId))).toList(),
                               onChanged: (val) async{_.setDropdownValue(val);},
                                                   decoration: InputDecoration(
                                                 
                          contentPadding: const EdgeInsets.all(8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                               ),
                          ),
              ),
                        ),
              const Spacer(),
              Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.28,
                      child: OutlinedButton(
                      onPressed: () {},
                      child: const Text('Subscribe',
                      style: TextStyle(color: Colors.black),)
                      ,)
                    ),
              )
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Market data:',style: TextStyle(fontWeight: FontWeight.bold),)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: 
                          _.currentCurrency == null ?
                                   SizedBox(
                                     height: 32,
                                     child: Row(
                                       children: const [
                                         Spacer(flex: 5),
                                         CircularProgressIndicator(),
                                         Spacer(flex: 5)
                                       ],
                                     ),
                                   )
                             :
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Column(
                              children: [
                                const Text('Symbool:'),
                                Text(_.dropdownValue! + '/USD')
                              ],
                            ),
                            Column(
                              children: [
                                const Text('Price:'),
                                Text('\$' + _.currentCurrency!.price.toString()),
                              ],
                            ),
                            Column(
                              children: [
                                const Text('Time:'),
                                Text(
                                  DateFormat.MMMd().format(_.currentCurrency!.dateTime!) + ', ' +
                                  DateFormat.Hm().format(_.currentCurrency!.dateTime!)
                                  ),
                              ],
                            )])
                            ,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Charting data:',style: TextStyle(fontWeight: FontWeight.bold),)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: HistoricalDataChart(),
                        )),
                    )
                  ],
                ));
            }
            return const Center(child: CircularProgressIndicator());
          }
        ),
    );
  }
}