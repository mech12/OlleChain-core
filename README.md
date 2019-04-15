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


# How to find Olle-data transaction. 
-------------------

* step 1 :  find transaction  included "OP_RETURN"

* step 2 :  olle colored coin value ( 0.00001013 ) in transaction vout list

* step 3 :  Decoding op_return's data and check sign field 


## step 3  example code 
```js
            var ret = tx.vout.find(vo => {
                return vo.value == 0; // this is op_return data
            });

            var result = ret.scriptPubKey.asm.replace('OP_RETURN ', '');
            result = Buffer.from(result.toString(), 'hex').toString('utf8');
            result = JSON.parse(result);
            const sign = result.sign;
            const node = result.node;

            const Message = require('bitcore-message');
            function signVerify(signature, message) => {
                var verified = Message(message).verify(g_G.VAR.OLLE_SIGN_ADDRESS, signature);
                return verified;
            }
            assert ( signVerify(sign , node ) == true );
```


## Olle-Data transaction sample
```json
{
  "txid": "034b3db2d7423290e5e3bfec67467254f1888d80999a44a24ba10e291cee157f",
  "hash": "034b3db2d7423290e5e3bfec67467254f1888d80999a44a24ba10e291cee157f",
  "version": 2,
  "size": 4771,
  "vsize": 4771,
  "locktime": 0,
  "vin": [
    {
      "txid": "cc0aec3092e5ff9611597f169640146b1db8840bb1653ce0a41e8f2243bc8e00",
      "vout": 0,
      "scriptSig": {
        "asm": "3045022100df06416735b82bc93cc0275e00b6d4a2087cf64885f586ab0a780528867f735e0220710f48d2a0e8a4eced8ff800ef367e3f85a3f936e3889cb33055e1f4afc393e8[ALL] 03c5e17b1041ad1f50dddc124125ee1b528c7b75e1eb91b3cee31e51f98fb9f263",
        "hex": "483045022100df06416735b82bc93cc0275e00b6d4a2087cf64885f586ab0a780528867f735e0220710f48d2a0e8a4eced8ff800ef367e3f85a3f936e3889cb33055e1f4afc393e8012103c5e17b1041ad1f50dddc124125ee1b528c7b75e1eb91b3cee31e51f98fb9f263"
      },
      "sequence": 4294967295
    }
  ],
  "vout": [
    {
      "value": 0,
      "n": 0,
      "scriptPubKey": {
        "asm": "OP_RETURN 7b227369676e223a2 ... ... ... 0322d32305430343a34323a30352e3239365a227d5d7d",
        "hex": "6a4db2117b2273696 ... ... ... 1392d30322d32305430343a34323a30352e3239365a227d5d7d",
        "type": "nulldata"
      }
    },
    {
      "value": 0.00001012,
      "n": 1,
      "scriptPubKey": {
        "asm": "OP_DUP OP_HASH160 f64e33fe767406c63306104f3b07882e4618e3b9 OP_EQUALVERIFY OP_CHECKSIG",
        "hex": "76a914f64e33fe767406c63306104f3b07882e4618e3b988ac",
        "reqSigs": 1,
        "type": "pubkeyhash",
        "addresses": [
          "1PTLuqYnttxvcyR1rRjySUa6x2b19HyrK5"
        ]
      }
    },
    {
      "value": 0.2319392,
      "n": 2,
      "scriptPubKey": {
        "asm": "OP_DUP OP_HASH160 a65d0fe4961584ae5d08c216a52b00bdc6d42272 OP_EQUALVERIFY OP_CHECKSIG",
        "hex": "76a914a65d0fe4961584ae5d08c216a52b00bdc6d4227288ac",
        "reqSigs": 1,
        "type": "pubkeyhash",
        "addresses": [
          "1GAeeupQZDLmWZFHR4a7UC7N4oLwbqU64b"
        ]
      }
    }
  ],
  "hex": "0200000001008ebc43228f1e ... ... ... d08c216a52b00bdc6d4227288ac00000000",
  "blockhash": "00000000b00111324a6a27409d0a541145da3611c830ebba582c5c344293b90b",
  "confirmations": 9869,
  "time": 1550637759,
  "blocktime": 1550637759
}
```

## Ollek-Data prev-signing data
```js

    var sign = g_G.bitcoin.signMessage('olle', OLLE_SIGN_PRIVATE_KEY );

    let txt = JSON.stringify({
        sign: sign,
        node: 'olle',
        ver: 1,
        sendDate: new Date(),

        type: rq.type,
        data: dataList,
    });
    var op_return_data = Buffer.from(txt).toString('hex');

```

