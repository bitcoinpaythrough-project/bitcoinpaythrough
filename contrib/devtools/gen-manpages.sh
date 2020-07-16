#!/usr/bin/env bash

export LC_ALL=C
TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

BITCOINPAYTHROUGHD=${BITCOINPAYTHROUGHD:-$BINDIR/bitcoinpaythroughd}
BITCOINPAYTHROUGHCLI=${BITCOINPAYTHROUGHCLI:-$BINDIR/bitcoinpaythrough-cli}
BITCOINPAYTHROUGHTX=${BITCOINPAYTHROUGHTX:-$BINDIR/bitcoinpaythrough-tx}
WALLET_TOOL=${WALLET_TOOL:-$BINDIR/bitcoinpaythrough-wallet}
BITCOINPAYTHROUGHQT=${BITCOINPAYTHROUGHQT:-$BINDIR/qt/bitcoinpaythrough-qt}

[ ! -x $BITCOINPAYTHROUGHD ] && echo "$BITCOINPAYTHROUGHD not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
read -r -a BPHVER <<< "$($BITCOINPAYTHROUGHCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }')"

# Create a footer file with copyright content.
# This gets autodetected fine for bitcoinpaythroughd if --version-string is not set,
# but has different outcomes for bitcoinpaythrough-qt and bitcoinpaythrough-cli.
echo "[COPYRIGHT]" > footer.h2m
$BITCOINPAYTHROUGHD --version | sed -n '1!p' >> footer.h2m

for cmd in $BITCOINPAYTHROUGHD $BITCOINPAYTHROUGHCLI $BITCOINPAYTHROUGHTX $WALLET_TOOL $BITCOINPAYTHROUGHQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${BPHVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${BPHVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
