import 'package:flutter/material.dart';

class SecurityStatusCard extends StatelessWidget {
  final String label;
  final String? subtitle;
  final bool isThreat;
  final IconData icon;

  const SecurityStatusCard({
    super.key,
    required this.label,
    this.subtitle,
    required this.isThreat,
    this.icon = Icons.security,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = isThreat ? Colors.red.shade300 : Colors.green.shade300;
    final accentColor = isThreat ? Colors.red : Colors.green;
    final backgroundColor =
        isThreat ? Colors.red.shade50 : Colors.green.shade50;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: borderColor, width: 1.25),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: backgroundColor,
          child: Icon(icon, color: accentColor),
        ),
        title: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
        subtitle: Text(
          subtitle ?? (isThreat ? 'Threat detected on your device' : 'No issues found'),
          style: TextStyle(
            fontSize: 12,
            color: isThreat ? Colors.red.shade400 : Colors.grey.shade600,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: isThreat ? Colors.red.shade100 : Colors.green.shade100,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            isThreat ? '⚠ RISK' : '✔ SAFE',
            style: TextStyle(
              color: isThreat ? Colors.red.shade800 : Colors.green.shade800,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
