// Copyright (c) 2011-2014 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef BITCOINPAYTHROUGH_QT_BITCOINPAYTHROUGHADDRESSVALIDATOR_H
#define BITCOINPAYTHROUGH_QT_BITCOINPAYTHROUGHADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class BitcoinpaythroughAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit BitcoinpaythroughAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

/** Bitcoinpaythrough address widget validator, checks for a valid bitcoinpaythrough address.
 */
class BitcoinpaythroughAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit BitcoinpaythroughAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

#endif // BITCOINPAYTHROUGH_QT_BITCOINPAYTHROUGHADDRESSVALIDATOR_H
