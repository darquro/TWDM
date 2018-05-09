//
//  DirectMessageAPIClient.swift
//  TWDM
//
//  Created by yuki.kuroda on 2018/04/28.
//  Copyright © 2018年 darquro. All rights reserved.
//

import Foundation
import CoreData

class DirectMessageAPIClient {
    
    private var onReceiveMessageObserver: ((DirectMessage) -> Void)?
    
    func addObserverOnReceiveMessage(block: @escaping (DirectMessage) -> Void) {
        onReceiveMessageObserver = block
    }
    
    func post(dm: DirectMessage, completion:@escaping (Result<Void?, RequestErrors>) -> Void) {
        
        guard let userID = dm.userID, let followerID = dm.followerID, let message = dm.message else {
            completion(.failure(.requestError))
            return
        }
        
        // save CoreDate
        do {
            try saveCoreData(value: dm)
        } catch {
            completion(.failure(.saveDataError))
        }
        
        completion(Result.success(nil))
        
        // reply
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
            let reply = "\(message) \(message)"
            let dm = DirectMessage(userID: userID, followerID: followerID, message: reply, postBy: .follower)
            do {
                try self.saveCoreData(value: dm)
            } catch {
                completion(.failure(.saveDataError))
            }
            self.onReceiveMessageObserver?(dm)
        }
    }
    
    func fetch(userID: String, followerID: String, complition: (Result<[DirectMessage]?, RequestErrors>) -> Void) {
        let context = CoreDataProvider.directMessages.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<DirectMessageModel> = DirectMessageModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "userID = %@ AND followerID = %@", userID, followerID)
        do {
            let result = try context.execute(fetchRequest) as! NSAsynchronousFetchResult<DirectMessageModel>
            guard let models = result.finalResult, models.count > 0 else {
                complition(.success(nil))
                return
            }
            
            let messages = models.compactMap { DirectMessage.convert(from: $0) }
            complition(.success(messages))
        } catch {
            Log.d("direct message fetch error")
            complition(.failure(.responseError))
        }
    }
    
    private func saveCoreData(value: DirectMessage) throws {
        let context = CoreDataProvider.directMessages.persistentContainer.viewContext
        let model = DirectMessageModel(context: context)
        do {
            try model.apply(value: value)
            CoreDataProvider.directMessages.saveContext()
        } catch {
            throw RequestErrors.saveDataError
        }
    }
}
