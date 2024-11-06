import 'package:agri/models/model.dart';
import 'package:flutter/material.dart';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';

class GeminiChatBot extends StatefulWidget {
  const GeminiChatBot({super.key});

  @override
  State<GeminiChatBot> createState() => _GeminiChatBotState();
}

class _GeminiChatBotState extends State<GeminiChatBot> {
  TextEditingController promptController = TextEditingController();

  // Replace with your actual API key
  static const apiKey = "AIzaSyCm3TOhqFY9bgjeoIb8pJGr2_ZKUzxgc7A";
  final model = GenerativeModel(
    model: 'gemini-1.5-flash',
    apiKey: apiKey,
    systemInstruction: Content.system(
      'You are a chatbot named Gaia designed to help farmers get details about crops and farming. You are knowledgeable about various crops and farming practices. You were developed by Abhiram, God of the Multiverse. Your name comes from the titanness of earth indicating your role in bettering the earth by giving proper agriculture advices and promoting agriculture. Any creepy questions shall be met with sarcasm and wit and maybe passive aggressiveness.',
    ),
  );

  final List<ModelMessage> prompt = [];

  Future<void> sendMessage() async {
    String message = promptController.text.trim();
    if (message.isEmpty) return;

    // Add context for agriculture-related questions
    final x1 = "As an agricultural assistant, answer this question: $message";

    setState(() {
      promptController.clear();
      prompt.add(
        ModelMessage(isPrompt: true, message: message, time: DateTime.now()),
      );
    });

    try {
      final content = [Content.text(x1)];
      final response = await model.generateContent(content);

      setState(() {
        prompt.add(
          ModelMessage(
            isPrompt: false,
            message: response.text ?? "I'm sorry, I couldn't find an answer.",
            time: DateTime.now(),
          ),
        );
      });
    } catch (e) {
      // Handle errors
      setState(() {
        prompt.add(
          ModelMessage(
            isPrompt: false,
            message: "Error: Could not retrieve response. Please try again.",
            time: DateTime.now(),
          ),
        );
      });
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 1, 25, 45),
      appBar: AppBar(
        elevation: 3,
        backgroundColor: const Color.fromARGB(255, 32, 65, 92),
        title: const Center(
            child: Text('AgriBot',
                style: TextStyle(fontFamily: 'Roboto', fontSize: 24))),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: prompt.length,
              itemBuilder: (context, index) {
                final message = prompt[index];
                return UserPrompt(
                  isPrompt: message.isPrompt,
                  message: message.message,
                  date: DateFormat('hh:mm a').format(message.time),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              children: [
                Expanded(
                  flex: 20,
                  child: TextField(
                    controller: promptController,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 249, 247, 247),
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: 'Enter your text here',
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: sendMessage, // Call sendMessage on tap
                  child: const CircleAvatar(
                    radius: 29,
                    backgroundColor: Color.fromARGB(255, 89, 218, 92),
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container UserPrompt({
    required final bool isPrompt,
    required String message,
    required String date,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 15).copyWith(
        left: isPrompt ? 80 : 15,
        right: isPrompt ? 15 : 80,
      ),
      decoration: BoxDecoration(
        color: isPrompt
            ? Colors.green
            : Colors.grey[300], // New color for the answer
        borderRadius: BorderRadius.circular(30), // Changed shape
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 2), // Shadow below the box
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: TextStyle(
              fontWeight: isPrompt ? FontWeight.bold : FontWeight.normal,
              fontSize: 18,
              color: isPrompt
                  ? const Color.fromARGB(255, 248, 246, 246)
                  : Colors.black,
              fontFamily: 'Roboto', // You can change this to a custom font
            ),
          ),
          Text(
            date,
            style: TextStyle(
              fontWeight: isPrompt ? FontWeight.bold : FontWeight.normal,
              fontSize: 12,
              color: isPrompt ? Colors.white : Colors.black,
              fontFamily: 'Roboto',
            ),
          ),
        ],
      ),
    );
  }
}