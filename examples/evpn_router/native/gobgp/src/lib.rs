#![allow(bad_style, missing_copy_implementations, improper_ctypes)]

pub mod gobgp_utils;

#[macro_use] extern crate rustler;
#[macro_use] extern crate lazy_static;

use rustler::{Env, Term, NifResult, Encoder};

mod atoms {
    rustler_atoms! {
        atom ok;
    }
}

rustler_export_nifs!(
    "Elixir.EvpnRouter.GoBGP.NativeUtils",
    [("get_route_family", 2, get_route_family)],
    None
);

fn get_route_family<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let num1: i64 = args[0].decode()?;
    let num2: i64 = args[1].decode()?;

    Ok((atoms::ok(), num1 + num2).encode(env))
}
