//
//  ContentView.swift
//  SwiftDemanglerMac
//
//  Created by Joseph Heck on 2/22/21.
//

import SwiftUI
import CwlDemangle

struct ContentView: View {
    @State private var mangledSymbol: String = ""
    @State private var unmangledString: String = ""
    @State private var errorMessage: String = ""
    
    var body: some View {
        VStack {
            TextField("enter mangled string", text: $mangledSymbol)
                .onChange(of: mangledSymbol, perform: { value in
                    do {
                        let swiftSymbol = try parseMangledSwiftSymbol(value)
                        let result = swiftSymbol.print(using:
                           SymbolPrintOptions.default.union(.synthesizeSugarOnTypes))
                        unmangledString = result
                        errorMessage = ""
                    } catch {
                        errorMessage = "Error: \(error)"
                    }
                })
                .padding()
            Text(errorMessage).font(.caption).foregroundColor(.red)

            TextField("unmangled", text: $unmangledString)
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.sizeThatFits)
    }
}
