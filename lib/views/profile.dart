import 'package:flutter/material.dart';
import 'package:projectakhir/views/doantepage.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Widget textfield({@required hintText}) {
    return Material(
      elevation: 4,
      shadowColor: Color.fromRGBO(49, 39, 79, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        enableInteractiveSelection: false,
        enabled: false,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              letterSpacing: 2,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            fillColor: Color.fromRGBO(49, 39, 79, 1),
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff21254A),
      body: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            painter: HeaderCurvedContainer(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: 35,
                    letterSpacing: 1.5,
                    color:  Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.width / 3,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff21254A), width: 5),
                  shape: BoxShape.circle,
                  color: Color(0xff21254A),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('images/fotoformal.png'),
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 450,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 40,),
                    textfield(
                      hintText: '123200083',
                    ),
                    SizedBox(height: 20,),
                    textfield(
                      hintText: 'Eggy Priambodo',
                    ),
                    SizedBox(height: 20,),
                    
                    Material(
                      elevation: 4,
                      shadowColor: Color.fromRGBO(49, 39, 79, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height/6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromRGBO(49, 39, 79, 1),

                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 10,),
                            Text('Kesan & Pesan', style: TextStyle(
                              letterSpacing: 2,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),),
                            SizedBox(height: 10,),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Text('Kuliah TPM bersama Bapak Bagus sangat menyenangkan dan menantang.\n'
                                  'Semoga dengan cara mengajar Bapak Bagus, dapat menciptakan progammer-progammer handal',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                letterSpacing: 2,
                                color: Colors.white,

                              ),),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(0, 1)
                          )
                        ]
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(49, 39, 79, 1),
                        ),
                        onPressed: () {

                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                              return DonatePage(
                              );
                            }),
                          );
                        },
                        child: Text('DONATE HERE !!!',style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),),

                      ),),

                  ],
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}


class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color.fromRGBO(49, 39, 79, 1);
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}