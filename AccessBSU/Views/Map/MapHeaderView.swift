//
//  MapHeaderView.swift
//  AccessBSU
//
//  Created by Jaylen Smith on 4/2/24.
//

import SwiftUI
import MapKit
import WeatherKit
 
enum MapType: CaseIterable, Identifiable {
    case satellite, standard
    
    var id: Self { self }
    
    var type: MKMapType {
        switch self {
        case .satellite:
            return .satellite
        case .standard:
            return .standard
        }
    }
    
    var title: String {
        switch self {
        case .satellite:
            return "Satellite"
        case .standard:
            return "Standard"
        }
    }
}

struct MapHeaderView: View {
    
    @State private var weather: Weather?
    
    @EnvironmentObject var mapVM: MapViewModel
    
    var body: some View {
        HStack {
            HStack(spacing: 7) {
                Text("BSU")
                    .font(.system(size: 30)).fontWeight(.heavy)
                HStack(spacing: 2) {
                    Image(systemName: "sun.max.fill")
                        .foregroundColor(.yellow)
                    Text("75ºF")
                }
                .font(.system(size: 18)).fontWeight(.bold)
            }
            Spacer()
            Menu {
                Section("Map Type") {
                    Picker("Map Type", selection: $mapVM.mapType) {
                        ForEach(MapType.allCases) {
                            Text($0.title)
                                .tag($0)
                        }
                    }
                }
            } label: {
                Image(systemName: "map")
                    .font(.system(size: 22))
                    .foregroundColor(.label)
            }
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(15)
        .background(Color(uiColor: .secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray.opacity(0.2))
        }
        .padding()
    }
    
//    private func fetchWeather() async {
//        let service = WeatherService()
//        do {
//            let weather = try await service.weather(for: .bowieStateUniversity)
//            DispatchQueue.main.async {
//                self.weather = weather
//            }
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
}

#Preview {
    MapHeaderView()
        .environmentObject(MapViewModel())
}
