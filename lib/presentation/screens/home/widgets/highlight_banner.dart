import 'package:flutter/material.dart';
import 'package:training/data/models/training.dart';
import 'package:training/presentation/common/app_theme.dart';
import 'package:training/presentation/common/ui_string.dart';
import 'package:training/presentation/screens/detail/training_detail_page.dart';

class HighlightBanner extends StatelessWidget {
  const HighlightBanner({
    super.key,
    required this.highlight,
  });

  final Training highlight;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TrainingDetailPage(training: highlight),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(image: _bannerImageView()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _nameView(),
            _locationAndDateView(),
            const SizedBox(height: 20),
            _priceView(),
          ],
        ),
      ),
    );
  }

  Row _priceView() {
    return Row(
      children: [
        Text(
          "\$${highlight.actualPrice}",
          style: const TextStyle(
              color: AppTheme.sunburntCyclops,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.lineThrough,
              decorationThickness: 3,
              decorationColor: AppTheme.sunburntCyclops),
        ),
        const SizedBox(width: 10),
        Text(
          "\$${highlight.discountPrice}",
          style: const TextStyle(
            color: AppTheme.sunburntCyclops,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        const Text(
          UIString.viewDetails,
          style: TextStyle(
            color: AppTheme.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Icon(
          Icons.arrow_right_alt,
          color: AppTheme.white,
        )
      ],
    );
  }

  Row _locationAndDateView() {
    return Row(
      children: [
        Text(
          highlight.location,
          style: const TextStyle(
            color: AppTheme.white,
            fontSize: 14,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          highlight.date,
          style: const TextStyle(
            color: AppTheme.white,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Text _nameView() {
    return Text(
      highlight.name,
      style: const TextStyle(
        color: AppTheme.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  DecorationImage _bannerImageView() {
    return DecorationImage(
      image: AssetImage(highlight.banner),
      fit: BoxFit.fitWidth,
      colorFilter: ColorFilter.mode(
        Colors.black.withOpacity(0.6),
        BlendMode.darken,
      ),
    );
  }
}
