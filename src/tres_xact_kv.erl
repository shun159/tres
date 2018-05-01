-module(tres_xact_kv).

-include_lib("stdlib/include/ms_transform.hrl").

-export([create/0, drop/1]).
-export([insert/3, insert/4,
         update/3, get/2,
         delete/2, is_exists/2,
         is_empty/1]).

-define(TABLE, xact_kv).
-define(ENTRY, xact_entry).
-define(TABLE_OPTS, [set, protected, {keypos, #?ENTRY.xid}]).

-record(?ENTRY, {xid = 0, pending = nil, orig = nil, from = nil}).

-spec create() -> reference().
create() ->
    ets:new(?TABLE, ?TABLE_OPTS).

-spec drop(reference()) -> true.
drop(Tid) ->
    ets:delete(Tid).

-spec insert(reference(), integer(), map()) -> true.
insert(Tid, Xid, Orig) ->
    ets:insert(Tid, #?ENTRY{xid = Xid, orig = Orig}).

-spec insert(reference(), integer(), map(), term()) -> true.
insert(Tid, Xid, Orig, From) ->
    ets:insert(Tid, #?ENTRY{xid = Xid, orig = Orig, from = From}).

-spec update(reference(), integer(), map()) -> integer().
update(Tid, Xid, #{'__struct__' := 'Elixir.Openflow.ErrorMsg'} = Error) ->
    ets:select_replace(Tid, ms_for_handle_error(Tid, Xid, Error));
update(Tid, Xid, Msg) ->
    ets:select_replace(Tid, ms_for_update(Xid, Msg)).

-spec get(reference(), integer()) -> [term()].
get(Tid, Xid) ->
    ets:select(Tid, ms_for_get(Xid)).

-spec delete(reference(), integer()) -> integer().
delete(Tid, Xid) ->
    ets:select_delete(Tid, ms_for_exists(Xid)).

-spec is_exists(reference(), integer()) -> boolean().
is_exists(Tid, Xid) ->
    case ets:select(Tid, ms_for_exists(Xid)) of
        [_|_] -> true;
        []    -> false
    end.

-spec is_empty(reference()) -> boolean().
is_empty(Tid) ->
    case ets:info(Tid, size) of
        0 -> true;
        _ -> false
    end.

%% Private functions

ms_for_exists(Xid) ->
    ets:fun2ms(fun(#?ENTRY{xid = TXid}) when TXid == Xid -> true end).

ms_for_get(Xid) ->
    ets:fun2ms(fun(#?ENTRY{xid = TXid} = E) when TXid == Xid -> E end).

ms_for_update(Xid, Msg) ->
    ets:fun2ms(fun(#?ENTRY{xid = TXid} = E) when TXid == Xid -> E#?ENTRY{pending = Msg} end).

ms_for_handle_error(Tid, Xid, Error) ->
    [#?ENTRY{orig = Orig}|_] = get(Tid, Xid),
    Error1 = maps:merge(Error, #{data => Orig, xid => Xid}),
    ets:fun2ms(fun(#?ENTRY{xid = TXid} = E) when TXid == Xid -> E#?ENTRY{pending = Error1} end).
