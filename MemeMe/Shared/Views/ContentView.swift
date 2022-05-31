//
//  ContentView.swift
//  Shared
//
//  Created by RhaXiel on 18/1/22.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowPhotoLibrary = false
    @State private var isShowCamera = false
    @State private var isShowShareSheet = false
    
    @State private var topText: String = ""
    @State private var bottomText: String = ""
    
    @State private var image = UIImage()
    
    @State public var frameSize: CGSize = .zero
    
    @State private var meme: Meme? = nil
    
    @State private var cameraEnabled: Bool = UIImagePickerController.isSourceTypeAvailable(.camera)
    
    var body: some View {
        VStack{
            GeometryReader { (geometry) in
                self.makeView(geometry)
            }
            
            HStack{
                Button(action: {
                    self.isShowCamera = true
                }) {
                    HStack {
                        Image(systemName: "camera")
                            .font(.system(size: 20))
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                    .background((cameraEnabled) ? Color.blue : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                }.disabled(!cameraEnabled)
                .sheet(isPresented: $isShowCamera) {
                    ImagePicker(sourceType: .camera, selectedImage: self.$image)
                }
                
                
                Button(action: {
                    self.isShowPhotoLibrary = true
                }) {
                    HStack {
                        Image(systemName: "photo")
                            .font(.system(size: 20))
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                }
                .sheet(isPresented: $isShowPhotoLibrary) {
                    ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                }
                
                Button(action: {
                    self.imageActionSheet(image: self.snapshot())
                }) {
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 20))
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                }
            }
            .padding([.leading, .bottom, .trailing], 20.0)
            .background(.black)
        }
        .background(.black)
    }
    
    private func imageActionSheet(image: UIImage) {
            let imageToShare = [ image ] as [AnyObject]
            let activityVC = UIActivityViewController(activityItems: imageToShare as [AnyObject], applicationActivities: nil)
            if let popOverController = activityVC.popoverPresentationController {
                popOverController.permittedArrowDirections = [.right]
            }

            DispatchQueue.main.async {
                let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first

                if var topController = keyWindow?.rootViewController {
                    while let presentedViewController = topController.presentedViewController {
                        topController = presentedViewController
                    }

                    topController.present(activityVC, animated: true, completion: nil)
                }
            }
            
        }
    
    func makeView(_ geometry: GeometryProxy) -> some View {
        
            DispatchQueue.main.async { self.frameSize = geometry.size }

        return ZStack(alignment: .center) {
                Image(uiImage: self.image)
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 0, maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height)
                VStack{
                    TextField(
                        "TOP",
                        text: $topText
                    )
                    .onChange(of: topText){
                        print($0)
                        self.meme?.topText = $0
                    }
                        .onAppear(perform: {
                            if(self.topText == ""){
                                self.topText = "TOP"
                            }
                        })
                        .onTapGesture(count: 1, perform: {
                            self.topText = ""
                        })
                        .textInputAutocapitalization(.characters)
                        .multilineTextAlignment(.center)
                        .disableAutocorrection(true)
                        .font(.custom("HelveticaNeue-CondensedBlack", size: 35.0))
                        .foregroundColor(.white)
                        .padding(.top, 20)
                        .frame(width: UIScreen.main.bounds.width * 0.7)
                        .glowBorder(color: .black, lineWidth: 3)
                    Spacer()
                    TextField(
                        "BOTTOM",
                        text: $bottomText
                    )
                    .onChange(of: bottomText){
                        print($0)
                        self.meme?.bottomText = $0
                    }
                        .onAppear(perform: {
                            if(self.bottomText == ""){
                                self.bottomText = "BOTTOM"
                            }
                        })
                        .onTapGesture(count: 1, perform: {
                            self.bottomText = ""
                        })
                        .textInputAutocapitalization(.characters)
                        .multilineTextAlignment(.center)
                        .disableAutocorrection(true)
                        .font(.custom("HelveticaNeue-CondensedBlack", size: 35.0))
                        .foregroundColor(.white)
                        .padding(.bottom, 20)
                        .frame(width: UIScreen.main.bounds.width * 0.7)
                        .glowBorder(color: .black, lineWidth: 3)
                }
        }.frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
