import Foundation
import CoreML
import Combine
import SwiftUI

class TitanicViewModel: ObservableObject {
    @Published var age: Double = 30.0
    @Published var sibSp: Double = 0.0
    @Published var parch: Double = 0.0
    @Published var fare: Double = 30.0
    @Published var familySize: Double = 1.0
    @Published var isAlone: Double = 1.0
    @Published var sexMale: Double = 0.0
    @Published var embarkedQ: Double = 0.0
    @Published var embarkedS: Double = 0.0
    @Published var pclass2: Double = 0.0
    @Published var pclass3: Double = 1.0
    
    @Published var predictionResult: String = "Insira os dados para prever."
    @Published var predictionColor: Color = .gray
    
    private let model: TitanicSurvivalPredictorBoostedTree
    
    init() {
        guard let loadedModel = try? TitanicSurvivalPredictorBoostedTree(configuration: MLModelConfiguration()) else {
            fatalError("Falha ao carregar o modelo Core ML. Verifique o nome do modelo.")
        }
        self.model = loadedModel
    }
    
    func predictSurvival() {
        do {
            let inputAge = age
            let inputSibSp = Int64(sibSp)
            let inputParch = Int64(parch)
            let inputFare = fare
            let inputFamilySize = Int64(familySize)
            let inputIsAlone = Int64(isAlone)
            let inputSexMale = Int64(sexMale)
            let inputEmbarkedQ = Int64(embarkedQ)
            let inputEmbarkedS = Int64(embarkedS)
            let inputPclass2 = Int64(pclass2)
            let inputPclass3 = Int64(pclass3)
            
            let input = TitanicSurvivalPredictorBoostedTreeInput(
                Age: inputAge,
                SibSp: inputSibSp,
                Parch: inputParch,
                Fare: inputFare,
                FamilySize: inputFamilySize,
                IsAlone: inputIsAlone,
                Sex_male: inputSexMale,
                Embarked_Q: inputEmbarkedQ,
                Embarked_S: inputEmbarkedS,
                Pclass_2: inputPclass2,
                Pclass_3: inputPclass3
            )
            let output = try model.prediction(input: input)
            let survivalPrediction = output.Survived
            
            if survivalPrediction == 1 {
                predictionResult = "Previsão: SOBREVIVEU! 🎉"
                predictionColor = .green
            } else {
                predictionResult = "Previsão: NÃO SOBREVIVEU. 😔"
                predictionColor = .red
            }
            
        } catch {
            predictionResult = "Erro na previsão: \(error.localizedDescription)"
            predictionColor = .orange
        }
    }
    
    func toggleSex() {
        sexMale = sexMale == 0 ? 1 : 0
    }
    
    func setPclass(classValue: Int) {
        pclass2 = (classValue == 2) ? 1 : 0
        pclass3 = (classValue == 3) ? 1 : 0
    }
    
    func setEmbarked(port: String) {
        embarkedQ = 0
        embarkedS = 0
        if port == "Q" {
            embarkedQ = 1
        } else if port == "S" {
            embarkedS = 1
        }
    }
}
