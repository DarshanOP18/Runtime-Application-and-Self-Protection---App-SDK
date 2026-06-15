import 'package:flutter/material.dart';

import '../rasp/rasp_check_model.dart';
import '../widgets/security_status_card.dart';

class HomeScreen extends StatelessWidget {
  final RaspCheckResult result;
  final VoidCallback onRefresh;

  const HomeScreen({super.key, required this.result, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    final hasWarnings = result.isThreatDetected;
    final statusColor = hasWarnings ? Colors.orange.shade800 : Colors.green;

    return Scaffold(
      appBar: AppBar(
        title: const Text('RASP Security Dashboard'),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: onRefresh,
            icon: const Icon(Icons.refresh),
            tooltip: 'Re-scan Device',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green.shade50, Colors.white],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildSummaryCard(hasWarnings, statusColor),
              const SizedBox(height: 16),
              SecurityStatusCard(
                label: 'Root / Jailbreak',
                isThreat: result.isRooted,
                icon: Icons.phonelink_lock,
              ),
              SecurityStatusCard(
                label: 'Emulator',
                isThreat: result.isEmulator,
                icon: Icons.devices_other,
              ),
              SecurityStatusCard(
                label: 'Debug Mode',
                isThreat: result.isDebugging,
                icon: Icons.bug_report,
              ),
              SecurityStatusCard(
                label: 'App Tampered',
                isThreat: result.isTampered,
                icon: Icons.verified_user,
              ),
              SecurityStatusCard(
                label: 'Screenshot Blocking',
                isThreat: !result.screenshotBlockingEnabled,
                icon: Icons.screenshot,
              ),
              const SizedBox(height: 16),
              // NEW ENHANCED SECURITY CHECKS
              const Text(
                'Enhanced Security Checks',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              SecurityStatusCard(
                label: 'Frida Framework',
                isThreat: result.isFridaDetected,
                icon: Icons.memory,
              ),
              SecurityStatusCard(
                label: 'VPN Connection',
                isThreat: result.isVpnActive,
                icon: Icons.vpn_lock,
              ),
              SecurityStatusCard(
                label: 'App Repackaging',
                isThreat: result.isRepackaged,
                icon: Icons.unarchive,
              ),
              SecurityStatusCard(
                label: 'RE Tools Active',
                isThreat: result.hasReverseEngineeringTools,
                icon: Icons.code,
              ),
              SecurityStatusCard(
                label: 'SSL / MITM Attack',
                isThreat: result.isMitmDetected,
                icon: Icons.lock_open,
              ),
              SecurityStatusCard(
                label: 'Overlay Attack',
                isThreat: result.isOverlayDetected,
                icon: Icons.picture_in_picture,
              ),
              SecurityStatusCard(
                label: 'Accessibility Abuse',
                isThreat: result.isAccessibilityAbused,
                icon: Icons.accessibility_new,
              ),
              SecurityStatusCard(
                label: 'Device Integrity',
                subtitle: result.isDeviceRisk ? result.deviceRiskReason : 'Hardware & Settings Secure',
                isThreat: result.isDeviceRisk,
                icon: Icons.fingerprint,
              ),
              const SizedBox(height: 16),
              // CATEGORY 1: ADVANCED FEATURES
              const Text(
                'Enterprise Security Layers',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              SecurityStatusCard(
                label: 'Dual App / Cloning',
                isThreat: result.isCloneDetected,
                icon: Icons.copy,
              ),
              SecurityStatusCard(
                label: 'Device Binding',
                subtitle: result.isDeviceBindingFailed ? 'Hardware Key Tampered' : 'Hardware Bound to Device',
                isThreat: result.isDeviceBindingFailed,
                icon: Icons.link,
              ),
              SecurityStatusCard(
                label: 'Offline Compliance',
                subtitle: result.isOfflineExceeded ? 'Offline Limit Exceeded' : 'Usage within limits',
                isThreat: result.isOfflineExceeded,
                icon: Icons.signal_wifi_off,
              ),
              SecurityStatusCard(
                label: 'IP Reputation & Geo',
                subtitle: result.isHighRiskIp ? 'Blocked Country/VPN IP' : 'Connection Secure',
                isThreat: result.isHighRiskIp,
                icon: Icons.public,
              ),
              const SizedBox(height: 12),
              if (hasWarnings && !result.isBlockingEnforced)
                Text(
                  result.threatSummary,
                  style: TextStyle(color: Colors.grey.shade700),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard(bool hasWarnings, Color statusColor) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(
              hasWarnings ? Icons.warning_amber_rounded : Icons.verified,
              color: statusColor,
              size: 44,
            ),
            const SizedBox(height: 12),
            Text(
              hasWarnings ? 'Security warnings detected' : 'Device is secure',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: statusColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              hasWarnings
                  ? 'Some risk indicators are active on this device.'
                  : 'No active threats were detected by the current checks.',
              style: TextStyle(color: Colors.grey.shade700),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
