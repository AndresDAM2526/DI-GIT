import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final anchura = MediaQuery.sizeOf(context).width;
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: SafeArea(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 800),
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus aliquet euismod tristique. Pellentesque in ligula lectus. Pellentesque mi metus, lobortis ut urna eleifend, eleifend tempus lacus. Morbi ac est tortor. Nunc arcu neque, rhoncus non sem nec, viverra convallis turpis. Sed quis arcu nisl. Donec sed elit at nisl sollicitudin sodales.Etiam ultrices ligula sed convallis porttitor. Integer ut ultrices leo. Duis finibus nec elit sed tempus. Duis sit amet tincidunt nibh. Quisque tempor sapien tellus, sollicitudin sollicitudin risus suscipit quis. Vivamus suscipit dolor vitae sem tempor hendrerit. In sollicitudin at lacus eu lacinia. Integer ut faucibus lectus, quis malesuada lorem. Morbi efficitur blandit est. Cras posuere lacus arcu, ac tempor sem lacinia eu. Integer eu fringilla metus. Proin et sollicitudin augue, non finibus magna. Sed pellentesque sodales lorem et sodales.Cras scelerisque mollis tellus ac ultricies. Suspendisse rhoncus felis arcu, at facilisis velit efficitur auctor. Quisque et sem tellus. Nulla accumsan velit eget lectus tristique pretium. Pellentesque lectus metus, facilisis vitae placerat ac, eleifend id nibh. Quisque eu ornare quam. In ut metus a lorem dictum rutrum a quis quam. Morbi rutrum suscipit ipsum, vehicula vulputate quam sollicitudin non. Quisque commodo, libero mattis tempor facilisis, dolor ex fermentum mauris, eget convallis turpis risus eget leo.In nec scelerisque nisi, ut dapibus tortor. In augue urna, porta in turpis id, dapibus suscipit est. In a justo nec enim lobortis eleifend at eget justo. Pellentesque ullamcorper lacus quis lorem congue ornare. Pellentesque ornare mauris id erat condimentum, eu faucibus turpis pharetra. Vivamus non pharetra nulla, at venenatis neque. Suspendisse felis sem, consequat id euismod luctus, faucibus ut ante. Maecenas lectus nibh, hendrerit ac gravida at, facilisis at ligula. Morbi et scelerisque arcu, in volutpat sem. Phasellus tempor erat ac tellus tincidunt vulputate. Curabitur commodo, mauris sed ultricies tincidunt, nibh diam pretium ligula, et maximus est nisl ac dolor. Sed et purus eu justo pretium mollis eu quis tellus.Donec egestas tellus et ante pretium fermentum. Ut convallis diam id aliquam viverra. Ut posuere tortor elit, nec euismod magna vulputate a. Quisque nec pellentesque ante. Ut mattis urna cursus, hendrerit urna molestie, placerat libero. Praesent pretium eros urna, id venenatis nisi cursus a. Nunc lorem mi, congue sagittis justo non, condimentum congue augue. Duis lacinia arcu non risus sollicitudin sollicitudin.",
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
