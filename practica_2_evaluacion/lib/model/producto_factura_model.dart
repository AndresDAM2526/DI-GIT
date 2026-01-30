class ProductoFactura {
  String nombre;
  double precio;
  int cantidad;

  ProductoFactura({
    required this.nombre,
    required this.precio,
    required this.cantidad,
  });

  factory ProductoFactura.fromJson(Map<String, dynamic> json) {
    return ProductoFactura(
      nombre: json['nombre'],
      precio: json['precio'],
      cantidad: json['cantidad'],
    );
  }
}
