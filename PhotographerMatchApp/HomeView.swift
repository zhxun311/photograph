import SwiftUI

struct HomeView: View {
    @State private var photographers = [
        Photographer(name: "摄影师 A", styles: ["自然", "人像"], color: .blue.opacity(0.8), sampleImage: Image(systemName: "photo")),
        Photographer(name: "摄影师 B", styles: ["电影感", "风景"], color: .green.opacity(0.8), sampleImage: Image(systemName: "photo")),
        Photographer(name: "摄影师 C", styles: ["时尚", "街拍"], color: .purple.opacity(0.8), sampleImage: Image(systemName: "photo")),
    ]
    @State private var favoriteStatuses: Set<UUID> = []
    @State private var selectedPhotographer: Photographer? // 用于存储选中的摄影师

    var body: some View {
        NavigationView {
            VStack {
                TabView {
                    ForEach(photographers) { photographer in
                        // 用 NavigationLink 包裹卡片，点击后跳转
                        NavigationLink(
                            destination: PhotographerDetailView(photographer: photographer),
                            tag: photographer.id, // 使用 tag 确保绑定正确的摄影师
                            selection: Binding(
                                get: { selectedPhotographer?.id },
                                set: { newID in
                                    selectedPhotographer = photographers.first(where: { $0.id == newID })
                                }
                            )
                        ) {
                            PhotographerCardView(
                                photographerName: photographer.name,
                                styles: photographer.styles,
                                sampleImage: photographer.sampleImage,
                                backgroundColor: photographer.color,
                                isFavorited: Binding(
                                    get: { favoriteStatuses.contains(photographer.id) },
                                    set: { isFavorited in
                                        if isFavorited {
                                            favoriteStatuses.insert(photographer.id)
                                        } else {
                                            favoriteStatuses.remove(photographer.id)
                                        }
                                    }
                                )
                            )
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .frame(height: UIScreen.main.bounds.height * 0.75)
                
                Spacer()
                
                NavigationLink(destination: FavoritesView(favoritePhotographers: .constant(photographers.filter { favoriteStatuses.contains($0.id) }), favoriteStatuses: $favoriteStatuses)) {
                    Text("查看收藏的摄影师")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .background(Color(.systemBackground))
            .navigationTitle("浏览摄影师")
        }
    }
}
