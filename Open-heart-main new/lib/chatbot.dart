import 'package:flutter/material.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final List<Map<String, String>> messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final Map<String, String> botResponses = {
    'hello': 'Hi there! 👋 How can I help you with donations or campaigns?',
    'how to donate': 'You can click "Start A Donation Campaign" on the home page or "Support A Campaign".',
    'leaderboard': 'Check out the leaderboard on the leaderboard page.',
    'how to get points': 'You can get points by donating for charity programs.',
    'donate': 'We accept donations through our campaigns. Tap the "Donate" button on any active campaign.',
    'report': 'You can submit a report from the "Report" section in the bottom menu.',
    'report an issue': 'To report an issue, go to the "Report Problem" section from the home screen.',
    'contact': 'You can contact us via email at **admin@openheart.com** or call +123 456 7890.',
    'bye': 'Goodbye! 👋 Stay kind and generous!',
    'help': 'I can help you donate, report, volunteer, or find info about our campaigns.',
  };

  final List<String> quickReplies = [
    'How to donate',
    'Leaderboard',
    'How to get points',
    'Report an issue',
    'Contact',
    'Help'
  ];

  @override
  void initState() {
    super.initState();
    messages.add({
      "role": "bot",
      "text": "👋 Welcome to Open Heart! How can I help you today?",
    });
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      messages.add({"role": "user", "text": text.trim()});
    });

    _controller.clear();
    _generateBotResponse(text.toLowerCase().trim());
    _scrollToBottom();
  }

  void _generateBotResponse(String userInput) {
    String response = "🤖 I'm not sure about that. Please contact support at openheartteamz@gmail.com.";

    botResponses.forEach((key, value) {
      if (userInput.contains(key)) {
        response = value;
      }
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        messages.add({"role": "bot", "text": response});
      });
      _scrollToBottom();
    });
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

  Widget _buildQuickReplies() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 12, bottom: 8),
      child: Wrap(
        spacing: 8,
        children: quickReplies.map((label) {
          return ActionChip(
            label: Text(label),
            backgroundColor: Colors.blue.shade100,
            labelStyle: const TextStyle(color: Colors.black87),
            onPressed: () => _sendMessage(label),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        leading: IconButton(
          icon: Image.asset('Assets/icons/back.png', height: 22),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Chat with Us",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isUser = message["role"] == "user";
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    constraints: const BoxConstraints(maxWidth: 280),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue.shade100 : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      message["text"] ?? "",
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                );
              },
            ),
          ),
          _buildQuickReplies(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.blue.shade100)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      hintText: "Type your message...",
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => _sendMessage(_controller.text),
                  child: Image.asset('Assets/icons/send.png', height: 28),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
