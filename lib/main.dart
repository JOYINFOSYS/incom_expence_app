import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'category_widget.dart';

void main() {
  runApp(const IncomeExpenceAcc());
}

class IncomeExpenceAcc extends StatelessWidget {
  const IncomeExpenceAcc({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
            borderRadius: BorderRadius.circular(20),
           ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.deepPurple, width: 1),
            borderRadius: BorderRadius.circular(20),
          ),
        )
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final incomeTEController = TextEditingController();
  final expenceTEController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  List<IncomeExpenceModel> incomeExpenceList = [];

  DateTime time = DateTime.now();

  int calculateIncomeSum(List<IncomeExpenceModel>incomeExpenceList ){
    int incomeSum = 0;
    for(IncomeExpenceModel i in incomeExpenceList){
      incomeSum +=  int.parse(i.income);
      setState(() {});
    }
    return incomeSum;
  }

  int calculateExpenceSum(List<IncomeExpenceModel>incomeExpenceList ){
    int incomeSum = 0;
    for(IncomeExpenceModel i in incomeExpenceList){
      incomeSum +=  int.parse(i.expence);
      setState(() {});
    }
    return incomeSum;
  }

  @override
  Widget build(BuildContext context) {

    int result = calculateIncomeSum(incomeExpenceList);
    int resultexp = calculateExpenceSum(incomeExpenceList);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Income Expence account"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple.shade100,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
               Form(
                 key: formkey,
                 child: Row(
                  children: [
                    Expanded(child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: incomeTEController,
                      decoration: const InputDecoration(
                        labelText: "Income",
                        isDense: true,
                      ),
                    )),
                    SizedBox(width: 8,),
                    Expanded(child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: expenceTEController,
                      decoration: const InputDecoration(
                          labelText: "Expence",
                        isDense: true,
                      ),
                    )),
                  ],
                               ),
               ),
              const SizedBox(height: 10,),
              SizedBox(
                height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                    ),
                      onPressed: (){

                      incomeExpenceList.add(IncomeExpenceModel(income: incomeTEController.text.trim(), expence: expenceTEController.text.trim(), date: DateFormat("yMd").format(time)));
                      incomeTEController.clear();
                      expenceTEController.clear();
                      setState(() {});

                      }, child: Text("Add"))),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const CategoryWidget(title: 'Date', color: Colors.blue,),
                  const CategoryWidget(title: 'Income', color: Colors.green,),
                  const CategoryWidget(title: 'Expence', color: Colors.pink,),
                  const CategoryWidget(title: 'More', color: Colors.brown,),
                ],


              ),
              const SizedBox(height: 10,),

              Card(
                color: Colors.deepPurple.shade300,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                child: ListView.builder(
                shrinkWrap: true,
                    primary: false,
                    itemCount: incomeExpenceList.length,
                    itemBuilder: (context, index){
                      return SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 8),
                          child: Row(

                            children: [
                              const SizedBox(width: 10,),
                              SizedBox(
                                height: 30,
                                width: 100,
                                child: Card(
                                    margin: EdgeInsets.zero,
                                    child: Center(child: Text(incomeExpenceList[index].date))),
                              ),
                              const SizedBox(width: 10,),
                             SizedBox(
                                 width: 80,
                                 child: Text(incomeExpenceList[index].income,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                              const SizedBox(width: 5,),

                              const SizedBox(width: 18,),

                              SizedBox(
                                  width: 80,
                                  child: Text(incomeExpenceList[index].expence,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),maxLines: 1,overflow: TextOverflow.ellipsis,)),

                             Spacer(),
                             InkWell(
                                 onTap: (){
                                   incomeExpenceList.remove(incomeExpenceList[index]);
                                   setState(() {});
                                 },
                                 child: Icon(Icons.delete_sweep_sharp)),

                           ],
                          ),
                        )

                      );
                    },




                ),
              )
            ]
          ),
        ),
      ),


      floatingActionButton: Row(
       mainAxisAlignment: MainAxisAlignment.spaceAround,

        children: [

          FloatingActionButton.extended(onPressed: (){}, label: Text("Income : $result ")),
          FloatingActionButton.extended(onPressed: (){}, label: Text("Expence : $resultexp")),
          FloatingActionButton.extended(onPressed: (){}, label: Text("Balance : ${result-resultexp}")),
        ],

      ),

     floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

    );

  }
}

class IncomeExpenceModel {
final String income,expence,date;

  IncomeExpenceModel({required this.date, required this.income, required this.expence});
}

