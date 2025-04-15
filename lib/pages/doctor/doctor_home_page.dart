import 'package:flutter/material.dart';

class DoctorHomePage extends StatelessWidget {
  const DoctorHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text("Doctor's Dashboard"),
        backgroundColor: Colors.blueAccent, // Blue primary color
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome text with doctor's name and emoji
              const Text(
                "Welcome, Dr. [Doctor's Name] 🩺",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent, // Blue color for the text
                  fontFamily: 'FunkyFont', // Playful Font
                ),
              ),
              const SizedBox(height: 12),

              // Recent Activity Section with emojis
              _buildSectionTitle("📝 Recent Activity"),
              const SizedBox(height: 8),
              _buildActivityCard(
                title: "Appointment with Patient XYZ 👩‍⚕️",
                subtitle: "Date: 20th April 2025 | Time: 10:00 AM ⏰",
                onTap: () {
                  // Navigate to appointment details
                },
                statusColor: Colors.greenAccent, // Status color: Green for upcoming
              ),
              const SizedBox(height: 12),

              _buildActivityCard(
                title: "Follow-up with Patient ABC 💊",
                subtitle: "Date: 22nd April 2025 | Time: 1:00 PM ⏰",
                onTap: () {
                  // Navigate to appointment details
                },
                statusColor: Colors.orangeAccent, // Status color: Orange for pending
              ),

              const SizedBox(height: 24),

              // Upcoming Appointments Section with emojis
              _buildSectionTitle("📅 Upcoming Appointments"),
              const SizedBox(height: 8),
              _buildUpcomingAppointmentsList(),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // Widget to build section titles with emojis
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.blueAccent, // Blue color for section titles
        fontFamily: 'FunkyFont',
      ),
    );
  }

  // Widget for activity cards (recent appointments or tasks)
  Widget _buildActivityCard({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required Color statusColor, // Status color for the appointment status
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [Colors.blueAccent.withOpacity(0.8), Colors.lightBlue.withOpacity(0.8)], // Blue gradient
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white, fontFamily: 'FunkyFont')),
              const SizedBox(height: 6),
              Text(subtitle, style: const TextStyle(fontSize: 14, color: Colors.white70, fontFamily: 'FunkyFont')),
              const SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: statusColor, // Circle with status color
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(statusColor == Colors.greenAccent ? "Upcoming" : "Pending", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget to build the upcoming appointments list
  Widget _buildUpcomingAppointmentsList() {
    return Column(
      children: [
        _buildUpcomingAppointmentCard(
          patientName: "Patient XYZ 👩‍⚕️",
          appointmentDate: "20th April 2025",
          appointmentTime: "10:00 AM ⏰",
          statusColor: Colors.greenAccent, // Status: upcoming
        ),
        const SizedBox(height: 12),
        _buildUpcomingAppointmentCard(
          patientName: "Patient ABC 💊",
          appointmentDate: "22nd April 2025",
          appointmentTime: "1:00 PM ⏰",
          statusColor: Colors.orangeAccent, // Status: pending
        ),
        const SizedBox(height: 12),
        _buildUpcomingAppointmentCard(
          patientName: "Patient DEF 🏥",
          appointmentDate: "25th April 2025",
          appointmentTime: "2:30 PM ⏰",
          statusColor: Colors.greenAccent, // Status: upcoming
        ),
      ],
    );
  }

  // Widget to build individual upcoming appointment cards with status colors
  Widget _buildUpcomingAppointmentCard({
    required String patientName,
    required String appointmentDate,
    required String appointmentTime,
    required Color statusColor, // Status color for the appointment
  }) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        onTap: () {
          // Navigate to appointment details
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white, boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(2, 4), blurRadius: 6)]),
          child: Row(
            children: [
              const Icon(Icons.calendar_today, color: Colors.blueAccent), // Blue calendar icon
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(patientName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueAccent, fontFamily: 'FunkyFont')),
                    const SizedBox(height: 4),
                    Text('$appointmentDate at $appointmentTime', style: const TextStyle(fontSize: 14, color: Colors.black54, fontFamily: 'FunkyFont')),
                  ],
                ),
              ),
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: statusColor, // Circle with status color
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
