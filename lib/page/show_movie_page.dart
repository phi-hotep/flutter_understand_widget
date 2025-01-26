// ignore_for_file: avoid_print, must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_understand_widget/page/movie_details_page.dart';

class ShowMoviePage extends StatefulWidget {
  const ShowMoviePage(
      {super.key, required this.showList, required this.refresh});

  final showList;
  final Function() refresh;

  @override
  State<StatefulWidget> createState() => _ShowMoviePageState();
}

class _ShowMoviePageState extends State<ShowMoviePage> {
  //We initialize the widget with two movies in the showList
  @override
  void initState() {
    super.initState();
    print('initState is called');

    //widget.showList = showList.sublist(0, 2);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('Then didChangeDependencies is called');
  }

//Is called whenever the user swipe or clic on the double arrow button
  @override
  void didUpdateWidget(covariant ShowMoviePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget != widget) {
      print('didUpdateWidget is called');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                widget.refresh();
                print(
                    'The parent widget forces the child to rebuild with new list of movies');
              },
              icon: const Icon(
                Icons.compare_arrows_sharp,
                size: 40,
              ),
            ),
            const SizedBox(
              width: 10,
            )
          ],
          title: const Text('Movies'),
        ),
        body: RefreshIndicator(
          // enable the swipe feature
          color: Colors.white,
          onRefresh: () async {
            widget.refresh(); // the call for reorder function in parent widget
            print(
                'The parent widget forces the child to rebuild with new list of movies');
          },
          child: Center(
            child: ListView.builder(
              itemCount: widget.showList.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          //Navigate to the new route
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieDetails(
                              movie: widget.showList[index],
                            ),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Container(
                            constraints: const BoxConstraints.expand(
                                height: 200, width: 150),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                image: AssetImage(widget.showList[index].cover),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 200,
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    widget.showList[index].title,
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        widget.showList[index].comment,
                                        textAlign: TextAlign.center,
                                        maxLines: 6,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ));
  }

  @override
  void deactivate() {
    print('deactivate is called');
    super.deactivate();
  }

  @override
  void dispose() {
    print('dispose is called');
    super.dispose();
  }
}
