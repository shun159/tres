#![allow(bad_style, missing_copy_implementations, improper_ctypes)]

mod gobgp_utils;
use gobgp_utils::get_route_family;
use gobgp_utils::serialize_path;

use gobgp_utils::{buf, path_t};

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
    [("nif_get_route_family", 1, nif_get_route_family),
     ("serialize_path", 2, nif_serialize_path)],
    None
);

pub fn nif_get_route_family<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let mut p0: String = args[0].decode()?;
    let family = unsafe { get_route_family(&mut p0) };

    Ok((atoms::ok(), family).encode(env))
}

pub fn nif_serialize_path<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let mut family: u32 = args[0].decode()?;
    let mut path_str: String = args[1].decode()?;
    let mut path: path_t = unsafe { serialize_path(&mut family, &mut path_str) }

    Ok((atoms::ok(), ))
}
