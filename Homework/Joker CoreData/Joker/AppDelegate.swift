//
//  AppDelegate.swift
//  Joker
//
//  Created by Nathan VelaBorja on 1/12/17.
//  Copyright © 2017 Nathan VelaBorja. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Initialize database on first load
        if (!UserDefaults.standard.bool(forKey: "initialLaunch")) {
            print("First launch, initializing database.")
            
            UserDefaults.standard.set(true, forKey: "initialLaunch")
            UserDefaults.standard.synchronize()
            
            initializeDBJokes()
        }
        
        return true
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

    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Joker")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func initializeDBJokes() {
        // Default jokes, added only first time app is launched
        addJoke("What is blue", "and smells like", "red paint?", "Blue paint.")
        addJoke("Why do communists", "only write in", "lowercase?", "They hate Capitalism.")
        addJoke("What is going", "to replace", "Obamacare?", "DonTCare.")
        addJoke("What do you", "call bears with", "no ears?", "B.")
        addJoke("What did the", "two apples have", "in common?", "They were both apples.")
    }
    
    func addJoke(_ first: String = "", _ second: String = "", _ third: String = "", _ answer: String = "") {
        let context = persistentContainer.viewContext
        
        let joke = NSEntityDescription.insertNewObject(forEntityName: "DBJoke", into: context)
        joke.setValue(first, forKey: "line1")
        joke.setValue(second, forKey: "line2")
        joke.setValue(third, forKey: "line3")
        joke.setValue(answer, forKey: "answer")
        
        saveContext()
    }
    
    func deleteJoke(_ first: String = "", _ second: String = "", _ third: String = "", _ answer: String = "") {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "DBJoke")
        fetchRequest.predicate = NSPredicate(format: "line1 == %@ AND line2 == %@ AND line3 == %@ AND answer == %@", first, second, third, answer)
        
        var jokesToDelete: [NSManagedObject]!
        do {
            jokesToDelete = try context.fetch(fetchRequest)
        } catch {
            print("Error. AppDelegate deleteJoke(). Message: \(error)")
        }
        
        for joke in jokesToDelete {
            context.delete(joke)
        }
        
        saveContext()
    }
    
    func editJoke(_ oldFirst: String = "", _ oldSecond: String = "", _ oldThird: String = "", _ oldAnswer: String = "" , _ newFirst: String = "", _ newSecond: String = "", _ newThird: String = "", _ newAnswer: String = "") {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "DBJoke")
        fetchRequest.predicate = NSPredicate(format: "line1 == %@ AND line2 == %@ AND line3 == %@ AND answer == %@", oldFirst, oldSecond, oldThird, oldAnswer)
        
        var jokesToUpdate: [NSManagedObject]!
        do {
            jokesToUpdate = try context.fetch(fetchRequest)
        } catch {
            print("Error. AppDelegate editJoke(). Message: \(error)")
        }
        
        for joke in jokesToUpdate {
            joke.setValue(newFirst, forKey: "line1")
            joke.setValue(newSecond, forKey: "line2")
            joke.setValue(newThird, forKey: "line3")
            joke.setValue(newAnswer, forKey: "answer")
        }
        
        saveContext()
    }
    
    func getJokeObjects() -> [Joke] {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "DBJoke")
        
        var jokesMO: [NSManagedObject]!
        do {
            jokesMO = try context.fetch(fetchRequest)
        } catch {
            print("Error. AppDelegate getJokeObjects(). Message: \(error)")
        }
        
        var jokes = [Joke]()
        
        for joke in jokesMO {
            let line1 = joke.value(forKey: "line1") as! String
            let line2 = joke.value(forKey: "line2") as! String
            let line3 = joke.value(forKey: "line3") as! String
            let answer = joke.value(forKey: "answer") as! String
            jokes.append(Joke(line1, line2, line3, answer))
        }
        
        return jokes
    }
}

