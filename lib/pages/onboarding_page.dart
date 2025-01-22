import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:korean_bubble_tea/intro_pageone.dart';

class DevicePage extends StatefulWidget {
  @override
  State<DevicePage> createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {
  final List<List<dynamic>> devices = [
    ["Chief Onyebuchi", "assets/buchitwo.JPG", false],
    ["Nwoke Oma", "assets/buchi3.JPG", true],
    ["The Smart and Mighty", "assets/buchi.one.JPG", true],
    ["My Big Spender", "assets/buchitwo.JPG", false],
  ];

  void toggleDevice(int index, bool value) {
    setState(() {
      devices[index][2] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chief Onyebuchi",
          style: GoogleFonts.bebasNeue(fontSize: 28),
        ),
        backgroundColor: Colors.grey[850],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const IntroPage1()));
          },
        ),
      ),
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: GridView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: devices.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
          ),
          itemBuilder: (context, index) {
            return DeviceBox(
              deviceName: devices[index][0],
              imagePath: devices[index][1],
              powerOn: devices[index][2],
              onChanged: (value) => toggleDevice(index, value),
            );
          },
        ),
      ),
    );
  }
}

class DeviceBox extends StatefulWidget {
  final String deviceName;
  final String imagePath;
  final bool powerOn;
  final void Function(bool)? onChanged;

  const DeviceBox({
    Key? key,
    required this.deviceName,
    required this.imagePath,
    required this.powerOn,
    this.onChanged,
  }) : super(key: key);

  @override
  State<DeviceBox> createState() => _DeviceBoxState();
}

class _DeviceBoxState extends State<DeviceBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    if (widget.powerOn) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(DeviceBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.powerOn) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: widget.powerOn ? Colors.grey[900] : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: AnimatedBuilder(
                  animation: _scaleAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Image.asset(
                        widget.imagePath,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.deviceName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: widget.powerOn ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            CupertinoSwitch(
              value: widget.powerOn,
              onChanged: widget.onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
