import 'package:flutter/material.dart';
import 'package:newsapp/global_widget/custom_image.dart';
import 'package:newsapp/module/home/model/artical_model.dart';
import 'package:newsapp/utils/utils.dart';

class HomeDetailsScreen extends StatefulWidget {
  const HomeDetailsScreen({super.key, required this.article});
  final Article article;

  @override
  State<HomeDetailsScreen> createState() => _HomeDetailsScreenState();
}

class _HomeDetailsScreenState extends State<HomeDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FE),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          "Details Screen",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomImage(
                    path: widget.article.urlToImage,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text("Author: ${widget.article.author}",
                        style: TextStyle(fontSize: 12),
                      )),
                      Expanded(child: Text(
                          "Published at: ${Utils.formatDate(widget.article.publishedAt)}",
                        textAlign: TextAlign.end,
                        style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Text(widget.article.title,style: TextStyle(
                      fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),),
                  Text(widget.article.content)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
