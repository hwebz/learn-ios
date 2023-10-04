//
//  ContentView.swift
//  PhotoGallery
//
//  Created by Personal on 04/10/2023.
//

import SwiftUI

struct ImageCollection {
    let name: String
    let images: [String]
}

struct HighlightView: View {
    private let images: [String] = [
        "nature_1",
        "nature_2",
        "nature_3",
        "nature_4",
        "nature_5"
    ]
    
    private let collections: [ImageCollection] = [
        ImageCollection(name: "Collection 1", images: [
            "nature_1",
            "nature_2",
            "nature_3",
            "nature_4",
            "nature_5"
        ]),
        ImageCollection(name: "Collection 2", images: [
            "nature_1",
            "nature_4",
            "nature_5"
        ]),
        ImageCollection(name: "Collection 3", images: [
            "nature_1",
            "nature_2",
            "nature_3"
        ])
    ]
    
    @State private var isClicked: Bool = false
    @State private var imageFile: String = ""
    @State private var imageName: String = ""
    @State private var imageDate: String = ""
    @State private var imageDescription: String = ""
    @State private var selectedCollection: ImageCollection?
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                if geometry.size.width > geometry.size.height {
                    // horizontal mode, show side panel
                    HStack {
                        // Side panel
                        List(collections, id: \.name) { collection in
                            Button(action: {
                                selectedCollection = collection
                            }) {
                                Text(collection.name)
                            }
                        }
                        .frame(width: geometry.size.width * 0.25)
                        
                        // Images
                        ScrollableImages(isClicked: $isClicked, imageFile: $imageFile, imageName: $imageName, imageDate: $imageDate, imageDescription: $imageDescription, selectedCollection: $selectedCollection, collections: collections)
                    }
                } else {
                    // Vertical mode, just show images
                    ScrollableImages(isClicked: $isClicked, imageFile: $imageFile, imageName: $imageName, imageDate: $imageDate, imageDescription: $imageDescription, selectedCollection: $selectedCollection, collections: collections)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HighlightView()
    }
}

struct ScrollableImages: View {
    @Binding var isClicked: Bool
    @Binding var imageFile: String
    @Binding var imageName: String
    @Binding var imageDate: String
    @Binding var imageDescription: String
    @Binding var selectedCollection: ImageCollection?
    var collections: [ImageCollection] = []
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 300))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                if let images = selectedCollection?.images {
                    ForEach(0..<images.count, id: \.self) { i in
                        NavigationLink(isActive: $isClicked) {
                            EnhancedView(
                                imageFile: $imageFile,
                                imageName: $imageName,
                                imageDate: $imageDate,
                                imageDescription: $imageDescription
                            )
                        } label: {
                            Image(images[i])
                                .resizable()
                                .scaledToFill()
                                .frame(width: 300, height: 300)
                                .onTapGesture {
                                    imageFile = images[i]
                                    imageName = "Wonderful Nature Landscape Photo"
                                    imageDate = "22/09/2023"
                                    imageDescription = "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc."
                                    isClicked = true
                                }
                        }
                    }
                }
            }
        }
        .onAppear {
            // Select the first collection by default
            if (selectedCollection == nil) {
                selectedCollection = collections.first
            }
        }
    }
}
