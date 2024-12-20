//
//  Dotenv.swift
//  FullWeatherApp
//
//  Created by Görkem Arpacı on 20.10.2024.
//

import Foundation

class Dotenv {
    static func load(filename: String = ".env") {
        // .env dosyasının yolunu al
        guard let path = Bundle.main.path(forResource: filename, ofType: nil) else {
            print(".env dosyası bulunamadı!")
            return
        }

        do {
            // Dosya içeriğini oku
            let contents = try String(contentsOfFile: path, encoding: .utf8)
            let lines = contents.split(whereSeparator: \.isNewline)

            // Her satırı anahtar-değer çiftlerine ayır
            for line in lines {
                let parts = line.split(separator: "=", maxSplits: 1)
                guard parts.count == 2 else { continue }

                let key = String(parts[0]).trimmingCharacters(in: .whitespacesAndNewlines)
                let value = String(parts[1]).trimmingCharacters(in: .whitespacesAndNewlines)

                // Ortam değişkenini ayarla
                setenv(key, value, 1)
            }
        } catch {
            print("Hata: .env dosyası okunamadı - \(error)")
        }
    }
}
