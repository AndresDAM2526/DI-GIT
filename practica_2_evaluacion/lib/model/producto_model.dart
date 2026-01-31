///Clase para crear un objeto de tipo producto
class Producto {
  ///Atributo para guardar el identificador de producto
  int idProducto;
  ///Atributo para guardar el nombre de producto
  String nombre;
  ///Atributo para guardar la categoria de producto
  String categoria;
  ///Atributo para guardar la cantidad de producto
  int cantidad;
  ///Atributo para guardar el precio de producto
  double precio;

  Producto({
    required this.idProducto,
    required this.nombre,
    required this.categoria,
    required this.cantidad,
    required this.precio,
  });

  ///Función usada para transformar un objeto de tipo Producto en formato JSON
  Map<String, dynamic> toJson() => {
    'idProducto': idProducto,
    'nombre': nombre,
    'categoria': categoria,
    'cantidad': cantidad,
    'precio': precio,
  };

  ///Función para convertir un objeto en formato JSON en un objeto tipo Producto
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
