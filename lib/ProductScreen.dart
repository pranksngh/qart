import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductScreen extends StatefulWidget {
 
var productList;

 ProductScreen({required this.productList});

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Product Details"),
      ),

      body: SafeArea(
        child: SingleChildScrollView(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(20),
                    width:120,
                    height:160,
                    
                    decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                        image: NetworkImage('${widget.productList["ImageUrl"]}'),
                        fit: BoxFit.cover,
                      ),
                     border: Border.all(color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                       Align(
                           alignment: Alignment.bottomCenter,
                         child: Container(
                           margin: EdgeInsets.only(bottom:20),
                          alignment: Alignment.center,
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          height:50,

                          child: Text("${widget.productList['Option']}\n${widget.productList['Color']}\n${widget.productList['MRP']}",textAlign: TextAlign.center, style: TextStyle(fontSize: 11,color: Colors.white),),
                        ),
                       ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)
                              ),
                            ),
                          height:20,
                          width: MediaQuery.of(context).size.width,
                          child: RatingBarIndicator(
                    rating: widget.productList['Likeabilty'],
                    itemCount: 5,
                    itemSize: 15.0,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, _) => Icon(
                      
                      Icons.star,
                      color: Colors.amber,
                      size: 9,
                    ),
                  ),
                        ),
                        ),
                      ],
                    ),
                  ),

                  
                  
                ],
              ),

              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(10),
               
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                   color: Colors.white,
                ),
                child: Column(
                  children: [
                     TextFormField(
                     initialValue: "${widget.productList['Brand']} - ${widget.productList['Category']} - ${widget.productList['Collection']}", 
                       
                    readOnly: true,
                  decoration: InputDecoration(
                  
                    border: OutlineInputBorder(),
                    labelText: 'Brand - Category - Collection',
                  ),
                  onChanged: (text) {
                   
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                   TextFormField(
                     initialValue: "${widget.productList['Gender']} - ${widget.productList['Name']} - ${widget.productList['SubCategory']}", 
                       
                    readOnly: true,
                  decoration: InputDecoration(
                  
                    border: OutlineInputBorder(),
                    labelText: 'Gender - Name - SubCategory',
                  ),
                  onChanged: (text) {
                   
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                   TextFormField(
                     initialValue: "${widget.productList['Fit']} - ${widget.productList['Theme']} - ${widget.productList['Finish']}", 
                       
                    readOnly: true,
                  decoration: InputDecoration(
                  
                    border: OutlineInputBorder(),
                    labelText: 'Fit - Theme - Finish`',
                  ),
                  onChanged: (text) {
                   
                  },
                ),

                    SizedBox(
                  height: 10,
                ),
                   TextFormField(
                     initialValue: "${widget.productList['OfferMonths']} - ${widget.productList['Mood']} ", 
                       
                    readOnly: true,
                  decoration: InputDecoration(
                  
                    border: OutlineInputBorder(),
                    labelText: 'OFF_MONTH - Mood',
                  ),
                  onChanged: (text) {
                   
                  },
                ),
                  ],
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Text('Description',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                      SizedBox(height:5),
                      Text('${widget.productList["Description"]}',style: TextStyle(fontSize: 13),),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}