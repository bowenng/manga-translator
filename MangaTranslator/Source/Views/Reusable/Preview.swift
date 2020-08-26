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
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: config.previewSize.width, height: config.previewSize.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .clipped()
            .cornerRadius(config.cornerRadiusSize)
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, config.paddingSize)
    }
    
    public init(image: UIImage,
                config: Preview.Config) {
        self.image = image
        self.config = config
    }
}

extension Preview {
    struct Config {
        let previewSize: (width: CGFloat, height: CGFloat)
        let cornerRadiusSize: CGFloat
        let paddingSize: CGFloat
    }
}

struct Preview_Previews: PreviewProvider {
    static var previews: some View {
        Preview(image: UIImage(named: "manga")!,
                config: Preview.Config(previewSize: (width: 200, height: 200), cornerRadiusSize: 5.0, paddingSize: 5.0))
    }
}
