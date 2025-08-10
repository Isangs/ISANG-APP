import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../core/constants/app_color.dart';

class GoalDetailScreen extends StatefulWidget {
  final Map<String, dynamic> goal;

  const GoalDetailScreen({
    super.key,
    required this.goal,
  });

  @override
  State<GoalDetailScreen> createState() => _GoalDetailScreenState();
}

class _GoalDetailScreenState extends State<GoalDetailScreen> {
  final TextEditingController _memoController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  bool isTextMode = true; // 텍스트 모드가 기본 선택
  String? selectedImagePath; // 선택된 이미지 경로
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: AppColor.darkbackgroundGradient,
          ),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
              // 상단 헤더
              Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    // 더보기 메뉴 (필요시 추가)
                    SizedBox(width: 40),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // 중앙 아이콘
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: AppColor.purpleGradient,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  'assets/icons/goalEnd.svg',
                  width: 20,
                  height: 20,
                  color: Colors.white,
                ),
              ),

              SizedBox(height: 30),

              // 제목
              Text(
                widget.goal['title'] ?? '30분 조깅하기',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 8),

              // 부제목
              Text(
                '집중해서 완료해보세요!',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 40),

              // 완료 중단 제목
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  '완료 증명 제출',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              SizedBox(height: 16),

              // 액션 버튼들
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    // 텍스트 버튼
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isTextMode = true;
                          });
                        },
                        child: Container(
                          height: 77,
                          decoration: BoxDecoration(
                            color: isTextMode ? Colors.white : Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.edit,
                                color: isTextMode ? Color(0xFF6B46C1) : Colors.white,
                                size: 20,
                              ),
                              SizedBox(height: 4),
                              Text(
                                '텍스트',
                                style: TextStyle(
                                  color: isTextMode ? Color(0xFF6B46C1) : Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 12),

                    // 사진 버튼
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          setState(() {
                            isTextMode = false;
                          });
                          await _pickImage();
                        },
                        child: Container(
                          height: 77,
                          decoration: BoxDecoration(
                            color: !isTextMode ? Colors.white : Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.camera_alt,
                                color: !isTextMode ? Color(0xFF6B46C1) : Colors.white,
                                size: 20,
                              ),
                              SizedBox(height: 4),
                              Text(
                                '사진',
                                style: TextStyle(
                                  color: !isTextMode ? Color(0xFF6B46C1) : Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // 텍스트 모드일 때 메모 입력 영역, 사진 모드일 때 선택된 이미지 표시
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  width: double.infinity,
                  height: 120,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: isTextMode
                      ? TextField(
                          controller: _memoController,
                          maxLines: null,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          decoration: InputDecoration(
                            hintText: '어떤 내용을 입력하세요...',
                            hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 14,
                            ),
                            filled: true,
                            fillColor: Colors.transparent,
                            border: InputBorder.none,
                          ),
                        )
                      : selectedImagePath != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                File(selectedImagePath!),
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.image,
                                          color: Colors.white.withOpacity(0.5),
                                          size: 40,
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          '선택된 이미지',
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(0.5),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_photo_alternate,
                                    color: Colors.white.withOpacity(0.5),
                                    size: 40,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    '사진을 선택해주세요',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.5),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                ),
              ),

              Spacer(),

              // 완료하기 버튼
              Padding(
                padding: EdgeInsets.all(24),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xFF10B981), // 초록색
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      // 완료 처리 로직
                      Navigator.pop(context, {'showRecordSettings': true}); // 기록 설정 팝업 신호와 함께 돌아가기
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      '완료하기',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 이미지 선택 기능
  Future<void> _pickImage() async {
    try {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 20),
                  Text(
                    '사진 선택',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: Text('카메라로 촬영'),
                    onTap: () async {
                      Navigator.pop(context);
                      final XFile? image = await _picker.pickImage(
                        source: ImageSource.camera,
                      );
                      if (image != null) {
                        setState(() {
                          selectedImagePath = image.path;
                        });
                        _showImageSelectedSnackBar();
                      }
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text('갤러리에서 선택'),
                    onTap: () async {
                      Navigator.pop(context);
                      final XFile? image = await _picker.pickImage(
                        source: ImageSource.gallery,
                      );
                      if (image != null) {
                        setState(() {
                          selectedImagePath = image.path;
                        });
                        _showImageSelectedSnackBar();
                      }
                    },
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('이미지를 선택할 수 없습니다.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // 이미지 선택 완료 알림
  void _showImageSelectedSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('사진이 추가되었습니다.'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    _memoController.dispose();
    super.dispose();
  }
}
