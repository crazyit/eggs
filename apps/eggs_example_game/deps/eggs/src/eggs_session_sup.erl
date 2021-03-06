%% eggs (Erlang Generic Game Server)
%%
%% Copyright (C) 2012-2013  Jordi Llonch <llonch.jordi at gmail dot com>
%%
%% This program is free software: you can redistribute it and/or modify
%% it under the terms of the GNU Affero General Public License as
%% published by the Free Software Foundation, either version 3 of the
%% License, or (at your option) any later version.
%%
%% This program is distributed in the hope that it will be useful,
%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%% GNU Affero General Public License for more details.
%%
%% You should have received a copy of the GNU Affero General Public License
%% along with this program.  If not, see <http://www.gnu.org/licenses/>.

-module(eggs_session_sup).
-behaviour(supervisor).

%% API
-export([start_link/0]).

%% supervisor
-export([init/1, start_session/1]).

%% API
-spec start_link() -> 'ignore' | {'error',_} | {'ok',pid()}.
start_link() ->
  lager:debug("Starting session supervisor..."),
  supervisor:start_link(?MODULE, []).

%% supervisor callbacks
-spec init([]) -> {'ok',{{'one_for_one',5,10},[]}}.
init([]) ->
%%   WorkerSpecs = {make_ref(), {SessionModule, start_link, []}, temporary, 2000, worker, [SessionModule]},
%%   StartSpecs = {{simple_one_for_one, 0, 1},[WorkerSpecs]},
%%   {ok, StartSpecs}.
  {ok, {{one_for_one, 5, 10}, []}}.

-spec start_session(atom() | pid() | {atom(),atom()}) -> {'ok','undefined' | pid()}.
start_session(SessionSupPid) ->
  lager:debug("Starting new session..."),
  {ok, SessionPid} = supervisor:start_child(SessionSupPid, []),
  {ok, SessionPid}.

