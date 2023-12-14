import Foundation
import SwiftUI
import HealthKit

struct HealthData {
    let type: HKQuantityTypeIdentifier
    var value: Int
}

class HealthStoreManager: ObservableObject {
    @Published var heartRateData: HealthData?
    @Published var ECGData: HealthData?
    @Published var AfibData: HealthData?
    @Published var BloodOxData: HealthData?

    let healthStore = HKHealthStore()

    func requestHealthKitPermissions() async {
        // I don't know what to request I'm just getting anything to look legit
        guard let heartType = HKQuantityType.quantityType(forIdentifier: .heartRate),
              let oxygenType = HKObjectType.quantityType(forIdentifier: .oxygenSaturation),
              let atrialType = HKObjectType.quantityType(forIdentifier: .atrialFibrillationBurden),
              let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)
        else {
            return
        }

        if HKHealthStore.isHealthDataAvailable() {
            let healthDataToRead: Set = [atrialType, heartType, oxygenType, stepType]
            
            do {
                try await healthStore.requestAuthorization(toShare: [], read: healthDataToRead)
            } catch {
                // fix these later to correctly handle an error
                print("Health data unavailable")
            }
        } else {
            print("Health data is not available")
        }
    }

    func fetchHealthData(for type: HKQuantityTypeIdentifier) {
        let healthType = HKObjectType.quantityType(forIdentifier: type)!

        // Create a predicate to get the most recent sample
        let predicate = HKQuery.predicateForSamples(withStart: Date.distantPast, end: Date(), options: .strictEndDate)

        // Create a query to fetch the most recent health data sample
        let query = HKSampleQuery(sampleType: healthType, predicate: predicate, limit: 1, sortDescriptors: nil) { [weak self] (query, samples, error) in
            guard let self = self else { return }

            if let sample = samples?.first as? HKQuantitySample {
                let value = Int(sample.quantity.doubleValue(for: HKUnit.count().unitDivided(by: .minute())))
                let healthData = HealthData(type: type, value: value)

                DispatchQueue.main.async {
                    switch type {
                    case .heartRate:
                        self.heartRateData = healthData
                    // Uncomment and implement these if needed
                    // case .electrocardiogram:
                    //     self.ECGData = healthData
                    case .atrialFibrillationBurden:
                        self.AfibData = healthData
                    case .oxygenSaturation:
                        self.BloodOxData = healthData
                    default:
                        break
                    }
                }
            }
        }

        healthStore.execute(query)
    }
}

struct ListView: View {
    @StateObject private var healthStoreManager = HealthStoreManager()

    var body: some View {
        VStack {
            NavigationStack {
                Text("Welcome to Shannon Health Sync!")
                Text("All Data is Successfully uploaded")
                Text("Last recorded Heart Rate: \(healthStoreManager.heartRateData?.value ?? 0) bpm")
                Text("Last recorded ECG: \(healthStoreManager.ECGData?.value ?? 0)")
                Text("Last recorded Afib: \(healthStoreManager.AfibData?.value ?? 0)")
                Text("Last recorded BloodOx: \(healthStoreManager.BloodOxData?.value ?? 0)")
            }
        }
        .onAppear {
            Task {
                await healthStoreManager.requestHealthKitPermissions()
                healthStoreManager.fetchHealthData(for: .heartRate)
                // Uncomment and implement these if needed
                //healthStoreManager.fetchHealthData(for: .HKElectrocardiogramType)
                healthStoreManager.fetchHealthData(for: .atrialFibrillationBurden)
                healthStoreManager.fetchHealthData(for: .oxygenSaturation)
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
