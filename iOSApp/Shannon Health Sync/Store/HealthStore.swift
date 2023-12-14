//
//  HealthStore.swift
//  Pedometer
//
//  Created by Adian Acosta on 12/10/23.
//

import Foundation
import HealthKit
import Observation

enum HealthError: Error {
    case healthDataNotAvailable
}

@Observable
class HealthStore {
    
    var steps: [Step] = []
    var HealthStore: HKHealthStore?
    var lastError: Error?
    
    init() {
        if HKHealthStore.isHealthDataAvailable() {
            HealthStore = HKHealthStore()
        } else {
            lastError = HealthError.healthDataNotAvailable
        }
    }
    
    func calculateSteps() async throws {
        
        guard let healthStore = self.HealthStore else { return }
        
        let calender = Calendar(identifier: .gregorian)
        let startDate = calender.date(from: DateComponents(year: 2023, month: 12, day: 1))
        let endDate = Date()
        
        let heartType = HKQuantityType(.heartRate)
        
        let stepType = HKQuantityType(.stepCount)
        let everyDay = DateComponents(day:1)
        let thisWeek = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
        let stepsThisWeek = HKSamplePredicate.quantitySample(type: stepType, predicate: thisWeek)
        let heartRateThisWeek = HKSamplePredicate.quantitySample(type: heartType, predicate: thisWeek)
        
        
        let sumOfStepsQuery = HKStatisticsCollectionQueryDescriptor(predicate: stepsThisWeek, options: .cumulativeSum, anchorDate: endDate, intervalComponents: everyDay)
        
        let stepsCount = try await sumOfStepsQuery.result(for: healthStore)
        
        guard let startDate = startDate else { return }
        
        stepsCount.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
            let count = statistics.sumQuantity()?.doubleValue(for: .count())
            let step = Step(count: Int(count ?? 0), date: statistics.startDate)
            if step.count > 0 {
                // add the step in steps collection
                self.steps.append(step)
            }
        }
    }
    
    func requestAuthorization() async {
        // I don't know what to request i'm just getting anything to look legit
        guard let heartType = HKQuantityType.quantityType(forIdentifier: .heartRate),
              let oxygenType = HKObjectType.quantityType(forIdentifier: .oxygenSaturation),
              let atrialType = HKObjectType.quantityType(forIdentifier: .atrialFibrillationBurden),
              let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)
        else {
            return
        }
        
        guard let healthStore = self.HealthStore else { return }
        
        let healthDataToRead: Set = [atrialType, heartType, oxygenType, stepType]
        
        do {
            try await healthStore.requestAuthorization(toShare: [], read: healthDataToRead)
        } catch {
            lastError = error
        }
    }
}
