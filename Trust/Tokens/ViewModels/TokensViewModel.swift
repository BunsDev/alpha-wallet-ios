// Copyright SIX DAY LLC. All rights reserved.

import Foundation
import UIKit

struct TokensViewModel {

    var tokens: [TokenObject] = []
    var tickers: [String: CoinTicker]?

    private var amount: String? {
        var totalAmount: Double = 0
        tokens.forEach { token in
            totalAmount += amount(for: token)
        }
        guard totalAmount != 0 else { return "--" }
        return CurrencyFormatter.formatter.string(from: NSNumber(value: totalAmount))
    }

    private func amount(for token: TokenObject) -> Double {
        guard let tickers = tickers else { return 0 }
        guard !token.valueBigInt.isZero, let tickersSymbol = tickers[token.contract] else { return 0 }
        let tokenValue = CurrencyFormatter.plainFormatter.string(from: token.valueBigInt, decimals: token.decimals).doubleValue
        let price = Double(tickersSymbol.price) ?? 0
        return tokenValue * price
    }

    var headerBalance: String? {
        return amount
    }

    var headerBalanceTextColor: UIColor {
        return Colors.black
    }

    var headerBackgroundColor: UIColor {
        return .white
    }

    var headerBalanceFont: UIFont {
        return Fonts.semibold(size: 26)!
    }

    var title: String {
        return NSLocalizedString("tokens.navigation.title", value: "Tokens", comment: "")
    }

    var backgroundColor: UIColor {
        return .white
    }

    var hasContent: Bool {
        return !tokens.isEmpty
    }

    var numberOfSections: Int {
        return 1
    }

    func numberOfItems(for section: Int) -> Int {
        return tokens.count
    }

    func item(for row: Int, section: Int) -> TokenObject {
        return tokens[row]
    }

    func ticker(for token: TokenObject) -> CoinTicker? {
        return tickers?[token.contract]
    }

    func canDelete(for row: Int, section: Int) -> Bool {
        let token = item(for: row, section: section)
        return token.isCustom
    }

    var footerTitle: String {
        return NSLocalizedString("tokens.footer.label.title", value: "Tokens will appear automagically. + to add manually.", comment: "")
    }

    var footerTextColor: UIColor {
        return Colors.black
    }

    var footerTextFont: UIFont {
        return Fonts.light(size: 15)!
    }
}
