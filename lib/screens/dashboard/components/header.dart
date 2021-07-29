import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inspection_admin/controllers/MenuController.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../responsive.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
              onPressed: context.read<MenuController>().controlMenu,
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              )),
        Container(
          //   mainAxisAlignment: MainAxisAlignment.start,
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/admin/Header/Back.svg",
                height: 30,
              ),
              SizedBox(
                width: defaultPadding,
              ),
              SvgPicture.asset(
                "assets/admin/Header/Reload.svg",
                height: 30,
              ),
            ],
          ),
        ),
        Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        Container(
          child: Row(
            children: [
              Icon(
                Icons.notification_important_outlined,
                color: Colors.black,
              ),
              SizedBox(
                width: defaultPadding,
              ),
              Container(
                width: 1,
                height: 23,
                color: Colors.grey,
              ),
              SizedBox(
                width: defaultPadding,
              ),
              ProfileCard(),
            ],
          ),
        ),
        //if (!Responsive.isMobile(context))
        // Text(
        //   "Dashboard",
        //   style: Theme.of(context).textTheme.headline6,
        // ),
        // if (!Responsive.isMobile(context))
        //   Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        // Expanded(
        //   child: SearchField(),
        // ),
        // ProfileCard(),
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.only(left: defaultPadding),
      // padding: EdgeInsets.symmetric(
      //     horizontal: defaultPadding, vertical: defaultPadding / 2),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        border: Border.all(color: Colors.white10),
      ),
      child: Image.asset(
        "assets/images/profile_pic.png",
        height: 25,
      ),
    );
  }
// if (!Responsive.isMobile(context))
//   Padding(
//     padding: const EdgeInsets.symmetric(
//       horizontal: defaultPadding / 2,
//     ),
//     child: Text("Elias Ayele"),
//   ),
//Icon(Icons.keyboard_arrow_down),
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search here",
        fillColor: Colors.blueGrey.withOpacity(0.3),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        prefixIcon: InkWell(
          onTap: () {},
          child: Icon(
            Icons.search,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
