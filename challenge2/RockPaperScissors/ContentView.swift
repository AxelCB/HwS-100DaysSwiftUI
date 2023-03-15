//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Axel Collard Bovy on 1/8/22.
//

import SwiftUI

let possibleChoices = ["Rock", "Paper", "Scissors"]
let winningMoves = ["Paper", "Scissors", "Rock"]
let losingMoves = ["Scissors", "Rock", "Paper"]

struct ContentView: View {
    @State var appsMove = Int.random(in: 0..<3)
    @State var shouldWin = Bool.random()
    @State var playerScore = 0
    @State var currentQuestion = 0

    var body: some View {
        VStack {
            VStack {
                Text("App's move \(possibleChoices[appsMove])")
                Text("Should \(shouldWin ? "win" : "lose")")
            }
            VStack {
                Text("You choose:")
                ForEach(possibleChoices, id: \.self) { choice in
                    Button(choice) {
                        onChoiceTap(choice)
                    }
                }
            }
            Text("Your score is: \(playerScore)")
        }
        .onAppear(perform: nextQuestion)
    }

    func onChoiceTap(_ choice: String) {
        guard choice != possibleChoices[appsMove] else {
            nextQuestion()
            return
        }

        if (shouldWin && choice == winningMoves[appsMove])
            || (!shouldWin && choice == losingMoves[appsMove]) {
            playerScore += 10
        } else {
            playerScore -= 10
        }
        nextQuestion()
    }

    func nextQuestion() {
        shouldWin.toggle()
        appsMove = Int.random(in: 0..<3)
        currentQuestion += 1

        if currentQuestion == 10 {
            endGame()
        }
    }

    func endGame() {
        // Show alert with game over message
        // option to restart a new game
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
