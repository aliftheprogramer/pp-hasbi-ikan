import 'package:flutter/material.dart';
import 'package:pui_bhasbi_mobile/common/theme/app_theme.dart';
import 'package:pui_bhasbi_mobile/common/widget/app_bar_custom.dart';
import 'package:pui_bhasbi_mobile/features/report/domain/entity/report_entity.dart';

class ReportDetailPage extends StatelessWidget {
  final ReportEntity report;

  const ReportDetailPage({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(title: "Detail Laporan"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (report.photoUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  report.photoUrl!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 200,
                    color: Colors.grey[200],
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.broken_image,
                      color: Colors.grey,
                      size: 50,
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 20),
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: report.user?.avatarUrl != null
                      ? NetworkImage(report.user!.avatarUrl!)
                      : null,
                  child: report.user?.avatarUrl == null
                      ? const Icon(Icons.person, size: 20)
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        report.user?.name ?? "Pengguna tidak dikenal",
                        style: AppTheme.subtitle.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (report.createdAt != null)
                        Builder(
                          builder: (context) {
                            try {
                              final date = DateTime.parse(report.createdAt!);
                              return Text(
                                "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}",
                                style: AppTheme.body.copyWith(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              );
                            } catch (e) {
                              return const SizedBox.shrink();
                            }
                          },
                        ),
                    ],
                  ),
                ),
                _buildStatusBadge(report.status),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "Deskripsi",
              style: AppTheme.subtitle.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              report.description ?? "Tidak ada deskripsi",
              style: AppTheme.body,
            ),
            const SizedBox(height: 20),
            if (report.addressText != null) ...[
              Text(
                "Lokasi",
                style: AppTheme.subtitle.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.location_on, size: 20, color: Colors.blue),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      report.addressText!,
                      style: AppTheme.body.copyWith(color: Colors.grey[800]),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
            if (report.adminNote != null && report.adminNote!.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Catatan Admin:",
                      style: AppTheme.body.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange.shade800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      report.adminNote!,
                      style: AppTheme.body.copyWith(
                        color: Colors.orange.shade900,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String? status) {
    Color color;
    switch (status?.toUpperCase()) {
      case 'APPROVED':
        color = Colors.green;
        break;
      case 'REJECTED':
        color = Colors.red;
        break;
      case 'PENDING':
        color = Colors.orange;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status ?? "UNKNOWN",
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
