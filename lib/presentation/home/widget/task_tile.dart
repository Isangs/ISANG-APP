import 'package:flutter/material.dart';
import 'package:isang/core/constants/app_color.dart';

class TaskTile extends StatelessWidget {
  final String title;
  final bool isCompleted;

  const TaskTile({
    super.key,
    required this.title,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColor.background,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [AppColor.shadow],
      ),
      child: Row(
        children: [
          // 완료 체크박스
          GestureDetector(
            onTap: () {
              // TODO: 완료 상태 토글 로직
            },
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isCompleted ? AppColor.primary : Colors.transparent,
                border: Border.all(
                  color: isCompleted ? AppColor.primary : Colors.grey[400]!,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: isCompleted
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 12,
                    )
                  : null,
            ),
          ),
          const SizedBox(width: 12),
          
          // 제목
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isCompleted ? Colors.grey[600] : AppColor.textPrimary,
                decoration: isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
