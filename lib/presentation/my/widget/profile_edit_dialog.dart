import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:isang/core/constants/app_color.dart';

class ProfileEditDialog extends StatefulWidget {
  final String initialName;
  final String initialNickname;
  final String initialEmail;
  final String initialBio;
  final File? initialImage;
  final Function(String, String, String, String) onSave;
  final Function(File?)? onImageChanged;

  const ProfileEditDialog({
    super.key,
    required this.initialName,
    required this.initialNickname,
    required this.initialEmail,
    required this.initialBio,
    this.initialImage,
    required this.onSave,
    this.onImageChanged,
  });

  @override
  State<ProfileEditDialog> createState() => _ProfileEditDialogState();
}

class _ProfileEditDialogState extends State<ProfileEditDialog> {
  late TextEditingController nameController;
  late TextEditingController nicknameController;
  late TextEditingController emailController;
  late TextEditingController bioController;
  File? selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.initialName);
    nicknameController = TextEditingController(text: widget.initialNickname);
    emailController = TextEditingController(text: widget.initialEmail);
    bioController = TextEditingController(text: widget.initialBio);
    selectedImage = widget.initialImage; // 초기 이미지 설정
    
    // 텍스트 필드 변경 리스너 추가
    nameController.addListener(_onTextChanged);
    nicknameController.addListener(_onTextChanged);
    emailController.addListener(_onTextChanged);
    bioController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    // 텍스트가 변경될 때마다 실시간으로 저장
    widget.onSave(
      nameController.text,
      nicknameController.text,
      emailController.text,
      bioController.text,
    );
  }

  @override
  void dispose() {
    // 이미지 변경사항만 전달 (텍스트는 이미 실시간으로 저장됨)
    if (widget.onImageChanged != null) {
      widget.onImageChanged!(selectedImage);
    }
    
    // 리스너 제거
    nameController.removeListener(_onTextChanged);
    nicknameController.removeListener(_onTextChanged);
    emailController.removeListener(_onTextChanged);
    bioController.removeListener(_onTextChanged);
    
    nameController.dispose();
    nicknameController.dispose();
    emailController.dispose();
    bioController.dispose();
    super.dispose();
  }

  Future<void> _showImageSourceDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('사진 선택'),
          content: const Text('사진을 선택하는 방법을 선택하세요.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.camera);
              },
              child: const Text('카메라'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.gallery);
              },
              child: const Text('갤러리'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('취소'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 300,
        maxHeight: 300,
        imageQuality: 80,
      );
      
      if (image != null) {
        setState(() {
          selectedImage = File(image.path);
        });
        
        // 이미지가 선택되면 즉시 부모 위젯에 전달
        if (widget.onImageChanged != null) {
          widget.onImageChanged!(selectedImage);
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('이미지 선택 중 오류가 발생했습니다: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      backgroundColor: AppColor.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: 343,
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 헤더
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '프로필',
                    style: TextStyle(
                      color: AppColor.textPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // 프로필 이미지
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        gradient: AppColor.purpleGradient,
                        shape: BoxShape.circle,
                      ),
                    ),
                    // 선택된 이미지가 있으면 표시, 없으면 기본 아이콘
                    selectedImage != null
                        ? ClipOval(
                            child: Image.file(
                              selectedImage!,
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                            ),
                          )
                        : SvgPicture.asset(
                            'assets/icons/kakaoLoginIcon.svg',
                            height: 90,
                            width: 90,
                          ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // 사진 변경 링크
              GestureDetector(
                onTap: _showImageSourceDialog,
                child: Text(
                  '사진 변경',
                  style: TextStyle(
                    color: AppColor.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // 이름 입력 필드
              _buildInputField(
                controller: nameController,
                label: '이름',
                hint: '이름을 입력하세요',
              ),
              const SizedBox(height: 16),
              // 닉네임 입력 필드
              _buildInputField(
                controller: nicknameController,
                label: '닉네임',
                hint: '닉네임을 입력하세요',
              ),
              const SizedBox(height: 16),
              // 이메일 입력 필드
              _buildInputField(
                controller: emailController,
                label: '이메일',
                hint: '이메일을 입력하세요',
              ),
              const SizedBox(height: 16),
              // 자기소개 입력 필드
              _buildInputField(
                controller: bioController,
                label: '자기소개',
                hint: '자기소개를 입력하세요',
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
  }) {
    return SizedBox(
      width: 295,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            maxLines: maxLines,
            style: TextStyle(
              color: AppColor.textPrimary,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: AppColor.textPrimary),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColor.primary),
              ),
              filled: true,
              fillColor: Colors.grey[50],
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
