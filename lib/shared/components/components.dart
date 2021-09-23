import 'package:flutter/material.dart';
import 'package:hot_news/modules/web_view/webview_screen.dart';
import 'package:hot_news/shared/cubit/cubit.dart';
import 'package:intl/intl.dart';

Widget buildArticleItem(dynamic article, BuildContext context,index) {
  return Container(
    //color: AppCubit.get(context).businessSelectedItems[index]?Colors.grey[200]:null,
    color: AppCubit.get(context).businessSelectedItem==index&&AppCubit.get(context).isDesktop?Colors.grey[200]:null,
    child: InkWell(
      onTap: () {
        //in mobile
        //navigateTo(context, WebViewScreen(article['url']));
        //in web and desktop
        AppCubit.get(context).selectBusinessItem(index);
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            ///news image
            Container(
              width: 125.0,
              height: 125.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.greenAccent,
                image: DecorationImage(
                  image: NetworkImage('${article['urlToImage']}'),
                  fit: BoxFit.cover,
                  onError: (exception,stackTrace){
                    print("Error:There is no image: $exception");
                  }
                ),
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            ///date and title
            Expanded(
              child: Container(
                height: 125.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      ///title
                      child: Text(
                        '${article['title']}',
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyText1,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    ///publishing date
                    Text(
                      '${DateFormat.yMMMd().format(DateTime.parse(article['publishedAt']))}',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}


Widget myDivider() =>
    Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 16.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget articleBuilder(List<dynamic> news, {isSearch = false}) {
  //you can use if(state is GetBusinessLoadingNewsState)

  if (news.isEmpty) {
    if (isSearch == true) {
      return Container();
    } else {
      return Center(child: CircularProgressIndicator());
    }
  } else {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return buildArticleItem(news[index], context,index);
        },
        separatorBuilder: (context, index) {
          return myDivider();
        },
        itemCount: news.length);
  }
}

///TextFormField Component
Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  required IconData icon,
  Function(String value)? onChange,
}) =>
    TextFormField(
      onChanged: onChange,
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        prefixIcon: Icon(icon),
      ),
    );
///navigate from screen to another
void navigateTo(context, widget) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ));
}
