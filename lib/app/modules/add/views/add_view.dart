import 'package:crypto_wallet/app/data/models/coin_model.dart';
import 'package:crypto_wallet/app/widgets/submit_button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_controller.dart';

class AddView extends GetView<AddController> {
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AddView'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(
            () => DropdownButton(
              value: controller.dropdownValue.value,
              onChanged: (String? value) {
                controller.dropdownValue.value = value!;
              },
              items: controller.coins
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Container(
            width: Get.size.width / 1.3,
            child: TextFormField(
              controller: _amountController,
              decoration: InputDecoration(labelText: "Coin Amount"),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
          ),
          SubmitButton(
            onPressed: () async {
              await controller.addCoin(controller.dropdownValue.value, _amountController.text);
              Get.back();
            },
            child: Text("Add"),
          )
        ],
      ),
    );
  }
}
