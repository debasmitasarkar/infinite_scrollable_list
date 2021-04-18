import 'package:flutter/material.dart';
import 'package:infinite_feed/datasource/remote_api.dart';
import 'package:infinite_feed/response/news_response.dart';
import 'package:infinite_feed/widgets/article_widget.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Infinite Feed',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: InfiniteFeed(),
    );
  }
}

class InfiniteFeed extends StatefulWidget {
  InfiniteFeed({Key key}) : super(key: key);

  @override
  _InfiniteFeedState createState() => _InfiniteFeedState();
}

class _InfiniteFeedState extends State<InfiniteFeed> {
  // 1. Set up remote api to get news article
  // 2. Check out and make design
  // 3. Know about the package
  // 4. load list of data in screen
  PagingController<int, Article> _controller =
      PagingController(firstPageKey: 1);

  int _pageSize = 10;

  @override
  void initState() {
    _controller.addPageRequestListener((pageKey) {
      _fetchArticles(pageKey);
    });
    super.initState();
  }

  _fetchArticles(int pageKey) async {
    // 1. call remote api to get data
    try {
      List<Article> articles =
          await RemoteApi.getArticleList(pageKey, _pageSize);
      // 48 - 10,10,10,10,8
      // 1 , 1+ 1 = 2
      final bool isLastPage = articles.length < _pageSize;
      if (isLastPage) {
        _controller.appendLastPage(articles);
      } else {
        _controller.appendPage(articles, pageKey + 1);
      }
    } catch (e) {
      _controller.error = e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _controller.refresh();
        },
        child: Container(
            color: Colors.black,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: PagedListView<int, Article>.separated(
              padding: EdgeInsets.all(10),
              pagingController: _controller,
              builderDelegate: PagedChildBuilderDelegate<Article>(
                firstPageErrorIndicatorBuilder: (context) => Text(
                    'Error occured',
                    style: TextStyle(color: Colors.white)),
                newPageErrorIndicatorBuilder: (context) => Text('Error occured',
                    style: TextStyle(color: Colors.white)),
                noMoreItemsIndicatorBuilder: (context) => Text(
                    'That\'s all folks!',
                    style: TextStyle(color: Colors.white)),
                itemBuilder: (BuildContext context, Article item, int index) {
                  return ArticleWidget(
                    headline: item.title,
                    imageUrl: item.urlToImage,
                    publishedAt: item.publishedAt,
                  );
                },
              ),
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 15,
                );
              },
            )),
      ),
    );
  }
}
