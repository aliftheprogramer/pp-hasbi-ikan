import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pui_bhasbi_mobile/common/theme/app_theme.dart';
import 'package:pui_bhasbi_mobile/common/widget/app_bar_custom.dart';
import 'package:pui_bhasbi_mobile/core/services/service_locator.dart';
import '../bloc/approved_reports_cubit.dart';
import '../bloc/approved_reports_state.dart';

class InformationPage extends StatelessWidget {
  const InformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ApprovedReportsCubit>()..getApprovedReports(),
      child: Scaffold(
        appBar: const AppBarCustom(title: "Informasi"),
        body: BlocBuilder<ApprovedReportsCubit, ApprovedReportsState>(
          builder: (context, state) {
            if (state is ApprovedReportsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ApprovedReportsError) {
              return Center(child: Text(state.message));
            } else if (state is ApprovedReportsSuccess) {
              if (state.reports.isEmpty) {
                return const Center(child: Text("Belum ada laporan"));
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.reports.length,
                itemBuilder: (context, index) {
                  final report = state.reports[index];
                  return Card(
                    color: Colors.white,
                    margin: const EdgeInsets.only(bottom: 16),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 16,
                                backgroundImage: report.user?.avatarUrl != null
                                    ? NetworkImage(report.user!.avatarUrl!)
                                    : null,
                                child: report.user?.avatarUrl == null
                                    ? const Icon(Icons.person, size: 16)
                                    : null,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  report.user?.name ?? "Pengguna tidak dikenal",
                                  style: AppTheme.subtitle.copyWith(
                                    fontWeight: FontWeight.bold,
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
                          const SizedBox(height: 8),
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
                          const SizedBox(height: 10),
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
}
