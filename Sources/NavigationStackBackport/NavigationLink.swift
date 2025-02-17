import SwiftUI

public struct NavigationLink<Label: View>: View {
	public let body: AnyView

	public init<P: Hashable>(value: P?, @ViewBuilder label: () -> Label) {
        body = AnyView(Backport(label: label(), item: value.map { .init(value: $0) }))
	}

	public init<P: Hashable>(value: P?, @ViewBuilder label: () -> Label) where P: Codable {
        body = AnyView(Backport(label: label(), item: value.map { .init(value: $0) }))
	}

	public init<P: Hashable>(_ titleKey: LocalizedStringKey, value: P?) where Label == Text {
        body = AnyView(Backport(label: Text(titleKey), item: value.map { .init(value: $0) }))
	}

	public init<P: Hashable>(_ titleKey: LocalizedStringKey, value: P?) where Label == Text, P: Codable {
        body = AnyView(Backport(label: Text(titleKey), item: value.map { .init(value: $0) }))
	}

	public init<P: Hashable, S>(_ title: S, value: P?) where Label == Text, S: StringProtocol {
        body = AnyView(Backport(label: Text(title), item: value.map { .init(value: $0) }))
	}

	public init<P: Hashable, S>(_ title: S, value: P?) where Label == Text, S: StringProtocol, P: Codable {
        body = AnyView(Backport(label: Text(title), item: value.map { .init(value: $0) }))
	}
}

private extension NavigationLink {
	struct Backport: View {
		let label: Label
		let item: NavigationPathItem?
		@Environment(\.navigationAuthority) private var authority

		var body: some View {
			Button {
				guard let item else { return }
				authority.pathPushPublisher.send(item)
			} label: {
				label
			}
			.disabled(item == nil || !authority.canNavigate)
		}
	}
}
