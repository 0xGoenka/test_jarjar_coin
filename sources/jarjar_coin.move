module jarjar_coin::jarjar_coin;

use sui::coin::{Self, TreasuryCap};
use sui::url::{Url, Self};

public struct JARJAR_COIN has drop {}

fun init(witness: JARJAR_COIN, ctx: &mut TxContext) {

    let symbol = b"JARJAR";
    let name = b"JARJAR";
    let url: Url = url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1836050301935108096/tBRhFEfC_400x400.jpg");
    let description = b"Coin for the jarjar ecosystem";

    let (treasury, metadata) = coin::create_currency(witness, 6, symbol,name, 
    description, option::some(url), ctx);
    transfer::public_freeze_object(metadata);
    transfer::public_transfer(treasury, ctx.sender())
}

public fun mint(
    treasury_cap: &mut TreasuryCap<JARJAR_COIN>, 
    amount: u64, 
    ctx: &mut TxContext,
) {
    let coin = coin::mint(treasury_cap, amount, ctx);
    transfer::public_transfer(coin, ctx.sender());
}