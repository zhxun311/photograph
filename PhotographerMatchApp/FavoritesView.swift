import SwiftUI

struct FavoritesView: View {
    @Binding var favoritePhotographers: [Photographer]
    @Binding var favoriteStatuses: Set<UUID>
    @State private var selectedPhotographer: Photographer? // 用于存储选中的摄影师
    @State private var animatingID: UUID?

    // 排序和搜索相关的状态
    @State private var sortOption: SortOption = .name
    @State private var searchText: String = ""

    enum SortOption: String, CaseIterable {
        case name = "名称"
        case style = "风格"
    }
    
    private var filteredAndSortedPhotographers: [Photographer] {
        let filtered = favoritePhotographers.filter { photographer in
            searchText.isEmpty || photographer.name.localizedCaseInsensitiveContains(searchText)
        }
        
        switch sortOption {
        case .name:
            return filtered.sorted { $0.name < $1.name }
        case .style:
            return filtered.sorted { $0.styles.joined(separator: ", ") < $1.styles.joined(separator: ", ") }
        }
    }

    var body: some View {
        VStack {
            // 搜索栏
            TextField("搜索摄影师", text: $searchText)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
            
            // 排序选项
            Picker("排序方式", selection: $sortOption) {
                ForEach(SortOption.allCases, id: \.self) { option in
                    Text(option.rawValue).tag(option)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            
            List {
                ForEach(filteredAndSortedPhotographers) { photographer in
                    // NavigationLink 包裹每个收藏的摄影师，点击跳转到详情页面
                    NavigationLink(destination: PhotographerDetailView(photographer: photographer)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(photographer.name)
                                    .font(.headline)
                                Text(photographer.styles.joined(separator: ", "))
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            
                            // 收藏按钮，仅点击爱心时触发取消收藏
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    animatingID = photographer.id
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    withAnimation(.easeInOut(duration: 0.3)) {
                                        removeFavorite(photographer)
                                    }
                                }
                            }) {
                                Image(systemName: animatingID == photographer.id ? "heart" : "heart.fill")
                                    .foregroundColor(animatingID == photographer.id ? .gray : .red)
                                    .animation(.easeInOut, value: animatingID)
                            }
                            .buttonStyle(BorderlessButtonStyle()) // 确保按钮只作用于爱心图标
                        }
                        .padding(.vertical, 8)
                        .opacity(animatingID == photographer.id ? 0 : 1) // 控制透明度
                        .transition(.opacity) // 淡出效果
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
        .navigationTitle("收藏的摄影师")
    }

    // 取消收藏的函数
    private func removeFavorite(_ photographer: Photographer) {
        favoriteStatuses.remove(photographer.id)
        favoritePhotographers.removeAll { $0.id == photographer.id }
        animatingID = nil // 重置动画ID
    }
}
