//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Garima Bothra on 10/06/20.
//  Copyright © 2020 Garima Bothra. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var showingProgress = false
    @State private var scoreTitle = ""
    @State private var message = ""

    var body: some View {
        ZStack {

            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                    Text("Your score is \(score)")
                    .foregroundColor(.white)
                }

                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        Image(self.countries[number]).renderingMode(.original).clipShape(Capsule()).overlay(Capsule().stroke(Color.black, lineWidth: 1.0)).shadow(color: .black, radius: 2.0)
                    }
                }
                Spacer()
            }
            .alert(isPresented: $showingProgress) {
                Alert(title: Text(scoreTitle), message: Text(message), dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                    })
            }
        }
    }

    func flagTapped(_ number: Int){
        if(number == correctAnswer){
            scoreTitle = "Correct"
            message = "Amazing, it's the flag of \(countries[correctAnswer])"
            score += 1
        } else {
            scoreTitle = "Oops! Try again"
            message = "Wrong! The correct answer is \(countries[correctAnswer])"
        }
        showingProgress = true
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0 ... 2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
