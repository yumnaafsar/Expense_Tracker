import 'package:expense_tracker_app/data/model/add_date.dart';
import 'package:expense_tracker_app/data/utility.dart';
import 'package:expense_tracker_app/widget/chart.dart';
import 'package:flutter/material.dart';

class Statistic extends StatefulWidget {
  const Statistic({super.key});

  @override
  State<Statistic> createState() => _StatisticState();
}
ValueNotifier kj = ValueNotifier(0);
class _StatisticState extends State<Statistic> {
  List day = ['Day', 'Week', 'Month', 'Year'];
  List f = [today(), week(), month(), year()];
  List<Add_data> a = [];
  int index_color = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ValueListenableBuilder(builder: (context, value, child){
            a = f[value];
            return custom();
          }, valueListenable: kj,)
          ),
    );
  }

  CustomScrollView custom() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Statistics',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...List.generate(4, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                             index_color = index;
                               kj.value = index;
                          });
                         
                        },
                        child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: index_color == index
                                ? Color.fromARGB(228, 4, 141, 141)
                                : Colors.white,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            day[index],
                            style: TextStyle(
                              color:index_color == index
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    })
                  ],
                ),
              ),
              SizedBox(height:20 ,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 120,
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Expense',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),
                          ),
                          Icon(Icons.arrow_downward_sharp, color: Colors.grey,)
                        ],
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 2
                        ),
                        borderRadius: BorderRadius.circular(8)
                      ),
                    ),
                  ],
                ),

              ),

              SizedBox(height: 20,),

              Charts(indexx: index_color ,),

              SizedBox(height: 20,),

              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Top Spending', style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                     ),
                       Icon(
                      Icons.swap_vert,
                      size: 25,
                      color: Colors.grey,
                    ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),

        SliverList(delegate: SliverChildBuilderDelegate((context, index) {
          return ListTile(
           leading: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset('images/${a[index].name}.png', height: 40),
              ),
              title: Text(
                a[index].name,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                ' ${a[index].datetime.year}-${a[index].datetime.day}-${a[index].datetime.month}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: Text(
                a[index].IN=="Income" ?'\$ ${a[index].amount}':'-\$ ${a[index].amount}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 19,
                  color: a[index].IN == 'Income' ? Colors.green : Colors.red,
                ),
              ),
            );
          },
        childCount: a.length
        )
         )
      ],
    );
  }
}
