import SwiftUI

struct ContentView: View {

    @State private var calories = 1450
    @State private var targetCalories = 2200

    @State private var protein = 95
    @State private var targetProtein = 150

    @State private var water = 1.8
    @State private var targetWater = 2.5

    var body: some View {

        NavigationStack {

            ZStack {

                LinearGradient(
                    colors: [.blue.opacity(0.3), .purple.opacity(0.3)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                ScrollView {

                    VStack(spacing: 20) {

                        Text("NutriTrack")
                            .font(.largeTitle)
                            .fontWeight(.bold)

                        CalorieRing(
                            calories: calories,
                            target: targetCalories
                        )

                        ScoreCard(
                            score: dailyScore
                        )

                        HStack {

                            StatCard(
                                title: "Белки",
                                value: "\(protein) г",
                                icon: "bolt.fill"
                            )

                            StatCard(
                                title: "Вода",
                                value: "\(water) л",
                                icon: "drop.fill"
                            )
                        }

                        VStack(spacing: 15) {

                            Button("+100 ккал") {
                                calories += 100
                            }

                            Button("+10 г белка") {
                                protein += 10
                            }

                            Button("+250 мл воды") {
                                water += 0.25
                            }

                        }
                        .buttonStyle(.borderedProminent)

                        VStack(alignment: .leading) {

                            Text("Рекомендация")
                                .font(.headline)

                            Text(recommendation)

                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.ultraThinMaterial)
                        .cornerRadius(20)

                    }
                    .padding()
                }
            }
        }
    }

    var dailyScore: Int {

        let caloriePart = min(Int(Double(calories) / Double(targetCalories) * 50), 50)
        let proteinPart = min(Int(Double(protein) / Double(targetProtein) * 30), 30)
        let waterPart = min(Int(water / targetWater * 20), 20)

        return caloriePart + proteinPart + waterPart
    }

    var recommendation: String {

        if protein < targetProtein {
            return "Добавь больше белка в рацион."
        }

        if water < targetWater {
            return "Пора выпить воды."
        }

        return "Сегодня всё отлично."
    }
}

struct CalorieRing: View {

    let calories: Int
    let target: Int

    var progress: Double {
        min(Double(calories) / Double(target), 1.0)
    }

    var body: some View {

        ZStack {

            Circle()
                .stroke(.gray.opacity(0.2), lineWidth: 20)

            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    .green,
                    style: StrokeStyle(
                        lineWidth: 20,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))

            VStack {

                Text("\(calories)")
                    .font(.system(size: 40, weight: .bold))

                Text("из \(target) ккал")
                    .foregroundColor(.secondary)
            }
        }
        .frame(width: 220, height: 220)
    }
}

struct ScoreCard: View {

    let score: Int

    var body: some View {

        VStack {

            Text("Рейтинг дня")
                .font(.headline)

            Text("\(score)/100")
                .font(.system(size: 40, weight: .bold))

            ProgressView(
                value: Double(score),
                total: 100
            )

        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
        .cornerRadius(20)
    }
}

struct StatCard: View {

    let title: String
    let value: String
    let icon: String

    var body: some View {

        VStack(spacing: 10) {

            Image(systemName: icon)
                .font(.title)

            Text(title)

            Text(value)
                .fontWeight(.bold)

        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(20)
    }
}

#Preview {
    ContentView()
}
