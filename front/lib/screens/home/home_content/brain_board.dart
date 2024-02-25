import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todotodo/my_style.dart';

class BrainBoard extends StatelessWidget {
  final double brainState = 0.4; // 0.0 ~ 1.0 사이의 값을 가짐, 쾌적과 위험 상태를 표시
  final int brainImageState = 3; // 상태에 따른 이미지 번호를 받음

  String getBrainImagePath(int state) {
    // 상태에 따른 이미지 경로 설정
    return 'assets/brain$state.png';
  }

  @override
  Widget build(BuildContext context) {
    // brainState를 기반으로 화살표 위치 계산
    double arrowPosition = brainState.clamp(0.0, 1.0) * 2 - 1; // 화살표 위치를 0.0과 1.0 사이로 제한
    Alignment arrowAlignment = Alignment(arrowPosition, 2);

    return Container(
      child: Column(
        children: [
          Container(
            height: 100,
            child: Center(
              // 이미지 상태에 따라 이미지 변경
              child: Image.asset(getBrainImagePath(brainImageState)),
            ),
          ),
          SizedBox(height: 10,),
          SizedBox(
            child: Column(
              children: [
                Container(
                  height: 20,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        MyColors.sky_blue,
                        MyColors.sky_blue,
                        Colors.yellow,
                        MyColors.red,
                        MyColors.red
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Align(
                  alignment: arrowAlignment,
                  child: Icon(Icons.arrow_drop_up_outlined, size: 32),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('쾌적', style: MyTextStyles.b4),
              Text('위험', style: MyTextStyles.b4),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

