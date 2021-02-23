import 'package:flutter/material.dart';

class TileCard extends StatelessWidget {
  final String id;
  final String content;
  final String image;
  final String price;
  final String updatetime;
  final String userava;
  final String username;

  TileCard(
      {this.id,
      this.content,
      this.image,
      this.price,
      this.updatetime,
      this.userava,
      this.username});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Material(
      // elevation: 8.0,
      // borderRadius: new BorderRadius.all(
      //   new Radius.circular(8.0),
      // ),
      color: Color.fromRGBO(255, 255, 255, 0),
      child: new InkWell(
          onTap: () {
            //  Navigator.push(
            //    context,
            //    new MaterialPageRoute(
            //      builder: (context) {
            //        return new FullScreenImagePage(imageurl: imgPath);
            //      },
            //    ),
            //  );
            print("dd");
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) {
                  return Text("dd");
                },
              ),
            );
          },
          child: Column(
            children: [
              Container(
                child: Hero(
                  tag: image,
                  child: new Material(
                    color: Colors.transparent,
                    child: new InkWell(
                      onTap: () {
                        print("ee");
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                            builder: (context) {
                              return Text("ee");
                            },
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                // height: 30,
                padding: EdgeInsets.only(top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      content,
                      maxLines: 2,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ],
          )),
    ));
  }
}
