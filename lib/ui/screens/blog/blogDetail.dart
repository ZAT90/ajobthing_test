import 'dart:math';

import 'package:ajobthing_test/main.dart';
import 'package:ajobthing_test/model/blog.dart';
import 'package:ajobthing_test/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';

class BlogDetail extends StatelessWidget {
  final BlogResult blogResult;
  const BlogDetail({super.key, required this.blogResult});

  @override
  Widget build(BuildContext context) {
    logger.d('blogresult in detail: $blogResult');
    List<String> tags = blogResult.tag!.split(',');
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
            children: [
              Image.network(
                blogResult.photo!,
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  'assets/images/noImage.png',
                  width: Constants(context).width,
                  height: Constants(context).height / 3.2,
                ),
                width: Constants(context).width,
                height: Constants(context).height / 3.2,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (String item in tags)
                    Row(
                      children: [
                        Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.primaries[
                                    Random().nextInt(Colors.primaries.length)],
                                border: Border.all(color: Colors.blueGrey),
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              children: [
                                Text(
                                  item,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )),
                        const SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Text(
                      blogResult.title!,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          decoration: TextDecoration.underline,
                          fontStyle: FontStyle.italic),
                    ),
                    Text(
                      ' - ${blogResult.author!} (${DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(blogResult.createAt!))})',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      blogResult.subTitle!,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        blogResult.content!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(wordSpacing: 2, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
