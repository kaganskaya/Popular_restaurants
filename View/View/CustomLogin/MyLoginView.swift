//
//  MyLoginView.swift
//  View
//
//  Created by liza_kaganskaya on 2/11/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


@IBDesignable
class MyLoginView: UIView {
    
    
    @IBOutlet weak var backgrView: UIImageView!
  
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var pasword: UITextField!
    
    @IBOutlet weak var formView: UIView!
    
    @IBOutlet var myView: UIView!
    
    @IBOutlet weak var loginButton: UIButton!
    
    let disposeBag:DisposeBag = DisposeBag()
    
    private var userData:MyUser = MyUser(username: " ", password: " ")
    
    private var index: Int = 0
    
    let backGroundArray = [UIImage(named: "Image"),UIImage(named:"burg"),UIImage(named:"wog"),UIImage(named:"Shum")]
    
    var completionHandler:((String,String) -> Void)?

    
    @IBAction func logIn(_ sender: Any) {
       completionHandler?(username.text!,pasword.text!)
    }
    
    
    override func prepareForInterfaceBuilder(){
        super.prepareForInterfaceBuilder()
        
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setUserData(userData:MyUser){
        self.userData = userData
    }
    
    func setup() {
        
        let bundle = Bundle(for: MyLoginView.self)
            bundle.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)
        
        addSubview(myView)
        myView.frame = self.bounds
        myView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        formView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.show()
        self.subscribeRxChanges()
        
    }
    
    override var bounds: CGRect{
        
        didSet{
            layer.allowsGroupOpacity = false
        }
    }

    @objc func changeBackground(){
        
        index = backGroundArray.count - 1 == index ? 0 : index + 1
        
        let toImage = backGroundArray[index];
        
        UIView.transition(with: self.backgrView, duration: 1, options: .transitionCrossDissolve, animations: {self.backgrView.image = toImage}, completion: nil)
        
        
    }
    
    func setupImage(){
        
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.dark)) as UIVisualEffectView
        
            visualEffectView.frame = self.myView.frame
        
            visualEffectView.alpha = 0.2
        
            backgrView.image = UIImage(named: "burg")
        
            backgrView.addSubview(visualEffectView)
        

        Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(changeBackground), userInfo: nil, repeats: true)
        
    }
    
    
//    func blur(){
//
//        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
//
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//
//            blurEffectView.frame = backgrView.bounds
//
//            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//
//            backgrView.addSubview(blurEffectView)
//
//    }
    
    func show(){
        setupImage()
    }


    private func subscribeRxChanges(){


         Observable.combineLatest(username.rx.text, pasword.rx.text)
            .subscribe(onNext: { (login,pas)  in
                
                if((login!.count) > 0 && (pas!.count)>0){
                        self.loginButton.isEnabled = true
                        self.loginButton.alpha = 1.0
                }else{
                        self.loginButton.isEnabled = false
                        self.loginButton.alpha = 0.5
                }
                
            }).disposed(by: disposeBag)

    }
}
