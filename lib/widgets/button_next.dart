import 'package:dentistry/resources/colors_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ButtonNext extends StatelessWidget {
  ButtonNext({Key? key, this.onPressed, this.isEnabled = false}) : super(key: key);

  Function()? onPressed;
  bool isEnabled ;

  @override
  Widget build(BuildContext context) {

    var localText = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      height: 56,
      child: RaisedButton(
        padding: const EdgeInsets.all(16.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),

        color: ColorsRes.fromHex(ColorsRes.primaryColor),
        textColor: Colors.white,
        child: Text(localText.continueText, style: const TextStyle(fontSize: 14)),
        onPressed: isEnabled ? onPressed : null,
      ),
    );
  }
}
