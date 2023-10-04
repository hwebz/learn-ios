//
//  ContentView.swift
//  TaxCalculator
//
//  Created by Personal on 04/10/2023.
//

import SwiftUI

struct FrontView: View {
    @State private var salary: String = ""
    @State private var isSalaryValid: Bool = false
    @State private var selectedTaxOption: TaxOption = .option1
    @State private var selectedGeography: Geography = .country("USA")
    
    enum Geography: Hashable {
        case country(String)
        case state(String, String) // Country, State
        var displayText: String {
            switch self {
            case .country(let country):
                return country
            case .state(let country, let state):
                return "\(state), \(country)"
            }
        }
    }
    
    enum TaxOption: String, CaseIterable {
        case option1 = "Income Tax"
        case option2 = "Dividen Tax"
        case option3 = "Corporation Tax"
        // You can add more tax options if needed
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Annual Salary")
                    .padding(.bottom, 75)
                
                TextField("Salary", text: $salary)
                    .frame(width: 200)
                    .border(.black, width: 1)
                    .padding(.bottom, 75)
                    .keyboardType(.decimalPad)
                
                Picker("Tax Option", selection: $selectedTaxOption) {
                    ForEach(TaxOption.allCases, id: \.self) { option in
                        Text(option.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.bottom, 75)
                
                Picker("Geography", selection: $selectedGeography) {
                    Text("USA").tag(Geography.country("USA"))
                    Text("California, USA").tag(Geography.state("USA", "California"))
                    // Add more geography options as needed
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.bottom, 75)
                
                Button {
                    
                } label: {
                    Text("Calculate Tax")
                }
                .buttonStyle(.borderedProminent)
                
                NavigationLink(isActive: $isSalaryValid) {
//                    ResultsView(salary: $salary)
//                    AnotherResultsView(salary: salary, taxOption: selectedTaxOption, geography: selectedGeography)
                    SecondResultsView(salary: salary, taxOption: selectedTaxOption, geography: selectedGeography)
                } label: {
                    Text("Calculate Tax")
                        .bold()
                        .frame(width: 200, height: 50)
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .onTapGesture {
                            GoToResultView()
                        }
                }
            }
            .padding()
            .navigationTitle("Main Page")
        }
    }
    
    func GoToResultView() {
//        if (Float(salary) != nil) {
//            if (Float(salary)! > 0) {
//                isSalaryValid = true
//            }
//        }
        if let salaryFloat = Float(salary), salaryFloat > 0 {
            isSalaryValid = true
        }
    }
}

struct AnotherResultsView: View {
    var salary: String
    var taxOption: FrontView.TaxOption
    var geography: FrontView.Geography
    
    var body: some View {
        VStack {
            Text("Results")
                .font(.title)
                .padding()
            Text("Salary: \(salary)")
                .padding()
            Text("Tax Option: \(taxOption.rawValue)")
                .padding()
            Text("Geography: \(geography.displayText)")
            // Calculate and display tax results based on the selected tax option
            Spacer()
        }
    }
}

struct FrontView_Previews: PreviewProvider {
    static var previews: some View {
        FrontView()
    }
}
