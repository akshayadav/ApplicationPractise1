//
//  MessagesView.swift
//  NRIOneSample1
//
//  Created by Akshay Yadav on 3/5/26.
//

import SwiftUI

struct MessagesView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var conversations: [Conversation] = [
        Conversation(
            id: UUID(),
            name: "Danube Properties",
            lastMessage: "Thank you for your interest in our Dubai project",
            timestamp: Date(),
            unreadCount: 2
        ),
        Conversation(
            id: UUID(),
            name: "NRI Support Team",
            lastMessage: "Your document verification is complete",
            timestamp: Date().addingTimeInterval(-3600),
            unreadCount: 0
        )
    ]
    
    var body: some View {
        NavigationStack {
            List(conversations) { conversation in
                NavigationLink {
                    ConversationDetailView(conversation: conversation)
                } label: {
                    HStack(spacing: 12) {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 50, height: 50)
                            .overlay {
                                Text(conversation.name.prefix(1))
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                            }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(conversation.name)
                                .font(.headline)
                            
                            Text(conversation.lastMessage)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .lineLimit(1)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing, spacing: 4) {
                            Text(conversation.timestamp, style: .relative)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            
                            if conversation.unreadCount > 0 {
                                Text("\(conversation.unreadCount)")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                                    .frame(width: 20, height: 20)
                                    .background(Color.red)
                                    .clipShape(Circle())
                            }
                        }
                    }
                }
            }
            .navigationTitle("Messages")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct Conversation: Identifiable {
    let id: UUID
    let name: String
    let lastMessage: String
    let timestamp: Date
    let unreadCount: Int
}

struct ConversationDetailView: View {
    let conversation: Conversation
    @State private var messageText = ""
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 16) {
                    MessageBubble(
                        text: conversation.lastMessage,
                        isFromUser: false,
                        timestamp: conversation.timestamp
                    )
                    
                    MessageBubble(
                        text: "Hi, I'm interested in learning more about your properties.",
                        isFromUser: true,
                        timestamp: Date()
                    )
                }
                .padding()
            }
            
            Divider()
            
            HStack(spacing: 12) {
                TextField("Message", text: $messageText)
                    .textFieldStyle(.roundedBorder)
                
                Button {
                    // Send message
                    messageText = ""
                } label: {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.title2)
                        .foregroundStyle(Color(red: 0.7, green: 0.2, blue: 0.2))
                }
            }
            .padding()
        }
        .navigationTitle(conversation.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MessageBubble: View {
    let text: String
    let isFromUser: Bool
    let timestamp: Date
    
    var body: some View {
        HStack {
            if isFromUser { Spacer() }
            
            VStack(alignment: isFromUser ? .trailing : .leading, spacing: 4) {
                Text(text)
                    .padding(12)
                    .background(isFromUser ? Color.blue : Color.gray.opacity(0.2))
                    .foregroundStyle(isFromUser ? .white : .primary)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                
                Text(timestamp, style: .time)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
            
            if !isFromUser { Spacer() }
        }
    }
}

#Preview {
    MessagesView()
}
