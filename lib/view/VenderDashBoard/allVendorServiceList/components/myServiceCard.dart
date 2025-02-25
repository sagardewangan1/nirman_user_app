import 'package:flutter/material.dart';
import 'package:qixer/view/utils/common_helper.dart';

class MyServiceCard extends StatelessWidget {
  final String featureImage;
  final String serviceName;
  final String category;
  final String subCategory;
  final String createdDate;
  final bool isActive;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onToggleActive;

  const MyServiceCard({
    super.key,
    required this.featureImage,
    required this.serviceName,
    required this.category,
    required this.subCategory,
    required this.createdDate,
    required this.isActive,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 3,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row with image and service details
            Row(
              children: [
                // Feature Image
                CommonHelper().profileImage(
                  featureImage,
                  80,
                  80,
                ),
                const SizedBox(width: 12.0),
                // Service Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        serviceName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        "$subCategory • $category",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        "Created: $createdDate",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            // Row with action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Edit and Delete Buttons
                Row(
                  children: [
                    TextButton.icon(
                      onPressed: onEdit,
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.blue,
                        size: 16,
                      ),
                      label: const Text(
                        "Edit",
                        style: TextStyle(color: Colors.blue, fontSize: 14),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: onDelete,
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 16,
                      ),
                      label: const Text(
                        "Delete",
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      ),
                    ),
                  ],
                ),
                // Active/Deactive Toggle
                InkWell(
                  onTap: onToggleActive,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: isActive
                            ? [
                                Colors.green.shade400,
                                Colors.green.shade700,
                              ]
                            : [
                                Colors.grey.shade400,
                                Colors.grey.shade600,
                              ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Text(
                        isActive ? "Active" : "DeActive",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors
                              .white, // Ensures contrast with the green background
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
