import 'package:quickdeal/src/presentation/features/dashboard/subscreens/profile/profile.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = context.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text("About Us"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App/Company Information
            Text(
              "Welcome to QuickDeal",
              style: TextStyle(
                fontSize: 21.sp,
                fontWeight: FontWeight.bold,
                color: isDark ? CColors.textWhite : CColors.primary,
              ),
            ),
            16.hBox,
            Text(
              "QuickDeal is a leading platform designed to simplify your life by connecting you with the best services and opportunities. Our mission is to provide seamless and efficient solutions for all your needs.",
              style: TextStyle(
                fontSize: 16,
                color: isDark ? CColors.textWhite : Colors.black87,
              ),
            ),
            24.hBox,

            // Team Members Section
            Text(
              "Our Team",
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: isDark ? CColors.textWhite : CColors.primary,
              ),
            ),
            16.hBox,
            _buildTeamMember(
              name: "John Doe",
              role: "CEO & Founder",
              imageUrl: "https://via.placeholder.com/150",
              isDark: isDark,
            ),
            12.hBox,
            _buildTeamMember(
              name: "Jane Smith",
              role: "Lead Developer",
              imageUrl: "https://via.placeholder.com/150",
              isDark: isDark,
            ),
            12.hBox,
            _buildTeamMember(
              name: "Alice Johnson",
              role: "UI/UX Designer",
              imageUrl: "https://via.placeholder.com/150",
              isDark: isDark,
            ),
            24.hBox,

            // Mission and Vision Section
            Text(
              "Our Mission & Vision",
              style: TextStyle(
                fontSize: 21.sp,
                fontWeight: FontWeight.bold,
                color: isDark ? CColors.textWhite : CColors.primary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Mission: To empower individuals and businesses by providing innovative and reliable solutions that enhance productivity and efficiency.",
              style: TextStyle(
                fontSize: 16.sp,
                color: isDark ? CColors.textWhite : Colors.black87,
              ),
            ),
            12.hBox,
            Text(
              "Vision: To become the global leader in delivering seamless and user-friendly platforms that transform the way people connect and collaborate.",
              style: TextStyle(
                fontSize: 16,
                color: isDark ? CColors.textWhite : Colors.black87,
              ),
            ),
            24.hBox,

            // Contact Information Section
            Text(
              "Contact Us",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: isDark ? CColors.textWhite : CColors.primary,
              ),
            ),
            16.hBox,
            _buildContactInfo(
              icon: Icons.phone,
              title: "Phone",
              value: "+1 (123) 456-7890",
              isDark: isDark,
            ),
            12.hBox,
            _buildContactInfo(
              icon: Icons.email,
              title: "Email",
              value: "support@quickdeal.com",
              isDark: isDark,
            ),
            const SizedBox(height: 12),
            _buildContactInfo(
              icon: Icons.location_on,
              title: "Address",
              value: "123 Main St, City, Country",
              isDark: isDark,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamMember(
      {required String name,
      required String role,
      required String imageUrl,
      required bool isDark}) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 30,
          child: Icon(Icons.account_circle_outlined),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? CColors.white : Colors.black87,
              ),
            ),
            Text(
              role,
              style: TextStyle(
                fontSize: 14.sp,
                color: isDark ? CColors.white : Colors.black54,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContactInfo(
      {required IconData icon,
      required String title,
      required String value,
      required bool isDark}) {
    return Row(
      children: [
        Icon(icon, color: isDark ? CColors.textWhite : Colors.black, size: 24),
        12.vBox,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: isDark ? CColors.textWhite : Colors.black87,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                color: isDark ? CColors.textWhite : Colors.black54,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
