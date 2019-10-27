//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Eihab Khan on 25/10/2019.
//  Copyright © 2019 Eihab Khan. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    @State private var showingScore = false
    @State private var scoreTitle   = ""
    @State private var userScore = 0
    @State private var answerMessage = ""
    
    @State private var countries = ["Estonia", "France", "Italy", "Germany", "Ireland","Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .font(.body)
                        .foregroundColor(.white)
                    Text((countries[correctAnswer]))
                        .foregroundColor(.white)
                        .font(.title)
                        .fontWeight(.black)
                    
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 2))
                            .shadow(color: .black, radius: 2)
                    }
                    
                }
                
                Spacer()

                HStack(alignment: .center, spacing: 10) {
                    Text("Score: ")
                    .foregroundColor(.white)
                    
                    Text("\(userScore)")
                    .foregroundColor(.white)
                        .fontWeight(.bold)
                }
                
                
                }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text(answerMessage), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
                })
        }
       
    } // ==> End of Body
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            userScore += 1
            answerMessage = "Your score is: \(userScore)"
        } else {
            scoreTitle = "Wrong"
            userScore -= 1
            answerMessage = "That's the flag of \(countries[number]) \n Your score is: \(userScore)"
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



//          Color.red.frame(width: 200, height: 200)
//            Color.red.edgesIgnoringSafeArea(.all)
//            Color(red: 1, green: 0.8, blue: 0.5)
//            LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .top, endPoint: .bottom)
