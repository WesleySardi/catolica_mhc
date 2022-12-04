class CoordenadoresCrud {
  int _coord_id;
  String _coord_nome;
  String _coord_sobrenome;

  CoordenadoresCrud(this._coord_id, this._coord_nome, this._coord_sobrenome);

  String get coord_sobrenome => _coord_sobrenome;

  set coord_sobrenome(String value) {
    _coord_sobrenome = value;
  }

  String get coord_nome => _coord_nome;

  set coord_nome(String value) {
    _coord_nome = value;
  }

  int get coord_id => _coord_id;

  set coord_id(int value) {
    _coord_id = value;
  }
}