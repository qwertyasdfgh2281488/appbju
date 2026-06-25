import SwiftUI

struct ContentView: View {

    @StateObject private var homeViewModel = HomeViewModel()

    var body: some View {

        TabView {

            NavigationStack {

                HomeView(viewModel: homeViewModel)

            }
            .tabItem {

                Label("Главная", systemImage: "house.fill")

            }

            NavigationStack {

                DiaryView()

            }
            .tabItem {

                Label("Дневник", systemImage: "fork.knife")

            }

            NavigationStack {

                StatisticsView()

            }
            .tabItem {

                Label("Статистика", systemImage: "chart.bar.fill")

            }

            NavigationStack {

                ProfileView()

            }
            .tabItem {

                Label("Профиль", systemImage: "person.fill")

            }

        }
        .tint(.green)

    }

}

#Preview {

    ContentView()

}
