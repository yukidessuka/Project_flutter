import 'package:flutter/material.dart';

class ProfileScreenNew extends StatelessWidget {
  const ProfileScreenNew({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            height: 300,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 253, 253, 253),
                  Color.fromARGB(255, 255, 255, 255),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Content
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // Top Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 24,
                          color: Color(0xFFA3774A),
                        ),
                        Text(
                          "Profile",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFA3774A),
                          ),
                        ),
                        Icon(
                          Icons.more_vert,
                          size: 28,
                          color: Color(0xFFA3774A),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Avatar
                  CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: const AssetImage(
                        'photo/pompompurin1.jpg',
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Name
                  const Text(
                    "PomPomPurin",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFA3774A),
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Subtitle
                  Text(
                    "Golden retriever with a love for pudding",
                    style: TextStyle(color: Colors.brown[300], fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  // Description
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      "PomPomPurin is a friendly golden retriever from Sanrio, known for his trademark brown beret and love for pudding.",
                      style: TextStyle(color: Colors.brown[200], fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Stats Cards
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        _StatCard(
                          icon: Icons.brush,
                          count: "2",
                          label: "Projects",
                        ),
                        _StatCard(
                          icon: Icons.access_time,
                          count: "1000",
                          label: "Years",
                        ),
                        _StatCard(
                          icon: Icons.emoji_events,
                          count: "45",
                          label: "Awards",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFD369),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 36,
                            vertical: 12,
                          ),
                        ),
                        onPressed: () {},
                        child: const Text("Follow"),
                      ),
                      const SizedBox(width: 16),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFFA3774A),
                          side: const BorderSide(color: Color(0xFFA3774A)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 12,
                          ),
                        ),
                        onPressed: () {},
                        child: const Text("Message"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // Tabs
                  DefaultTabController(
                    length: 3,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 32),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFE29A).withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TabBar(
                            labelColor: const Color(0xFFA3774A),
                            unselectedLabelColor: Colors.brown[300],
                            indicator: BoxDecoration(
                              color: const Color(0xFFFFD369),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            indicatorPadding: const EdgeInsets.symmetric(
                              horizontal: -8,
                            ), // indicator ยาวกว่ากรอบ tab
                            tabs: const [
                              Tab(text: 'Projects'),
                              Tab(text: 'About'),
                              Tab(text: 'Reviews'),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 280,
                          child: TabBarView(
                            children: [
                              // Projects Tab
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: const [
                                    _ProjectCard(
                                      image: 'photo/pompompurin2.jpg',
                                      title: 'Purin & Friends',
                                      subtitle:
                                          'Sharing pudding with best buddies',
                                    ),
                                    SizedBox(width: 16),
                                    _ProjectCard(
                                      image: 'photo/pompompurin3.jpg',
                                      title: 'Chill Time',
                                      subtitle:
                                          'Relaxing with a cozy beret',
                                    ),
                                  ],
                                ),
                              ),
                              // About Tab
                              Center(
                                child: Text(
                                  "About info...",
                                  style: TextStyle(color: Colors.brown[300]),
                                ),
                              ),
                              // Reviews Tab
                              Center(
                                child: Text(
                                  "Reviews info...",
                                  style: TextStyle(color: Colors.brown[300]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Stat Card
class _StatCard extends StatelessWidget {
  final IconData icon;
  final String count;
  final String label;
  const _StatCard({
    required this.icon,
    required this.count,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE29A),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.2),
            offset: const Offset(0, 5),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFFA3774A), size: 28),
          const SizedBox(height: 8),
          Text(
            count,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFFA3774A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.brown, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

// Project Card
class _ProjectCard extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  const _ProjectCard({
    required this.image,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              image,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFFA3774A),
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.brown, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
