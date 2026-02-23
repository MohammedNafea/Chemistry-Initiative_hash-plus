import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:chemistry_initiative/l10n/app_localizations.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import 'package:permission_handler/permission_handler.dart';

class MultiplayerQuizScreen extends StatefulWidget {
  const MultiplayerQuizScreen({super.key});

  @override
  State<MultiplayerQuizScreen> createState() => _MultiplayerQuizScreenState();
}

class _MultiplayerQuizScreenState extends State<MultiplayerQuizScreen> {
  late NearbyService nearbyService;
  StreamSubscription? subscription;
  StreamSubscription? receivedDataSubscription;

  List<Device> devices = [];
  Device? connectedDevice;
  bool isInit = false;

  final String _serviceType = 'chemquiz';

  // Quiz State
  bool isHost = false;
  String currentQuestion = '';
  List<String> currentOptions = [];
  String correctAnswer = '';
  int hostScore = 0;
  int guestScore = 0;
  String waitingMessage = 'Waiting for Host to send a question...';

  final List<Map<String, dynamic>> _sampleQuestions = [
    {
      "question": "What is the chemical formula for Water?",
      "options": ["H2O", "CO2", "O2", "NaCl"],
      "answer": "H2O",
    },
    {
      "question": "Which element has the atomic number 1?",
      "options": ["Helium", "Hydrogen", "Carbon", "Oxygen"],
      "answer": "Hydrogen",
    },
    {
      "question": "What is the primary gas in Earth's atmosphere?",
      "options": ["Oxygen", "Nitrogen", "Carbon Dioxide", "Argon"],
      "answer": "Nitrogen",
    },
  ];

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    subscription?.cancel();
    receivedDataSubscription?.cancel();
    nearbyService.stopAdvertisingPeer();
    nearbyService.stopBrowsingForPeers();
    super.dispose();
  }

  void init() async {
    await [
      Permission.bluetooth,
      Permission.bluetoothAdvertise,
      Permission.bluetoothConnect,
      Permission.bluetoothScan,
      Permission.location,
    ].request();

    nearbyService = NearbyService();
    await nearbyService.init(
      serviceType: _serviceType,
      deviceName:
          'Student_${DateTime.now().millisecondsSinceEpoch.toString().substring(10)}',
      strategy: Strategy.P2P_STAR,
      callback: (isRunning) async {
        if (isRunning) {
          await nearbyService.stopAdvertisingPeer();
          await nearbyService.stopBrowsingForPeers();
          await Future.delayed(const Duration(milliseconds: 200));
          await nearbyService.startAdvertisingPeer();
          await nearbyService.startBrowsingForPeers();
        }
      },
    );

    subscription = nearbyService.stateChangedSubscription(
      callback: (devicesList) {
        if (!mounted) return;
        setState(() {
          devices = devicesList;
          connectedDevice = devicesList.cast<Device?>().firstWhere(
            (d) => d?.state == SessionState.connected,
            orElse: () => null,
          );
          if (connectedDevice == null) {
            _resetQuizState();
          }
        });
      },
    );

    receivedDataSubscription = nearbyService.dataReceivedSubscription(
      callback: (data) {
        if (!mounted) return;
        final payload = jsonDecode(data["message"]);
        _handleMessage(payload);
      },
    );

    setState(() {
      isInit = true;
    });
  }

  void _resetQuizState() {
    currentQuestion = '';
    currentOptions = [];
    correctAnswer = '';
    hostScore = 0;
    guestScore = 0;
    isHost = false;
    waitingMessage = 'Waiting for Host to send a question...';
  }

  void _handleMessage(Map<String, dynamic> payload) {
    if (payload['type'] == 'question') {
      setState(() {
        currentQuestion = payload['question'];
        currentOptions = List<String>.from(payload['options']);
        correctAnswer = payload['answer'];
        waitingMessage = '';
      });
    } else if (payload['type'] == 'answer') {
      final choice = payload['choice'];
      if (choice == correctAnswer) {
        guestScore++;
      } else {
        hostScore++;
      }
      setState(() {
        currentQuestion = '';
      });
      // Send updated score
      nearbyService.sendMessage(
        connectedDevice!.deviceId,
        jsonEncode({"type": "score", "host": hostScore, "guest": guestScore}),
      );
    } else if (payload['type'] == 'score') {
      setState(() {
        hostScore = payload['host'];
        guestScore = payload['guest'];
        currentQuestion = '';
        waitingMessage = 'Waiting for next question...';
      });
    }
  }

  void _sendQuestion(Map<String, dynamic> q) {
    setState(() {
      currentQuestion = q['question'];
      currentOptions = List<String>.from(q['options']);
      correctAnswer = q['answer'];
    });
    nearbyService.sendMessage(
      connectedDevice!.deviceId,
      jsonEncode({
        "type": "question",
        "question": currentQuestion,
        "options": currentOptions,
        "answer": correctAnswer,
      }),
    );
  }

  void _answerQuestion(String choice) {
    if (choice == correctAnswer) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Correct!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Wrong!'), backgroundColor: Colors.red),
      );
    }
    nearbyService.sendMessage(
      connectedDevice!.deviceId,
      jsonEncode({"type": "answer", "choice": choice}),
    );
    setState(() {
      currentQuestion = '';
      waitingMessage = 'Waiting for Host...';
    });
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    if (!isInit) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(local.multiplayerQuiz),
        actions: [
          if (connectedDevice != null)
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                nearbyService.disconnectPeer(
                  deviceID: connectedDevice!.deviceId,
                );
              },
            ),
        ],
      ),
      body: connectedDevice != null
          ? _buildQuizArea(local)
          : _buildDiscoveryArea(local),
    );
  }

  Widget _buildDiscoveryArea(AppLocalizations local) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            local.challengingPlayers,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: devices.length,
            itemBuilder: (context, index) {
              final device = devices[index];
              return ListTile(
                leading: const Icon(Icons.person),
                title: Text(device.deviceName),
                subtitle: Text(_getStateName(device.state)),
                trailing: _getButtonState(device, local),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildQuizArea(AppLocalizations local) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${local.hostScore}: $hostScore',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${local.guestScore}: $guestScore',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          if (currentQuestion.isNotEmpty) ...[
            Text(
              currentQuestion,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ...currentOptions.map(
              (opt) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (isHost) return; // Host just watches the question
                    _answerQuestion(opt);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(opt, style: const TextStyle(fontSize: 18)),
                  ),
                ),
              ),
            ),
          ] else if (isHost) ...[
            const Text(
              'Select a question to send:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ..._sampleQuestions.map(
              (q) => ListTile(
                title: Text(q['question']),
                trailing: const Icon(Icons.send),
                onTap: () => _sendQuestion(q),
                tileColor: Theme.of(
                  context,
                ).colorScheme.primaryContainer.withValues(alpha: 0.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ] else ...[
            Center(
              child: Text(waitingMessage, style: const TextStyle(fontSize: 18)),
            ),
          ],
        ],
      ),
    );
  }

  String _getStateName(SessionState state) {
    switch (state) {
      case SessionState.notConnected:
        return 'Not Connected';
      case SessionState.connecting:
        return 'Connecting...';
      case SessionState.connected:
        return 'Connected';
    }
  }

  Widget _getButtonState(Device device, AppLocalizations local) {
    switch (device.state) {
      case SessionState.notConnected:
        return ElevatedButton(
          onPressed: () {
            isHost = true; // The one who invites becomes the Host
            nearbyService.invitePeer(
              deviceID: device.deviceId,
              deviceName: device.deviceName,
            );
          },
          child: Text(local.inviteHost),
        );
      case SessionState.connecting:
        return const CircularProgressIndicator();
      case SessionState.connected:
        return ElevatedButton(
          onPressed: () {
            nearbyService.disconnectPeer(deviceID: device.deviceId);
          },
          child: const Text('Disconnect'),
        );
    }
  }
}
