import 'package:ajobthing_test/bloc/content/content_bloc.dart';
import 'package:ajobthing_test/main.dart';
import 'package:ajobthing_test/model/address.dart';
import 'package:ajobthing_test/model/candidate.dart';
import 'package:ajobthing_test/model/contact.dart';
import 'package:ajobthing_test/model/experience.dart';
import 'package:ajobthing_test/ui/common/loading.dart';
import 'package:ajobthing_test/ui/dialogs/errorDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class CandidateDetail extends StatefulWidget {
  const CandidateDetail({super.key});

  @override
  State<CandidateDetail> createState() => _CandidateDetailState();
}

class _CandidateDetailState extends State<CandidateDetail> {
  CandidateResult? candidateResult;
  AddressResult? addressResult;
  ContactResult? contactResult;
  ExperienceResult? experienceResult;
  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  @override
  Widget build(BuildContext context) {
    final contentBloc = BlocProvider.of<ContentBloc>(context);
    return BlocListener<ContentBloc, ContentState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is GetCandidateDetails) {
          candidateResult = state.candidateResult;
          addressResult = state.addressResult;
          contactResult = state.contactResult;
          experienceResult = state.experienceResult;
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
        }
      },
      child: BlocBuilder<ContentBloc, ContentState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Container(
                // alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 20, bottom: 50),
                child: candidateResult == null ||
                        addressResult == null ||
                        contactResult == null ||
                        experienceResult == null
                    ? loaderWidget()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage:
                                NetworkImage(candidateResult!.photo!),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          loadDetail('Name', candidateResult!.name!),
                          loadDetail(
                              'BirthDay',
                              DateFormat('dd/MM/yyyy').format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      candidateResult!.birthday!))),
                          loadDetail(
                              'Gender', candidateResult!.gender!.toUpperCase()),
                          Container(
                            height: 1,
                            color: Colors.grey,
                            margin: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                          ),
                          loadDetail('Address', addressResult!.address!),
                          loadDetail('City', addressResult!.city!),
                          loadDetail('State', addressResult!.state!),
                          loadDetail(
                              'Zip Code', addressResult!.zipCode!.toString()),
                          Container(
                            height: 1,
                            color: Colors.grey,
                            margin: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 25, right: 25),
                            child: Text(
                              'Click email to send email or click phone number to whatsapp',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                          GestureDetector(
                              onTap: () async => await launchUrl(Uri(
                                    scheme: 'mailto',
                                    path: contactResult!.email!,
                                    query:
                                        encodeQueryParameters(<String, String>{
                                      'body':
                                          'Hi I am from ${experienceResult!.companyName!} company',
                                    }),
                                  )),
                              child:
                                  loadDetail('Email', contactResult!.email!)),
                          GestureDetector(
                              onTap: () async => await launchUrl(Uri.parse(
                                  'whatsapp://send?phone=${contactResult!.phone!}'
                                  '&text=${Uri.encodeComponent('Hi I am from ${experienceResult!.companyName!} company')}')),
                              child:
                                  loadDetail('Phone', contactResult!.phone!)),
                          Container(
                            height: 1,
                            color: Colors.grey,
                            margin: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                          ),
                          loadDetail('Status', experienceResult!.status!),
                          loadDetail('Company', experienceResult!.companyName!),
                          loadDetail('Job Title', experienceResult!.jobTitle!),
                          loadDetail('Industry', experienceResult!.industry!),
                        ],
                      ),
              ),
            ),
          );
        },
      ),
    );
  }

  Padding loadDetail(String placeHolder, String value) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 20),
      child: Row(
        children: [
          Text(
            '$placeHolder: ',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    );
  }
}
