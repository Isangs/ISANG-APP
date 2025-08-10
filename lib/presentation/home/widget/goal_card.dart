import 'package:flutter/material.dart';
import 'package:isang/core/constants/app_color.dart';
import '../view/goal_detail_screen.dart';

class GoalCard extends StatelessWidget {
  final String title;                // ex) 프로젝트 기획서 작성
  final String category;             // ex) 업무, 운동, 학습, 건강, 개인성장
  final String priority;             // ex) 높음/보통/낮음
  final bool isCompleted;            // 체크 상태(회색 원 내부 체크로 바꾸고 싶으면 후처리)
  final Map<String, dynamic>? goalData; // 전체 goal 데이터

  const GoalCard({
    super.key,
    required this.title,
    required this.category,
    required this.priority,
    required this.isCompleted,
    this.goalData,
  });

  @override
  Widget build(BuildContext context) {
    final _bg = _backgroundByCategory(category);

    return GestureDetector(
      onLongPress: () async {
        // 2초 길게 누르기로 상세 페이지 이동
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GoalDetailScreen(
              goal: goalData ?? {
                'title': title,
                'category': category,
                'priority': priority,
                'isCompleted': isCompleted,
              },
            ),
          ),
        );
        
        // 완료하기 버튼을 눌렀을 때 기록 설정 팝업 표시
        if (result != null && result is Map && result['showRecordSettings'] == true) {
          _showRecordSettingsDialog(context);
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(20, 18, 16, 18),
        decoration: BoxDecoration(
          gradient: _bg,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 16,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          children: [
            // 우측 상단: 보라 포인트 점 + 회색 원
            Positioned(
              right: 10,
              top: 12,
              child: Row(
                children: [
                  Container(
                    width: 24, height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade500, width: 2),
                      color: Colors.white.withOpacity(0.0),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    children: [
                      Container(
                        width: 8, height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xFF9333EA), shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(height: 20,)
                    ],
                  ),
                ],
              ),
            ),

            // 본문
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 상단 칩들
                Row(
                  children: [
                    _categoryChip(category),
                    const SizedBox(width: 8),
                    _priorityChip(priority),
                  ],
                ),
                const SizedBox(height: 14),

                // 제목
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isCompleted ? Colors.grey.shade600 : const Color(0xFF111827),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ───────── helpers ─────────

  LinearGradient _backgroundByCategory(String c) {
    assert(() {
      debugPrint('[GoalCard] category="$c"');
      return true;
    }());

    switch (c) {
      case '건강':
        return const LinearGradient(
          begin: Alignment.topLeft, end: Alignment.bottomRight,
          colors: [Color(0xFFebf8fc), Color(0xFFe4f0f5)],
        );
      case '운동':
        return const LinearGradient(
          begin: Alignment.topLeft, end: Alignment.bottomRight,
          colors: [Color(0xFFfaf1ec), Color(0xFFf4eaec)],
        );
      case '학습':
        return const LinearGradient(
          begin: Alignment.topLeft, end: Alignment.bottomRight,
          colors: [Color(0xFFEFF4FF), Color(0xFFEFF7FF)],
        );
      case '개인성장':
        return const LinearGradient(
          begin: Alignment.topLeft, end: Alignment.bottomRight,
          colors: [Color(0xFFf4f1fe), Color(0xFFf3e9f4)],
        );
      case '업무':
      default:
        return const LinearGradient(
          begin: Alignment.topLeft, end: Alignment.bottomRight,
          colors: [Color(0xFFeef9f2), Color(0xffd7eeee)],
        );
    }
  }

  Widget _categoryChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF3E8FF), // 연보라 캡슐
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF7C3AED),
        ),
      ),
    );
  }

  Widget _priorityChip(String label) {
    final Color dot = switch (label) {
      '높음' => const Color(0xFFEF4444), // red
      '보통' => const Color(0xFFF59E0B), // amber
      '낮음' => const Color(0xFF22C55E), // green
      _ => Colors.grey,
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 8, height: 8,
            margin: const EdgeInsets.only(right: 6),
            decoration: BoxDecoration(color: dot, shape: BoxShape.circle),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey.shade800,
            ),
          ),
        ],
      ),
    );
  }

  // 기록 설정 팝업 다이얼로그
  void _showRecordSettingsDialog(BuildContext context) {
    bool recordAddition = true; // 기록 추가 토글 (기본값: true)
    bool publicRecord = false;  // 공개 범위 토글 (기본값: false - 나만 보기)

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 제목
                    Text(
                      '기록 설정',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 24),
                    
                    // 기록 추가 토글
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '기록 추가',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '완료 기록을 저장합니다',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                recordAddition = !recordAddition;
                              });
                            },
                            child: Container(
                              width: 50,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: recordAddition 
                                    ? Color(0xFF8B5CF6) 
                                    : Color(0xFFE5E5E5), // 회색
                              ),
                              child: AnimatedAlign(
                                duration: Duration(milliseconds: 200),
                                alignment: recordAddition 
                                    ? Alignment.centerRight 
                                    : Alignment.centerLeft,
                                child: Container(
                                  width: 26,
                                  height: 26,
                                  margin: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: 12),
                    
                    // 공개 범위 토글
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '공개 범위',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '나만 보기',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                publicRecord = !publicRecord;
                              });
                            },
                            child: Container(
                              width: 50,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: publicRecord 
                                    ? Color(0xFF8B5CF6) 
                                    : Color(0xFFE5E5E5), // 회색
                              ),
                              child: AnimatedAlign(
                                duration: Duration(milliseconds: 200),
                                alignment: publicRecord 
                                    ? Alignment.centerRight 
                                    : Alignment.centerLeft,
                                child: Container(
                                  width: 26,
                                  height: 26,
                                  margin: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: 24),
                    
                    // 버튼들
                    Row(
                      children: [
                        // 취소 버튼
                        Expanded(
                          child: Container(
                            height: 48,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[300],
                                foregroundColor: Colors.black,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                '취소',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        
                        SizedBox(width: 12),
                        
                        // 확인 버튼
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: AppColor.purpleGradient,
                              borderRadius: BorderRadius.circular(16)
                            ),
                            height: 48,
                            child: ElevatedButton(
                              onPressed: () {
                                // 설정 저장 로직
                                Navigator.of(context).pop();
                                
                                // 설정 완료 스낵바 표시
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('기록 설정이 완료되었습니다'),
                                    backgroundColor: Color(0xFF8B5CF6),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                '확인',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
