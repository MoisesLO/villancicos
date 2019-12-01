import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'package:audioplayer/audioplayer.dart';
import 'package:audio_service/audio_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:firebase_admob/firebase_admob.dart';



void main() => runApp(MyApp());


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {

  final BehaviorSubject<double> _dragPositionSubject = BehaviorSubject.seeded(null);



  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    iniciar();
    connect();
  }

  @override
  void dispose() {
    disconnect();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        connect();
        break;
      case AppLifecycleState.paused:
        disconnect();
        break;
      default:
        break;
    }
  }

  void connect() async {
    await AudioService.connect();
  }

  void iniciar(){
    AudioService.start(
      backgroundTaskEntrypoint: _audioPlayerTaskEntrypoint,
      resumeOnClick: true,
      androidNotificationChannelName: 'Audio Service Demo',
      notificationColor: 0xFF2196f3,
      androidNotificationIcon: 'mipmap/ic_launcher',
    );
  }

  void disconnect() {
    AudioService.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAdMob.instance.initialize(appId: "ca-app-pub-5852042324891789~5092546369");
    myBanner
    // typically this happens well before the ad is shown
      ..load()
      ..show(
        // Positions the banner ad 60 pixels from the bottom of the screen
        anchorOffset: 0,
        // Positions the banner ad 10 pixels from the center of the screen to the right
        horizontalCenterOffset: 0,
        // Banner Position
        anchorType: AnchorType.bottom,
      );
    return MaterialApp(
      home: WillPopScope(
        onWillPop: () {
          disconnect();
          return Future.value(true);
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Villancicos de Navidad'),
          ),
          body: Center(
            child: StreamBuilder<List<MediaItem>>(
              stream: AudioService.queueStream,
              builder: (context, snapshot) {
                final queue = snapshot.data;
                return StreamBuilder<MediaItem>(
                  stream: AudioService.currentMediaItemStream,
                  builder: (context, snapshot) {
                    final mediaItem = snapshot.data;
                    return StreamBuilder<PlaybackState>(
                      stream: AudioService.playbackStateStream,
                      builder: (context, snapshot) {
                        final state = snapshot.data;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.skip_previous),
                                  iconSize: 64.0,
                                  onPressed: AudioService.skipToPrevious,
                                ),//
                                if (state?.basicState == BasicPlaybackState.paused)
                                  ...[playButton()]
                                else
                                  ...[pauseButton()]
                                ,
                                IconButton(
                                  icon: Icon(Icons.skip_next),
                                  iconSize: 64.0,
                                  onPressed: AudioService.skipToNext,
                                ),
                              ],
                              ),
                            if (queue != null && queue.isNotEmpty) ...[positionIndicator(mediaItem, state)],
                            Expanded(
                              child: ListView(
                                children: <Widget>[
                                  Card(
                                    child: ListTile(
                                      leading: CircleAvatar(child: Image.asset("assets/icon.png")),
                                      title: Text('Navidad Feliz-Navidad'),
                                      subtitle: Text('Navidad y Año nuevo 2019'),
                                      trailing: Icon(Icons.play_arrow),
                                      onTap: (){
                                        AudioService.playFromMediaId('0');
                                      }
                                    ),
                                  ),Card(
                                    child: ListTile(
                                      leading: CircleAvatar(child: Image.asset("assets/icon.png")),
                                      title: Text('Campana sobre campana'),
                                      subtitle: Text('Navidad y Año nuevo 2019'),
                                      trailing: Icon(Icons.play_arrow),
                                      onTap: (){
                                        AudioService.playFromMediaId('1');
                                      }
                                    ),
                                  ),Card(
                                    child: ListTile(
                                      leading: CircleAvatar(child: Image.asset("assets/icon.png")),
                                      title: Text('Campanas de Belen'),
                                      subtitle: Text('Navidad y Año nuevo 2019'),
                                      trailing: Icon(Icons.play_arrow),
                                      onTap: (){
                                        AudioService.playFromMediaId('2');
                                      }
                                    ),
                                  ),Card(
                                    child: ListTile(
                                      leading: CircleAvatar(child: Image.asset("assets/icon.png")),
                                      title: Text('Cascabel'),
                                      subtitle: Text('Navidad y Año nuevo 2019'),
                                      trailing: Icon(Icons.play_arrow),
                                      onTap: (){
                                        AudioService.playFromMediaId('3');
                                      }
                                    ),
                                  ),Card(
                                    child: ListTile(
                                      leading: CircleAvatar(child: Image.asset("assets/icon.png")),
                                      title: Text('El-nino-del-tambor'),
                                      subtitle: Text('Navidad y Año nuevo 2019'),
                                      trailing: Icon(Icons.play_arrow),
                                      onTap: (){
                                        AudioService.playFromMediaId('4');
                                      }
                                    )
                                  ),Card(
                                    child: ListTile(
                                      leading: CircleAvatar(child: Image.asset("assets/icon.png")),
                                      title: Text('Mi-burrito-sabanero'),
                                      subtitle: Text('Navidad y Año nuevo 2019'),
                                      trailing: Icon(Icons.play_arrow),
                                      onTap: (){
                                        AudioService.playFromMediaId('5');
                                      }
                                    )
                                  ),Card(
                                    child: ListTile(
                                      leading: CircleAvatar(child: Image.asset("assets/icon.png")),
                                      title: Text('Navidad Feliz Navidad'),
                                      subtitle: Text('Navidad y Año nuevo 2019'),
                                      trailing: Icon(Icons.play_arrow),
                                      onTap: (){
                                        AudioService.playFromMediaId('6');
                                      }
                                    )
                                  ),Card(
                                    child: ListTile(
                                      leading: CircleAvatar(child: Image.asset("assets/icon.png")),
                                      title: Text('Noche de paz2'),
                                      subtitle: Text('Navidad y Año nuevo 2019'),
                                      trailing: Icon(Icons.play_arrow),
                                      onTap: (){
                                        AudioService.playFromMediaId('7');
                                      }
                                    )
                                  ),Card(
                                    child: ListTile(
                                      leading: CircleAvatar(child: Image.asset("assets/icon.png")),
                                      title: Text('Tutaina 2'),
                                      subtitle: Text('Navidad y Año nuevo 2019'),
                                      trailing: Icon(Icons.play_arrow),
                                      onTap: (){
                                        AudioService.playFromMediaId('8');
                                      }
                                    )
                                  ),Card(
                                    child: ListTile(
                                      leading: CircleAvatar(child: Image.asset("assets/icon.png")),
                                      title: Text('A belen pastores'),
                                      subtitle: Text('Navidad y Año nuevo 2019'),
                                      trailing: Icon(Icons.play_arrow),
                                      onTap: (){
                                        AudioService.playFromMediaId('9');
                                      }
                                    )
                                  ),Card(
                                    child: ListTile(
                                      leading: CircleAvatar(child: Image.asset("assets/icon.png")),
                                      title: Text('pastores venid 2'),
                                      subtitle: Text('Navidad y Año nuevo 2019'),
                                      trailing: Icon(Icons.play_arrow),
                                      onTap: (){
                                        AudioService.playFromMediaId('10');
                                      }
                                    )
                                  ),Card(
                                    child: ListTile(
                                      leading: CircleAvatar(child: Image.asset("assets/icon.png")),
                                      title: Text('ven a cantar'),
                                      subtitle: Text('Navidad y Año nuevo 2019'),
                                      trailing: Icon(Icons.play_arrow),
                                      onTap: (){
                                        AudioService.playFromMediaId('11');
                                      }
                                    )
                                  ),Card(
                                    child: ListTile(
                                      leading: CircleAvatar(child: Image.asset("assets/icon.png")),
                                      title: Text('yo soy vicentico'),
                                      subtitle: Text('Navidad y Año nuevo 2019'),
                                      trailing: Icon(Icons.play_arrow),
                                      onTap: (){
                                        AudioService.playFromMediaId('12');
                                      }
                                    )
                                  ),Card(
                                    child: ListTile(
                                      leading: CircleAvatar(child: Image.asset("assets/icon.png")),
                                      title: Text('zagalillos 2'),
                                      subtitle: Text('Navidad y Año nuevo 2019'),
                                      trailing: Icon(Icons.play_arrow),
                                      onTap: (){
                                        AudioService.playFromMediaId('13');
                                      }
                                    )
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(40),
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  RaisedButton audioPlayerButton() => startButton('AudioPlayer', _audioPlayerTaskEntrypoint);

  // RaisedButton textToSpeechButton() => startButton('TextToSpeech', _textToSpeechTaskEntrypoint);

  RaisedButton startButton(String label, Function entrypoint) => RaisedButton(
    child: Text(label),
    onPressed: () {
      AudioService.start(
        backgroundTaskEntrypoint: entrypoint,
        resumeOnClick: true,
        androidNotificationChannelName: 'Audio Service Demo',
        notificationColor: 0xFF2196f3,
        androidNotificationIcon: 'mipmap/ic_launcher',
      );
    },
  );

  IconButton playButton() => IconButton(
        icon: Icon(Icons.play_arrow),
        iconSize: 64.0,
        onPressed: AudioService.play,
      );

  IconButton pauseButton() => IconButton(
        icon: Icon(Icons.pause),
        iconSize: 64.0,
        onPressed: AudioService.pause,
      );

  IconButton stopButton() => IconButton(
        icon: Icon(Icons.stop),
        iconSize: 64.0,
        onPressed: AudioService.stop,
      );

  Widget positionIndicator(MediaItem mediaItem, PlaybackState state) {
    return StreamBuilder(
      stream: Observable.combineLatest2<double, double, double>(
          _dragPositionSubject.stream,
          Observable.periodic(Duration(milliseconds: 200),
              (_) => state.currentPosition.toDouble()),
          (dragPosition, statePosition) => dragPosition ?? statePosition),
      builder: (context, snapshot) {
        var position = snapshot.data ?? 0.0;
        double duration = mediaItem?.duration?.toDouble();
        return Column(
          children: [
            Text(mediaItem.title+ " "+ "${(state.currentPosition / 1000).toStringAsFixed(3)}"),
            if (duration != null)
              Slider(
                min: 0.0,
                max: duration,
                value: max(0.0, min(position, duration)),
                onChanged: (value) {
                  _dragPositionSubject.add(value);
                },
                onChangeEnd: (value) {
                  AudioService.seekTo(value.toInt());
                  _dragPositionSubject.add(null);
                },
              ),
//            Text("${(state.currentPosition / 1000).toStringAsFixed(3)}"),
          ],
        );
      },
    );
  }
}




void _audioPlayerTaskEntrypoint() async {
  AudioServiceBackground.run(() => AudioPlayerTask());
}

class AudioPlayerTask extends BackgroundAudioTask {
  final _queue = <MediaItem>[
    MediaItem(
      id: "https://villancicos.s3.amazonaws.com/Navidad-Feliz-Navidad.mp3",
      album: "Villancicos",
      title: "Navidad Feliz Navidad",
      artist: "Navidad",
      duration: 2856950,
      artUri: "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
    ),
    MediaItem(
      id: "https://villancicos.s3.amazonaws.com/Campana-sobre-campana.mp3",
      album: "Science Friday",
      title: "Campana Sobre Campana",
      artist: "Science Friday and WNYC Studios",
      duration: 2856950,
      artUri:
          "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
    ),
    MediaItem(
      id: "https://villancicos.s3.amazonaws.com/Campanas-de-Belen.mp3",
      album: "Science Friday",
      title: "Campanas-de-Belen.mp3",
      artist: "Science Friday and WNYC Studios",
      duration: 5739820,
      artUri:
      "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
    ),
    MediaItem(
      id: "https://villancicos.s3.amazonaws.com/Cascabel.mp3",
      album: "Science Friday",
      title: "Cascabel.mp3",
      artist: "Science Friday and WNYC Studios",
      duration: 2856950,
      artUri:
      "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
    ),
    MediaItem(
      id: "https://villancicos.s3.amazonaws.com/El-nino-del-tambor.mp3",
      album: "Science Friday",
      title: "El-nino-del-tambor.mp3",
      artist: "Science Friday and WNYC Studios",
      duration: 2856950,
      artUri:
      "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
    ),
    MediaItem(
      id: "https://villancicos.s3.amazonaws.com/Mi-burrito-sabanero.mp3",
      album: "Science Friday",
      title: "Ha-nacido-El-Nino.mp3",
      artist: "Science Friday and WNYC Studios",
      duration: 2856950,
      artUri:
      "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
    ),
    MediaItem(
      id: "https://villancicos.s3.amazonaws.com/Navidad-Feliz-Navidad.mp3",
      album: "Science Friday",
      title: "Navidad-Feliz-Navidad.mp3",
      artist: "Science Friday and WNYC Studios",
      duration: 2856950,
      artUri:
      "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
    ),
    MediaItem(
      id: "https://villancicos.s3.amazonaws.com/Noche-de-paz2.mp3",
      album: "Science Friday",
      title: "Noche-de-paz2.mp3",
      artist: "Science Friday and WNYC Studios",
      duration: 2856950,
      artUri:
      "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
    ),
    MediaItem(
      id: "https://villancicos.s3.amazonaws.com/Tutaina-ver-2.mp3",
      album: "Science Friday",
      title: "Tutaina-ver-2.mp3",
      artist: "Science Friday and WNYC Studios",
      duration: 2856950,
      artUri:
      "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
    ),
    MediaItem(
      id: "https://villancicos.s3.amazonaws.com/a-belen-pastores.mp3",
      album: "Science Friday",
      title: "a-belen-pastores.mp3",
      artist: "Science Friday and WNYC Studios",
      duration: 2856950,
      artUri:
      "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
    ),
    MediaItem(
      id: "https://villancicos.s3.amazonaws.com/pastores-venid-ver-2.mp3",
      album: "Science Friday",
      title: "pastores-venid-ver-2.mp3",
      artist: "Science Friday and WNYC Studios",
      duration: 2856950,
      artUri:
      "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
    ),
    MediaItem(
      id: "https://villancicos.s3.amazonaws.com/ven-a-cantar.mp3",
      album: "Science Friday",
      title: "ven-a-cantar.mp3",
      artist: "Science Friday and WNYC Studios",
      duration: 2856950,
      artUri:
      "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
    ),
    MediaItem(
      id: "https://villancicos.s3.amazonaws.com/yo-soy-vicentico.mp3",
      album: "Science Friday",
      title: "yo-soy-vicentico.mp3",
      artist: "Science Friday and WNYC Studios",
      duration: 2856950,
      artUri:
      "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
    ),
    MediaItem(
      id: "https://villancicos.s3.amazonaws.com/zagalillos-ver-2.mp3",
      album: "Science Friday",
      title: "zagalillos-ver-2.mp3",
      artist: "Science Friday and WNYC Studios",
      duration: 2856950,
      artUri:
      "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
    ),    
  ];
  int _queueIndex = 0;
  AudioPlayer _audioPlayer = AudioPlayer();
  Completer _completer = Completer();
  int _position;

  bool get hasNext => _queueIndex + 1 < _queue.length; // true si no pasa del maximo
  bool get hasPrevious => _queueIndex > 0; // true si no pasa del minimo

  MediaItem get mediaItem => _queue[_queueIndex];

  @override
  Future<void> onStart() async {
    var playerStateSubscription = _audioPlayer.onPlayerStateChanged
        .where((state) => state == AudioPlayerState.COMPLETED)
        .listen((state) {
      _handlePlaybackCompleted();
    });
    var audioPositionSubscription =
        _audioPlayer.onAudioPositionChanged.listen((when) {
      final wasConnecting = _position == null;
      _position = when.inMilliseconds;
      if (wasConnecting) {
        // After a delay, we finally start receiving audio positions from the
        // AudioPlayer plugin, so we can broadcast the playing state.
        _setPlayState();
      }
    });

    AudioServiceBackground.setQueue(_queue);
    AudioServiceBackground.setMediaItem(mediaItem);
    _setState(state: BasicPlaybackState.connecting, position: 0);
    onPlay();
    await _completer.future;
    playerStateSubscription.cancel();
    audioPositionSubscription.cancel();
  }

  void _setPlayState() {
    _setState(state: BasicPlaybackState.playing, position: _position);
  }

  void _handlePlaybackCompleted() {
    if (hasNext) {
      onSkipToNext();
    } else {
      onStop();
    }
  }

  void playPause() {
    if (AudioServiceBackground.state.basicState == BasicPlaybackState.playing)
      onPause();
    else
      onPlay();
  }

  @override
  void changeMusic(){
    print('Change Music');
  }

  @override
  void onSkipToNext() {
    if (!hasNext) return;
    if (AudioServiceBackground.state.basicState == BasicPlaybackState.playing) {
      _audioPlayer.stop();
    }
    _queueIndex++;
    _position = null;
    _setState(state: BasicPlaybackState.skippingToNext, position: 0);
    AudioServiceBackground.setMediaItem(mediaItem);
    onPlay();
  }

  // Cambia de Cancion
  @override
  void onPlayFromMediaId(mediaId) {
    if (!hasNext) return;
    if (AudioServiceBackground.state.basicState == BasicPlaybackState.playing) {
      _audioPlayer.stop();
    }
    _queueIndex=int.parse(mediaId);
    _position = null;
    _setState(state: BasicPlaybackState.skippingToNext, position: 0);
    AudioServiceBackground.setMediaItem(mediaItem);
    onPlay();
  }

  @override
  void onSkipToPrevious() {
    if (!hasPrevious) return;
    if (AudioServiceBackground.state.basicState == BasicPlaybackState.playing) {
      _audioPlayer.stop();
    _queueIndex--;
    _position = null;
    }
    _setState(state: BasicPlaybackState.skippingToPrevious, position: 0);
    AudioServiceBackground.setMediaItem(mediaItem);
    onPlay();
  }

  @override
  void onPlay() {
    _audioPlayer.play(mediaItem.id);
    if (_position != null) {
      _setPlayState();
      // Otherwise we are still loading the audio.
    }
  }

  @override
  void onPause() {
    _audioPlayer.pause();
    _setState(state: BasicPlaybackState.paused, position: _position);
  }

  @override
  void onSeekTo(int position) {
    _audioPlayer.seek(position / 1000.0);
    final state = AudioServiceBackground.state.basicState;
    _setState(state: state, position: position);
  }

  @override
  void onClick(MediaButton button) {
    playPause();
  }

  @override
  void onStop() {
    _audioPlayer.stop();
    _setState(state: BasicPlaybackState.stopped);
    _completer.complete();
  }

  void _setState({@required BasicPlaybackState state, int position = 0}) {
    AudioServiceBackground.setState(
      controls: getControls(state),
      basicState: state,
      position: position,
    );
  }

  List<MediaControl> getControls(BasicPlaybackState state) {
    switch (state) {
      case BasicPlaybackState.playing:
        return [
          MediaControl(
            androidIcon: 'drawable/ic_action_pause',
            label: 'Pause',
            action: MediaAction.pause,
          ),
          MediaControl(
            androidIcon: 'drawable/ic_action_stop',
            label: 'Stop',
            action: MediaAction.stop,
          )
        ];
      case BasicPlaybackState.paused:
        return [
          MediaControl(
            androidIcon: 'drawable/ic_action_play_arrow',
            label: 'Play',
            action: MediaAction.play,
          ), MediaControl(
            androidIcon: 'drawable/ic_action_stop',
            label: 'Stop',
            action: MediaAction.stop,
          )];
      default:
        return [MediaControl(
          androidIcon: 'drawable/ic_action_stop',
          label: 'Stop',
          action: MediaAction.stop,
        )];
    }
  }
}




MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  keywords: <String>['flutterio', 'beautiful apps'],
  contentUrl: 'https://flutter.io',
  birthday: DateTime.now(),
  childDirected: false,
  designedForFamilies: false,
  gender: MobileAdGender.male, // or MobileAdGender.female, MobileAdGender.unknown
  testDevices: <String>[], // Android emulators are considered test devices
);

BannerAd myBanner = BannerAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  adUnitId: "ca-app-pub-5852042324891789/6702847796",
  size: AdSize.smartBanner,
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("BannerAd event is $event");
  },
);

InterstitialAd myInterstitial = InterstitialAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  adUnitId: "ca-app-pub-5852042324891789/7318775526",
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("InterstitialAd event is $event");
  },
);