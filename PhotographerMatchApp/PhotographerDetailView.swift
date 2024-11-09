import SwiftUI

struct PhotographerDetailView: View {
    let photographer: Photographer

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(photographer.name)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("风格: \(photographer.styles.joined(separator: ", "))")
                .font(.title3)
                .foregroundColor(.secondary)
            
            photographer.sampleImage
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 300)
                .cornerRadius(10)
            
            // 示例简介和联系方式
            Text("关于摄影师")
                .font(.headline)
                .padding(.top)
            
            Text("这里可以添加摄影师的详细简介或个人介绍，包含他们的经验、擅长领域等。")
            
            Text("联系方式")
                .font(.headline)
                .padding(.top)
            
            Text("邮箱: example@photographer.com")
            Text("电话: 123-456-7890")
            
            Spacer()
        }
        .padding()
        .navigationTitle("摄影师详情")
    }
}
