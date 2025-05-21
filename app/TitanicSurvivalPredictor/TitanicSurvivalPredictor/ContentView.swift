import SwiftUI

struct ContentView: View {
    // MARK: - Propriedades de Estado
    @StateObject var viewModel = TitanicViewModel()

    // MARK: - Body da View
    var body: some View {
        NavigationView {
            Form {
                // MARK: - Seção de Dados Pessoais
                Section("Dados Pessoais") {
                    HStack {
                        Text("Idade: \(Int(viewModel.age))")
                        Slider(value: $viewModel.age, in: 0...80, step: 1)
                    }

                    Picker("Sexo", selection: $viewModel.sexMale) {
                        Text("Feminino").tag(0.0)
                        Text("Masculino").tag(1.0)
                    }
                    .pickerStyle(.segmented)

                    Picker("Viajando Sozinho?", selection: $viewModel.isAlone) {
                        Text("Sozinho(a)").tag(1.0)
                        Text("Acompanhado(a)").tag(0.0)
                    }
                    .pickerStyle(.segmented)
                }

                // MARK: - Seção da Família e Tarifa
                Section("Detalhes da Viagem") {
                    HStack {
                        Text("Irmãos/Cônjuges: \(Int(viewModel.sibSp))")
                        Slider(value: $viewModel.sibSp, in: 0...8, step: 1)
                    }
                    HStack {
                        Text("Pais/Filhos: \(Int(viewModel.parch))")
                        Slider(value: $viewModel.parch, in: 0...6, step: 1)
                    }
                    HStack {
                        Text("Tarifa: \(viewModel.fare, specifier: "%.2f")")
                        Slider(value: $viewModel.fare, in: 0...500, step: 1)
                    }
                }

                // MARK: - Seção da Classe e Embarque
                Section("Classe e Embarque") {
                    Picker("Classe", selection: Binding(
                        get: {
                            if viewModel.pclass2 == 1 { return 2 }
                            if viewModel.pclass3 == 1 { return 3 }
                            return 1
                        },
                        set: { newValue in
                            viewModel.setPclass(classValue: newValue)
                        }
                    )) {
                        Text("1ª Classe").tag(1)
                        Text("2ª Classe").tag(2)
                        Text("3ª Classe").tag(3)
                    }
                    .pickerStyle(.segmented)

                    Picker("Embarque", selection: Binding(
                        get: {
                            if viewModel.embarkedQ == 1 { return "Q" }
                            if viewModel.embarkedS == 1 { return "S" }
                            return "C"
                        },
                        set: { newValue in
                            viewModel.setEmbarked(port: newValue)
                        }
                    )) {
                        Text("Cherbourg (C)").tag("C")
                        Text("Queenstown (Q)").tag("Q")
                        Text("Southampton (S)").tag("S")
                    }
                    .pickerStyle(.segmented)
                }

                // MARK: - Botão de Previsão
                Button("Prever Sobrevivência") {
                    viewModel.predictSurvival()
                    viewModel.familySize = viewModel.sibSp + viewModel.parch + 1
                    viewModel.isAlone = (viewModel.familySize == 1) ? 1.0 : 0.0
                }
                .font(.title2)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)

                // MARK: - Resultado da Previsão
                Text(viewModel.predictionResult)
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(viewModel.predictionColor.opacity(0.2))
                    .cornerRadius(10)
                    .multilineTextAlignment(.center)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Sobrevivência no Titanic")
        }
    }
}

#Preview {
    ContentView()
}
