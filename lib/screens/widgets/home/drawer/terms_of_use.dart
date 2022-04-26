import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toeic_learning_app/models/terms_of_use_model.dart';
import 'package:toeic_learning_app/models/user_model.dart';
import 'package:toeic_learning_app/providers/terms_of_use_provider.dart';
import 'package:toeic_learning_app/services/toast_service.dart';

import '../../../../config/theme.dart';
import '../../loader.dart';

class TermsOfUseScreen extends StatelessWidget {
  final User user;
  const TermsOfUseScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TermsOfUseProvider termsOfUseProvider =
        Provider.of<TermsOfUseProvider>(context);
    TermsOfUse? termsOfUse;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Điều khoản sử dụng',
          style: TextStyle(color: blackColor),
        ),
        elevation: 0.7,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        actions: [
          user.authorization == "admin"
              ? IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute<void>(
                      builder: (BuildContext context) {
                        return EditTermsOfUse(termsOfUse: termsOfUse);
                      },
                    ));
                  },
                  icon: Icon(
                    Icons.edit,
                    color: blackColor,
                  ),
                )
              : Container(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: FutureBuilder<TermsOfUse>(
          future: termsOfUseProvider.getTermsOfUse(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            termsOfUse = snapshot.data;
            return snapshot.hasData
                ? Text(
                    snapshot.data!.content!,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  )
                : const Center(
                    child: ColorLoader(),
                  );
          },
        ),
      ),
    );
  }
}

class EditTermsOfUse extends StatefulWidget {
  final TermsOfUse? termsOfUse;
  const EditTermsOfUse({Key? key, this.termsOfUse}) : super(key: key);

  @override
  State<EditTermsOfUse> createState() => _EditTermsOfUseState();
}

class _EditTermsOfUseState extends State<EditTermsOfUse> {
  ToastService toast = ToastService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: blackCoffeeColor),
        elevation: 0,
        backgroundColor: whiteColor,
        title: Text(
          'Edit Terms of Use',
          style: TextStyle(color: blackColor),
        ),
        titleSpacing: 20,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _updateTermsOfUse(widget.termsOfUse!.id, widget.termsOfUse!.content);
        },
        backgroundColor: blueColor,
        child: const Icon(Icons.save),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            left: 10.0, right: 5.0, top: 10.0, bottom: 5.0),
        child: TextField(
          controller: TextEditingController(text: widget.termsOfUse!.content),
          onChanged: (value) {
            widget.termsOfUse!.content = value;
          },
          maxLines: null,
          style: const TextStyle(),
          decoration: const InputDecoration(
            hintText: 'Enter Something...',
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  _updateTermsOfUse(id, content) {
    TermsOfUseProvider termsOfUseProvider =
        Provider.of<TermsOfUseProvider>(context, listen: false);

    termsOfUseProvider.updateTermsOfUse(id, content).then(
      (response) {
        if (response['status']) {
          Navigator.pop(context);
          toast.showToast(
            context: context,
            message: response['message'],
            icon: Icons.error,
            backgroundColor: Colors.green,
          );
        } else {
          toast.showToast(
            context: context,
            message: response['message'],
            icon: Icons.error,
            backgroundColor: Colors.redAccent,
          );
        }
      },
    );
  }
}
