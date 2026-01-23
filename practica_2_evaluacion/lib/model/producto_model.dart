class Producto {
  int idProducto;
  String nombre;
  String categoria;
  int cantidad;
  double precio;

  Producto({
    required this.idProducto,
    required this.nombre,
    required this.categoria,
    required this.cantidad,
    required this.precio,
  });

  Map<String, dynamic> toJson() => {
    'idProducto': idProducto,
    'nombre': nombre,
    'categoria': categoria,
    'cantidad': cantidad,
    'precio': precio,
  };

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      idProducto: json['idProducto'],
      nombre: json['nombre'],
      categoria: json['categoria'],
      cantidad: json['cantidad'],
      precio: json['precio'],
    );
  }
}
