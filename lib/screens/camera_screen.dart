import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  int _currentIndex = 1;
  PageController _pageController = PageController(initialPage: 1);
  String _title = "Photo";

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: PageView(
        controller: _pageController,
        children: [
          Container(
            color: Colors.cyanAccent,
          ),
          Container(
            color: Colors.amberAccent,
          ),
          Container(
            color: Colors.greenAccent,
          )
        ],
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
            switch (_currentIndex) {
              case 0:
                _title = 'Gallery';
                break;
              case 1:
                _title = 'Photo';
                break;
              case 2:
                _title = 'Video';
                break;
            }
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 0,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black38,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box), title: Text('GALLERY')),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box), title: Text('PHOTO')),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box), title: Text('VIDEO')),
        ],
        currentIndex: _currentIndex,
        onTap: _inItemTabbed,
      ),
    );
  }

  void _inItemTabbed(index) {
    print(index);
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(_currentIndex,
          duration: Duration(milliseconds: 200), curve: Curves.fastOutSlowIn);
    });
  }
}
