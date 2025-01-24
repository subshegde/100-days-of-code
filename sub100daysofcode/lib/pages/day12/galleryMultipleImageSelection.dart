import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:sub100daysofcode/constants/appColors.dart';


class ImagesForChildTable {
  dynamic? id;
  String? fileName;
  String? size;
  String? fileType;
  String? file;

  ImagesForChildTable(
      {this.id, this.fileName, this.size, this.fileType, this.file});

  ImagesForChildTable.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fileName = json['file_name'];
    size = json['size'];
    fileType = json['file_type'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['file_name'] = this.fileName;
    data['size'] = this.size;
    data['file_type'] = this.fileType;
    data['file'] = this.file;
    return data;
  }
}


class SelectImagesCameraFiles{
  List<String> cameraAndFiles;
  List<AssetEntity> selectedImages;

  SelectImagesCameraFiles({required this.cameraAndFiles,required this.selectedImages});
}

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> with TickerProviderStateMixin {
  Map<String, List<AssetEntity>> groupedAssets = {};

  int selectIndex = 0;

  @override
  void initState() {
    super.initState();

        requestPermission().then((value){
      if(value == true){
        load();
      }
    });
  }


  void safeSetState(VoidCallback fn) {
    if (mounted) {
      setState(() {
        fn();
      });
    }
  }

  
Future<bool> requestPermission() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    bool storageGranted = true;
    bool videosGranted = true;
    bool photosGranted = true;

    // Check permissions for Android 13 and above
    if (androidInfo.version.sdkInt >= 33) {
      videosGranted = await Permission.videos.isGranted;
      photosGranted = await Permission.photos.isGranted;
    } else {
      storageGranted = await Permission.storage.isGranted;
    }

    if (storageGranted && videosGranted && photosGranted) {
      return true;
    } else {
      print("Storage or media permissions denied on Android");
      return false;
    }
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    bool storageGranted = await Permission.storage.isGranted;

    if (storageGranted) {
      return true;
    } else {
      print("Storage permission denied on iOS");
      return false;
    }
  }

  return false;
}

  Map<String, List<File?>>imageFiles = {};
  Map<String, List<Uint8List?>> thumbnails = {};
Future<void> load() async {
  try {
    List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(type: RequestType.all);

    if (albums.isEmpty) {
      print('No albums found.');
      return;
    }

    // Only 100 items to load
    List<AssetEntity> allAssets = await albums[0].getAssetListPaged(page: 0, size: 100);

    //     //all 
    //  int assetCount = await albums[0].assetCountAsync;
    //  List<AssetEntity> allAssets = await albums[0].getAssetListRange(start: 0, end: assetCount);


    // Sort assets by creation date
    allAssets.sort((a, b) => b.createDateTime!.compareTo(a.createDateTime!));

    Map<String, List<AssetEntity>> grouped = {};
    Map<String, List<File?>> imageFilesGrouped = {}; // To hold images for each date group
    Map<String, List<Uint8List?>> thumbnailsGrouped = {}; // To hold thumbnails for each date group

    for (var asset in allAssets) {
      String formattedDate = asset.createDateTime != null
          ? DateFormat('dd-MM-yyyy').format(asset.createDateTime!)
          : 'Unknown Date';

      if (!grouped.containsKey(formattedDate)) {
        grouped[formattedDate] = [];
        imageFilesGrouped[formattedDate] = [];
        thumbnailsGrouped[formattedDate] = [];
      }
      grouped[formattedDate]!.add(asset);

      // Preload images and thumbnails
      File? file = await asset.file;
      Uint8List? thumbnailData = await asset.thumbnailDataWithOption(
        ThumbnailOption(size: ThumbnailSize.square(200)),
      );

      imageFilesGrouped[formattedDate]!.add(file);
      thumbnailsGrouped[formattedDate]!.add(thumbnailData);
    }

    setState(() {
      groupedAssets = grouped;
      imageFiles = imageFilesGrouped;
      thumbnails = thumbnailsGrouped;
    });
  } catch (e) {
    print('Error loading assets: $e');
  }
}
List<AssetEntity> selectedImages = [];
List<File> assetEntityConvertedToFile = [];


  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile ;
  List<String> imageLists = [];
Future<void> _pickImageFromCamera() async {
  final XFile? image = await _picker.pickImage(source: ImageSource.camera);

  if (image != null) {
    File file = File(image.path);

    String filename = file.path.split('/').last; 
    String path = file.path;

    setState(() {
      _imageFile = image;
      imageLists.add(path);
    });

    int fileSize = await file.length();
    
    String fileType = file.path.split('.').last.toLowerCase(); 

    String mimeType = {
      'gif': 'image/gif',
      'jpg': 'image/jpeg',
      'jpeg': 'image/jpeg',
      'png': 'image/png',
      'pdf': 'application/pdf',
      'txt': 'text/plain',
      'doc': 'application/msword',
      'docx': 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
      'csv': 'text/csv',
      'xlsx': 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    }[fileType] ?? 'application/octet-stream';

    String base64FileContent = base64Encode(await file.readAsBytes());
    String prefixedBase64FileContent = 'data:$mimeType;base64,$base64FileContent';

    fileList.add(
      ImagesForChildTable(
        id: generateUniqueId(),
        file: prefixedBase64FileContent,
        size: '${(fileSize / 1024).toStringAsFixed(2)} KB',
        fileType: mimeType,
        fileName: filename,
      ),
    );

    fileList2.add(
      ImagesForChildTable(
        id: generateUniqueId(),
        file: path,
        size: '${(fileSize / 1024).toStringAsFixed(2)} KB',
        fileType: mimeType,
        fileName: filename,
      ),
    );
  } else {
    print("File picking was canceled");
  }}

List<ImagesForChildTable> fileList = [];
List<ImagesForChildTable> fileList2 = [];

Future<void> _pickDocument() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf','gif', 'txt', 'doc', 'docx', 'csv', 'xlsx'],
  );

  if (result != null) {
    File file = File(result.files.single.path ?? '');
    String filename = file.path.split('/').last;
    String path = file.path;
    int fileSize = await file.length();
    String fileType = result.files.single.extension ?? 'unknown';

      safeSetState(() {
        imageLists.add(path);
      });

    String mimeType = {
      'gif': 'image/gif',
      'pdf': 'application/pdf',
      'txt': 'text/plain',
      'doc': 'application/msword',
      'docx': 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
      'csv': 'text/csv',
      'xlsx': 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    }[fileType.toLowerCase()] ?? 'application/octet-stream';

    String base64FileContent = base64Encode(await file.readAsBytes());
    String prefixedBase64FileContent = 'data:$mimeType;base64,$base64FileContent';

    fileList.add(
      ImagesForChildTable(
        id: generateUniqueId(),
        file: prefixedBase64FileContent,
        size: '${(fileSize / 1024).toStringAsFixed(2)} KB',
        fileType: mimeType,
        fileName: filename,
      ),
    );

    fileList2.add(
      ImagesForChildTable(
        id: generateUniqueId(),
        file: path,
        size: '${(fileSize / 1024).toStringAsFixed(2)} KB',
        fileType: mimeType,
        fileName: filename,
      ),
    );
  } else {
    print("File picking was canceled");
  }
}

String generateUniqueId() {
  final timeStamp = DateTime.now().microsecondsSinceEpoch;
  final random = Random().nextInt(100000);
  return (timeStamp + random).toString() + '+a';
}


Future<void> convertToBase64AndNormal() async {
  for (int sn = 0; sn < selectedImages.length; sn++) {
    final File? file = await selectedImages[sn].file;

    if (file == null) {
      continue;
    }

    String filename = file.path.split('/').last;
    String path = file.path;
    int fileSize = await file.length();
    String fileType = file.path.split('.').last.toLowerCase(); // Gettin file extension

    // Determine MIME type based on file extension
    String mimeType = {
      'gif': 'image/gif',
      'jpg': 'image/jpeg',
      'jpeg': 'image/jpeg',
      'png': 'image/png',
      'pdf': 'application/pdf',
      'txt': 'text/plain',
      'doc': 'application/msword',
      'docx': 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
      'csv': 'text/csv',
      'xlsx': 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    }[fileType] ?? 'application/octet-stream';

    String base64FileContent = base64Encode(await file.readAsBytes());
    String prefixedBase64FileContent = 'data:$mimeType;base64,$base64FileContent';

    fileList.add(
      ImagesForChildTable(
        id: generateUniqueId(),
        file: prefixedBase64FileContent,
        size: '${(fileSize / 1024).toStringAsFixed(2)} KB',
        fileType: mimeType,
        fileName: filename,
      ),
    );

    fileList2.add(
      ImagesForChildTable(
        id: generateUniqueId(),
        file: path,
        size: '${(fileSize / 1024).toStringAsFixed(2)} KB',
        fileType: mimeType,
        fileName: filename,
      ),
    );
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(child:  Column(
        children: [
          Expanded(
            child: 
             _buildTab1(),
          ),
        ],
      ),
    ));
  }
  Widget _buildTab1() {
  return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
    Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height: 123,
        decoration: const BoxDecoration(color: AppColors.white),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 25.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () async{
                      if(selectIndex == 0){
                        _pickImageFromCamera();
                      }
                    },
                    child: Column(
                      children: [
                        selectIndex == 1 ? Image.asset('assets/icons/camera.png', scale: 10.0,color: AppColors.grey,):
                        Image.asset('assets/icons/camera.png', scale: 10.0,color: AppColors.black,),
                        const SizedBox(
                          height: 10,
                        ),
                         Text(
                          'Open Camera',
                          style: TextStyle(
                              color: selectIndex == 0 ? const Color.fromARGB(255, 63, 63, 63):AppColors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if(selectIndex == 0){
                        _pickDocument();
                      }
                    },
                    child: Column(
                      children: [
                        selectIndex == 1 ? Image.asset('assets/icons/folder.png', scale: 10.0,color: AppColors.grey,):
                        Image.asset('assets/icons/folder.png', scale: 10.0,color: AppColors.black,),
                        const SizedBox(
                          height: 10,
                        ),
                         Text(
                          'Choose Files',
                          style: TextStyle(
                              color: selectIndex == 0 ? const Color.fromARGB(255, 63, 63, 63):AppColors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
    
  Expanded(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
if (imageLists.isNotEmpty) ...[
  Container(
    margin: const EdgeInsets.only(left: 5),
    child: const Text('Selected from Camera & Files'),
  ),
  Column(
    children: [
      Container(
        margin: const EdgeInsets.only(left: 3, right: 3),
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.bg,
          border: const Border(
            top: BorderSide(color: Color.fromARGB(255, 218, 219, 220), width: 1),
            left: BorderSide(color: Color.fromARGB(255, 218, 219, 220), width: 1),
            right: BorderSide(color: Color.fromARGB(255, 218, 219, 220), width: 1),
            bottom: BorderSide(color: Color.fromARGB(255, 218, 219, 220), width: 1),
          ),
        ),
        height: 85,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: imageLists.length,
          itemBuilder: (context, index) {
            final file = imageLists[index];

            return Padding(
              padding: const EdgeInsets.all(2.0),
              child: Stack(
                children: [
                  file.endsWith('.pdf')
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey[300],
                          ),
                          width: 80,
                          height: 150,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: PDFView(
                              filePath: file,
                            ),
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey[300],
                          ),
                          width: 80,
                          height: 150,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              File(file),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          imageLists.removeAt(index);
                        });
                      },
                      child:
                      Container(
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: AppColors.white,),
                        child: const CircleAvatar(
                              backgroundColor: AppColors.blue,
                              radius: 10,
                              child: Icon(
                                Icons.delete,
                                color: AppColors.white,
                                size: 16,
                              ),
                            ),
                      ),
                      
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      const SizedBox(height: 5),
    ],
  ),
],




      Container(
        margin: const EdgeInsets.only(left: 8, right: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: const Text(
                'Recent Images',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black),
              ),
            ),

            Container(child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [ 
                  GestureDetector(
             onTap: () {
              safeSetState(() {
                selectIndex = 1 - selectIndex;
              });
              if(selectIndex == 0){
                safeSetState((){
                  selectedImages.clear();
                });
              }

              print('selectedImages length when cancel ${selectedImages.length}');
            },
              child: 
            Container(
              width: 75,
              height: 35,
              decoration: selectIndex == 0 ? BoxDecoration(
                color: const Color.fromARGB(255, 44, 44, 44),
                borderRadius: BorderRadius.circular(20),
              ) : BoxDecoration(
                color: const Color.fromARGB(255, 172, 172, 173),
                borderRadius: BorderRadius.circular(20),
              ) ,
              child:  Center(
                child: Text(
                  selectIndex == 0 ? 'Select' : 'Cancel',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color:selectIndex == 0 ?AppColors.white : AppColors.black,),
                ),
              ),
            ),),
            if(selectedImages.isNotEmpty || imageLists.isNotEmpty)...[
              const SizedBox(width: 5,),
                 Container(
      width: 75,
      height: 35,
      child: ElevatedButton(
        onPressed: (){

          convertToBase64AndNormal().then((_){
            Navigator.pop(context,{ 
            'selectedImages':selectedImages,
            'cameraAndFiles':imageLists,
            'fileList':fileList,
            'fileList2':fileList,
          });
          });

          
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          // elevation: 5,
          shadowColor: Colors.blueAccent.withOpacity(0.5),
        ),
        child: const Text(
          'OK',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),),],
            ],),),
          
          ],
        ),
      ),
      const SizedBox(height: 10),
//       Expanded(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               groupedAssetsCopy.isEmpty
//                   ? const Center(
//                       child: Text('No assets found',
//                           style: TextStyle(color: AppColors.grey)))
//                   : ListView(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       children: groupedAssetsCopy.keys.map((date) {
//                         List<AssetEntity> assetsForDate = groupedAssetsCopy[date]!;

//                         return Padding(
//                           padding: const EdgeInsets.all(2.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 margin: const EdgeInsets.only(left: 6, top: 5),
//                                 child: Text(
//                                   date,
//                                   style: const TextStyle(
//                                       fontSize: 11,
//                                       fontWeight: FontWeight.bold,
//                                       color: Color.fromARGB(255, 82, 82, 83)),
//                                 ),
//                               ),
//                               const SizedBox(height: 3),

//                               Container(
//                                 padding: const EdgeInsets.all(4.0),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(8),
//                                   color: AppColors.bg,
//                                   border: const Border(
//                                     top: BorderSide(
//                                         color: Color.fromARGB(255, 218, 219, 220),
//                                         width: 1),
//                                     left: BorderSide(
//                                         color: Color.fromARGB(255, 218, 219, 220),
//                                         width: 1),
//                                     right: BorderSide(
//                                         color: Color.fromARGB(255, 218, 219, 220),
//                                         width: 1),
//                                     bottom: BorderSide.none,
//                                   ),
//                                 ),
//                                 child: Column(
//                                   children: [
//                                       // const Padding(
//                                   //   padding: EdgeInsets.only(
//                                   //       top: 0.0, right: 8.0, bottom: 2),
//                                   //   child: Row(
//                                   //     children: [
//                                   //       Icon(
//                                   //         Icons.image,
//                                   //         color: AppColors.grey,
//                                   //         size: 20.0,
//                                   //       ),
//                                   //       SizedBox(width: 2),
//                                   //       Text(
//                                   //         "Images",
//                                   //         style: TextStyle(
//                                   //           color: AppColors.grey,
//                                   //           fontSize: 14,
//                                   //           fontWeight: FontWeight.bold,
//                                   //         ),
//                                   //       ),
//                                   //     ],
//                                   //   ),
//                                   // ),

//                                   // gridview
//                                     // GridView.builder(
//                                     //   shrinkWrap: true,
//                                     //   physics: const NeverScrollableScrollPhysics(),
//                                     //   gridDelegate:
//                                     //       const SliverGridDelegateWithFixedCrossAxisCount(
//                                     //     crossAxisCount: 4,
//                                     //     mainAxisSpacing: 4.0,
//                                     //     crossAxisSpacing: 4.0,
//                                     //   ),
//                                     //   itemCount: assetsForDate.length,
//                                     //   itemBuilder: (context, index) {
//                                     //     return FutureBuilder<File?>(
//                                     //       future: assetsForDate[index].file,
//                                     //       builder: (context, snapshot) {
//                                     //         if (snapshot.connectionState ==
//                                     //             ConnectionState.done) {
//                                     //           if (snapshot.hasData) {
//                                     //             return GestureDetector(
//                                     //               onTap: () {
//                                     //                 // Handle Image Tap
//                                     //               },
//                                     //               child: Container(
//                                     //                 margin:
//                                     //                     const EdgeInsets.only(
//                                     //                         top: 3),
//                                     //                 decoration: BoxDecoration(
//                                     //                   borderRadius:
//                                     //                       BorderRadius.circular(
//                                     //                           8),
//                                     //                   boxShadow: [
//                                     //                     BoxShadow(
//                                     //                       color: Colors.black
//                                     //                           .withOpacity(0.2),
//                                     //                       blurRadius: 4.0,
//                                     //                       spreadRadius: 1.0,
//                                     //                     ),
//                                     //                   ],
//                                     //                 ),
//                                     //                 child: FutureBuilder<Uint8List?>(
//                                     //                   future:assetsForDate[index].thumbnailDataWithOption(
//                                     //                     const ThumbnailOption(size: ThumbnailSize.square(200)),
//                                     //                   ),
//                                     //                   builder:(context, snapshot) {
//                                     //                     if (snapshot.connectionState == ConnectionState.done) {
//                                     //                       if (snapshot.hasData) {
//                                     //                         return ClipRRect(
//                                     //                           borderRadius:BorderRadius.circular(0),
//                                     //                           child: Image.memory(
//                                     //                             snapshot.data!,
//                                     //                             fit: BoxFit.cover,
//                                     //                           ),
//                                     //                         );
//                                     //                       } else {
//                                     //                         return const Center(
//                                     //                             child: Text(
//                                     //                                 'Error loading image',
//                                     //                                 style: TextStyle(color: AppColors.grey)));
//                                     //                       }
//                                     //                     }
//                                     //                     return const Center(
//                                     //                         child:CircularProgressIndicator(color: AppColors.yellow));
//                                     //                   },
//                                     //                 ),
//                                     //               ),
//                                     //             );
//                                     //           } else {
//                                     //             return const Center(
//                                     //                 child: Text(
//                                     //                     'Error retrieving image file',
//                                     //                     style: TextStyle(color: AppColors.grey)));
//                                     //           }
//                                     //         }
//                                     //         return const Center(
//                                     //             child: CircularProgressIndicator(color: AppColors.orange));
//                                     //       },
//                                     //     );
//                                     //   },
//                                     // )

//                                     GridView.builder(
//   shrinkWrap: true,
//   physics: const NeverScrollableScrollPhysics(),
//   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//     crossAxisCount: 4,
//     mainAxisSpacing: 4.0,
//     crossAxisSpacing: 4.0,
//   ),
//   itemCount: imageFiles.length, // Use the length of the preloaded image list
//   itemBuilder: (context, index) {
//     return GestureDetector(
//       onTap: () {
//         // Handle Image Tap
//       },
//       child: Container(
//         margin: const EdgeInsets.only(top: 3),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.2),
//               blurRadius: 4.0,
//               spreadRadius: 1.0,
//             ),
//           ],
//         ),
//         child: imageFiles[index] != null
//             ? ClipRRect(
//                 borderRadius: BorderRadius.circular(0),
//                 child: Image.memory(
//                   thumbnails[index]!, // Use preloaded thumbnail data
//                   fit: BoxFit.cover,
//                 ),
//               )
//             : const Center(child: CircularProgressIndicator(color: AppColors.yellow)),
//       ),
//     );
//   },
// )


                                    
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       }).toList(),
//                     ),
//             ],
//           ),
//         ),
//       ),
Expanded(
  child: SingleChildScrollView(
    child: Column(
      children: [
        groupedAssets.isEmpty
            ? const Center(
                child: Text('No assets found', style: TextStyle(color: AppColors.grey)))
            : ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: groupedAssets.keys.map((date) {
                  List<AssetEntity> assetsForDate = groupedAssets[date]!;

                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 6, top: 5),
                          child: Text(
                            date,
                            style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 82, 82, 83)),
                          ),
                        ),
                        const SizedBox(height: 3),

                        Container(
                          padding: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.bg,
                            border: const Border(
                              top: BorderSide(
                                  color: Color.fromARGB(255, 218, 219, 220),
                                  width: 1),
                              left: BorderSide(
                                  color: Color.fromARGB(255, 218, 219, 220),
                                  width: 1),
                              right: BorderSide(
                                  color: Color.fromARGB(255, 218, 219, 220),
                                  width: 1),
                              bottom: BorderSide.none,
                            ),
                          ),
                          child: GridView.builder(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 4,
    mainAxisSpacing: 4.0,
    crossAxisSpacing: 4.0,
  ),
  itemCount: assetsForDate.length,
  itemBuilder: (context, index) {
    var asset = assetsForDate[index];
    var thumbnail = thumbnails[date]?[index];

    bool isSelected = selectedImages.contains(asset);

    return GestureDetector(
      onTap: () {
        if (selectIndex == 1) {
          setState(() {
            if (isSelected) {
              safeSetState((){selectedImages.remove(asset); });
            } else {
              safeSetState((){selectedImages.add(asset); });
            }
          });
        }

      },
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4.0,
                  spreadRadius: 1.0,
                ),
              ],
            ),
            child: thumbnail != null && thumbnail is Uint8List
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.memory(
                      thumbnail,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  )
                : const Center(child: CircularProgressIndicator(color: AppColors.yellow)),
          ),
          if (selectIndex == 1)
            Positioned(
              right: 0,
              top: 2,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      safeSetState((){selectedImages.remove(asset); });
                    } else {
                      safeSetState((){selectedImages.add(asset); });
                    }
                  });
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 10,
                  child: Icon(
                    isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                    color: isSelected ? Colors.blue : AppColors.grey,
                    size: 20,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  },
)


                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
      ],
    ),
  ),
)


    ],
  ),
)

  ]);

}
}

// Widget _buildTab1(Map<String, List<AssetEntity>> groupedAssets) {
//   List<AssetEntity> selectedImages = [];

//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.stretch,
//     children: [
//       Padding(
//         padding: const EdgeInsets.all(4.0),
//         child: Container(
//           height: 123,
//           decoration: const BoxDecoration(color: AppColors.bg),
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Padding(
//             padding: const EdgeInsets.only(bottom: 25.0),
//             child: Column(
//               children: [
//                 const SizedBox(height: 10),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     GestureDetector(
//                       onTap: () {},
//                       child: Column(
//                         children: [
//                           Image.asset('assets/icons/camera.png', scale: 10.0),
//                           const SizedBox(height: 10),
//                           const Text(
//                             'Camera',
//                             style: TextStyle(
//                                 color: AppColors.blue,
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.bold),
//                           )
//                         ],
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {},
//                       child: Column(
//                         children: [
//                           Image.asset('assets/icons/folder.png', scale: 10.0),
//                           const SizedBox(height: 10),
//                           const Text(
//                             'Files',
//                             style: TextStyle(
//                                 color: AppColors.green,
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.bold),
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       Expanded(
//         child: Column(
//           children: [
//             // Header Section: Recent Images and Select Button
//             Container(
//               margin: const EdgeInsets.only(left: 8, right: 8),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     'Recent Images',
//                     style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.bold,
//                         color: AppColors.black),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       safeSetState(() {
//                         selectIndex = 1 - selectIndex;
//                       });
//                     },
//                     child: Container(
//                       width: 75,
//                       height: 35,
//                       decoration: BoxDecoration(
//                         color: selectIndex == 0
//                             ? const Color.fromARGB(255, 44, 44, 44)
//                             : const Color.fromARGB(255, 172, 172, 173),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Center(
//                         child: Text(
//                           selectIndex == 0 ? 'Select' : 'Cancel',
//                           style: TextStyle(
//                               fontSize: 15,
//                               fontWeight: FontWeight.bold,
//                               color: selectIndex == 0
//                                   ? AppColors.white
//                                   : AppColors.black),
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             const SizedBox(height: 10),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     groupedAssets.isEmpty
//                         ? const Center(
//                             child: Text('No assets found',
//                                 style: TextStyle(color: AppColors.grey)))
//                         : ListView(
//                             shrinkWrap: true,
//                             physics: const NeverScrollableScrollPhysics(),
//                             children: groupedAssets.keys.map((date) {
//                               List<AssetEntity> assetsForDate =
//                                   groupedAssets[date]!;

//                               return Padding(
//                                 padding: const EdgeInsets.all(2.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Container(
//                                       margin: const EdgeInsets.only(left: 6, top: 5),
//                                       child: Text(
//                                         date,
//                                         style: const TextStyle(
//                                             fontSize: 11,
//                                             fontWeight: FontWeight.bold,
//                                             color: Color.fromARGB(
//                                                 255, 82, 82, 83)),
//                                       ),
//                                     ),
//                                     const SizedBox(height: 3),
//                                     Container(
//                                       padding: const EdgeInsets.all(4.0),
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(8),
//                                         color: AppColors.bg,
//                                         border: const Border(
//                                           top: BorderSide(
//                                               color: Color.fromARGB(
//                                                   255, 218, 219, 220),
//                                               width: 1),
//                                           left: BorderSide(
//                                               color: Color.fromARGB(
//                                                   255, 218, 219, 220),
//                                               width: 1),
//                                           right: BorderSide(
//                                               color: Color.fromARGB(
//                                                   255, 218, 219, 220),
//                                               width: 1),
//                                           bottom: BorderSide.none,
//                                         ),
//                                       ),
//                                       child: GridView.builder(
//                                         shrinkWrap: true,
//                                         physics:
//                                             const NeverScrollableScrollPhysics(),
//                                         gridDelegate:
//                                             const SliverGridDelegateWithFixedCrossAxisCount(
//                                           crossAxisCount: 4,
//                                           mainAxisSpacing: 4.0,
//                                           crossAxisSpacing: 4.0,
//                                         ),
//                                         itemCount: assetsForDate.length,
//                                         itemBuilder: (context, index) {
//                                           return FutureBuilder<File?>(
//                                             future: assetsForDate[index].file,
//                                             builder: (context, snapshot) {
//                                               if (snapshot.connectionState ==
//                                                   ConnectionState.done) {
//                                                 if (snapshot.hasData) {
//                                                   bool isSelected =
//                                                       selectedImages.contains(
//                                                           assetsForDate[
//                                                               index]);

//                                                   return GestureDetector(
//                                                     onTap: () {
//                                                       // Only handle image tap when selectIndex is 1 (for selection)
//                                                       if (selectIndex == 1) {
//                                                         safeSetState(() {
//                                                           if (isSelected) {
//                                                             selectedImages
//                                                                 .remove(assetsForDate[index]);
//                                                           } else {
//                                                             selectedImages
//                                                                 .add(assetsForDate[index]);
//                                                           }
//                                                         });
//                                                       }
//                                                     },
//                                                     child: Stack(
//                                                       children: [
//                                                         Container(
//                                                           margin:
//                                                               const EdgeInsets
//                                                                       .only(
//                                                                   top: 3),
//                                                           decoration:
//                                                               BoxDecoration(
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(8),
//                                                             boxShadow: [
//                                                               BoxShadow(
//                                                                 color: Colors
//                                                                     .black
//                                                                     .withOpacity(
//                                                                         0.2),
//                                                                 blurRadius: 4.0,
//                                                                 spreadRadius: 1.0,
//                                                               ),
//                                                             ],
//                                                           ),
//                                                           child: FutureBuilder<
//                                                               Uint8List?>(
//                                                             future:
//                                                                 assetsForDate[
//                                                                         index]
//                                                                     .thumbnailDataWithOption(
//                                                               const ThumbnailOption(
//                                                                   size: ThumbnailSize
//                                                                       .square(200)),
//                                                             ),
//                                                             builder: (context,
//                                                                 snapshot) {
//                                                               if (snapshot
//                                                                       .connectionState ==
//                                                                   ConnectionState
//                                                                       .done) {
//                                                                 if (snapshot
//                                                                     .hasData) {
//                                                                   return ClipRRect(
//                                                                     borderRadius:
//                                                                         BorderRadius.circular(
//                                                                             8),
//                                                                     child: Image.memory(
//                                                                       snapshot.data!,
//                                                                       fit: BoxFit.cover,
//                                                                       width: double.infinity,
//                                                                       height: double.infinity,
//                                                                     ),
//                                                                   );
//                                                                 } else {
//                                                                   return const Center(
//                                                                       child: Text(
//                                                                           'Error loading image',
//                                                                           style: TextStyle(
//                                                                               color:
//                                                                                   AppColors.grey)));
//                                                                 }
//                                                               }
//                                                               return const Center(
//                                                                   child:
//                                                                       CircularProgressIndicator(
//                                                                           color: AppColors.grey));
//                                                             },
//                                                           ),
//                                                         ),
//                                                         // Show the checkbox only if selectIndex == 1
//                                                         if (selectIndex == 1)
//                                                           Positioned(
//                                                             top: 5,
//                                                             right: 5,
//                                                             child: GestureDetector(
//                                                               onTap: () {
//                                                                 // Toggle selection
//                                                                 safeSetState(() {
//                                                                   if (isSelected) {
//                                                                     selectedImages
//                                                                         .remove(
//                                                                             assetsForDate[index]);
//                                                                   } else {
//                                                                     selectedImages
//                                                                         .add(
//                                                                             assetsForDate[index]);
//                                                                   }
//                                                                 });
//                                                               },
//                                                               child: Container(
//                                                                 width: 20,
//                                                                 height: 20,
//                                                                 decoration:
//                                                                     BoxDecoration(
//                                                                   color: isSelected
//                                                                       ? AppColors.blue
//                                                                       : AppColors
//                                                                           .grey,
//                                                                   shape: BoxShape
//                                                                       .circle,
//                                                                 ),
//                                                                 child: isSelected
//                                                                     ? const Icon(
//                                                                         Icons
//                                                                             .check,
//                                                                         size: 15,
//                                                                         color: AppColors
//                                                                             .white,
//                                                                       )
//                                                                     : null,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                       ],
//                                                     ),
//                                                   );
//                                                 } else {
//                                                   return const Center(
//                                                       child: Text(
//                                                           'Error retrieving image file',
//                                                           style: TextStyle(
//                                                               color: AppColors
//                                                                   .grey)));
//                                                 }
//                                               }
//                                               return const Center(
//                                                   child: CircularProgressIndicator(
//                                                       color: AppColors.grey));
//                                             },
//                                           );
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             }).toList(),
//                           ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ],
//   );
// }}


