import SwiftUI
import MapKit

struct Shelter: Identifiable {
    let id = UUID()
    let name: String
    let address: String
    let phone: String?
    let website: String?
    let distance: Double?
}

class ShelterSearchViewModel: ObservableObject {
    
    @Published var shelters: [Shelter] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var locationModel: LocationModel
    
    init(locationViewModel: LocationModel) {
        self.locationModel = locationViewModel
    }
    
    func searchNearbyAnimalShelters() {
        isLoading = true
        errorMessage = nil
        shelters = []
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "animal shelter nearby"
        request.resultTypes = .pointOfInterest
        
        request.region = locationModel.region
        
        let search = MKLocalSearch(request: request)
        search.start { [weak self] response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                    return
                }
                guard let mapItems = response?.mapItems else { return }
                
                let userLocation = CLLocation(latitude: self?.locationModel.region.center.latitude ?? 41.7132045,
                                              longitude: self?.locationModel.region.center.longitude ?? 44.7824601)
                
                self?.shelters = mapItems.map { item in
                    Shelter(
                        name: item.name ?? "Unknown",
                        address: item.placemark.title ?? "No address",
                        phone: item.phoneNumber,
                        website: item.url?.absoluteString,
                        distance: item.placemark.location?.distance(from: userLocation)
                    )
                }
            }
        }
    }
}

struct ShelterListView: View {
    
    @EnvironmentObject var locationViewModel: LocationModel
    @StateObject private var viewModel: ShelterSearchViewModel
    @State private var searchText = ""
    
    init() {
        _viewModel = StateObject(wrappedValue: ShelterSearchViewModel(locationViewModel: LocationModel()))
    }
    
    private var filteredShelters: [Shelter] {
        if searchText.isEmpty {
            return viewModel.shelters
        } else {
            return viewModel.shelters.filter { shelter in
                shelter.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Searching shelters…")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let error = viewModel.errorMessage {
                    VStack {
                        Text("Error: \(error)")
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                        
                        Button("Retry") {
                            viewModel.searchNearbyAnimalShelters()
                        }
                        .buttonStyle(.borderedProminent)
                        .padding(.top)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                } else if filteredShelters.isEmpty {
                    emptyStateView
                } else {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(filteredShelters) { shelter in
                                OrganizationCard(shelter: shelter)
                                    .padding(.horizontal)
                            }
                        }
                        .padding(.vertical)
                    }
                }
            }
            .navigationTitle("Animal Shelters")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                viewModel.searchNearbyAnimalShelters()
            }
            .searchable(text: $searchText, prompt: "Search shelters")
        }
    }
}

extension ShelterListView {
    
    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Image(systemName: "house.slash")
                .font(.system(size: 60))
                .foregroundColor(.secondary)
            
            VStack(spacing: 8) {
                Text("No Shelters Found")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text("Try adjusting your search or filters")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            
            Button("Clear Filters") {
                searchText = ""
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

struct ShelterListView_Previews: PreviewProvider {
    
    static var previews: some View {
        ShelterListView()
    }
    
}
