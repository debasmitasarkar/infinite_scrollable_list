import 'package:flutter/material.dart';

class ArticleWidget extends StatelessWidget {
  final String imageUrl;
  final String headline;
  final DateTime publishedAt;
  const ArticleWidget(
      {@required this.headline,
      @required this.imageUrl,
      @required this.publishedAt,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade900,
      ),
      padding: EdgeInsets.all(10),
      height: 100,
      child: Row(
        children: [
          Image.network(
            imageUrl ??
                'https://miro.medium.com/max/1000/1*ilC2Aqp5sZd1wi0CopD1Hw.png',
            width: 100,
            fit: BoxFit.fill,
          ),
          SizedBox(width: 10),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Container(
                    child: Text(
                      headline,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Text(
                  '${publishedAt.day}/${publishedAt.month}/${publishedAt.year}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
