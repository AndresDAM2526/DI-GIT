class ProductoFactura {
  String nombre;
  double precio;

  ProductoFactura({required this.nombre, required this.precio});

  factory ProductoFactura.fromJson(Map<String, dynamic> json) {
    return ProductoFactura(nombre: json['nombre'], precio: json['precio']);
  }
}
