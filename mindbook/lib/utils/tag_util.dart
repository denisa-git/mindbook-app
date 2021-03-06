class TagUil {
  String _tag;
  bool _selected;

  TagUil(String tag, bool selected) {
    _tag = tag;
    _selected= selected;
  }

  Map<String, bool> getMap() {
    return {_tag: _selected};
  }

  void setSelected(bool selected) {
    _selected = selected;
  }

  bool getSelected() {
    return _selected;
  }

  void setTag(String tag) {
    _tag = tag;
  }

  String getTag() {
    return _tag;
  }

  @override
  String toString() => "TagUil<$_tag:$_selected>";

}
