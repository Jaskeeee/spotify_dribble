import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration:InputDecoration(
        fillColor: Colors.black,
        hintStyle:TextStyle(
          color: Colors.black
        ),
        filled: true,
        prefixIcon: Icon(Icons.search),
        hintText: "Search by Title, Artist or Album...",
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            style: BorderStyle.solid
          )
        ),
        focusedBorder:  OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            style: BorderStyle.solid
          )
        ),
        errorBorder:  OutlineInputBorder(
          borderSide: BorderSide(
            color:Colors.black,
            style: BorderStyle.solid
          )
        )
      ),
    );
  }
}