import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/constants/common_size.dart';
import 'package:flutter_project/constants/screen_size.dart';

class ProfileBody extends StatefulWidget {
  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  SelectedTap _selectedTap = SelectedTap.left;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              _username(),
              _userBio(),
              _editProfileBtn(),
              _tabButtons(),
              _selectedIndicator(),
            ]),
          ),
          SliverToBoxAdapter(
              child: GridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 3,
            childAspectRatio: 1,
            children: List.generate(
                30,
                (index) => CachedNetworkImage(
                  fit: BoxFit.cover,
                      imageUrl: "https://picsum.photos/id/$index/100/100",
                    )),
          ))
        ],
      ),
    );
  }

  Widget _selectedIndicator() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      alignment: _selectedTap == SelectedTap.left
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: Container(
        height: 3,
        width: size.width / 2,
        color: Colors.black87,
      ),
      curve: Curves.easeInOut,
    );
  }

  Row _tabButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: IconButton(
              icon: ImageIcon(
                AssetImage('assets/images/grid.png'),
                color: _selectedTap == SelectedTap.left
                    ? Colors.black
                    : Colors.black26,
              ),
              onPressed: () {
                setState(() {
                  _selectedTap = SelectedTap.left;
                });
              }),
        ),
        Expanded(
          child: IconButton(
              icon: ImageIcon(
                AssetImage('assets/images/saved.png'),
                color: _selectedTap == SelectedTap.left
                    ? Colors.black26
                    : Colors.black,
              ),
              onPressed: () {
                setState(() {
                  _selectedTap = SelectedTap.right;
                });
              }),
        )
      ],
    );
  }

  Padding _editProfileBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: common_gap, vertical: common_xxs_gap),
      child: SizedBox(
        height: 24,
        child: OutlineButton(
          onPressed: () {},
          borderSide: BorderSide(color: Colors.black45),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'Edit Profile',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _username() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: common_gap, vertical: common_xxs_gap),
      child: Text(
        'username',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _userBio() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: common_gap),
      child: Text(
        'This is what I belive!!',
        style: TextStyle(fontWeight: FontWeight.w400),
      ),
    );
  }
}

enum SelectedTap { left, right }
