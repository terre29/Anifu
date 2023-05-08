//
//  APIHelper.swift
//  Anifu
//
//  Created by Terretino on 02/01/23.
//

import Foundation
import RxSwift

public struct APIHelper {
    public static let shared = APIHelper()
    
    func load<T>(resource: Resource<T>) -> Observable<T> {
        return Observable.just(resource.url)
            .flatMap { url -> Observable<Data> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.data(request: request)
            }.map { data -> T in
                let jsonData = try JSONDecoder().decode(T.self, from: data)
                return jsonData
            }
    }
}
