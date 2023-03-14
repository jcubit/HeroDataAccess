//
//  Utils.swift
//  
//
//  Created by Javier Cuesta on 14.03.23.
//

import Foundation

// Resource: https://forums.swift.org/t/how-can-i-access-a-file-inside-of-an-xctestcase/53424/5

func fixtureData(for fixture: String) throws -> Data {
    try Data(contentsOf: fixtureUrl(for: fixture))
}


func fixtureUrl(for fixture: String) -> URL {
    fixturesDirectory().appendingPathComponent(fixture)
}


func fixturesDirectory(path: String = #file) -> URL {
    let url = URL(fileURLWithPath: path)
    let testsDir = url.deletingLastPathComponent()
    return testsDir.appendingPathComponent("Fixtures")
}
