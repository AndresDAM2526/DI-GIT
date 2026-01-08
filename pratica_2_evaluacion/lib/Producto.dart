class Producto {
  String nombre;
  String categoria;
  int cantidad;
  double precio;

  Producto({
    required this.nombre,
    required this.categoria,
    required this.cantidad,
    required this.precio,
  });

  Map<String, dynamic> toJson() => {
    'nombre': nombre,
    'categoria': categoria,
    'cantidad': cantidad,
    'precio': precio,
  };

}
