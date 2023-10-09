//
//  CharacteristicsView.swift
//  ReLife
//
//  Created by Andrew Kuzmich on 09.10.2023.
//

import SwiftUI

struct CharacteristicsView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 10) {
                    Text("Char")
                    //                            ForEach(characteristics.sorted(by: { $0.name < $1.name })) { characteristic in
                    //                                CharacteristicRow(characteristic: $characteristic)
                        .padding()
                }
            }
            .padding()
        }
        .navigationTitle("Characteristics")
        .toolbar {
            //                        ToolbarItem(placement: .navigationBarTrailing) {
            //                            Button(action: {
            ////                                isAddingCharacteristic.toggle()
            //                            }) {
            //                                Image(systemName: "plus")
            //                            }
            //                        }
            //                    }
            //                }
            //                .sheet(isPresented: $isAddingCharacteristic) {
            //                    NavigationView {
            //                        VStack(spacing: 20) {
            //                            TextField("Characteristic Name", text: "newCharacteristicName")
            //                                .padding()
            //                                .textFieldStyle(RoundedBorderTextFieldStyle())
            //
            ////                            Stepper(value: $newCharacteristicPoints, in: 0...100, step: 10) {
            ////                                Text("Points: newCharacteristicPoints")
            ////                            }
            //
            //                            Button(action: {
            ////                                addCharacteristic()
            //                            }) {
            //                                Text("Add Characteristic")
            //                                    .padding()
            //                                    .background(Color.blue)
            //                                    .foregroundColor(.white)
            //                                    .cornerRadius(10)
            //                            }
            //                        }
            //                        .padding()
            //                        .navigationTitle("Add Characteristic")
            //                        .toolbar {
            //                            ToolbarItem(placement: .navigationBarLeading) {
            //                                Button("Cancel") {
            ////                                    isAddingCharacteristic.toggle()
            //                                }
            //                            }
            //                        }
            //                    }
            //                }
        }
    }
        }

struct CharacteristicsView_Previews: PreviewProvider {
    static var previews: some View {
        CharacteristicsView()
    }
}
