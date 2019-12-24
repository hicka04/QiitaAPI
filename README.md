# QiitaAPIClient
## Description
Type-Safe QiitaAPI Client

## Requirements
* iOS >= v13
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

QiitaAPIClient().send(QiitaAPI.SearchArticles())
    .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
            print(error)
        case .finished:
            print("finished")
        }
    }) { articles in
        print(articles)
    }.store(in: &cancellables)
```

### Closure
```Swift
import QiitaAPIClient

QiitaAPIClient().send(QiitaAPI.SearchArticles()) { [weak self] result in
    switch result {
    case .success(let articles):
        print(articles)
    case .failure(let error):
        print(error)
    }
}
```

## Mocking
Sample Code: [MockQiitaAPIClient.swift](./Tests/QiitaAPIClientTests/MockQiitaAPIClient.swift)
