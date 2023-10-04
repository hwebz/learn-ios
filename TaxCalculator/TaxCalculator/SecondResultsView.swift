//
//  SecondResultsView.swift
//  TaxCalculator
//
//  Created by Personal on 04/10/2023.
//

import SwiftUI
import SwiftUICharts

struct TaxBreakdown {
    var postTaxSalary: Double
    var incomeTax: Double
    var nationalInsuranceTax: Double
    var chartData: [(String, Double)]
    var postTaxPercentage: Double
    var incomeTaxPercentage: Double
    var nationalInsurancePercentage: Double
}

struct SecondResultsView: View {
    @Binding var salary: String
    var taxOption: FrontView.TaxOption
    var geography: FrontView.Geography
    
    private func calculateTaxBreakdown(for salary: Double, in geography: FrontView.Geography, and taxOption: FrontView.TaxOption) -> TaxBreakdown {
        var incomeTax: Double = 0
        var nationalInsuranceTax: Double = 0
        
        /// Income                      Tax rate
        /// Up to 12,570                0%              Personal allowance
        /// 12,570 to 37,700          20%           Basic rate
        /// 37,701 to 150,000        40%             Higher rate
        /// over 150,000                45%             Additional rate
        if (salary > 12570) {
            if (salary > 37700) {
                if (salary > 150000) {
                    incomeTax += (37700 - 12571) * 0.2
                    incomeTax += (150000 - 37701) + 0.4
                    incomeTax += (salary - 150000) * 0.45
                } else {
                    incomeTax += (37700 - 12571) * 0.2
                    incomeTax += (salary - 37700) * 0.4
                }
            } else {
                incomeTax += (salary - 12570) * 0.2
            }
        }
        
        nationalInsuranceTax = salary * 0.13
        let countryTax = geography == .country("USA") ? 100.0 : 0
        let taxOptionTax = taxOption == .option1 ? 100.0 : 0
        let postTaxSalary = salary - incomeTax - nationalInsuranceTax - countryTax - taxOptionTax
        let chartData: [(String, Double)] = [
            ("Post Tax Salary", postTaxSalary),
            ("Tax", incomeTax),
            ("National Insurance", nationalInsuranceTax)
        ]
        let totalSalary = salary + nationalInsuranceTax
        let postTaxPercentage = postTaxSalary / totalSalary * 100
        let incomeTaxPercentage = incomeTax / totalSalary * 100
        let nationalInsurancePercentage = nationalInsuranceTax / totalSalary * 100
        return TaxBreakdown(
            postTaxSalary: postTaxSalary,
            incomeTax: incomeTax,
            nationalInsuranceTax: nationalInsuranceTax,
            chartData: chartData,
            postTaxPercentage: postTaxPercentage,
            incomeTaxPercentage: incomeTaxPercentage,
            nationalInsurancePercentage: nationalInsurancePercentage
        )
    }
    
    private func formatCurrency(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "£"
        return formatter.string(from: NSNumber(value: value)) ?? ""
    }
    
    var body: some View {
        let salaryNum: Double = Double(salary) ?? 0
        let taxBreakdown = calculateTaxBreakdown(for: salaryNum, in: geography, and: taxOption)
        let salaryString = formatCurrency(salaryNum)
        let postTaxSalaryString = formatCurrency(taxBreakdown.postTaxSalary)
        let incomeTaxString = formatCurrency(taxBreakdown.incomeTax)
        let nationalInsuranceTaxString = formatCurrency(taxBreakdown.nationalInsuranceTax)
        
        return VStack {
            PieChart()
                .data(taxBreakdown.chartData)
                .chartStyle(ChartStyle(backgroundColor: .white, foregroundColor: ColorGradient(.blue, .purple)))
            
            Text("Before Tax")
                .font(.system(size: 32))
                .padding(.vertical)
            Text(salaryString)
                .font(.system(size: 32))
                .padding(.vertical)
            Text("After Tax")
                .font(.system(size: 32))
                .padding(.vertical)
            Text(postTaxSalaryString)
                .font(.system(size: 32))
                .padding(.vertical)
            
            Group {
                Text("Post Tax Salary")
                ProgressView(postTaxSalaryString, value: taxBreakdown.postTaxPercentage, total: 100)
                Text("Tax")
                ProgressView(incomeTaxString, value: taxBreakdown.incomeTaxPercentage, total: 100)
                Text("National Insurance")
                ProgressView(nationalInsuranceTaxString, value: taxBreakdown.nationalInsurancePercentage, total: 100)
            }
        }
        .padding()
        .navigationTitle("Summary")
    }
}
struct SecondResultsView_Previews: PreviewProvider {
    static var previews: some View {
        SecondResultsView(salary: .constant("100"), taxOption: .option1, geography: .country("USA"))
    }
}
