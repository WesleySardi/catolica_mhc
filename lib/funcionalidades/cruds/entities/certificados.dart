class Certificados {

  int _id;
  int _numero_de_matricula;
  String _nome_do_curso;
  String _instituicao;
  String _tipo_certificado;
  String _status;
  double _carga_horaria;
  String _motivo;
  String _imagem;

  Certificados(
      this._id,
      this._numero_de_matricula,
      this._nome_do_curso,
      this._instituicao,
      this._tipo_certificado,
      this._status,
      this._carga_horaria,
      this._motivo,
      this._imagem);

  String get imagem => _imagem;

  set imagem(String value) {
    _imagem = value;
  }

  String get motivo => _motivo;

  set motivo(String value) {
    _motivo = value;
  }

  double get carga_horaria => _carga_horaria;

  set carga_horaria(double value) {
    _carga_horaria = value;
  }

  String get status => _status;

  set status(String value) {
    _status = value;
  }

  String get tipo_certificado => _tipo_certificado;

  set tipo_certificado(String value) {
    _tipo_certificado = value;
  }

  String get instituicao => _instituicao;

  set instituicao(String value) {
    _instituicao = value;
  }

  String get nome_do_curso => _nome_do_curso;

  set nome_do_curso(String value) {
    _nome_do_curso = value;
  }

  int get numero_de_matricula => _numero_de_matricula;

  set numero_de_matricula(int value) {
    _numero_de_matricula = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  @override
  String toString() {
    return 'Certificados{_id: $_id, _numero_de_matricula: $_numero_de_matricula, _nome_do_curso: $_nome_do_curso, _instituicao: $_instituicao, _tipo_certificado: $_tipo_certificado, _status: $_status, _carga_horaria: $_carga_horaria, _motivo: $_motivo, _imagem: $_imagem}';
  }
}