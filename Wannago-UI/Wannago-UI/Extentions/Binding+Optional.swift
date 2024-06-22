import SwiftUI

extension Binding {
    func unwrap<T>() -> Binding<T>? where Value == T? {
        guard let value = self.wrappedValue else { return nil }
        return Binding<T>(
            get: { value },
            set: { self.wrappedValue = $0 }
        )
    }
}
