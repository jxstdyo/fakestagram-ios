//
//  CameraViewController.swift
//  fakestagram
//
//  Created by Antonyo Chavez Saucedo on 4/27/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import UIKit
import TransitionButton

class CameraViewController: UIViewController,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate{
    let client = CreatePostClient()
    
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var imagenPicker: UIImageView!
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var tituloTxt: UITextField!
    
    let imgPicker = UIImagePickerController()

    override func viewDidLoad() {
        imgPicker.delegate = self
        toolbar.anchor(top: nil,
                       leading: view.layoutMarginsGuide.leadingAnchor, trailing: view.layoutMarginsGuide.trailingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, size: CGSize(width: 0, height: 40))
        
        uploadButton.anchor(top: nil,
                            leading: view.layoutMarginsGuide.leadingAnchor,
                            trailing: view.layoutMarginsGuide.trailingAnchor,
                            bottom: toolbar.topAnchor,
                            padding: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0), size: CGSize(width: 0, height: 50))
        
        uploadButton.anchor(top: nil,
                            leading: view.layoutMarginsGuide.leadingAnchor,
                            trailing: view.layoutMarginsGuide.trailingAnchor,
                            bottom: toolbar.topAnchor,
                            padding: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0), size: CGSize(width: 0, height: 50))
        
        tituloTxt.anchor(top: nil,
                         leading: view.layoutMarginsGuide.leadingAnchor,
                         trailing: view.layoutMarginsGuide.trailingAnchor,
                         bottom: uploadButton.topAnchor,
                         padding: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
        
        titulo.anchor(top: nil,
                         leading: nil,
                         trailing: nil,
                         bottom: tituloTxt.topAnchor,
                         padding: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
        
        titulo.centerAnchor(centerX: view.centerXAnchor, centerY: nil)
        
        imagenPicker.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                            leading: view.layoutMarginsGuide.leadingAnchor,
                            trailing: view.layoutMarginsGuide.trailingAnchor,
                            bottom: titulo.topAnchor,
                            padding: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
        
        
        hidden(true);
        clean();
    }
    
    
    
    @IBAction func showCamera(_ sender: Any) {
        openCamera()
    }
    
    @IBAction func showGallery(_ sender: Any) {
        openGallery()
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    //MARK:-- ImagePicker delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.editedImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        self.imagenPicker.image = selectedImage
        hidden(false);
        picker.dismiss(animated: true, completion: nil)
    }
    

    
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imgPicker.sourceType = UIImagePickerController.SourceType.camera
            imgPicker.allowsEditing = true
            self.present(imgPicker, animated: true, completion: nil)
        }
        else
        {
            UIAlert.showMessage(showIn: self, message: "No esta disponible la camara.")
        }
    }
    
    func openGallery()
    {
        imgPicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imgPicker.allowsEditing = true
        self.present(imgPicker, animated: true, completion: nil)
    }
    
    
    @IBAction func uploadButton(_ sender: TransitionButton) {
        
        guard let name = self.tituloTxt.text else {
            UIAlert.showMessage(showIn: self, message: "Es necesario ingresar un titulo.")
            return
        }
        
        if name.isEmpty{
            UIAlert.showMessage(showIn: self, message: "Es necesario ingresar un titulo.")
            return
        }
        
        
        guard let imagen = self.imagenPicker.image else {
            UIAlert.showMessage(showIn: self, message: "No ha seleccionado una Imagen.")
            return
        }
        
        sender.startAnimation() // 2: Then start the animation when the user tap the button
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async(execute: {
            
            guard let imgBase64 = imagen.encodedBase64() else { return }
            let payload = CreatePostBase64(title: name, imageData: imgBase64)
            
            DispatchQueue.main.async(execute: { () -> Void in
                self.client.create(payload: payload) { (postResult) in
                    print(postResult)
                }
                sender.stopAnimation(animationStyle: .expand, completion: {
                     DispatchQueue.main.async(execute: { () -> Void in
                        self.hidden(true)
                        self.clean()
                     })
                })
            })
        })
        
    }
    
    func hidden(_ hidden : Bool){
        self.uploadButton.isHidden = hidden
        self.titulo.isHidden = hidden
        self.tituloTxt.isHidden = hidden
        self.imagenPicker.isHidden = hidden
        self.tituloTxt.endEditing(true)
    }
    
    func clean(){
        self.tituloTxt.text = ""
        self.imagenPicker.image = nil
    }
    
}
