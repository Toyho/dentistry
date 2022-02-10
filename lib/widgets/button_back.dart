import 'package:dentistry/resources/colors_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ButtonBack extends StatelessWidget {
  ButtonBack({Key? key, this.onPressed}) : super(key: key);

  Function()? onPressed;

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
        child: Text(localText.backText, style: const TextStyle(fontSize: 14)),
        onPressed: onPressed,
      ),
    );
  }
}
