//
//  EnhancedView.swift
//  PhotoGallery
//
//  Created by Personal on 04/10/2023.
//

import SwiftUI

struct DeviceRotationViewModifer: ViewModifier {
    let action: (UIDeviceOrientation) -> Void
    
    func body(content: Content) -> some View {
        content.onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifer(action: action))
    }
}

struct EnhancedView: View {
    @Binding var imageFile: String
    @Binding var imageName: String
    @Binding var imageDate: String
    @Binding var imageDescription: String
    
    @State private var orientation = UIDeviceOrientation.unknown
    @State private var isFullScreen: Bool = false
    
    let screenSize: CGRect = UIScreen.main.bounds
    
    var body: some View {
        ScrollView {
            Group {
                if isFullScreen {
                    Image(imageFile)
                        .resizable()
                        .scaledToFit()
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            self.isFullScreen.toggle()
                        }
                } else if (orientation.isLandscape) {
                    LazyHStack {
                        VStack {
                            Image(imageFile)
                                .resizable()
                                .scaledToFit()
                                .onTapGesture {
                                    self.isFullScreen.toggle()
                                }
                        }.frame(width: screenSize.width * 0.5)
                        
                        VStack {
                            Text(imageName)
                                .fontWeight(.bold)
                            Text(imageDate)
                            Text(imageDescription)
                        }.frame(width: screenSize.width * 0.5)
                    }
                } else {
                    LazyVStack {
                        VStack {
                            Image(imageFile)
                                .resizable()
                                .scaledToFit()
                                .onTapGesture {
                                    self.isFullScreen.toggle()
                                }
                        }.frame(width: screenSize.width)
                        
                        VStack {
                            Text(imageName)
                                .fontWeight(.bold)
                            Text(imageDate)
                            Text(imageDescription)
                        }.frame(width: screenSize.width)
                    }
                }
            }
        }
        .onRotate { newOrientation in
            print(newOrientation)
            orientation = newOrientation
        }
        .ignoresSafeArea(.all)
    }
}

struct EnhancedView_Previews: PreviewProvider {
    static var previews: some View {
        EnhancedView(imageFile: .constant(""), imageName: .constant(""), imageDate: .constant(""), imageDescription: .constant(""))
    }
}
