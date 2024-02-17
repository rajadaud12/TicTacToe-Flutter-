import 'package:audioplayers/audioplayers.dart';

class AudioManager {
  static final player = AudioPlayer();
  static Future<void> playSound(String soundPath) async {
    final player = AudioPlayer();
    await player.play(AssetSource(soundPath));
  }
  static Future<void> clickSound() async {
    await playSound('sounds/clickButton.mp3');
  }
  static Future<void> startSound() async {
    await playSound('sounds/yokoso_watashi_no.mp3');
  }
  static Future<void> coinSound() async {
    await playSound('sounds/coin.mp3');
  }
  static Future<void> aizen() async {
    player.setVolume(0.1);
    await player.play(AssetSource('sounds/Shiro Sagisu - Treachery lyrics.mp3'));
    player.onPlayerComplete.listen((event){
      aizen();
    });
  }
  static void setMute(bool mute) {
    player.setVolume(mute ? 0.0 : 0.1);
  }
}
