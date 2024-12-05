import 'package:uptime_monitor/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uptime_monitor/models/AllSites.dart';
import 'package:uptime_monitor/screens/dashboard/components/general_info_card.dart';

import '../../../constants.dart';

class MySites extends StatelessWidget {
  const MySites({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Uptime",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                backgroundColor: primaryColor,
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding * 1.5,
                  vertical: defaultPadding,
                ),
              ),
              onPressed: () { Navigator.of(context).pushNamed("/add-site"); },
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              label: Text(
                "Add new",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        SizedBox(height: defaultPadding),
        // Responsive(
        //   mobile: FileInfoCardGridView(
        //     crossAxisCount: _size.width < 650 ? 2 : 4,
        //     childAspectRatio: _size.width < 650 ? 1.3 : 1,
        //   ),
        //   tablet: FileInfoCardGridView(),
        //   desktop: FileInfoCardGridView(
        //     childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
        //   ),
        // ),
      ],
    );
  }
}

// class FileInfoCardGridView extends StatelessWidget {
//   const FileInfoCardGridView({
//     Key? key,
//     this.crossAxisCount = 4,
//     this.childAspectRatio = 1,
//   }) : super(key: key);
//
//   final int crossAxisCount;
//   final double childAspectRatio;
//
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       physics: NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       itemCount: demoAllSites.length,
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: crossAxisCount,
//         crossAxisSpacing: defaultPadding,
//         mainAxisSpacing: defaultPadding,
//         childAspectRatio: childAspectRatio,
//       ),
//       itemBuilder: (context, index) => GeneralInfoCard(sitesList: demoAllSites),
//     );
//   }
// }
