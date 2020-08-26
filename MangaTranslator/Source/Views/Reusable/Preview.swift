//
//  Preview.swift
//  MangaTranslator
//
//  Created by BOWEN WU on 8/26/20.
//

import SwiftUI

struct Preview: View {
    let image: UIImage
    let previewSize: (width: CGFloat, height: CGFloat)
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: previewSize.width, height: previewSize.height, alignment: .center)
            .clipped()
    }
    
    public init(image: UIImage,
                previewSize: (width: CGFloat, height: CGFloat)) {
        self.image = image
        self.previewSize = previewSize
    }
}

struct Preview_Previews: PreviewProvider {
    static var previews: some View {
        Preview(image: UIImage(named: "manga")!,
                previewSize: (width: 100, height: 200))
    }
}
