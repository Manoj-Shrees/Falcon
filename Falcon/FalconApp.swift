import SwiftUI
import StreamVideo
import StreamVideoSwiftUI

@main
struct FalconApp: App {
    @ObservedObject var viewModel: CallViewModel

    private var client: StreamVideo

    private let apiKey: String = "mmhfdzb5evj2"
    private let token: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL3Byb250by5nZXRzdHJlYW0uaW8iLCJzdWIiOiJ1c2VyL0phaW5hX1NvbG8iLCJ1c2VyX2lkIjoiSmFpbmFfU29sbyIsInZhbGlkaXR5X2luX3NlY29uZHMiOjYwNDgwMCwiaWF0IjoxNzMyMDA4MTQ5LCJleHAiOjE3MzI2MTI5NDl9.KMLtiPhFRVx9S0-KRwM_-doPTgWKWVIyyELzGU6dSrE"
    private let userId: String = "Jaina_Solo"
    private let callId: String = "dY7bnWHA8fJ1"

    init() {
        let user = User(
            id: userId,
            name: "Suwas", // name and imageURL are used in the UI
            imageURL: .init(string: "https://getstream.io/static/2796a305dd07651fcceb4721a94f4505/a3911/martin-mitrevski.webp")
        )

        // Initialize Stream Video client
        self.client = StreamVideo(
            apiKey: apiKey,
            user: user,
            token: .init(stringLiteral: token)
        )

        self.viewModel = .init()
    }

    var body: some Scene {
        WindowGroup {
            VStack {
                if viewModel.call != nil {
                    CallContainer(viewFactory: DefaultViewFactory.shared, viewModel: viewModel)
                } else {
                    Text("Getting ready...")
                }
            }.onAppear {
                Task {
                    guard viewModel.call == nil else { return }
                    viewModel.joinCall(callType: .default, callId: callId)
                }
            }
        }
    }
}
