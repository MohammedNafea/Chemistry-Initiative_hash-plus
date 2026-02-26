import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:chemistry_initiative/core/utils/platform_image_loader.dart';
import 'package:chemistry_initiative/l10n/app_localizations.dart';

class AITutorScreen extends ConsumerStatefulWidget {
  const AITutorScreen({super.key});

  @override
  ConsumerState<AITutorScreen> createState() => _AITutorScreenState();
}

class _AITutorScreenState extends ConsumerState<AITutorScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;
  GenerativeModel? _model;
  ChatSession? _chatSession;
  bool _isDemoMode = true;
  String _modelName = 'gemini-1.5-flash';
  String _apiVersion = 'v1';
  final String _flashModel = 'gemini-1.5-flash';
  final String _flashLatestModel = 'gemini-1.5-flash-latest';
  final String _flash8bModel = 'gemini-1.5-flash-8b';
  final String _proModel = 'gemini-1.5-pro';
  final String _proLatestModel = 'gemini-1.5-pro-latest';
  final String _proExpModel = 'gemini-2.0-pro-exp-02-05';
  final String _flash2Model = 'gemini-2.0-flash';
  final String _legacyProModel = 'gemini-pro';
  int _fallbackDepth = 0;
  final ScrollController _scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;
  bool _useLegacySystemInstruction = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInit) {
      try {
        _initializeTutor();
      } catch (e) {
        debugPrint("AI Tutor initialization failed: $e");
      }
      isInit = true;
    }
  }

  bool isInit = false;

  void _initializeTutor() {
    final localizations = AppLocalizations.of(context);
    if (localizations == null) return;
    final apiKey = dotenv.env['GEMINI_API_KEY'];
 
     if (apiKey != null && apiKey.isNotEmpty && apiKey.length > 10) {
      String language;
      try {
        language = Localizations.localeOf(context).languageCode == 'ar'
            ? 'Arabic'
            : 'English';
      } catch (e) {
        language = 'Arabic'; // Fallback
      }

      debugPrint("AI Tutor: Initializing with model $_modelName (API Key check: ${apiKey.substring(0, 8)}...) - Version: $_apiVersion");
      _model = GenerativeModel(
        model: _modelName,
        apiKey: apiKey.trim(),
        requestOptions: RequestOptions(apiVersion: _apiVersion),
        systemInstruction: _useLegacySystemInstruction
            ? null
            : Content.system(localizations.aiTutorSystemInstruction(language)),
      );
      _chatSession = _model!.startChat();
      if (_messages.isEmpty) {
        _messages.add({"role": "model", "text": localizations.aiTutorGreeting});
      }
      _isDemoMode = false;
    } else {
      _model = null;
      _chatSession = null;
      _isDemoMode = true;
      if (_messages.isEmpty) {
        _messages.add({"role": "model", "text": localizations.aiTutorGreeting});
      }
    }
  }

  void _sendMessage({String? retryText, XFile? retryImage}) async {
    final localizations = AppLocalizations.of(context);
    if (localizations == null) return;
    final text = retryText ?? _controller.text.trim();
    final image = retryImage ?? _selectedImage;
    if (text.isEmpty && image == null) return;

    if (retryText == null && retryImage == null) {
      _controller.clear();
      _clearSelectedImage();
    }

    if (_chatSession == null && !_isDemoMode) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(localizations.missingApiKey)));
      return;
    }

    if (_isDemoMode) {
      _sendDemoMessage(text);
      return;
    }

    if (!mounted) return;
    String language = 'Arabic';
    try {
      final currentLocale = Localizations.localeOf(context);
      language = currentLocale.languageCode == 'ar' ? 'Arabic' : 'English';
    } catch (_) {}

    setState(() {
      if (retryText == null && retryImage == null) {
        _controller.clear();
        _messages.add({"role": "user", "text": text});
        if (image != null) {
          _messages.last["image"] = image.path;
        }
        _messages.add({"role": "model", "text": ""});
      } else {
        _messages.last["text"] = "";
      }
      _isLoading = true;
      _selectedImage = null;
    });
    _scrollToBottom();

    try {
      final List<Part> parts = [];
      if (image != null) {
        final bytes = await image.readAsBytes();
        parts.add(DataPart('image/jpeg', bytes));
      }

      String processedText = text.isEmpty
          ? "What is this chemical compound or element?"
          : text;

      // If using legacy mode and this is the first message beyond greeting, prepend instructions
      if (_useLegacySystemInstruction && _messages.length <= 3) {
        final instruction = localizations.aiTutorSystemInstruction(language);
        processedText = "[$instruction]\n\nUser Question: $processedText";
      }

      parts.add(TextPart(processedText));

      if (_chatSession == null) throw Exception("Chat session not initialized");
      final responseStream = _chatSession!.sendMessageStream(
        Content.multi(parts),
      );

      await for (final chunk in responseStream) {
        if (!mounted) return;
        setState(() {
          _messages.last["text"] =
              (_messages.last["text"] ?? "") + (chunk.text ?? "");
        });
        _scrollToBottom();
      }
    } catch (e) {
      final errorStr = e.toString();
      debugPrint("AI Tutor Error (Model: $_modelName): $errorStr");

      // FALLBACK LOGIC: Try different models incrementally or different instruction modes
      final isPayloadError =
          errorStr.contains("systemInstruction") ||
          errorStr.contains("Invalid JSON payload");

      if (isPayloadError && !_useLegacySystemInstruction) {
        debugPrint(
          "AI Tutor: System instruction rejected by API, falling back to legacy mode...",
        );
        _useLegacySystemInstruction = true;
        _initializeTutor();
        _sendMessage(retryText: text, retryImage: image);
        return;
      }

      // FALLBACK LOGIC: Try different models and API versions incrementally
      final isModelError = errorStr.contains("not found") ||
              errorStr.contains("404") ||
              errorStr.contains("not supported") ||
              errorStr.contains("is not available") ||
              errorStr.contains("400");

      if (isModelError && _fallbackDepth < 10) {
        String? nextModel = _modelName;
        String nextVersion = _apiVersion;
        _fallbackDepth++;

        // Rotate versions first for the current model if it fails
        if (_apiVersion == 'v1') {
          nextVersion = 'v1beta';
        } else {
          nextVersion = 'v1';
          // If both versions failed for current model, move to next model
          if (_modelName == _flashModel) {
            nextModel = _flashLatestModel;
          } else if (_modelName == _flashLatestModel) {
            nextModel = _flash8bModel;
          } else if (_modelName == _flash8bModel) {
            nextModel = _flash2Model;
          } else if (_modelName == _flash2Model) {
            nextModel = _proModel;
          } else if (_modelName == _proModel) {
            nextModel = _proLatestModel;
          } else if (_modelName == _proLatestModel) {
            nextModel = _proExpModel;
          } else if (_modelName == _proExpModel) {
            nextModel = _legacyProModel;
          } else {
            nextModel = null; // Out of models
          }
        }

        if (nextModel != null) {
          debugPrint(
            "AI Tutor: Attempt failed. Retrying with model $nextModel on version $nextVersion...",
          );
          _modelName = nextModel;
          _apiVersion = nextVersion;
          _initializeTutor();
          _sendMessage(retryText: text, retryImage: image);
          return;
        }
      }

      if (!mounted) return;
      
      setState(() {
        // Final fallback to Demo Mode if all AI attempts fail
        if (!_isDemoMode && (errorStr.contains("not found") || 
            errorStr.contains("supported") || 
            errorStr.contains("available") ||
            errorStr.contains("denied") ||
            errorStr.contains("location") ||
            errorStr.contains("404") ||
            errorStr.contains("403"))) {
          debugPrint("AI Tutor: Critical failure on model $_modelName. Error: $e. Switching to Demo Mode.");
          _isDemoMode = true;
          _model = null; 
          
          final arMsg = "عذراً يا بطل! يبدو أن خدمة الذكاء الاصطناعي مقيدة في منطقتك حالياً أو أن هناك عطلاً مؤقتاً.\n\n(Error Detail: ${e.toString().split('\n').first})";
          final enMsg = "Oops! It seems the AI service is restricted in your region or experiencing a temporary issue.\n\n(Error Detail: ${e.toString().split('\n').first})";
          
          _messages.last["text"] = Localizations.localeOf(context).languageCode == 'ar' ? arMsg : enMsg;
          return;
        }

        final isAuthError =
            errorStr.contains("API key not valid") ||
            errorStr.contains("invalid API key") ||
            errorStr.contains("403") ||
            errorStr.contains("401");

        String errorMsg;
        if (isAuthError) {
          errorMsg = localizations.invalidApiKeyError;
        } else {
          final modelHint = localizations.aiErrorHint;
          errorMsg = localizations.aiErrorPrefix(_modelName, e.toString()) + modelHint;
        }
        _messages.last["text"] = errorMsg;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
      _scrollToBottom();
    }
  }

  void _sendDemoMessage(String userText) async {
    final localizations = AppLocalizations.of(context)!;

    setState(() {
      _messages.add({"role": "user", "text": userText});
      _messages.add({"role": "model", "text": ""});
      _isLoading = true;
    });
    _scrollToBottom();

    await Future.delayed(const Duration(seconds: 1));

    String response = localizations.demoModeMsg;

    if (!mounted) return;
    setState(() {
      _messages.last["text"] = response;
      _isLoading = false;
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(
      source: source,
      imageQuality: 70,
    );
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  void _clearSelectedImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  /// Cross-platform image builder
  Widget _buildImage(
    String path, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
  }) {
    return buildPlatformImage(path, width: width, height: height, fit: fit);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);
    if (localizations == null) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizations.aiTutor,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: theme.colorScheme.primaryContainer,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(color: theme.colorScheme.surface),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 20.0,
                ),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  final isUser = msg['role'] == 'user';
                  final text = msg['text'] ?? '';
                  final imagePath = msg['image'];

                  if (text.isEmpty &&
                      !isUser &&
                      index == _messages.length - 1 &&
                      _isLoading) {
                    return const SizedBox.shrink();
                  }

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Column(
                      crossAxisAlignment: isUser
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: isUser
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (!isUser)
                              CircleAvatar(
                                radius: 18,
                                backgroundColor: theme.colorScheme.secondary,
                                child: const Icon(
                                  Icons.psychology,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: isUser
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  if (imagePath != null)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 8.0,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: _buildImage(
                                          imagePath,
                                          width: 200,
                                          height: 200,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                      vertical: 12.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isUser
                                          ? theme.colorScheme.primary
                                          : theme.colorScheme.secondaryContainer
                                                .withOpacity(0.5),
                                      borderRadius: BorderRadius.only(
                                        topLeft: const Radius.circular(20),
                                        topRight: const Radius.circular(20),
                                        bottomLeft: Radius.circular(
                                          isUser ? 20 : 0,
                                        ),
                                        bottomRight: Radius.circular(
                                          isUser ? 0 : 20,
                                        ),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(
                                            0.03,
                                          ),
                                          blurRadius: 5,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: MarkdownBody(
                                      data: text,
                                      selectable: true,
                                      styleSheet: MarkdownStyleSheet(
                                        p: TextStyle(
                                          color: isUser
                                              ? Colors.white
                                              : theme
                                                    .colorScheme
                                                    .onSurfaceVariant,
                                          fontSize: 16,
                                          height: 1.5,
                                        ),
                                        strong: TextStyle(
                                          color: isUser
                                              ? Colors.white
                                              : theme.colorScheme.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        listBullet: TextStyle(
                                          color: isUser
                                              ? Colors.white
                                              : theme.colorScheme.primary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (isUser)
                              CircleAvatar(
                                radius: 18,
                                backgroundColor: theme.colorScheme.primary,
                                child: const Icon(
                                  Icons.person,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            if (_isLoading && _messages.isNotEmpty && _messages.last["text"]!.isEmpty)
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      localizations.thinking,
                      style: TextStyle(color: theme.colorScheme.outline),
                    ),
                  ],
                ),
              ),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_selectedImage != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: _buildImage(
                                _selectedImage!.path,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 4,
                              right: 4,
                              child: GestureDetector(
                                onTap: _clearSelectedImage,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: Colors.black54,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => _pickImage(ImageSource.camera),
                          icon: Icon(
                            Icons.camera_alt_rounded,
                            color: theme.colorScheme.primary,
                          ),
                          style: IconButton.styleFrom(
                            backgroundColor: theme.colorScheme.primaryContainer
                                .withOpacity(0.4),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: () => _pickImage(ImageSource.gallery),
                          icon: Icon(
                            Icons.photo_library_rounded,
                            color: theme.colorScheme.primary,
                          ),
                          style: IconButton.styleFrom(
                            backgroundColor: theme.colorScheme.primaryContainer
                                .withOpacity(0.4),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            textDirection: isAr
                                ? TextDirection.rtl
                                : TextDirection.ltr,
                            onSubmitted: (_) => _sendMessage(),
                            decoration: InputDecoration(
                              hintText: localizations.aiTutorHint,
                              hintStyle: TextStyle(
                                color: theme.colorScheme.outline,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: theme
                                  .colorScheme
                                  .surfaceContainerHighest
                                  .withOpacity(0.4),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 14,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: _sendMessage,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: theme.colorScheme.primary.withOpacity(
                                    0.3,
                                  ),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.send_rounded,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
