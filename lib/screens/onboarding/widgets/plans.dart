import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/core/widgets/image_widget.dart';

class Plans extends StatefulWidget {
  const Plans({super.key, required this.currentPlan, required this.data});

  final Function(int) currentPlan;
  final List<Map> data;

  @override
  State<Plans> createState() => _PlansState();
}

class _PlansState extends State<Plans> {
  int _currentIndex = 0;
  double swipeOffset = 0;

  List<Map> data = [];

  @override
  void initState() {
    super.initState();
    data = widget.data;
  }

  void _handleSwipe(DragEndDetails details) {
    if (details.primaryVelocity! < 0) {
      if (_currentIndex < data.length - 1) {
        setState(() {
          _currentIndex++;
          swipeOffset = 0;
        });
      }
    } else if (details.primaryVelocity! > 0) {
      if (_currentIndex > 0) {
        setState(() {
          _currentIndex--;
          swipeOffset = 0;
        });
      }
    }
    widget.currentPlan.call(_currentIndex);
  }

  void _handleSwipeUpdate(DragUpdateDetails details) {
    setState(() {
      swipeOffset += details.delta.dx;
    });
  }

  void _handleSwipeStart(DragStartDetails details) {
    setState(() {
      swipeOffset = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Mug Punter?\nBecome Pro with AI.',
          textAlign: TextAlign.center,
          style: regular(
            fontSize: 28.sp.clamp(20, 30),
            height: 1.2,
            fontFamily: AppFontFamily.secondary,
          ),
        ),
        SizedBox(height: 40.w.flexClamp(35, 40)),
        GestureDetector(
          onHorizontalDragStart: _handleSwipeStart,
          onHorizontalDragUpdate: _handleSwipeUpdate,
          onHorizontalDragEnd: _handleSwipe,
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            // transitionBuilder: (Widget child, Animation<double> animation) {
            //   final offsetAnimation =
            //       Tween<Offset>(
            //         begin: Offset(_swipeOffset > 0 ? -1.0 : 1.0, 0.0),
            //         end: Offset.zero,
            //       ).animate(
            //         CurvedAnimation(parent: animation, curve: Curves.easeInOut),
            //       );

            //   return SlideTransition(
            //     position: offsetAnimation,
            //     child: FadeTransition(opacity: animation, child: child),
            //   );
            // },
            child: _buildPlanCard(data[_currentIndex]),
          ),
        ),
      ],
    );
  }

  Widget _buildPlanCard(Map planData) {
    return Container(
      key: ValueKey(_currentIndex),
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary.setOpacity(0.2)),
      ),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 17),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          planData['title'].toString().split(" ").length != 1
              ? Text(
                  planData['title'],
                  textAlign: TextAlign.center,
                  style: regular(
                    fontSize: 24.sp.flexClamp(18, 26),
                    fontFamily: AppFontFamily.secondary,
                  ),
                )
              : RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: planData['title'].toString(),
                        style: regular(
                          fontSize: 24.sp.flexClamp(20, 26),
                          fontFamily: AppFontFamily.secondary,
                          color: AppColors.primary,
                        ),
                      ),
                      TextSpan(
                        text: ' ‘Pro Punter’ ',
                        style: regular(
                          fontSize: 24.sp.flexClamp(20, 26),
                          fontFamily: AppFontFamily.secondary,
                          color: AppColors.premiumYellow,
                        ),
                      ),
                      TextSpan(
                        text: 'Account',
                        style: regular(
                          fontSize: 24.sp.flexClamp(20, 26),
                          fontFamily: AppFontFamily.secondary,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
          SizedBox(height: 12),
          planData['price'].toString().isEmpty
              ? const SizedBox()
              : Text(
                  "\$ ${planData['price'].toString()}",
                  style: bold(fontSize: 24.sp.flexClamp(20, 26)),
                ),
          SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.all(0),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, i) {
              Map item = planData['points'][i];
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageWidget(
                    type: ImageType.svg,
                    path: item['icon'],
                    height: 20.w.clamp(18, 25),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      item['text'],
                      style: regular(fontSize: 16.sp.clamp(14, 18)),
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 5),
            itemCount: (planData['points'] as List).length,
          ),
        ],
      ),
    );
  }
}
