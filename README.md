OlleChain core Source Code
=====================================

[This code forked from Bitcoin](https://github.com/bitcoin/bitcoin)

https://bitcoincore.org


License
-------

OlleChain Core is released under the terms of the MIT license. See [COPYING](COPYING) for more
information or see https://opensource.org/licenses/MIT.

Differences from the original Bitcoin-core
-------------------
``` c++
        static const int COINBASE_MATURITY = 5; // 100 -> 5

        consensus.nPowTargetTimespan = 60 * 60; // 2week => 1 hour
        consensus.nPowTargetSpacing = 60; // 10 min => 1 minute

        static const CAmount MAX_MONEY = 9223372036854775000; // unlimited

        CAmount GetBlockSubsidy() // It's removed the subsidy halflife code.
```
