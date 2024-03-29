import 'package:beeShop/pages/AppMain/Home/SearchPage.dart';
import 'package:flutter/material.dart';

const searchList = [];

const recentSuggest = [
  '电子数码',
  '运动户外',
  '服装',
  '日用品',
  '食品',
  '其他',
];

class SearchBarDelegate extends SearchDelegate<String> {
  //清空按钮
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = "", //搜索值为空
      )
    ];
  }

  //返回上级按钮
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () => close(context, null) //点击时关闭整个搜索页面
        );
  }

  //-------搜到到内容后的展现
  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: SearchPage(query: query),
    );
  }

  //设置推荐
  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionsList = query.isEmpty
        ? recentSuggest
        : searchList.where((input) => input.startsWith(query)).toList();

    return ListView.builder(
      itemCount: suggestionsList.length,
      itemBuilder: (context, index) => ListTile(
        title: RichText(
          //富文本
          text: TextSpan(
              text: suggestionsList[index].substring(0, query.length),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: suggestionsList[index].substring(query.length),
                    style: TextStyle(color: Colors.grey))
              ]),
        ),
        onTap: () {
          print(suggestionsList[index]);
          query = suggestionsList[index];
        },
      ),
    );
  }
}
