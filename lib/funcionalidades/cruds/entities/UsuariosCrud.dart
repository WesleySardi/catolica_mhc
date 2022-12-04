class UsuariosCrud {
  int _usu_num_matricula;
  String _usu_nome;
  String _usu_sobrenome;
  String _usu_email;
  String _usu_senha;
  String _usu_curso;
  String _uso_telefone = "";
  String _uso_img_perfil = "";

  UsuariosCrud(
      this._usu_num_matricula,
      this._usu_nome,
      this._usu_sobrenome,
      this._usu_email,
      this._usu_senha,
      this._usu_curso,
      this._uso_telefone,
      this._uso_img_perfil);

  String get uso_img_perfil => _uso_img_perfil;

  set uso_img_perfil(String value) {
    _uso_img_perfil = value;
  }

  String get uso_telefone => _uso_telefone;

  set uso_telefone(String value) {
    _uso_telefone = value;
  }

  String get usu_curso => _usu_curso;

  set usu_curso(String value) {
    _usu_curso = value;
  }

  String get usu_senha => _usu_senha;

  set usu_senha(String value) {
    _usu_senha = value;
  }

  String get usu_email => _usu_email;

  set usu_email(String value) {
    _usu_email = value;
  }

  String get usu_sobrenome => _usu_sobrenome;

  set usu_sobrenome(String value) {
    _usu_sobrenome = value;
  }

  String get usu_nome => _usu_nome;

  set usu_nome(String value) {
    _usu_nome = value;
  }

  int get usu_num_matricula => _usu_num_matricula;

  set usu_num_matricula(int value) {
    _usu_num_matricula = value;
  }

  @override
  String toString() {
    return 'UsuariosCrud{_usu_num_matricula: $_usu_num_matricula, _usu_nome: $_usu_nome, _usu_sobrenome: $_usu_sobrenome, _usu_email: $_usu_email, _usu_senha: $_usu_senha, _usu_curso: $_usu_curso, _uso_telefone: $_uso_telefone, _uso_img_perfil: $_uso_img_perfil}';
  }
}
