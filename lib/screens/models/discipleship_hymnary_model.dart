class DiscipleshipHymnaryModel{
  int id;
  String title;
  String meter;
  String hymnMusic;
  String text;
  String music;
  String hymnTune;
  String bibleText;
  String verses;
  String key;

  DiscipleshipHymnaryModel({
    required this.id,
    required this.title,
    required this.meter,
    required this.hymnMusic,
    required this.text,
    required this.music,
    required this.hymnTune,
    required this.bibleText,
    required this.verses,
    required this.key
  });

  static DiscipleshipHymnaryModel fromJson(Map<String, dynamic> data){
    return DiscipleshipHymnaryModel(
      id: data['id'],
      title: data['title'],
      meter: data['meter'],
      hymnMusic: data['hymnMusic'],
      text: data['text'],
      music: data['music'],
      hymnTune: data['hymnTune'],
      bibleText: data['bibleText'],
      verses: data['verses'],
      key: data['key']
    );
  }
}