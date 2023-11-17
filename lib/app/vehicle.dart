class Vehicle {
  final int? id;
  final String modelo;
  final String horaEntrada;
  final String placa;
  final String nomeCliente;
  final String telefoneCliente;

  Vehicle({
    this.id,
    required this.modelo,
    required this.horaEntrada,
    required this.placa,
    required this.nomeCliente,
    required this.telefoneCliente,
  });

  Map<String, dynamic> toMap() {
    return {
      'modelo': modelo,
      'horaEntrada': horaEntrada,
      'placa': placa,
      'nomeCliente': nomeCliente,
      'telefoneCliente': telefoneCliente,
    };
  }
}
