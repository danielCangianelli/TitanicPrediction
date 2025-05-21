# 🚢 Titanic Survival Predictor: Machine Learning para Classificação Binária com Core ML e SwiftUI

---

## 🎯 Objetivo do Projeto

Este projeto tem como **objetivo principal** demonstrar o **ciclo completo de um projeto de Machine Learning para classificação binária**, desde a **preparação e pré-processamento de dados** até o **treinamento e exportação de modelos** utilizando **Create ML**. O aplicativo iOS desenvolvido serve como uma **ferramenta visual interativa para testar e validar a funcionalidade dos modelos Core ML** em tempo real.

O foco é a **Ciência de Dados e Machine Learning**, utilizando as capacidades do ecossistema Apple para inferência eficiente.

---

## ✨ Tecnologias Utilizadas

* **Python 3.x**: Para análise de dados, pré-processamento e engenharia de features.
* **Pandas**: Manipulação e análise de dados tabulares.
* **Numpy**: Suporte a operações numéricas.
* **Scikit-learn**: Divisão de dados (train_test_split).
* **Matplotlib / Seaborn**: Visualização de dados e análise de correlação.
* **Jupyter Notebook**: Ambiente interativo para desenvolvimento e documentação da fase de dados.
* **Xcode**: Ambiente de Desenvolvimento Integrado (IDE) da Apple.
* **Create ML**: Framework da Apple para treinar modelos de Machine Learning otimizados para Core ML.
* **Core ML**: Framework da Apple para integrar modelos de Machine Learning em aplicativos.
* **SwiftUI**: Framework declarativo da Apple para construir interfaces de usuário em aplicativos iOS.
* **MVVM (Model-View-ViewModel)**: Padrão de arquitetura de software para o aplicativo iOS.

---

## 🚀 Fases do Projeto

O projeto foi dividido em três fases principais:

### **Fase 1: Preparação e Pré-processamento de Dados (Python)**

Nesta fase crítica, os dados brutos do dataset do Titanic foram transformados em um formato limpo e adequado para o treinamento de modelos de Machine Learning.

* **Carregamento e Exploração:** Análise inicial dos dados, identificação de tipos de colunas e valores ausentes.
* **Tratamento de Dados Nulos:**
    * `Age`: Preenchida com a **mediana** para robustez.
    * `Embarked`: Preenchida com a **moda** (valor mais frequente).
    * `Cabin`: **Removida** devido à alta porcentagem de valores nulos.
* **Engenharia de Features:**
    * `FamilySize`: Criada a partir de `SibSp` + `Parch` + 1 (incluindo o próprio passageiro).
    * `IsAlone`: Feature binária (0 ou 1) indicando se o passageiro viajava sozinho.
* **Codificação de Variáveis Categóricas (One-Hot Encoding):**
    * `Sex`, `Embarked` e `Pclass` foram convertidas em colunas numéricas binárias (ex: `Sex_male`, `Pclass_2`, `Embarked_Q`) usando `pd.get_dummies()` com `drop_first=True` para evitar multicolinearidade.
* **Análise de Correlação:** Geração de um mapa de calor para visualizar a correlação entre as features e a variável alvo `Survived`, destacando a importância de `Sex_male`.
* **Divisão e Exportação:** O dataset foi dividido em conjuntos de **treino** e **teste** (`train_test_split`) e exportado para arquivos **CSV** (`titanic_train_preprocessed.csv`, `titanic_test_preprocessed.csv`) para uso no Create ML.

### **Fase 2: Criação e Treinamento do Modelo Core ML (Create ML)**

Esta fase focou na construção e avaliação dos modelos de Machine Learning usando a ferramenta da Apple.

* **Configuração do Projeto:** Criação de um novo projeto **`Tabular Classifier`** no Create ML.
* **Carregamento dos Dados:** Importação dos arquivos CSV pré-processados.
* **Definição de Target e Features:** A coluna `Survived` foi definida como alvo, e as demais colunas relevantes como features de entrada.
* **Treinamento de Modelos:** Dois modelos foram treinados para comparação:
    * **`Boosted Tree`**: Um algoritmo robusto e eficaz para dados tabulares.
    * **`Random Forest`**: Um modelo de ensemble que combina múltiplas árvores para melhorar a precisão.
* **Avaliação de Desempenho:** Análise das métricas de Acurácia, Precisão, Recall e F1-Score no conjunto de teste, além da Matriz de Confusão para entender o desempenho de cada modelo.
* **Teste de Inferência (Preview):** Utilização da funcionalidade de Preview (em lote) para validar as previsões dos modelos e suas confianças.
* **Exportação do Modelo:** Os modelos treinados foram exportados como arquivos `.mlmodel` (ex: `TitanicSurvivalPredictor_BoostedTree.mlmodel`, `TitanicSurvivalPredictor_RandomForest.mlmodel`), prontos para integração em aplicativos Apple.

### **Fase 3: Integração e Teste Visual do Modelo (Aplicativo iOS com SwiftUI)**

Esta fase demonstra como os modelos Core ML podem ser integrados e testados em um aplicativo real, servindo como uma interface de validação interativa.

* **Inclusão dos Modelos no Xcode:** Os arquivos `.mlmodel` foram adicionados ao projeto Xcode.
* **Arquitetura MVVM:** O aplicativo foi estruturado com o padrão Model-View-ViewModel para uma separação clara de responsabilidades:
    * **`TitanicViewModel.swift`**: Lógica de negócio, carregamento dinâmico dos modelos Core ML (`MLModel`), manipulação de entradas e saídas do modelo, e gerenciamento do estado da UI via `@Published` properties. Crucialmente, lidou com a conversão de tipos de dados (`Double` para `Int64`) exigida por algumas features no modelo.
    * **`ContentView.swift` (SwiftUI)**: Interface do usuário interativa com controles (Sliders, Pickers) para inserir os dados do passageiro.
* **Seleção Dinâmica de Modelos:** Implementação de um `Picker` na UI que permite ao usuário **alternar entre os modelos Boosted Tree e Random Forest** em tempo real, comparando suas previsões.
* **Previsão em Tempo Real:** Um botão aciona a previsão, e o resultado (Sobreviveu/Não Sobreviveu) é exibido dinamicamente com feedback visual.

---

## ⚙️ Como Executar o Projeto

Para replicar e explorar este projeto, siga os passos abaixo:

### **1. Configuração do Ambiente Python (Fase 1)**

1.  **Clone o Repositório:** (Se este projeto estiver em um repositório Git)
    ```bash
    git clone [LINK_DO_SEU_REPOSITORIO]
    cd [NomeDoSeuProjeto]
    ```
2.  **Crie um Ambiente Virtual (Opcional, mas Recomendado):**
    ```bash
    python3 -m venv venv
    source venv/bin/activate # macOS/Linux
    # venv\Scripts\activate # Windows
    ```
3.  **Instale as Dependências:**
    ```bash
    pip install pandas numpy scikit-learn matplotlib seaborn jupyter
    ```
4.  **Baixe o Dataset:**
    * Baixe o arquivo `train.csv` do Kaggle Titanic dataset.
    * Coloque-o na mesma pasta onde seu Jupyter Notebook (`titanic_preprocessing.ipynb`) será criado.
5.  **Execute o Jupyter Notebook:**
    ```bash
    jupyter notebook
    ```
    * Abra o arquivo `titanic_preprocessing.ipynb` (ou o nome que você usou) e execute todas as células para realizar o pré-processamento de dados e gerar os arquivos `titanic_train_preprocessed.csv` e `titanic_test_preprocessed.csv`.

### **2. Treinamento do Modelo com Create ML (Fase 2)**

1.  **Abra o Xcode:** Inicie o Xcode.
2.  **Abra o Create ML:** Vá em `Xcode` > `Open Developer Tool` > `Create ML`.
3.  **Crie um Novo Projeto ML:** Selecione `Create New Project`, dê um nome (ex: `TitanicSurvivalPredictor`) e escolha o template **`Tabular Classifier`**.
4.  **Carregue os Dados:** Arraste e solte `titanic_train_preprocessed.csv` para "Training Data" e `titanic_test_preprocessed.csv` para "Testing Data".
5.  **Configure Target e Features:** Selecione `Survived` como a coluna `Target`. Confirme que as outras colunas são suas `Features`.
6.  **Treine os Modelos:** Na seção `Algorithm`, selecione **`Boosted Tree`** e clique em `Train`. Repita o processo, criando um novo projeto ou salvando o primeiro modelo, para treinar também um modelo **`Random Forest`**.
7.  **Exporte os Modelos:** Após o treinamento, clique no botão de exportar (geralmente um ícone de compartilhamento) e salve os arquivos `.mlmodel` (ex: `TitanicSurvivalPredictor_BoostedTree.mlmodel`, `TitanicSurvivalPredictor_RandomForest.mlmodel`) em uma pasta acessível.

### **3. Configuração e Execução do Aplicativo iOS (Fase 3)**

1.  **Crie um Novo Projeto Xcode (iOS App):**
    * No Xcode, selecione `Create a new Xcode project`.
    * Escolha `iOS` > `App`.
    * Nome do Projeto: `TitanicClassifier` (ou similar).
    * Interface: `SwiftUI`, Language: `Swift`.
2.  **Adicione os Modelos Core ML:**
    * Arraste e solte **ambos** os arquivos `.mlmodel` (`.mlmodel` do Boosted Tree e `.mlmodel` do Random Forest) para o "Project Navigator" do seu projeto Xcode. Certifique-se de que "Copy items if needed" e o seu "Target" estejam selecionados.
3.  **Atualize `TitanicViewModel.swift`:**
    * Crie um novo arquivo Swift chamado `TitanicViewModel.swift`.
    * Copie e cole o código fornecido, **substituindo os placeholders** `TitanicSurvivalPredictor_BoostedTree` e `TitanicSurvivalPredictor_RandomForest` pelos **nomes exatos das classes geradas pelo Xcode** para seus modelos `.mlmodel`.
    * Certifique-se de que a capitalização dos nomes dos inputs (`sexMale`, `embarkedQ`, etc.) esteja correta conforme o Xcode gerou.
4.  **Atualize `ContentView.swift`:**
    * Abra o arquivo `ContentView.swift`.
    * Copie e cole o código SwiftUI fornecido.
5.  **Execute o Aplicativo:**
    * Selecione um simulador iOS (ex: iPhone 15 Pro) e clique no botão "Run" (seta de play no canto superior esquerdo do Xcode).
    * Interaja com a interface, altere os dados do passageiro, selecione os diferentes modelos e observe as previsões em tempo real.
---

## 📧 Contato

Se você tiver alguma dúvida ou sugestão, sinta-se à vontade para entrar em contato.
- **DuckNCode** - *Desenvolvedor principal* - [@dCangianelli](https://github.com/danielCangianelli)
- dcangianelli@icloud.com

---