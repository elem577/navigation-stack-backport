struct NavigationPathBackport {
	var items: [NavigationPathItem]
    var animated: Bool = true
}

extension NavigationPathBackport: Equatable {}

extension NavigationPathBackport: NavigationPathBox {
    
	var count: Int { items.count }
	var isEmpty: Bool { items.isEmpty }

	var backportedCodable: NavigationPath.CodableRepresentation? {
		guard items.allSatisfy(\.isCodable) else { return nil }
		return .init(storage: items)
	}

	mutating func append<V: Hashable>(_ value: V) {
        animated = true
		items.append(NavigationPathItem(value: value))
	}

	mutating func append<V>(_ value: V) where V: Hashable, V: Codable {
        animated = true
		items.append(NavigationPathItem(value: value))
	}

	mutating func removeLast(_ k: Int) {
        animated = true
		items.removeLast(k)
	}
    
    mutating func removeSubrange(_ bounds: Range<Int>) {
        animated = false
        items.removeSubrange(bounds)
    }
    
    mutating func remove(at: Int) {
        animated = false
        items.remove(at: at)
    }
}
