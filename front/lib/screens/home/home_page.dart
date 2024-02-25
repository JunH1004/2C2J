import 'package:flutter/material.dart';
import 'package:todotodo/my_style.dart';
import 'package:todotodo/screens/home/home_content/brain_board.dart';
import 'package:todotodo/screens/home/home_content/horizontal_calendar.dart';
import 'package:todotodo/widget/sliver_padding_box.dart';
import '../../widget/todolist_with_checkboxes.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.beige,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: MyColors.beige,
              title: Text('TODOTODO',style: MyTextStyles.h3,),
            ),
            SliverPaddingBox(child: BrainBoard()),
            SliverPaddingBox(
              child: HorizontalWeekTodoBoard()
            ),
          ],
        ),
      ),
    );
  }
}
