import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../database/models/trainning.dart';
import 'controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> getInitialData() async {
    await homeController.refreshData();
  }

  @override
  void initState() {
    super.initState();
    getInitialData();
  }

  Widget listBuilder({required List<Map<String, Object?>> value}) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: value.length,
      itemBuilder: (context, index) {
        var item = value[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          elevation: 8,
          child: Slidable(
            startActionPane: ActionPane(
              motion: const StretchMotion(),
              children: [
                SlidableAction(
                  onPressed: (_) async {
                    int? isDeleted = await trainningModel.delete(
                        id: int.parse(item['id'].toString()));
                    if (isDeleted != null) {
                      Fluttertoast.showToast(msg: 'Excluído com sucesso!');
                      await homeController.refreshData();
                    } else {
                      Fluttertoast.showToast(
                          msg: 'Erro ao excluir. Tente Novamente.');
                    }
                  },
                  backgroundColor: Theme.of(context).backgroundColor,
                  foregroundColor: Colors.white,
                  icon: Icons.delete_outlined,
                  label: 'Excluir',
                )
              ],
            ),
            child: ListTile(
              title: Text(
                item['title'].toString(),
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Row(children: <Widget>[
                const Icon(Icons.history),
                Text(
                  '${item['time'] ?? 0} minutos',
                )
              ]),
              contentPadding: const EdgeInsets.all(8),
              trailing: Text(
                item['description'].toString() == 'null'
                    ? ''
                    : item['description'].toString(),
              ),
              onTap: () {
                context.go(
                    '/counter?time=${item['time'] ?? 0}&interval=${item['interval'] ?? 1}');
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await homeController.refreshData();
      },
      child: Column(children: [
        Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(50.0)),
          ),
          child: Text(
            'Seus Treinos',
            textAlign: TextAlign.start,
            style: GoogleFonts.getFont('Poppins',
                fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Flexible(
          child: ValueListenableBuilder(
            valueListenable: homeController.data,
            builder: (context, value, _) {
              // return value.isNotEmpty
              //     ? listBuilder(value: value)
              //     : Center(
              //         child: Column(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: const [
              //               Icon(Icons.hourglass_bottom_outlined),
              //               Text('Você ainda não têm treinos')
              //             ]),
              //       );
              return listBuilder(value: [
                {'title': 'Teste', 'time': 3},
                {'title': 'Teste', 'time': 3},
                {'title': 'Teste', 'time': 3},
              ]);
            },
          ),
        ),
      ]),
    );
  }
}
