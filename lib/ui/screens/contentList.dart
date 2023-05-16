import 'package:ajobthing_test/bloc/content/content_bloc.dart';
import 'package:ajobthing_test/main.dart';
import 'package:ajobthing_test/model/blog.dart';
import 'package:ajobthing_test/model/candidate.dart';
import 'package:ajobthing_test/ui/common/loading.dart';
import 'package:ajobthing_test/ui/dialogs/errorDialog.dart';
import 'package:ajobthing_test/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ContentList extends StatefulWidget {
  const ContentList({super.key});

  @override
  State<ContentList> createState() => _ContentListState();
}

class _ContentListState extends State<ContentList> {
  List? initialList;
  List? searchedList;
  String searchText = '';
  TextEditingController filterController = TextEditingController();
  ScrollController listScroller = ScrollController();
  bool isShowEndButton = false;
  @override
  void initState() {
    listScroller.addListener(_onScrollEvent);
    super.initState();
  }

  @override
  void dispose() {
    listScroller.removeListener(_onScrollEvent);
    super.dispose();
  }

  void _onScrollEvent() {
    if (listScroller.offset >= listScroller.position.maxScrollExtent - 10) {
      // logger.d('offset : ${listScroller.offset}');
      // logger.d('extent max : ${listScroller.position.maxScrollExtent}');
      // logger.d('extent min : ${listScroller.position.minScrollExtent}');
      BlocProvider.of<ContentBloc>(context).add(ListEndReached());
    } else {
      if (listScroller.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (listScroller.offset <= listScroller.position.minScrollExtent + 30) {
          BlocProvider.of<ContentBloc>(context).add(HideScrollButton());
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final contentBloc = BlocProvider.of<ContentBloc>(context);
    return BlocListener<ContentBloc, ContentState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is GetContentList) {
          initialList = state.contentList;
          searchedList = state.contentList;
        } else if (state is GetSearchedList) {
          searchText = state.searchText;
          searchedList = state.searchedList;

          filterController.text = state.searchText;
          filterController.selection = TextSelection.fromPosition(
              TextPosition(offset: state.searchText.length));
        } else if (state is GetApiError) {
          showDialog(
              context: context,
              barrierDismissible: false,
              barrierColor: Colors.grey.withOpacity(0.3),
              builder: ((context) => ErrorDialog(
                  errorMessage: state.errorMsg,
                  onRetry: () {
                    contentBloc.add(LoadContentList());
                    Navigator.pop(context);
                  })));
        } else if (state is GetListEndReached) {
          isShowEndButton = true;
        } else if (state is GetListMoveUp) {
          isShowEndButton = false;
          listScroller.animateTo(listScroller.position.minScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut);
        } else if (state is ScrollButtonHidden) {
          isShowEndButton = false;
        }
      },
      child: BlocBuilder<ContentBloc, ContentState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            floatingActionButton: isShowEndButton
                ? ElevatedButton(
                    onPressed: () {
                      contentBloc.add(ListWillMoveUp());
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(20),
                      backgroundColor: Colors.blue, // <-- Button color
                      foregroundColor: Colors.red, // <-- Splash color
                    ),
                    child: const Icon(Icons.keyboard_arrow_up,
                        color: Colors.white),
                  )
                : const SizedBox.shrink(),
            body: Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(20),
                  child: searchedList == null
                      ? loaderWidget()
                      : Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: TextFormField(
                                    controller: filterController,
                                    autocorrect: false,
                                    onChanged: (value) => contentBloc.add(
                                        FilterSearchedContent(
                                            searchText: value,
                                            originalList: initialList!)),
                                    decoration: Constants.textFieldWithoutIcons(
                                        hintTextStr: 'Search here'),
                                  ),
                                ),
                                searchText.isNotEmpty
                                    ? Expanded(
                                        flex: 1,
                                        child: IconButton(
                                            icon:
                                                const Icon(Icons.close_rounded),
                                            onPressed: () {
                                              contentBloc.add(
                                                  FilterSearchedContent(
                                                      searchText: '',
                                                      originalList:
                                                          initialList!));
                                            }),
                                      )
                                    : SizedBox.shrink()
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            searchedList!.isEmpty
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text('No item...!!!'),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Icon(Icons.hourglass_empty),
                                    ],
                                  )
                                : Expanded(
                                    child: ListView.separated(
                                        controller: listScroller,
                                        shrinkWrap: true,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          if (searchedList![index]
                                              is CandidateResult) {
                                            CandidateResult candidateitem =
                                                searchedList![index];
                                            bool isExpired = DateTime.now()
                                                    .millisecondsSinceEpoch >
                                                DateTime.fromMillisecondsSinceEpoch(
                                                        candidateitem.expired!)
                                                    .millisecondsSinceEpoch;
                                            // logger.d(
                                            //     'expired date: ${DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(candidateitem.expired!))}');
                                            // logger.d('current date ms: $isExpired');
                                            return ListTile(
                                              onTap: () => Navigator.pushNamed(
                                                  context,
                                                  Constants.candidateDetails,
                                                  arguments: candidateitem),
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      side: BorderSide(
                                                          color: Colors.grey),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5))),
                                              title: Text(
                                                candidateitem.name!,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              subtitle: isExpired
                                                  ? const Text('Expired')
                                                  : const SizedBox.shrink(),
                                              trailing:
                                                  const Icon(Icons.people),
                                            );
                                          } else if (searchedList![index]
                                              is BlogResult) {
                                            BlogResult blogItem =
                                                searchedList![index];

                                            return ListTile(
                                              onTap: () => Navigator.pushNamed(
                                                  context,
                                                  Constants.blogDetails,
                                                  arguments: blogItem),
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      side: BorderSide(
                                                          color: Colors.grey),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5))),
                                              title: Text(
                                                blogItem.title!,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              subtitle: Text(
                                                blogItem.subTitle!,
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              trailing:
                                                  const Icon(Icons.wrap_text),
                                            );
                                          }
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) =>
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                        itemCount: searchedList!.length),
                                  ),
                          ],
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
