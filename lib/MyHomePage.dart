import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:qart/Database/db_provider.dart';
import 'package:qart/Models/Products.dart';
import 'package:qart/ProductScreen.dart';
import 'package:sqflite/sqflite.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({ Key? key }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

 var isLoading = false;
 late List<dynamic> fetchedData;
 var productCount;
  @override

  void initState(){
   calltoActions();
  }


  calltoActions()async{
     setState(() {
       isLoading = true;
     });
    await storeData();
    await Future.delayed(const Duration(seconds: 2));

    await DBProvider().fetchProducts().then((value){
      setState(() {
        fetchedData = value;
      });

    
    });

    print('fetched data is $fetchedData');

    setState(() {
      isLoading = false;
    });
  }

 

storeData() async {
  
 try{
   var url = Uri.parse("https://debug.qart.fashion/api/product/GetProductsWithSizes?retailerCode=40984");
   Response response = await http.get(url);

   final jsonData = json.decode(response.body);

    setState(() {
      productCount = jsonData['ProductCount'];
    });
 return (jsonData['Products'] as List).map((product) async {
      print('Inserting $product');
      DBProvider().createProduct(Products.fromJson(product));
    }).toList();




 }catch(e){
   print(e);
 }
 
}

  @override
  Widget build(BuildContext context) {
   return WillPopScope(
     onWillPop: null,
     child:Scaffold(
       backgroundColor: Colors.grey[300],
       appBar: AppBar(
         title: Text("Dashboard"),
         actions: [
           IconButton(
             onPressed: (){
               showSearch(
          context: context,
          delegate: CustomSearchDelegate(productList: fetchedData),
        );
             }, 
             
             icon: Icon(Icons.search),
             
             ),
           
               Container(
            padding: EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () async {
                await calltoActions();
              },
            ),
          ),
         ],
       ),

       body: SafeArea(
         child: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
            alignment: Alignment.center,
              margin: EdgeInsets.all(20),
              width: 150,
              height:180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Total Products',style: TextStyle(fontSize: 14, fontWeight:FontWeight.bold,color: Colors.grey),),
                  SizedBox(height:5),
                  Text('${fetchedData.length}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,)),
                ],
              ),
              
          
          ),
       ),
     ), 
     );
  }


  
}

class CustomSearchDelegate extends SearchDelegate {


  List<dynamic> productList;
  final recentSearches = [];
  CustomSearchDelegate({required this.productList});
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
     return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    List<dynamic> resultList = query.isEmpty?productList:productList.where((elem) => 
     elem['QRCode'].toString().toLowerCase().startsWith(query)
    ).toList();
   
   
    return  Container(

      child: ListView.builder(
        shrinkWrap: true,
         itemCount: resultList.length,
        itemBuilder: (context, index){
           
           String qrcode = resultList[index]['QRCode'];
           String color= resultList[index]['Color'];
           String option = resultList[index]['Option'];
           String sizes = resultList[index]['AvailableSizes'];
           String ImageUrl = resultList[index]['ImageUrl'];
           double mrp = resultList[index]['MRP'];

           var products = resultList[index];
  
           return Container(
             
              margin: EdgeInsets.all(10),
             child: ExpansionTile(
               
               initiallyExpanded: true,
               
               title: Text(qrcode, style:TextStyle(color: Colors.black)) ,
               children: [
                 ListTile(
                   isThreeLine: true,
                   leading: CachedNetworkImage(
                   imageUrl: "$ImageUrl",
                   placeholder: (context, url) => CircularProgressIndicator(),
                   errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                   title: Text(color),
                   subtitle: Text("OP:$option\nMRP:$mrp", 
                   style:TextStyle(fontSize: 11, fontWeight: FontWeight.normal)),
                   trailing: Container(
                     width: 50,
                     child: Text(sizes),
                   ),
                   onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductScreen(productList: resultList[index],))),
                 ),
               ],
             )
           );

          

      },
    ),
    );

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    
    final suggestionList = query.isEmpty?productList:productList.where((elem) => 
     elem['QRCode'].toString().toLowerCase().contains(query.toLowerCase()) || 
    elem['Option'].toString().toLowerCase().contains(query.toLowerCase())
    ).toList();
    return Container(

      child: ListView.builder(
        shrinkWrap: true,
         itemCount: suggestionList.length,
        itemBuilder: (context, index){
           
           String qrcode = suggestionList[index]['QRCode'];
           String color= suggestionList[index]['Color'];
           String option = suggestionList[index]['Option'];
           String sizes = suggestionList[index]['AvailableSizes'];
           String ImageUrl = suggestionList[index]['ImageUrl'];
           double mrp = suggestionList[index]['MRP'];
           return Container(
             
              margin: EdgeInsets.all(10),
             child: ExpansionTile(
               initiallyExpanded: true,
               title: Text(qrcode,style:TextStyle(color: Colors.black)) ,
               children: [
                 ListTile(
                   isThreeLine: true,
                   leading: CachedNetworkImage(
                   imageUrl: "$ImageUrl",
                   placeholder: (context, url) => CircularProgressIndicator(),
                   errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                   title: Text(color),
                   subtitle: Text("OP:$option\nMRP:$mrp", 
                   style:TextStyle(fontSize: 11, fontWeight: FontWeight.normal)),
                   trailing: Container(
                     width: 90,
                     child: Text(sizes),
                   ),

                     onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductScreen(productList: suggestionList[index],))),
                 ),
               ],
             )
           );

          

      },
    ),
    );
  }
}