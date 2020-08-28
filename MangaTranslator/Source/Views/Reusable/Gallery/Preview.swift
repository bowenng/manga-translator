//
//  Preview.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/26/20.
//

import SwiftUI

struct Preview: View {
    let image: UIImage
    let config: Preview.Config
    let options: [ButtonViewData]
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .contextMenu {
                ForEach(options) { option in
                    ContextMenuButton(viewData: option)
                }
            }
            .frame(width: config.previewSize.width, height: config.previewSize.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .cornerRadius(config.cornerRadiusSize)
            .shadow(radius: config.shadowRadiusSize)
    }
    
    public init(image: UIImage,
                config: Preview.Config,
                options: [ButtonViewData] = []) {
        self.image = image
        self.config = config
        self.options = options
    }
}

extension Preview {
    struct Config {
        let previewSize: (width: CGFloat, height: CGFloat)
        let cornerRadiusSize: CGFloat
        let paddingSize: CGFloat
        let shadowRadiusSize: CGFloat
    }
}

struct Preview_Previews: PreviewProvider {
    static var previews: some View {
        Preview(image: UIImage(named: "manga")!,
                config: Preview.Config(previewSize: (width: 200, height: 200), cornerRadiusSize: 5.0, paddingSize: 5.0, shadowRadiusSize: 5.0))
    }
}
