import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../database/models/trainning.dart';
import '../../screens/home/controller.dart';

class AppNewTrainningForm extends StatefulWidget {
  const AppNewTrainningForm({super.key});
  @override
  State<AppNewTrainningForm> createState() => _AppNewTrainningFormState();
}

class _AppNewTrainningFormState extends State<AppNewTrainningForm> {
  final _formKey = GlobalKey<FormState>();
  final String _requiredFieldMessage = 'Campo Obrigatório';
  final Map<String, Object> _formData = {};

  String? _requiredFieldsValidator(String? value) {
    if (value == null || value.isEmpty) {
      return _requiredFieldMessage;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Title(
              color: Colors.black,
              child: const Text(
                'Novo Período de treino',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const Spacer(flex: 20),
            TextFormField(
              autocorrect: false,
              enabled: true,
              keyboardType: TextInputType.text,
              onSaved: (String? newValue) {
                if (newValue != null && newValue.isNotEmpty) {
                  _formData['title'] = newValue;
                }
              },
              validator: _requiredFieldsValidator,
              decoration: const InputDecoration(
                  label: Text('Título'), border: OutlineInputBorder()),
            ),
            const Spacer(flex: 20),
            TextFormField(
              onSaved: (description) {
                _formData['description'] = description!;
              },
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), label: Text('Descrição')),
            ),
            const Spacer(flex: 20),
            TextFormField(
              onSaved: (interval) {
                _formData['interval'] = int.parse(interval as String);
              },
              validator: _requiredFieldsValidator,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Intervalo (em Minutos)')),
            ),
            CupertinoTimerPicker(
              alignment: Alignment.center,
              mode: CupertinoTimerPickerMode.ms,
              onTimerDurationChanged: (timeSelected) {
                if (timeSelected.inMinutes > 0) {
                  _formData['time'] = timeSelected.inMinutes;
                } else {
                  Fluttertoast.showToast(
                      msg: 'O tempo precisa maior do que zero.');
                }
              },
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    int? isCreated = await trainningModel.create(_formData);
                    if (isCreated != null && isCreated != 0) {
                      Fluttertoast.showToast(msg: 'Salvo com sucesso !');
                      await homeController.refreshData();
                    } else {
                      Fluttertoast.showToast(
                          msg: 'Erro ao salvar. Tente Novamente.');
                    }
                  }
                },
                child: const Text('Salvar',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
