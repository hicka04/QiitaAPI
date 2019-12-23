# QiitaAPIClient
## Description
Type-Safe QiitaAPI Client

## Requirements
* iOS >= v11
* macOS >= v10.15

## install
### Swift Package Manager
Package.swift
```Swift
// ...
    dependencies: [
        .package(url: "https://github.com/hicka04/QiitaAPIClient.git", .upToNextMajor("version"))
    ],
    targets: [
        .target(
            name: "YourTarget",
            dependencies: ["QiitaAPIClient"]),
// ...
```

```sh
$ swfit package build
```

## Usage
### `Combine` (Recommend)
```Swift
import QiitaAPIClient

var cancellables: Set<AnyCancellable> = []

QiitaAPIClient().send(QiitaAPI.SearchItems())
    .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
            print(error)
        case .finished:
            print("finished")
        }
    }) { items in
        print(items)
    }.store(in: &cancellables)
```

### Closure
```Swift
import QiitaAPIClient

QiitaAPIClient().send(QiitaAPI.SearchItems()) { [weak self] result in
    switch result {
    case .success(let items):
        print(items)
    case .failure(let error):
        print(error)
    }
}
```

## Mocking
Sample Code: [MockQiitaAPIClient.swift](./Tests/QiitaAPIClientTests/MockQiitaAPIClient.swift)
