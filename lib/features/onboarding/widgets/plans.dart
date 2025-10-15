import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:puntgpt_nick/core/constants/constants.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/core/widgets/image_widget.dart';

class Plans extends StatefulWidget {
  const Plans({super.key});

  @override
  State<Plans> createState() => _PlansState();
}

class _PlansState extends State<Plans> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map> data = [
    {
      "title": "Free 'Mug Punter' Account",
      "price": "",
      "points": [
        {"icon": AppAssets.delete, "text": "No chat function with PuntGPT"},
        {"icon": AppAssets.delete, "text": "No access to PuntGPT Punters Club"},
        {
          "icon": AppAssets.done,
          "text": "Limited PuntGPT Search Engine Filters",
        },
        {"icon": AppAssets.done, "text": "Limited AI analysis of horses"},
        {"icon": AppAssets.done, "text": "Access to Classic Form Guide"},
      ],
    },
    {
      "title": "Pro Punter Account",
      "price": "9.99",
      "points": [
        {"icon": AppAssets.done, "text": "Chat function with PuntGPT"},
        {"icon": AppAssets.done, "text": "Access to PuntGPT Punters Club"},
        {"icon": AppAssets.done, "text": "Full use of PuntGPT Search Engine"},
        {"icon": AppAssets.done, "text": "Access to Classic Form Guide"},
      ],
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
            fontSize: 35.sp.clamp(20, 50),
            height: 1.2,
            fontFamily: AppFontFamily.secondary,
          ),
        ),
        SizedBox(height: 40.w.flexClamp(35, 40)),

        _buildPlanCard(data[1]),
        SizedBox(height: 16),
        _buildPageIndicators(),
      ],
    );
  }

  Widget _buildPageIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        data.length,
        (index) => AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4),
          width: _currentPage == index ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: _currentPage == index
                ? AppColors.primary
                : AppColors.primary.setOpacity(0.3),
          ),
        ),
      ),
    );
  }

  Widget _buildPlanCard(Map planData) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary.setOpacity(0.2)),
      ),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 17),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Display title or price
          planData['title'].toString().isNotEmpty
              ? Text(
                  planData['title'],
                  textAlign: TextAlign.center,
                  style: regular(
                    fontSize: 24.sp.flexClamp(18, 26),
                    fontFamily: AppFontFamily.secondary,
                  ),
                )
              : planData['price'].toString().isNotEmpty
              ? RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '\$${planData['price']}',
                        style: regular(
                          fontSize: 32.sp.flexClamp(24, 36),
                          fontFamily: AppFontFamily.secondary,
                          color: AppColors.primary,
                        ),
                      ),
                      TextSpan(
                        text: '/month',
                        style: regular(fontSize: 16.sp.clamp(14, 18)),
                      ),
                    ],
                  ),
                )
              : SizedBox.shrink(),
          SizedBox(height: 15),
          ListView.separated(
            shrinkWrap: true,
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
