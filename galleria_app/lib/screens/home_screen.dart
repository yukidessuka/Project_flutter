import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _pageIndex = 0;
  int _selectedFilter = 0;
  final List<String> filters = ['All', 'Cozy Spaces', 'Creativity', 'Dreamy'];

  final List<Map<String, String>> items = [
    {
      'image': 'photo/pompompurin4.jpg',
      'title': "Purin's Cozy Corner",
      'description': 'A warm spot for pudding dreams',
      'category': 'Cozy Spaces',
    },
    {
      'image': 'photo/pompompurin5.jpg',
      'title': 'Purin & Friends',
      'description': 'Sharing smiles and sweet treats',
      'category': 'Creativity',
    },
    {
      'image': 'photo/pompompurin6.jpg',
      'title': 'Beret Moments',
      'description': 'Classic style, endless charm',
      'category': 'Creativity',
    },
    {
      'image': 'photo/pompompurin7.jpg',
      'title': 'Golden Day',
      'description': 'Sunshine and pudding happiness',
      'category': 'Dreamy',
    },
  ];

  List<Map<String, String>> get filteredItems {
    if (_selectedFilter == 0) return items;
    return items
        .where((item) => item['category'] == filters[_selectedFilter])
        .toList();
  }

  List<Widget> get _pages => [
    // Gallery Page
    Container(
      color: const Color.fromARGB(255, 255, 255, 255), // PomPomPurin cream
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Text(
                  "GALLERIA",
                  style: TextStyle(
                    color: Color(0xFFA3774A), // Softer PomPomPurin brown
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    letterSpacing: 1.2,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.search, color: Color(0xFFA3774A)),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.menu, color: Color(0xFFA3774A)),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          // Filter buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(filters.length, (index) {
                  final selected = _selectedFilter == index;
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ChoiceChip(
                      label: Text(
                        filters[index],
                        style: TextStyle(
                          color: selected
                              ? Colors.white
                              : const Color(0xFFA3774A),
                          fontWeight: selected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      selected: selected,
                      selectedColor: const Color(0xFFFFD369),
                      backgroundColor: const Color(0xFFFFE29A),
                      onSelected: (val) {
                        setState(() {
                          _selectedFilter = index;
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: selected ? 3 : 0,
                    ),
                  );
                }),
              ),
            ),
          ),
          // Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.75,
              ),
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 3,
                  color: const Color(0xFFFFE29A),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        child: Image.asset(
                          item['image']!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 120,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 12,
                          top: 10,
                          right: 12,
                        ),
                        child: Text(
                          item['title']!,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF8C5E3C),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 12,
                          top: 2,
                          right: 12,
                        ),
                        child: Text(
                          item['description']!,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFFA3774A),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ),
    // Saved Page
    Container(
      color: const Color(0xFFFFF4D6),
      child: const Center(
        child: Text(
          'Saved Page',
          style: TextStyle(fontSize: 20, color: Color(0xFFA3774A)),
        ),
      ),
    ),
    // Artists Page
    Container(
      color: const Color(0xFFFFF4D6),
      child: const Center(
        child: Text(
          'Artists Page',
          style: TextStyle(fontSize: 20, color: Color(0xFFA3774A)),
        ),
      ),
    ),
    // Profile Page
    const ProfileScreenNew(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF4D6),
      body: _pages[_pageIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: const Color(0xFFFFE29A),
        buttonBackgroundColor: const Color(0xFFFFD369),
        animationDuration: const Duration(milliseconds: 400),
        items: const [
          Icon(Icons.home, size: 28, color: Color(0xFFA3774A)),
          Icon(Icons.favorite_border, size: 28, color: Color(0xFFA3774A)),
          Icon(Icons.people_outline, size: 28, color: Color(0xFFA3774A)),
          Icon(Icons.person_outline, size: 28, color: Color(0xFFA3774A)),
        ],
        onTap: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
      ),
    );
  }
}
