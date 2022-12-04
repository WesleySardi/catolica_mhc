class CursosCrud {
  int _curso_id;
  String _curso_nome;
  double _curso_qtd_horas;
  int _curso_fk_id_coord;

  CursosCrud(this._curso_id, this._curso_nome, this._curso_qtd_horas,
      this._curso_fk_id_coord);

  int get curso_fk_id_coord => _curso_fk_id_coord;

  set curso_fk_id_coord(int value) {
    _curso_fk_id_coord = value;
  }

  double get curso_qtd_horas => _curso_qtd_horas;

  set curso_qtd_horas(double value) {
    _curso_qtd_horas = value;
  }

  String get curso_nome => _curso_nome;

  set curso_nome(String value) {
    _curso_nome = value;
  }

  int get curso_id => _curso_id;

  set curso_id(int value) {
    _curso_id = value;
  }
}