# idus_Introduction

## 🖥 프로젝트 소개
### **아이디어스 앱 소개 서비스** 

<br>

## 📌 사용 기술

- 사용 기술:  `UIKit`, `URLSession`, `NSCache`, `UICollectionViewFlowLayout`, `delegatePattern`, `MVVM`, `POP`

<br>

## ✏️ 주요 로직

**Network Layer 나누기**
- EndPoint, Request, APIError, URLSession+
- URLSession+에서 dataTask와 uploadTask를 func으로 재정의해주고 사용 

```swift
extension URLSession {
    typealias Handler = (Data?, URLResponse?, Error?) -> Void
    
    @discardableResult
    func dataTask(_ endpoint: URLRequest, handler: @escaping Handler) -> URLSessionDataTask {
        let task = dataTask(with: endpoint, completionHandler: handler)
        task.resume()
        return task
    }
    // ...
}
```

```swift
    static func request<T: Decodable>(_ session: URLSession = .shared, endpoint: URLRequest, completion: @escaping(Result<T, APIError>) -> Void) {
        session.dataTask(endpoint) { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(.failure(.failed))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.invalidData))
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                guard response.statusCode == 200 else {
                    completion(.failure(.unexpectedStatusCode(statusCode: "\(response.statusCode)")))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let userData = try decoder.decode(T.self, from: data)
                    completion(.success(userData))
                } catch {
                    completion(.failure(.invalidData))
                }
            }
        }
    }
```

<br>

**Generic을 이용한 POP(Protocol Oriented Programming)**
  
```swift
protocol ReusableCell {
    static var identifier: String { get }
}

extension ReusableCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionView {
    func register<T: UICollectionViewCell>(cellType: T.Type) where T: ReusableCell {
        self.register(cellType, forCellWithReuseIdentifier: cellType.identifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(cellType: T.Type, indexPath: IndexPath) -> T where T: ReusableCell {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: cellType.identifier, for: indexPath) as? T else { fatalError() }
        return cell
    }
}
```

```swift
extension PreviewTableViewCell {
    // ...
    private func attribute() {
        previewCollectionView.register(cellType: PreviewCollectionViewCell.self)
        // ...
    }
}
```

```swift
extension PreviewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    // ...
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = previewCollectionView.dequeueReusableCell(cellType: PreviewCollectionViewCell.self, indexPath: indexPath)
        // ...
    }
}
```

<br>

**이미지 캐싱**

```swift
enum LoadImageError: Error {
    case networkError
    case noImage
}

class LoadImage {
    static let cache = NSCache<NSString, UIImage>()
    
    func loadImage(_ url: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        if let image = LoadImage.cache.object(forKey: url as NSString) {
            completion(.success(image))
            return
        }
        
        guard let imageURL = URL(string: url) else { return }
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: imageURL) { data, response, error in
            guard error == nil else {
                completion(.failure(LoadImageError.networkError))
                return
            }
            
            guard let data = data else {
                completion(.failure(LoadImageError.noImage))
                return
            }
            
            guard let image = UIImage(data: data) else { return }
            LoadImage.cache.setObject(image, forKey: url as NSString)
            completion(.success(image))
        }
        dataTask.resume()
    }
}

```

<br>

**Alert 재사용 func**

```swift
extension UIViewController {
    
    func alert(title: String, message: String, okTitle: String = "확인") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: okTitle, style: .default)
        alert.addAction(ok)
        
        self.present(alert, animated: true, completion: nil)
    }
}
```

<br>

**closure 변수를 이용한 MVVM 로직처리**

```swift
final class SearchViewModel {
    
    // ...
    var loadingSucceed: () -> () = {}
    var loadingFailed: (_ error: APIError) -> () = { error in }
    
    func getDetail(_ id: String) {
        detailAPIService.getDetail(id) { result in
            switch result {
            case .success(let detail):
                self.detailData = detail
                self.loadingSucceed()
                // ...
            }
        }
    }
    // ...
}
```
