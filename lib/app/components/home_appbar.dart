import 'package:fiscal/app/components/theme_utils.dart';
import 'package:fiscal/app/modules/peso/peso_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// personalizando widget...
class HomeAppBar extends PreferredSize {
  final PesoController controller;
  HomeAppBar(this.controller)
      : super(
          preferredSize: Size(double.infinity, 115),
          child: AppBar(
              backgroundColor: Colors.grey[300],
              title: Text('Petô - Fiscal de Trânsito', style: TextStyle(color: Colors.white)),
              actions: [
                IconButton(
                  icon: Icon(Icons.location_on),
                  onPressed: () {},
                ),
              ],
              elevation: 0,
              // construindo o campo de pesquisa diferenciado
              flexibleSpace: Stack(
                children: [
                  Container(
                    // é esse camarada que está colocando a cor verde
                    height: 120, //115,
                    width: double.infinity,
                    color: ThemeUtils.primaryColor,
                  ),
                  // Align? novidade pra mim!!
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: ScreenUtil().screenWidth * .9,
                      child: Material(
                        // material pra colocar um elevation no campo de pesqusia
                        elevation: 4,
                        borderRadius: BorderRadius.circular(30),
                        child: TextFormField(
                          decoration: InputDecoration(
                            // fillColor e filled precisam ser configurados em conjunto
                            fillColor: Colors.white,
                            filled: true,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Icon(Icons.search, size: 30),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: Colors.grey[200]),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: Colors.grey[200]),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: Colors.grey[200]),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        );
}
