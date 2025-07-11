import SwiftUI
import MapKit

struct Organization: Identifiable {
    let id = UUID()
    let name: String
    let address: String
    let phone: String?
    let website: String?
    let distance: Double?
}

class OrganizationSearchViewModel: ObservableObject {
    
    @Published var organization: [Organization] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var locationModel: LocationModel
    private var keyword: String
    
    init(
        locationViewModel: LocationModel,
        keyword: String
    ) {
        self.locationModel = locationViewModel
        self.keyword = keyword
    }
    
    func searchNearbyOrganizations() {
        isLoading = true
        errorMessage = nil
        organization = []
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = keyword
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
                // აქაც გმირთა მოედანი ავიღე default მნიშვნელობად
                let userLocation = CLLocation(latitude: self?.locationModel.region.center.latitude ?? 41.7132045,
                                              longitude: self?.locationModel.region.center.longitude ?? 44.7824601)
                
                self?.organization = mapItems.map { item in
                    Organization(
                        name: item.name ?? OrganizationConsts.unknown,
                        address: item.placemark.title ?? OrganizationConsts.noAddress,
                        phone: item.phoneNumber,
                        website: item.url?.absoluteString,
                        distance: item.placemark.location?.distance(from: userLocation)
                    )
                }
            }
        }
    }
}

struct OrganizationListView: View {
    
    @EnvironmentObject var locationViewModel: LocationModel
    @StateObject private var viewModel: OrganizationSearchViewModel
    @State private var searchText = ""
    
    private var organizationType: OrganizationType
    
    init(organizationType: OrganizationType) {
        self.organizationType = organizationType
        _viewModel = StateObject(wrappedValue: OrganizationSearchViewModel(locationViewModel: LocationModel(),
                                                                           keyword: organizationType.keyword))
    }
    
    private var filteredShelters: [Organization] {
        if searchText.isEmpty {
            return viewModel.organization
        } else {
            return viewModel.organization.filter { organization in
                organization.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView(organizationType.searchStateDesc)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let error = viewModel.errorMessage {
                    VStack {
                        Text("Error: \(error)")
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                        
                        Button(OrganizationConsts.retryButtonLabel) {
                            viewModel.searchNearbyOrganizations()
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
            .navigationTitle(organizationType.navTitle)
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                viewModel.searchNearbyOrganizations()
            }
            .searchable(text: $searchText, prompt: organizationType.searchTitle)
        }
    }
}

extension OrganizationListView {
    
    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Image(systemName: OrganizationConsts.notFoundImageName)
                .font(.system(size: 60))
                .foregroundColor(.secondary)
            
            VStack(spacing: 8) {
                Text(organizationType.notFoundTitle)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text(OrganizationConsts.notFoundSuggestionText)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            
            Button(OrganizationConsts.clearFilters) {
                searchText = ""
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

struct OrganizationListView_Previews: PreviewProvider {
    
    static var previews: some View {
        OrganizationListView(organizationType: .shelter)
    }
    
}
