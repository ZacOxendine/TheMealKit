import UIKit

// MARK: - Error Handling

extension AppDelegate {
    // `AppDelegate` sits at the top of the responder chain.
    override func handle(
        _ error: Error,
        from viewController: UIViewController,
        retryHandler: @escaping () -> Void
    ) {
        let alertController = UIAlertController(
            title: "An error occurred.",
            message: error.localizedDescription,
            preferredStyle: .alert
        )

        alertController.addAction(UIAlertAction(
            title: "Dismiss",
            style: .default
        ))

        switch error.resolveCategory() {
        case .retryable:
            alertController.addAction(UIAlertAction(
                title: "Retry",
                style: .default,
                handler: { _ in retryHandler() }
            ))
        case .notRetryable:
            break
        }

        viewController.present(alertController, animated: true)
    }
}

extension UIResponder {
    // `Error` sent, moves up the responder chain, using the `next` property.
    @objc func handle(
        _ error: Error,
        from viewController: UIViewController,
        retryHandler: @escaping () -> Void
    ) {
        guard let nextResponder = self.next else {
            return assertionFailure(
                """
                Unhandled error \(error) from \(viewController).
                """
            )
        }

        nextResponder.handle(
            error,
            from: viewController,
            retryHandler: retryHandler
        )
    }
}

extension UIViewController {
    // Convenience API to automate `self` passing.
    func handle(_ error: Error, retryHandler: @escaping () -> Void) {
        handle(error, from: self, retryHandler: retryHandler)
    }
}
