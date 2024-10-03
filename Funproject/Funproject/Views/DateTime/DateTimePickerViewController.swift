import SwiftUI
import UIKit

class DateTimePickerViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swiftUIView = DateTimePickerView()
        let hostingController = UIHostingController(rootView: swiftUIView)
        addChild(hostingController)
        hostingController.view.frame = self.view.bounds
        self.view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
    }
}
