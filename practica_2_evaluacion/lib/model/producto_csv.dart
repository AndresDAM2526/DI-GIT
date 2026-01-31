///Clase usada para cargar los productos de los ficheros CSV
class ProductoCsv {
  String nombre;
  String categoria;
  int cantidad;
  double precio;

  ProductoCsv({
    required this.nombre,
    required this.categoria,
    required this.cantidad,
    required this.precio,
  });
}