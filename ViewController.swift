import UIKit
import WebKit

class ViewController: UIViewController {
    var webView: WKWebView!
    var isAnimationPlaying = false
    var isModelVisible = true

    override func viewDidLoad() {
        super.viewDidLoad()

        setupWebView()
        setupButtons()
    }

    func setupWebView() {
        // Initialize WKWebView
        webView = WKWebView(frame: .zero)
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)

        // Load the HTML file
        if let url = Bundle.main.url(forResource: "index", withExtension: "html") {
            webView.loadFileURL(url, allowingReadAccessTo: url)
        }

        // WebView constraints
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80) // Leave space for buttons
        ])
    }

    func setupButtons() {
        // Play/Pause Animation Button
        let animationButton = UIButton(type: .system)
        animationButton.setTitle("Play Animation", for: .normal)
        animationButton.translatesAutoresizingMaskIntoConstraints = false
        animationButton.backgroundColor = .systemBlue
        animationButton.tintColor = .white
        animationButton.layer.cornerRadius = 10
        animationButton.addTarget(self, action: #selector(toggleAnimation), for: .touchUpInside)
        view.addSubview(animationButton)

        // Show/Hide Model Button
        let visibilityButton = UIButton(type: .system)
        visibilityButton.setTitle("Hide Model", for: .normal)
        visibilityButton.translatesAutoresizingMaskIntoConstraints = false
        visibilityButton.backgroundColor = .systemRed
        visibilityButton.tintColor = .white
        visibilityButton.layer.cornerRadius = 10
        visibilityButton.addTarget(self, action: #selector(toggleVisibility), for: .touchUpInside)
        view.addSubview(visibilityButton)

        // Button Constraints
        NSLayoutConstraint.activate([
            animationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            animationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            animationButton.widthAnchor.constraint(equalToConstant: 150),
            animationButton.heightAnchor.constraint(equalToConstant: 50),

            visibilityButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            visibilityButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            visibilityButton.widthAnchor.constraint(equalToConstant: 150),
            visibilityButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc func toggleAnimation() {
        let script: String
        if isAnimationPlaying {
            script = "document.querySelector('#modelViewer').pause(); document.querySelector('#toggleAnimation').textContent = 'Play Animation';"
        } else {
            script = "document.querySelector('#modelViewer').play(); document.querySelector('#toggleAnimation').textContent = 'Pause Animation';"
        }
        isAnimationPlaying.toggle()
        webView.evaluateJavaScript(script, completionHandler: nil)
    }

    @objc func toggleVisibility() {
        let script: String
        if isModelVisible {
            script = "document.querySelector('#modelViewer').style.display = 'none'; document.querySelector('#toggleModel').textContent = 'Show Model';"
        } else {
            script = "document.querySelector('#modelViewer').style.display = 'block'; document.querySelector('#toggleModel').textContent = 'Hide Model';"
        }
        isModelVisible.toggle()
        webView.evaluateJavaScript(script, completionHandler: nil)
    }
}
