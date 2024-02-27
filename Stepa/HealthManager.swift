import SwiftUI
import HealthKit

class HealthManager {
    let healthStore = HKHealthStore()
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false)
            return
        }
        
        let typesToRead: Set<HKSampleType> = [HKSampleType.quantityType(forIdentifier: .stepCount)!]
        
        healthStore.requestAuthorization(toShare: nil, read: typesToRead) { success, error in
            completion(success)
        }
    }
    
    func fetchStepCount(completion: @escaping (Int?) -> Void) {
        // Check if step count data is available
        guard let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
            // Step count data is not available on this device
            completion(nil)
            return
        }
        
        // Check authorization status
        let authorizationStatus = healthStore.authorizationStatus(for: stepType)
        switch authorizationStatus {
        case .notDetermined:
            // Request authorization
            requestAuthorization { success in
                if success {
                    // Authorization granted, fetch step count
                    self.executeQuery(for: stepType, completion: completion)
                } else {
                    // Authorization denied, unable to fetch step count
                    completion(nil)
                }
            }
        case .sharingDenied:
            // Health data sharing is denied by the user
            print("Health data sharing is denied by the user")
            completion(nil)
        case .sharingAuthorized:
            // Health data sharing is authorized, fetch step count
            executeQuery(for: stepType, completion: completion)
        @unknown default:
            print("Unknown authorization status")
            completion(nil)
        }
    }

    private func executeQuery(for quantityType: HKQuantityType, completion: @escaping (Int?) -> Void) {
        // Set the start and end dates for the query
        let startDate = Calendar.current.startOfDay(for: Date())
        let endDate = Date()
        
        // Set the predicate for the query
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        
        // Set the query
        let query = HKStatisticsQuery(quantityType: quantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { query, result, error in
            if let error = error {
                // Handle query execution error
                print("Error executing step count query: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let result = result, let sum = result.sumQuantity() else {
                // Handle no data available
                print("No step count data available")
                completion(nil)
                return
            }
            
            // Get the step count
            let stepCount = Int(sum.doubleValue(for: HKUnit.count()))
            completion(stepCount)
        }
        
        // Execute the query
        healthStore.execute(query)
    }
}
