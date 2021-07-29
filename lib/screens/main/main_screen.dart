import 'package:flutter/material.dart';
import 'package:inspection_admin/controllers/MenuController.dart';
import 'package:inspection_admin/controllers/PageController.dart';
import 'package:inspection_admin/screens/InspectionsDashboard/inspections_screen.dart';
import 'package:inspection_admin/screens/dashboard/dashbord_screen.dart';
import 'package:provider/provider.dart';

import '../../responsive.dart';
import 'components/side_menu.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var page = Provider.of<PageControl>(context);
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      key: context.read<MenuController>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context)) Expanded(child: SideMenu()),
            if (page.currentPage == 1)
              Expanded(flex: 5, child: DashboardScreen()),
            if (page.currentPage == 2)
              Expanded(flex: 5, child: InspectionsDashboard()),
          ],
        ),
      ),
    );
  }
}
