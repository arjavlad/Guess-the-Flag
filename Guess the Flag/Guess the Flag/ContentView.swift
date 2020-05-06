//
//  ContentView.swift
//  Guess the Flag
//
//  Created by Arjav Lad on 06/05/20.
//  Copyright © 2020 Arjav Lad. All rights reserved.
//

import SwiftUI

struct ContentView: View {

	@State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
	@State private var correctAnswer = Int.random(in: 0...2)

	@State private var showingScore = false
	@State private var scoreTitle = ""

	@State private var score = 0

	var body: some View {
		ZStack {
			LinearGradient(gradient: Gradient(colors: [.blue, .black]),
						   startPoint: .top,
						   endPoint: .bottom).edgesIgnoringSafeArea(.all)
			VStack(spacing: 30) {
				VStack {
					Text("Tap the flag of")
						.foregroundColor(.white)
					Text(countries[correctAnswer])
						.foregroundColor(.white)
						.font(.largeTitle)
						.fontWeight(.black)
				}
				ForEach(0..<3) { number in
					Button(action: {
						self.flagTapped(number)
					}) {
						Image(self.countries[number])
							.renderingMode(.original)
							.clipShape(Capsule())
							.overlay(Capsule().strokeBorder(Color.black,lineWidth: 1))
							.shadow(color: .black, radius: 2)
					}
				}
				Spacer()
			}
		}.alert(isPresented: $showingScore) { () -> Alert in
			Alert(title: Text(scoreTitle),
				  message: Text("Your score is \(score)"),
				  dismissButton: .default(Text("Continue"), action: {
					self.askQuestion()
				}))
		}
	}

	func flagTapped(_ number: Int) {
		if number == correctAnswer {
			score += 50
			scoreTitle = "Correct"
		} else {
			scoreTitle = "Wrong"
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
