import 'package:flutter/material.dart';
import 'package:isang/presentation/common/custom_app_bar.dart';
import 'package:isang/presentation/home/widget/goal_card.dart';

import '../../../core/constants/app_color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = '전체';
  List<Map<String, dynamic>> goals = [];
  bool isDeleteMode = false; // 삭제 모드 상태 추가

  final List<String> categories = ['전체', '운동', '학습', '업무', '건강', '개인성장'];
  final List<Color> colorOptions = [
    Color(0xFFE91E63), // Pink
    Color(0xFFFF5722), // Deep Orange
    Color(0xFFFFC107), // Amber
    Color(0xFF4CAF50), // Green
    Color(0xFF00BCD4), // Cyan
    Color(0xFF2196F3), // Blue
    Color(0xFF9C27B0), // Purple
    Color(0xFFE91E63), // Pink (bottom row)
  ];

  @override
  void initState() {
    super.initState();
    goals = _getInitialGoals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        title: '오늘의 목표',
        subTitle: '힘내서 완료해보세요! 💪',
        icon: isDeleteMode ? 'delateOn' : 'delate', // 삭제 모드에 따라 아이콘 변경
        onIconPressed: () {
          setState(() {
            isDeleteMode = !isDeleteMode; // 삭제 모드 토글
          });
        },
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF8F9FF),
              Color(0xFFE8EFFF),
              Color(0xFFD4E4FF),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 카테고리 탭
                _buildCategoryTabs(),
                const SizedBox(height: 24),

                // 목표 카드들
                _buildGoalCards(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: isDeleteMode ? null : FloatingActionButton(
        onPressed: () {
          _showAddGoalBottomSheet();
        },
        shape: const CircleBorder(),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Ink(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Color(0xFFA855F7), Color(0xFF9333EA), Color(0xFFEC4899)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const SizedBox(
            width: 56,
            height: 56,
            child: Icon(Icons.add, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Container(
      height: 36,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == selectedCategory;
          final canDelete = category != '전체' && isDeleteMode; // '전체' 카테고리는 삭제 불가

          return Container(
            height: 36,
            margin: EdgeInsets.only(
              right: index == categories.length - 1 ? 0 : 12,
            ),
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    if (!isDeleteMode) {
                      setState(() {
                        selectedCategory = category;
                      });
                    }
                  },
                  child: Container(
                    height: 36,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppColor.background,
                      gradient: isSelected
                          ? AppColor.greyGradient
                          : AppColor.gradientWhiteColor,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: isSelected ? [AppColor.shadow] : [],
                      border: isSelected
                          ? null
                          : Border.all(color: Colors.grey[300]!, width: 1),
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : Colors.grey[700],
                      ),
                    ),
                  ),
                ),
                // 삭제 모드일 때 삭제 버튼 표시 ('전체' 제외)
                if (canDelete)
                  Positioned(
                    top: -2,
                    right: -2,
                    child: GestureDetector(
                      onTap: () {
                        _showDeleteCategoryDialog(category);
                      },
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1),
                        ),
                        child: Icon(
                          Icons.close,
                          size: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  // 초기 목표 데이터를 반환하는 헬퍼 메서드
  List<Map<String, dynamic>> _getInitialGoals() {
    return [
      {
        'title': '30분 조깅하기',
        'isCompleted': false,
        'category': '운동',
        'color': Color(0xFF4CAF50),
      },
      {
        'title': '프로젝트 기획서 작성',
        'isCompleted': false,
        'category': '업무',
        'color': Color(0xFF2196F3),
      },
      {
        'title': '영어 단어 50개 외우기',
        'isCompleted': false,
        'category': '학습',
        'color': Color(0xFFFFC107),
      },
      {
        'title': '책 30페이지 읽기',
        'isCompleted': false,
        'category': '개인성장',
        'color': Color(0xFF9C27B0),
      },
      {
        'title': '물 2L 마시기',
        'isCompleted': false,
        'category': '건강',
        'color': Color(0xFF00BCD4),
      },
    ];
  }

  Widget _buildGoalCards() {
    // 선택된 카테고리에 따라 필터링
    final filteredGoals = selectedCategory == '전체'
        ? goals
        : goals.where((goal) => goal['category'] == selectedCategory).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int index = 0; index < filteredGoals.length; index++)
          Column(
            children: [
              Stack(
                children: [
                  GoalCard(
                    title: filteredGoals[index]['title'],
                    category: filteredGoals[index]['category'],
                    priority: filteredGoals[index]['priority'] ?? '보통',
                    isCompleted: filteredGoals[index]['isCompleted'],
                    goalData: filteredGoals[index],
                  ),
                  if (isDeleteMode)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            // 원본 goals 리스트에서 해당 아이템을 찾아서 삭제
                            final goalToRemove = filteredGoals[index];
                            goals.removeWhere((goal) =>
                            goal['title'] == goalToRemove['title'] &&
                                goal['category'] == goalToRemove['category']
                            );
                          });
                        },
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
      ],
    );
  }

  void _showAddGoalBottomSheet() {
    String goalTitle = '';
    String selectedGoalCategory = '운동';
    String newCategoryName = '';
    Color selectedColor = colorOptions[0];
    bool isAddingNewCategory = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
              return Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  padding: EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          '새로운 할 일 추가',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 24),

                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: TextField(
                          onChanged: (value) {
                            goalTitle = value;
                          },
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(

                            hintText: '할 일을 입력하세요',
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 16,
                            ),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            fillColor: Colors.transparent,
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                          ),
                        ),
                      ),
                      SizedBox(height: 24),

                      Text(
                        '목표 선택',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 12),

                      if (!isAddingNewCategory)
                        Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey[300]!,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: InkWell(
                            onTap: () {
                              setModalState(() {
                                isAddingNewCategory = true;
                              });
                            },
                            child: Center(
                              child: Text(
                                '+ 새 목표 추가',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),

                      if (isAddingNewCategory)
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey[200]!),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  onChanged: (value) {
                                    newCategoryName = value;
                                  },
                                  style: TextStyle(color: Colors.black),

                                  decoration: InputDecoration(
                                    hintText: '새 목표 이름',
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 14,
                                    ),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    fillColor: Colors.transparent,
                                    filled: true,
                                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (newCategoryName.isNotEmpty) {
                                    setState(() {
                                      if (!categories.contains(newCategoryName)) {
                                        categories.add(newCategoryName);
                                        // 새 카테고리에 선택된 색상 저장 (향후 사용을 위해)
                                        // 여기서는 카테고리와 색상의 매핑을 저장할 수 있습니다
                                      }
                                    });
                                    setModalState(() {
                                      selectedGoalCategory = newCategoryName;
                                      isAddingNewCategory = false;
                                      newCategoryName = '';
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('\'$newCategoryName\' 카테고리가 추가되었습니다.'),
                                        duration: Duration(seconds: 2),
                                        backgroundColor: selectedColor,
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 12),
                                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    '추가',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      SizedBox(height: 16),

                      // 색상 선택 (카테고리 추가 모드일 때만 표시)
                      if (isAddingNewCategory) ...[
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: colorOptions.map((color) {
                            final isSelected = selectedColor == color;
                            return GestureDetector(
                              onTap: () {
                                setModalState(() {
                                  selectedColor = color;
                                });
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: color,
                                  shape: BoxShape.circle,
                                  border: isSelected
                                      ? Border.all(color: Colors.black, width: 2)
                                      : null,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 24),
                      ],

                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: categories.where((cat) => cat != '전체').map((category) {
                          final isSelected = selectedGoalCategory == category;
                          return GestureDetector(
                            onTap: () {
                              setModalState(() {
                                selectedGoalCategory = category;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.purple[100]
                                    : Colors.grey[100],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                category,
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.purple
                                      : Colors.grey[700],
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 32),

                      Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFA855F7), Color(0xFFEC4899)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            if (goalTitle.isNotEmpty) {
                              setState(() {
                                goals.add({
                                  'title': goalTitle,
                                  'isCompleted': false,
                                  'category': selectedGoalCategory,
                                  'color': selectedColor,
                                });
                              });
                              Navigator.pop(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: const Text(
                            '할 일 추가하기',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  // 카테고리 삭제 확인 다이얼로그
  void _showDeleteCategoryDialog(String category) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('카테고리 삭제'),
          content: Text('\'$category\' 카테고리를 삭제하시겠습니까?\n이 카테고리에 속한 모든 목표도 함께 삭제됩니다.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () {
                _deleteCategory(category);
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: Text('삭제'),
            ),
          ],
        );
      },
    );
  }

  // 카테고리 삭제 로직
  void _deleteCategory(String category) {
    setState(() {
      // 카테고리 목록에서 제거
      categories.remove(category);
      
      // 해당 카테고리의 모든 목표 삭제
      goals.removeWhere((goal) => goal['category'] == category);
      
      // 삭제된 카테고리가 현재 선택된 카테고리라면 '전체'로 변경
      if (selectedCategory == category) {
        selectedCategory = '전체';
      }
    });
    
    // 삭제 완료 스낵바 표시
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('\'$category\' 카테고리가 삭제되었습니다.'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }


}