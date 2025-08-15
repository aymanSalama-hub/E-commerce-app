import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:second_app/models/product.dart';
import 'package:second_app/widgets/product_cart.dart';

class Home extends StatefulWidget {
  static String id = '/home';

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();
  List filters = ['All', 'Category', 'Top', 'Recommended'];
  int _bottomNavIndex = 0;
  int selectedFilterIndex = 0;
  final List products = [
    Product(
      title: 'T-Shirt',
      ratingCount: 55,
      price: 300,
      image: 'assets/images/image1.jpg',
      imageAlt:
          'Girl wearing purple sweater covering face with rainbow scarf, standing against beige background',
    ),
    Product(
      title: 'Jacket',
      ratingCount: 666,
      price: 100,
      image: 'assets/images/splash.jpeg',
      imageAlt:
          'Person wearing beige turtleneck sweater holding collar close to face',
    ),
    Product(
      title: 'Child Jacket',
      ratingCount: 323,
      price: 600,
      image: 'assets/images/image3.jpg',
      imageAlt: 'Child wearing green sweater smiling against white background',
    ),
    Product(
      title: 'Hooded',
      ratingCount: 88,
      price: 700,
      image: 'assets/images/image5.jpg',
      imageAlt: 'Person wearing cream hoodie on brown background side profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 200, 98, 98),
        onPressed: () {},
        child: Icon(Icons.qr_code),
        //params
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: [
          Icons.home,
          Icons.add_shopping_cart,
          Icons.favorite_border,
          Icons.person_outlined,
        ],
        activeIndex: _bottomNavIndex,
        activeColor: const Color.fromARGB(255, 175, 66, 66),
        inactiveColor: const Color.fromARGB(255, 120, 115, 115),
        gapLocation: GapLocation.center,

        onTap: (index) => setState(() => _bottomNavIndex = index),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(
                            255,
                            120,
                            115,
                            115,
                          ).withOpacity(0.1),
                          hintText: 'Find Your Product',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintStyle: TextStyle(
                            color: const Color.fromARGB(255, 175, 66, 66),
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: const Color.fromARGB(255, 175, 66, 66),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 30),
                    Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(
                          255,
                          120,
                          115,
                          115,
                        ).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.notification_add_outlined,
                        color: const Color.fromARGB(255, 175, 66, 66),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  height: 100,
                  width: double.infinity,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 215, 127, 96),
                  ),
                  child: Image.asset(
                    "assets/images/login.jpeg",
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 36,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: filters.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final bool isSelected = index == selectedFilterIndex;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedFilterIndex = index;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color:
                                isSelected
                                    ? const Color.fromARGB(255, 175, 66, 66)
                                    : const Color.fromARGB(
                                      255,
                                      120,
                                      115,
                                      115,
                                    ).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            filters[index],
                            style: TextStyle(
                              color:
                                  isSelected
                                      ? Colors.white
                                      : const Color.fromARGB(255, 175, 66, 66),
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 260,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: products.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 16),
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ProductCard(product: product);
                    },
                  ),
                ),

                Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Newest Products',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 32,
                    crossAxisSpacing: 24,
                    childAspectRatio: 160 / 280,
                    children:
                        products
                            .map((product) => ProductCard(product: product))
                            .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
