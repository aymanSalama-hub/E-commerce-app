import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:second_app/models/product.dart';

class ProductOverview extends StatefulWidget {
  const ProductOverview({super.key, required this.product});
  final Product product;

  @override
  State<ProductOverview> createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  int _currentPage = 0;

  late List<String> images;

  @override
  void initState() {
    super.initState();
    images = [widget.product.image, widget.product.image, widget.product.image];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  const Text(
                    "Product Overview",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(flex: 2),
                ],
              ),

              const SizedBox(height: 10),

              SizedBox(
                height: 280,
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 250,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    viewportFraction: 0.8,
                  ),
                  items:
                      images.map((item) {
                        return GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder:
                                  (_) => Dialog(
                                    backgroundColor: Colors.black,
                                    insetPadding: EdgeInsets.all(10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Stack(
                                        children: [
                                          PhotoView(
                                            imageProvider: AssetImage(item),
                                            minScale:
                                                PhotoViewComputedScale
                                                    .contained,
                                            maxScale:
                                                PhotoViewComputedScale.covered *
                                                2,
                                          ),
                                          Positioned(
                                            top: 10,
                                            right: 10,
                                            child: IconButton(
                                              icon: const Icon(
                                                Icons.close,
                                                color: Colors.white,
                                                size: 30,
                                              ),
                                              onPressed:
                                                  () => Navigator.pop(context),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              item,
                              fit: BoxFit.cover,
                              width: 1000,
                            ),
                          ),
                        );
                      }).toList(),
                ),
              ),

              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(images.length, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color:
                          _currentPage == index
                              ? Colors.pink
                              : Colors.grey[400],
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.product.title,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  Text(
                    "\$${widget.product.price}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),
              Row(
                children: const [
                  Icon(Icons.star, color: Colors.amber, size: 28),
                  Icon(Icons.star, color: Colors.amber, size: 28),
                  Icon(Icons.star, color: Colors.amber, size: 28),
                  Icon(Icons.star, color: Colors.grey, size: 28),
                  Icon(Icons.star, color: Colors.grey, size: 28),
                ],
              ),

              const SizedBox(height: 10),
              Text(
                widget.product.imageAlt,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),

              const Spacer(),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.shopping_cart,
                      color: Colors.pink,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Buy Now",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
