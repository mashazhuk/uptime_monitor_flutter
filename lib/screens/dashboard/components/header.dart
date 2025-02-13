import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../controllers/MyMenuController.dart';
import '../../../responsive.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: !Responsive.isDesktop(context)
        ? BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.circular(10),
          )
        : null,
      child: Row(
        children: [
          if (!Responsive.isDesktop(context))
            IconButton(icon: Icon(Icons.menu), onPressed: context.read<MyMenuController>().controlMenu, color: Colors.white),
          if (!Responsive.isMobile(context))
            Text(
              "Dashboard",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
              ),
            ),
          if (!Responsive.isMobile(context))
            Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
          Expanded(
            child: SearchField(),
          ),
          ProfileCard()
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: defaultPadding),
      padding: EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding / 2),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Responsive.isDesktop(context) ? Border.all(color: Colors.white10) : null,
      ),
      child: Row(children: [
        CircleAvatar(
          radius: 16,
          backgroundImage: AssetImage("assets/images/profile_pic.png"),
        ),
        if (!Responsive.isMobile(context)) Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
          child: Text("Surname Name"),
        ),
        // Icon(Icons.keyboard_arrow_down)
      ]),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        fillColor: secondaryColor,
        filled: true,
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10)),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(defaultPadding * 0.75),
            margin: EdgeInsets.symmetric(
              horizontal: defaultPadding / 2,
            ),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg"),
          ),
        ),
      ),
    );
  }
}

