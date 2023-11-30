import 'package:flutter/material.dart';

class CheckOutScreanDropdownButtonFormField extends StatelessWidget {
  Function (String,String)? onChanged;
   CheckOutScreanDropdownButtonFormField({
    super.key,
    required this.city,
    this.onChanged,
  });

  final List<String> city;

  @override
  Widget build(BuildContext context) {
    final uniqueCity = city.toSet().toList();
    int selectedIndex = 0;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField(

        items: uniqueCity
            .map((e) => DropdownMenuItem(

                  child: Text(e),
                  value: e,
          onTap: (){
                     selectedIndex=uniqueCity.indexOf(e);
                     print(selectedIndex);

          },
                ))
            .toList(),

        hint: Text('select city'),
        decoration: InputDecoration(
          filled: true,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          isDense: true,
          isCollapsed: true,
          contentPadding: EdgeInsets.all(10),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
        ),
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 30,

        iconEnabledColor: Colors.black,
        onChanged: (value) {
          int index = uniqueCity.indexOf(value.toString()); // Get the index of the selected element
          if (index != -1) {
            selectedIndex = index+1; // Update the selectedIndex variable
          }
          onChanged!(value.toString(),selectedIndex.toString());
        },


      ),
    );
  }
}
