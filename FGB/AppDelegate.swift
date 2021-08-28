//  AppDelegate.swift
//  FGB
//  Created by iOS-Appentus on 07/03/19.
//  Copyright © 2019 appentus. All rights reserved.



import UIKit
import IQKeyboardManagerSwift
import Firebase
import FirebaseMessaging
import Crashlytics
import FBSDKLoginKit
import Cheers
import Braintree
var is_from_noti = false
//var is_first_time_launch = false

var str_new_offer_msg = ""

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate  {
    
    var window: UIWindow?
    
    var cheerView = CheerView()
    var cheers_VC = Cheer_ViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        var language = "en"
        if let default_value = UserDefaults.standard.object(forKey: "Language") as? String {
            if default_value == "English" {
                language = "en"
                Language.language = Language.english
            } else {
                language = "ar"
                Language.language = Language.arabic
            }
        }
        
        BTAppSwitch.setReturnURLScheme("com.appentus.FGB.payments")
        
//        LocalizationSystem.sharedInstance.setLanguage(languageCode: language)
        let remoteNotif = launchOptions?[UIApplicationLaunchOptionsKey.remoteNotification] as? [String: Any]
        if remoteNotif != nil {
            is_from_noti = true
        } else {
            
        }
        
        func_cheer_animation()
        
//        is_first_time_launch = true
        
        IQKeyboardManager.shared.enable = true
        
//        FBSDKAccessToken.setCurrent(nil)
//        FBSDKProfile.setCurrent(nil)
//        FBSDKLoginManager().logOut()
        
//        FBSDKApplicationDelegate.sharedInstance()?.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        Fabric.sharedSDK().debug = true
                
        NotificationCenter.default.addObserver(self, selector: #selector(func_cheer_animation), name: NSNotification.Name (rawValue: "cheers"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(func_cheer_animationSTOP), name: NSNotification.Name (rawValue: "cheers_stop"), object: nil)
        
        askForNotificationPermission(application)
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        if url.scheme?.localizedCaseInsensitiveCompare("com.appentus.FGB.payments") == .orderedSame {
            return BTAppSwitch.handleOpen(url, options: options)
        }
        return false
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        return FBSDKApplicationDelegate.sharedInstance()!.application(app, open: url, options: options)
//    }
    
}



var k_FireBaseFCMToken = ""

extension AppDelegate : MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        k_FireBaseFCMToken = fcmToken
    }
    
}



extension AppDelegate {
    @objc func func_cheer_animation() {
        let storyBoard = UIStoryboard (name: "Main", bundle: nil)
        cheers_VC = storyBoard.instantiateViewController(withIdentifier: "Cheer_ViewController") as! Cheer_ViewController
        
        cheerView = CheerView.init(frame:(cheers_VC.view.bounds))
        cheers_VC.view.addSubview(cheerView)
        cheers_VC.view.sendSubview(toBack: cheerView)
        
        UIApplication.shared.keyWindow?.addSubview(cheers_VC.view)
        UIApplication.shared.keyWindow?.rootViewController!.addChildViewController(cheers_VC)
        UIApplication.shared.keyWindow?.bringSubview(toFront: cheers_VC.view)
        
//        UIApplication.shared.keyWindow?.rootViewController!.view.addSubview(cheers_VC.view)
//        UIApplication.shared.keyWindow?.rootViewController!.view.bringSubview(toFront: cheers_VC.view)
        
        cheerView.config.particle = .confetti(allowedShapes: Particle.ConfettiShape.all)
        cheerView.start()
    }
    
    @objc func func_cheer_animationSTOP() {
        cheerView.stop()
    }
    
}



extension AppDelegate:UNUserNotificationCenterDelegate {
    func askForNotificationPermission(_ application: UIApplication) {
        let isRegisteredForRemoteNotifications = UIApplication.shared.isRegisteredForRemoteNotifications
        if !isRegisteredForRemoteNotifications {
            if #available(iOS 10.0, *) {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
                    (granted, error) in
                    if error == nil {
                        if !granted {
                            self.openNotificationInSettings()
                        } else {
                            UNUserNotificationCenter.current().delegate = self
                        }
                    }
                }
            } else {
                let settings: UIUserNotificationSettings =
                    UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
                application.registerUserNotificationSettings(settings)
            }
        } else {
            if #available(iOS 10.0, *) {
                UNUserNotificationCenter.current().delegate = self
            } else {
                
            }
        }
        
        application.registerForRemoteNotifications()
        
    }
    
    func openNotificationInSettings() {
        let alertController = UIAlertController(title: "Notification Alert", message: "Please enable Notification from Settings to never miss a text.", preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    })
                } else {
                    
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(settingsAction)
        DispatchQueue.main.async {
            self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }
    
    
//    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .badge, .sound])
        
        if  #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        } else {
            UIApplication.shared.cancelAllLocalNotifications()
        }
        
        let dataDict = notification.request.content.userInfo
        let dict_title = dataDict["aps"] as! [String:Any]
        let dict_alert = dict_title["alert"] as! [String:Any]
        str_new_offer_msg = "\(dict_alert["body"]!)"
        
        NotificationCenter.default.post(name:NSNotification.Name (rawValue: "cheers"), object: nil)
        
//        viewPresent(centerPoint: CGPoint.zero, storyBoard: "Main", viewId: "Cheer_ViewController")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
    }
    
    func application(_ application: UIApplication, didFailToContinueUserActivityWithType userActivityType: String, error: Error) {
        print(error)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        NotificationCenter.default.post(name:NSNotification.Name (rawValue: "cheers"), object: nil)
        
        let dataDict = userInfo
        let dict_title = dataDict["aps"] as! [String:Any]
        let dict_alert = dict_title["alert"] as! [String:Any]
        str_new_offer_msg = "\(dict_alert["body"]!)"
        
//        if is_first_time_launch {
//            is_first_time_launch = false
//            is_from_noti = true
//        }
        
    }
    
    func func_Set_Action_On_Getting_Notifications(jsonResp:[String:Any]) {
        let appdelgateObj = UIApplication.shared.delegate as! AppDelegate
        
        let storyboard = UIStoryboard (name: "Main", bundle: nil)
        
        
        
//        if let destinationVC = storyboard.instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController {
//
//            if let window = appdelgateObj.window , let rootViewController = window.rootViewController {
//                var currentController = rootViewController
//
//                while let presentedController = currentController.presentedViewController {
//                    currentController = presentedController
//                }
//
//                if currentController == self.window!.visibleViewController {
//                    print("same view controller")
//                } else {
//                    currentController.present(destinationVC, animated: true, completion: nil)
//                }
//
//            }
//        }
    }
    
    
    
    func viewPresent(centerPoint:CGPoint,storyBoard:String,viewId:String){
        UIApplication.shared.keyWindow?.rootViewController!.view.center = centerPoint
        UIApplication.shared.keyWindow?.rootViewController!.view.center = (UIApplication.shared.keyWindow?.rootViewController!.view.center)!
        let storyboard = UIStoryboard(name: "\(storyBoard)", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "\(viewId)")
        //        vc.transitioningDelegate = self
        vc.modalPresentationStyle = .custom
        UIApplication.shared.keyWindow?.rootViewController!.present(vc, animated: true, completion: nil)
    }
    
}



public extension UIWindow {
    public var visibleViewController: UIViewController? {
        return UIWindow.getVisibleViewControllerFrom(self.rootViewController)
    }
    
    public static func getVisibleViewControllerFrom(_ vc: UIViewController?) -> UIViewController? {
        if let nc = vc as? UINavigationController {
            return UIWindow.getVisibleViewControllerFrom(nc.visibleViewController)
        } else if let tc = vc as? UITabBarController {
            return UIWindow.getVisibleViewControllerFrom(tc.selectedViewController)
        } else {
            if let pvc = vc?.presentedViewController {
                return UIWindow.getVisibleViewControllerFrom(pvc)
            } else {
                return vc
            }
        }
    }
}



//extension Bundle {
//    private static var bundle: Bundle!
//    public static func localizedBundle() -> Bundle! {
//        if bundle == nil {
//            let appLang = UserDefaults.standard.string(forKey: "app_lang") ?? "ru"
//            let path = Bundle.main.path(forResource: appLang, ofType: "lproj")
//            bundle = Bundle(path: path!)
//        }
//        
//        return bundle;
//    }
//    
//    public static func setLanguage(lang: String) {
//        UserDefaults.standard.set(lang, forKey: "app_lang")
//        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
//        bundle = Bundle(path: path!)
//    }
//    
//    
//}




//class func setLanguage(_ language: String) {
//    var onceToken: Int
//    if (onceToken == 0) {
//        /* TODO: move below code to a static variable initializer (dispatch_once is deprecated) */
//        object_setClass(Bundle.main, BundleEx.self)
//    }
//    onceToken = 1
//    objc_setAssociatedObject(Bundle.main, bundle, language ? Bundle(path: Bundle.main.path(forResource: language, ofType: "lproj")) : nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//}


