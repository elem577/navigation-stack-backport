import SwiftUI

public struct NavigationPath {
	public var count: Int { box.count }
	public var isEmpty: Bool { box.isEmpty }
	public var codable: CodableRepresentation? { box.backportedCodable }

	private var box: any NavigationPathBox

	var storage: NavigationPathBackport {
		get { box as! NavigationPathBackport }
		set { box = newValue }
	}

	public init() {
        box = NavigationPathBackport(items: [])
	}

	public init<S: Sequence>(_ elements: S) where S.Element: Hashable {
        box = NavigationPathBackport(items: elements.map { .init(value: $0) })
	}

	public init<S: Sequence>(_ elements: S) where S.Element: Hashable, S.Element: Codable {
        box = NavigationPathBackport(items: elements.map { .init(value: $0) })
	}

	public init(_ codable: CodableRepresentation) {
        box = NavigationPathBackport(items: codable.storage as! [NavigationPathItem])
	}
}

public extension NavigationPath {
	mutating func append<V: Hashable>(_ value: V) {
		box.append(value)
	}

	mutating func append<V>(_ value: V) where V: Hashable, V: Codable {
		box.append(value)
	}

	mutating func removeLast(_ k: Int = 1) {
		box.removeLast(k)
	}
}

extension NavigationPath: Equatable {
	public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.box as? NavigationPathBackport == rhs.box as? NavigationPathBackport
	}
}
