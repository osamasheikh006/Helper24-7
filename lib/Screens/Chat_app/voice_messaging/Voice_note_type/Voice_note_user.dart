import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';


class voice_note extends StatefulWidget {
  const voice_note({Key? key}) : super(key: key);

  @override
  State<voice_note> createState() => _voice_noteState();
}

class _voice_noteState extends State<voice_note> {
  final recorder=FlutterSoundRecorder();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initRecorder();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    recorder.closeRecorder();
    super.dispose();
  }

  Future initRecorder() async {
    final status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      throw 'Microphone permission not granted';
    }
    await recorder.openRecorder();
  }


  Future stop() async {
    await recorder.stopRecorder();
  }

  Future record() async {
    await recorder.startRecorder(toFile: 'audio');

  }


  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.grey.shade300,
    body: Center(
      child:Column(
        children: [
          StreamBuilder<RecordingDisposition>(
            stream: recorder.onProgress,
            builder: (context,snapshot){
              final duration = snapshot.hasData
                  ?snapshot.data!.duration
                  :Duration.zero;
              return Text('${duration.inSeconds}s');
            }
          ),
      const SizedBox(height: 32),
      ElevatedButton(
          child: Icon(
            recorder.isRecording? Icons.stop:Icons.mic,
            size: 20,
          ), onPressed: () async {
    if (recorder.isRecording) {
    await stop();
    }
    else {
    await record();
    }
    },

    )
      ],
    ),

    ),
  );
   // return Container();

}
