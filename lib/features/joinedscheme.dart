import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartrip/utils/theme.dart';

@RoutePage()
class JoinedSchemeScreen extends StatelessWidget {
  final Map<String, dynamic> scheme;

  const JoinedSchemeScreen({super.key, required this.scheme});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: MediaQuery.of(context).size.height * 0.45,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(32),
                        bottomRight: Radius.circular(32),
                      ),
                      child: Image.asset(scheme['image'], fit: BoxFit.cover),
                    ),
                    Positioned(
                      bottom: 16,
                      right: 16,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.green[600],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '✔️ Joined',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              leading: Container(
                margin: const EdgeInsets.only(top: 16),
                child: CircleAvatar(
                  backgroundColor: Colors.white70,
                  child: BackButton(color: Colors.black),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      scheme['place'],
                      style: AppTheme.headingStyle.copyWith(fontSize: 26),
                    ),
                    const SizedBox(height: 8),
                    if (scheme['quote'].toString().isNotEmpty)
                      Text(
                        '"${scheme['quote']}"',
                        style: AppTheme.bodycontentStyle.copyWith(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.teal, size: 20),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            scheme['location'],
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildSection("📝 Overview", scheme['description']),
                    const SizedBox(height: 24),
                    _buildListSection("📦 Chit Scheme", scheme['chitsScheme'],
                        Icons.check_circle_outline, Colors.green),
                    const SizedBox(height: 24),
                    _buildListSection("🧳 Budget Plan", scheme['budgetPlans'],
                        Icons.monetization_on_outlined, Colors.deepOrange),
                    const SizedBox(height: 40),
                    Center(
                      child: Text(
                        "You have already joined this scheme 🎉",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTheme.headingStyle),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Text(
            content,
            style: AppTheme.bodycontentStyle.copyWith(height: 1.6),
          ),
        ),
      ],
    );
  }

  Widget _buildListSection(
    String title,
    List<dynamic> items,
    IconData icon,
    Color iconColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTheme.headingStyle),
        const SizedBox(height: 12),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                Icon(icon, color: iconColor, size: 20),
                const SizedBox(width: 10),
                Expanded(child: Text(item, style: AppTheme.bodycontentStyle)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
