import 'dart:convert';

class Proveedor {
  Proveedor({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.correo,
    required this.estado,
  });

  int id;
  String nombre;
  String apellido;
  String correo;
  String estado;

  factory Proveedor.fromJson(String str) => Proveedor.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Proveedor.fromMap(Map<String, dynamic> json) => Proveedor(
        id: json["providerid"],  // Corregido para coincidir con el JSON de la API
        nombre: json["provider_name"],
        apellido: json["provider_last_name"],
        correo: json["provider_mail"],
        estado: json["provider_state"],
      );

  Map<String, dynamic> toMap() => {
        "providerid": id,  // Consistencia con las claves de la API
        "provider_name": nombre,
        "provider_last_name": apellido,
        "provider_mail": correo,
        "provider_state": estado,
      };
}
