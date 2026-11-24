import SwiftUI
import WebKit
import AVFoundation

@main
struct CarTubeLiteApp: App {
    init() {
        // Route audio to the car speakers while parked (video stays on phone)
        try? AVAudioSession.sharedInstance().setCategory(.playback)
        try? AVAudioSession.sharedInstance().setActive(true)
    }
    var body: some Scene { WindowGroup { ContentView() } }
}

struct ContentView: View {
    @State private var mode = 0

    var body: some View {
        VStack(spacing: 6) {
            Text("CarTubeLite").font(.headline)
            Picker("", selection: $mode) {
                Text("YouTube").tag(0)
                Text("Netflix").tag(1)
            }.pickerStyle(.segmented).padding(.horizontal)
            if mode == 0 {
                WebPlayer(url: URL(string: "https://m.youtube.com")!)
            } else {
                WebPlayer(url: URL(string: "https://www.netflix.com")!)
            }
        }
    }
}

struct WebPlayer: UIViewRepresentable {
    let url: URL
    func makeUIView(context: Context) -> WKWebView {
        let cfg = WKWebViewConfiguration()
        cfg.allowsInlineMediaPlayback = true
        cfg.mediaTypesRequiringUserActionForPlayback = []
        let wv = WKWebView(frame: .zero, configuration: cfg)
        wv.customUserAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1"
        wv.load(URLRequest(url: url))
        return wv
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}
