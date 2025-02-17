import SwiftUI

public extension NavigationPath {
	struct CodableRepresentation {
		let storage: Any
	}
}

extension NavigationPath.CodableRepresentation: Codable {
	public init(from decoder: Decoder) throws {
		var container = try decoder.unkeyedContainer()
		var items: [NavigationPathItem] = []

		while !container.isAtEnd {
			let typeName = try container.decode(String.self)
			let jsonValue = try container.decode(String.self)
			items.insert(NavigationPathItem(typeName: typeName, jsonValue: jsonValue), at: 0)
		}

		storage = items
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.unkeyedContainer()

		try (storage as! [NavigationPathItem]).reversed().forEach { item in
			try item.encodePair(container: &container)
		}
	}
}
