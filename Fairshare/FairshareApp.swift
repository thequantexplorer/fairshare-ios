import SwiftUI

@main
struct FairshareApp: App {
    @State private var store = ReceiptStore()

    var body: some Scene {
        WindowGroup {
            ReceiptListView()
                .environment(store)
        }
    }
}
