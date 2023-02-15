import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Episode extends StatelessWidget {
  const Episode({
    super.key,
    required this.episode,
    required this.webtoonId,
  });
  onButtonTap() async {
    await launchUrlString(
        'https://comic.naver.com/webtoon/detail?titleId=$webtoonId&no=${episode.id}');
  }

  final String webtoonId;
  final WebtoonEpisodeModel episode;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonTap,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.withOpacity(0),
            ),
            color: Colors.white),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            episode.title,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
          const Icon(Icons.chevron_right_rounded)
        ]),
      ),
    );
  }
}
