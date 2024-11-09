import SwiftUI

struct PhotographerCardView: View {
    let photographerName: String
    let styles: [String] // 摄影师风格标签
    let sampleImage: Image // 摄影师样片
    let backgroundColor: Color // 底色
    @Binding var isFavorited: Bool

    var body: some View {
        ZStack {
            // 卡片背景色，略小一些的尺寸
            Rectangle()
                .fill(backgroundColor)
                .frame(width: UIScreen.main.bounds.width * 0.85, height: UIScreen.main.bounds.height * 0.65)
                .cornerRadius(20)
                .shadow(radius: 10)
            
            VStack(alignment: .leading, spacing: 10) {
                // 顶部区域：名称和收藏标志
                HStack {
                    Text(photographerName)
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding(.leading, 20)
                        .padding(.top, 20)
                    
                    Spacer()
                    
                    Button(action: {
                        isFavorited.toggle() // 切换收藏状态
                    }) {
                        Image(systemName: isFavorited ? "heart.fill" : "heart")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.orange)
                            .padding(.trailing, 20)
                            .padding(.top, 20)
                    }
                }
                
                Spacer()
                
                // 样片展示区域
                sampleImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width * 0.75, height: UIScreen.main.bounds.height * 0.35)
                    .cornerRadius(15)
                    .padding(.horizontal, 20)
                
                // 风格标签展示区域
                HStack {
                    ForEach(styles, id: \.self) { style in
                        Text(style)
                            .font(.subheadline)
                            .padding(8)
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(8)
                            .foregroundColor(.white)
                    }
                }
                .padding(.leading, 20)
                .padding(.bottom, 20)
            }
            .frame(width: UIScreen.main.bounds.width * 0.85, height: UIScreen.main.bounds.height * 0.65)
        }
    }
}
