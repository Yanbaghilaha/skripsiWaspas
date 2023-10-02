import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spk_app/material/colors.dart';

class MyTextField3 extends StatelessWidget {
  const MyTextField3({
    super.key,
    required this.kriteria,
    required this.bobot,
    this.onChanged,
    required this.textColor,
  });

  final String kriteria;
  final TextEditingController bobot;
  final Function? onChanged;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 10,
          child: TextField(
            controller: TextEditingController(
              text: kriteria,
            ),
            autofocus: true,
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                color: Colors.white60,
              ),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            onChanged: (v) {
              onChanged!(v);
            },
            showCursor: true,
            readOnly: true,
            cursorWidth: 4,
            cursorColor: AppColors.blue,
            decoration: InputDecoration(
              hintStyle: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.white12,
              ),
              contentPadding: const EdgeInsets.all(20),
              labelStyle: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white30,
              ),
              border: InputBorder.none,
              fillColor: const Color(0xff282B34),
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color(0xff505668),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.white60,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        //bobot
        Flexible(
          flex: 3,
          child: TextField(
            textAlign: TextAlign.center,
            onChanged: (value) {},
            controller: bobot,
            autofocus: true,
            keyboardType: TextInputType.number,
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                color: Colors.green,
              ),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            showCursor: true,
            cursorWidth: 4,
            cursorColor: AppColors.blue,
            decoration: InputDecoration(
              hintStyle: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.white12,
              ),
              contentPadding: const EdgeInsets.all(20),
              labelStyle: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white30,
              ),
              fillColor: const Color(0xff282B34),
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color(0xff505668),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.white60,
                ),
              ),
            ),
          ),
        ),
      ],
      // width: double.infinity,
    );
  }
}
