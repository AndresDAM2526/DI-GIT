class FormularioModel {
  String nombre;
  String correo;
  String tf;

  FormularioModel({
    required this.nombre,
    required this.correo,
    required this.tf,
  });

  @override
  String toString() {
    return "Contacto(nombre:$nombre-correo: $correo-telefono: $tf)";
  }
}
