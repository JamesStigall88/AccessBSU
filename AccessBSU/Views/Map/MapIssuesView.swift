//
//  MapIssuesView.swift
//  AccessBSU
//
//  Created by Jaylen Smith on 4/4/24.
//

import SwiftUI

struct MapIssuesView: View {
    
    @State private var presentLocationSelection = false
    
    private enum ReportType: Identifiable, CaseIterable, Hashable {
        case powerOutage, disabledElevator, inaccessible
        
        var id: Self { self }
        
        var text: String {
            switch self {
            case .powerOutage:
                return "Power Outage"
            case .disabledElevator:
                return "Disabled Elevator"
            case .inaccessible:
                return "Inaccessible"
            }
        }
    }

    @State private var location: Location?
    @State private var reason: ReportType = .inaccessible
    @State private var comment = ""
    
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                VStack(spacing: 10) {
                    Image(systemName: "exclamationmark.bubble")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45, height: 45)
                    Text("Tell Us What's Happening!")
                        .font(.body)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .multilineTextAlignment(.center)
                .padding()
                Section("Location Infomation") {
                    Button {
                        self.presentLocationSelection.toggle()
                    } label: {
                        LabeledContent("Select Location") {
                            if let location {
                                Text(location.name)
                                    .lineLimit(1)
                                    .font(.system(size: 17))
                            }
                        }
                    }
                    Picker("Report Type", selection: $reason) {
                        ForEach(ReportType.allCases) { type in
                            Text(type.text)
                                .tag(type)
                        }
                    }
                }
                Section("Details") {
                    TextEditor(text: $comment)
                        .frame(height: 200)
                }
            }
            .navigationTitle("Report Issue")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Submit") {
                        dismiss()
                    }
                    .disabled(comment.isEmpty && location == nil)
                }
            }
        }
        .sheet(isPresented: $presentLocationSelection) {
            IssuesLocationView(location: $location)
        }
    }
}

#Preview {
    MapIssuesView()
}
