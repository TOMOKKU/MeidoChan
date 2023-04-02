//
//  ContentView.swift
//  MeidoChan
//
//  Created by Toki Fukumoto on 2023/04/02.
//

import SwiftUI
import CoreData
import OpenAISwift
struct ContentView: View {
    
    @State private var inputText = ""
    @State private var messageArray: [String] = []
    
    private var client = OpenAISwift(authToken: "")
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(messageArray, id: \.self) { message in
                Text(message)
                Spacer()
            }
            HStack {
                TextField("ここに質問を入力", text: $inputText)
                Button("送信") {
                    send()
                }
            }
        }
        .padding()
    }
    
    func send() {
        guard !inputText.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        messageArray.append("自分: \(inputText)")
        client.sendCompletion(with: inputText, maxTokens: 500, completionHandler: { result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    let output = model.choices.first?.text ?? ""
                    self.messageArray.append("ChatGPT: \(output)")
                    self.inputText = ""
                }
            case .failure:
                break
            }
        })
    }
}
