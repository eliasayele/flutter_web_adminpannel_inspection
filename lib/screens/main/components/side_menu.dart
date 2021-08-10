import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inspection_admin/controllers/PageController.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var page = Provider.of<PageControl>(context);
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(
                child: SvgPicture.asset(
              "assets/admin/Invoice/twoflogo.svg",
              height: 40,
              width: double.infinity,
            )),
            DrawerListTile(
              title: "Dashboard",
              svgSrc: "assets/Dashboard.svg",
              press: () {
                page.changePage(1);
              },
            ),
            DrawerListTile(
              title: "Companies",
              svgSrc: "assets/Company.svg",
              press: () {},
            ),
            DrawerListTile(
              title: "Users",
              svgSrc: "assets/User.svg",
              press: () {},
            ),
            DrawerListTile(
              title: "Invoices",
              svgSrc: "assets/admin/Side Menu/Invoice.svg",
              press: () {},
            ),
            DrawerListTile(
              title: "Inspections",
              svgSrc: "assets/admin/Side Menu/Inspection.svg",
              press: () {
                page.changePage(2);
              },
            ),
            Divider(),
            DrawerListTile(
              title: "FAQ",
              svgSrc: "assets/admin/Side Menu/FAQ.svg",
              press: () {},
            ),
            ListTile(
              onTap: () {},
              horizontalTitleGap: 0.0,
              leading: SvgPicture.asset(
                "assets/admin/Side Menu/Collapse.svg",
                color: Colors.yellow,
                height: 16,
              ),
              title: Text(
                "Collapse",
                style: TextStyle(color: Colors.white54),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatefulWidget {
  const DrawerListTile(
      {Key? key,
      required this.title,
      required this.svgSrc,
      required this.press})
      : super(key: key);
  final String title, svgSrc;
  final VoidCallback press;

  @override
  _DrawerListTileState createState() => _DrawerListTileState();
}

class _DrawerListTileState extends State<DrawerListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      hoverColor: Colors.indigo.withOpacity(0.5),
      selectedTileColor: Colors.blue.withOpacity(0.5),
      onTap: widget.press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        widget.svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        widget.title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
