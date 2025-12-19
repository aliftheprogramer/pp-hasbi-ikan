import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pui_bhasbi_mobile/common/theme/app_theme.dart';
import 'package:pui_bhasbi_mobile/common/widget/app_bar_custom.dart';
import 'package:pui_bhasbi_mobile/core/services/service_locator.dart';
import '../bloc/my_reports_cubit.dart';
import '../bloc/my_reports_state.dart';

class MyReportsPage extends StatelessWidget {
  const MyReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MyReportsCubit>()..getMyReports(),
      child: Scaffold(
        appBar: const AppBarCustom(title: "Riwayat Laporan Saya"),
        body: BlocBuilder<MyReportsCubit, MyReportsState>(
          builder: (context, state) {
            if (state is MyReportsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MyReportsError) {
              return Center(child: Text(state.message));
            } else if (state is MyReportsSuccess) {
              if (state.reports.isEmpty) {
                return const Center(child: Text("Anda belum membuat laporan"));
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.reports.length,
                itemBuilder: (context, index) {
                  final report = state.reports[index];
                  return Card(
                    color: Colors.white,
                    margin: const EdgeInsets.only(bottom: 16),
                    elevation: 1.5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(
                                    report.status,
                                  ).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  report.status ?? "UNKNOWN",
                                  style: AppTheme.body.copyWith(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: _getStatusColor(report.status),
                                  ),
                                ),
                              ),
                              if (report.createdAt != null)
                                Builder(
                                  builder: (context) {
                                    try {
                                      final date = DateTime.parse(
                                        report.createdAt!,
                                      );
                                      return Text(
                                        "${date.day}/${date.month}/${date.year}",
                                        style: AppTheme.body.copyWith(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      );
                                    } catch (e) {
                                      return const SizedBox.shrink();
                                    }
                                  },
                                ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          if (report.photoUrl != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                report.photoUrl!,
                                height: 180,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                      height: 180,
                                      color: Colors.grey[200],
                                      alignment: Alignment.center,
                                      child: const Icon(
                                        Icons.broken_image,
                                        color: Colors.grey,
                                      ),
                                    ),
                              ),
                            ),
                          const SizedBox(height: 12),
                          Text(
                            report.description ?? "Tidak ada deskripsi",
                            style: AppTheme.body,
                          ),
                          const SizedBox(height: 8),
                          if (report.addressText != null)
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color: Colors.blue,
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    report.addressText!,
                                    style: AppTheme.body.copyWith(
                                      fontSize: 12,
                                      color: Colors.grey[700],
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          if (report.adminNote != null &&
                              report.adminNote!.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.orange.shade50,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.orange.shade200,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Catatan Admin:",
                                      style: AppTheme.body.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange.shade800,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      report.adminNote!,
                                      style: AppTheme.body.copyWith(
                                        fontSize: 12,
                                        color: Colors.orange.shade900,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toUpperCase()) {
      case 'APPROVED':
        return Colors.green;
      case 'REJECTED':
        return Colors.red;
      case 'PENDING':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
