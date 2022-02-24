import 'package:flutter/material.dart';
import 'package:flutter_project/constants/common_size.dart';
import 'package:flutter_project/constants/screen_size.dart';

class TakePhoto extends StatelessWidget {
  const TakePhoto({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 400,
          height: 400,
          color: Colors.black,
        ),
        Expanded(
            child: OutlineButton(
              onPressed: (){},
              shape: CircleBorder(),
              borderSide: BorderSide(color: Colors.black12,width: 20),
            )
            )
      ],
    );
  }
}
