import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';

class MySites extends StatelessWidget {
  const MySites({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Uptime", style: Theme.of(context).textTheme.titleSmall,),
              ElevatedButton.icon(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  backgroundColor: primaryColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical: defaultPadding,
                  ),
                ),
                onPressed: () {},
                icon: Icon(Icons.add, color: Colors.white,),
                label: Text("Add new", style: TextStyle(color: Colors.white),),
              ),
            ],
          )
        ]
    );
  }
}