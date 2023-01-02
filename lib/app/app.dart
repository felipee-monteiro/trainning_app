import 'package:flutter/material.dart';
import '../app/widgets/app_new_trainning_form.dart';

class App extends StatelessWidget {
  const App({super.key, required this.body});
  final Widget body;
  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).backgroundColor;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0,
          toolbarHeight: 116.0,
        ),
        resizeToAvoidBottomInset: true,
        drawer: Drawer(
            backgroundColor: backgroundColor,
            child: const SizedBox(
              height: double.infinity,
            )),
        body: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18.5),
            color: backgroundColor,
            child: body),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return BottomSheet(
                        onClosing: () {},
                        builder: (context) => const AppNewTrainningForm());
                  });
            },
            child: const Icon(Icons.add)),
      ),
    );
  }
}
