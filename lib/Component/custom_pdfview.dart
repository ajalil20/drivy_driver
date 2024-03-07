// import 'dart:async';
// import 'dart:io';
// import 'package:drivy_driver/Service/api_endpoints.dart';
// import 'package:drivy_driver/Utils/my_colors.dart';
// import 'package:drivy_driver/View/base_view.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';
// import '../../utils/app_strings.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
//
// class CustomPdfViewScreen extends StatefulWidget {
//   final String? pdfPath, pdfTitle, pdfType;
//   CustomPdfViewScreen({Key? key, this.pdfPath, this.pdfTitle, this.pdfType}) : super(key: key);
//   @override
//   State<CustomPdfViewScreen> createState() => _CustomPdfViewScreenState();
// }
//
// class _CustomPdfViewScreenState extends State<CustomPdfViewScreen> {
//   int? pages = 0;
//   int? currentPage = 0;
//   bool isReady = false;
//   dynamic remotePathPDF;
//   String landscapePathPdf = "";
//   String errorMessage = '';
//   final Completer<PDFViewController> _controller =
//   Completer<PDFViewController>();
//
//   Future<File> fromNetwork() async {
//     Completer<File> completer = Completer();
//     try {
//       final url =APIEndpoints.baseURL+widget.pdfPath!;
//       final fileName = url?.substring(url.lastIndexOf("/") + 1);
//       var request = await HttpClient().getUrl(Uri.parse(url!));
//       var response = await request.close();
//       var bytes = await consolidateHttpClientResponseBytes(response);
//       var dir = await getApplicationDocumentsDirectory();
//       File file = File("${dir.path}/$fileName");
//       await file.writeAsBytes(bytes, flush: true);
//       completer.complete(file);
//     } catch (e) {
//       throw Exception("Error downloading pdf file!");
//     }
//
//     return completer.future;
//   }
//   Future<File> fromAsset(String asset, String filename) async {
//     Completer<File> completer = Completer();
//     try {
//       var dir = await getApplicationDocumentsDirectory();
//       File file = File("${dir.path}/$filename");
//       var data = await rootBundle.load(asset);
//       var bytes = data.buffer.asUint8List();
//       await file.writeAsBytes(bytes, flush: true);
//       completer.complete(file);
//     } catch (e) {
//       throw Exception('Error parsing asset file!');
//     }
//
//     return completer.future;
//   }
//   Future<File> fromFileUpload(file, String asset, String filename) async {
//     Completer<File> completer = Completer();
//     try {
//       File file = File(asset);
//       completer.complete(file);
//     } catch (e) {
//       print(e);
//       throw Exception('Error parsing asset file!');
//     }
//     return completer.future;
//   }
//
//
//   @override
//   void initState() {
//     super.initState();
//     if (mounted) {
//       initializeFileType();
//     }
//   }
//
//   void initializeFileType() {
//     fromNetwork().then((f) {
//       setState(() {
//         landscapePathPdf = f.path;
//       });
//     });
//     // if (widget.pdfType == "file") {
//     //   fromFileUpload(
//     //       File(widget.pdfPath!), widget.pdfPath!.toString(), 'sample')
//     //       .then((f) {
//     //     setState(() {
//     //       landscapePathPdf = f.path;
//     //     });
//     //   });
//     // } else if (widget.pdfType == AppStrings.NETWORK_TEXT) {
//     //   ///Network
//     //
//     // } else {
//     //   ///Assets
//     //   fromAsset(widget.pdfPath!, 'sample.pdf').then((f) {
//     //     setState(() {
//     //       landscapePathPdf = f.path;
//     //     });
//     //   });
//     // }
//     //
//     // ///Upload from device
//     // // uploadFile();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     ThemeData theme = Theme.of(context);
//     print(APIEndpoints.baseURL+widget.pdfPath!);
//     return BaseView(
//       child: landscapePathPdf == ""
//           ? Center(
//         child: CircularProgressIndicator(
//           color: MyColors().primaryColor,
//         ),
//       )
//           : PDFView(
//         filePath: landscapePathPdf,
//         enableSwipe: true,
//         swipeHorizontal: false,
//         autoSpacing: false,
//         pageFling: false,
//         onRender: (_pages) {
//           setState(() {
//             pages = _pages;
//             isReady = true;
//           });
//         },
//         onError: (error) {
//           print(error.toString());
//         },
//         onPageError: (page, error) {
//           print('$page: ${error.toString()}');
//         },
//         onViewCreated: (PDFViewController pdfViewController) {
//           _controller.complete(pdfViewController);
//         },
//         onPageChanged: (int? page, int? total) {
//           print('page change: $page/$total');
//         },
//       ),
//     );
//   }
// }