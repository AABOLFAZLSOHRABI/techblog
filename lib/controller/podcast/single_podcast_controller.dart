import 'dart:async';
import 'package:get/get.dart';
import 'package:techblog/constant/api_constant.dart';
import 'package:techblog/models/podcast_file_model.dart';
import 'package:techblog/services/dio_service.dart';
import 'package:just_audio/just_audio.dart';

class SinglePodcastController extends GetxController {
  var id;
  RxBool loading = false.obs;
  RxList<PodcastFileModel> podcastFileList = RxList();
  final player = AudioPlayer();
  RxBool playState = false.obs;
  RxBool isLoopAll = false.obs;
  RxInt currentFileIndex = 0.obs;
  Rx<Duration> progressState = Duration.zero.obs;
  Rx<Duration> totalDuration = Duration.zero.obs;
  Rx<Duration> bufferState = Duration.zero.obs;

  SinglePodcastController({this.id});

  @override
  onInit() async {
    super.onInit();
    await getPodcastFiles();

    player.playerStateStream.listen((state) {
      playState.value = state.playing;
    });
    player.positionStream.listen((pos) {
      progressState.value = pos;
    });
    player.bufferedPositionStream.listen((bufferedPos) {
      bufferState.value = bufferedPos;
    });
    player.durationStream.listen((dur) {
      totalDuration.value = dur ?? Duration.zero;
    });
  }

  Future<void> getPodcastFiles() async {
    loading.value = true;
    var response = await DioService().getMethod(ApiUrlConstant.podcastFiles + id);
    if (response.statusCode == 200) {
      List<AudioSource> sources = [];
      for (var element in response.data["files"]) {
        var model = PodcastFileModel.fromJson(element);
        podcastFileList.add(model);
        sources.add(AudioSource.uri(Uri.parse(model.file!)));
      }
      await player.setAudioSources(sources, initialIndex: 0, initialPosition: Duration.zero);
    }
    loading.value = false;
  }
  Rx<Duration> progressValue = const Duration(seconds: 0).obs;
  Rx<Duration> bufferedValue = const Duration(seconds: 0).obs;
  Timer? timer;

  startProgress(){
    const tick = Duration(seconds: 1);
    int duration = player.duration!.inSeconds - player.position.inSeconds;
    if(timer!=null && timer!.isActive){
      timer!.cancel();
      timer = null;
    }
    timer = Timer.periodic(tick, (timer) {
      duration --;
      progressValue.value = player.position;
      bufferedValue.value = player.bufferedPosition;
      if(duration <=0){
        timer.cancel();
        progressValue.value = const Duration(seconds: 0);
        bufferedValue.value = const Duration(seconds: 0);
      }});
    }

    setLoopMode(){
      if(isLoopAll.value){
        isLoopAll.value = false;
        player.setLoopMode(LoopMode.off);
      }
      else{
        isLoopAll.value = true;
        player.setLoopMode(LoopMode.all);
      }
    }

  }
