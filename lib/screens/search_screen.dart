import 'package:flutter/material.dart';
import 'package:flutter_project/constants/common_size.dart';
import 'package:flutter_project/widgets/rounded_avatar.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              leading: RoundedAvatar(),
              title: Text('username $index'),
              subtitle: Text('user bio number $index'),
              trailing: Container(
                height: 30, width: 80,alignment: Alignment.center, decoration: BoxDecoration(
                color: Colors.red[50],
                border: Border.all(color: Colors.red,width: 0.5),
                borderRadius: BorderRadius.circular(8),
              ),
                child: Text('fallowing',style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(color: Colors.grey,);
          },
          itemCount: 30),
    );
  }
}
