import XCTest
import QiitaAPI

final class QiitaAPITests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let apiExpectation = expectation(description: "api request")
        QiitaAPI().send(SearchItems()) { result in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error)
            }
            apiExpectation.fulfill()
        }
        wait(for: [apiExpectation], timeout: 2)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
