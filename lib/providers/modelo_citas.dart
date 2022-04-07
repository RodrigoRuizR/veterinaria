
class Citas {
  final int idCita;
  final String fecha;
  final String hora;
  final String tipoServicio;


  Citas({
    required this.idCita,
    required this.fecha,
    required this.hora,
    required this.tipoServicio,
  });

  factory Citas.fromJson(Map<String, dynamic> json) => Citas(
        idCita: json['idCita'],
        fecha: json['fecha'],
        hora: json['hora'],
        tipoServicio: json['tipoServicio']
      );
}