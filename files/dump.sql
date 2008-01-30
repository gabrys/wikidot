--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres81
--

COMMENT ON SCHEMA public IS 'Standard public schema';


--
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: 
--

CREATE PROCEDURAL LANGUAGE plpgsql;


SET search_path = public, pg_catalog;

--
-- Name: gtsvector_in(cstring); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION gtsvector_in(cstring) RETURNS gtsvector
    AS '$libdir/tsearch2', 'gtsvector_in'
    LANGUAGE c STRICT;


ALTER FUNCTION public.gtsvector_in(cstring) OWNER TO wd;

--
-- Name: gtsvector_out(gtsvector); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION gtsvector_out(gtsvector) RETURNS cstring
    AS '$libdir/tsearch2', 'gtsvector_out'
    LANGUAGE c STRICT;


ALTER FUNCTION public.gtsvector_out(gtsvector) OWNER TO wd;

--
-- Name: gtsvector; Type: TYPE; Schema: public; Owner: wd
--

CREATE TYPE gtsvector (
    INTERNALLENGTH = variable,
    INPUT = gtsvector_in,
    OUTPUT = gtsvector_out,
    ALIGNMENT = int4,
    STORAGE = plain
);


ALTER TYPE public.gtsvector OWNER TO wd;

--
-- Name: tsquery_in(cstring); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION tsquery_in(cstring) RETURNS tsquery
    AS '$libdir/tsearch2', 'tsquery_in'
    LANGUAGE c STRICT;


ALTER FUNCTION public.tsquery_in(cstring) OWNER TO wd;

--
-- Name: tsquery_out(tsquery); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION tsquery_out(tsquery) RETURNS cstring
    AS '$libdir/tsearch2', 'tsquery_out'
    LANGUAGE c STRICT;


ALTER FUNCTION public.tsquery_out(tsquery) OWNER TO wd;

--
-- Name: tsquery; Type: TYPE; Schema: public; Owner: wd
--

CREATE TYPE tsquery (
    INTERNALLENGTH = variable,
    INPUT = tsquery_in,
    OUTPUT = tsquery_out,
    ALIGNMENT = int4,
    STORAGE = plain
);


ALTER TYPE public.tsquery OWNER TO wd;

--
-- Name: tsvector_in(cstring); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION tsvector_in(cstring) RETURNS tsvector
    AS '$libdir/tsearch2', 'tsvector_in'
    LANGUAGE c STRICT;


ALTER FUNCTION public.tsvector_in(cstring) OWNER TO wd;

--
-- Name: tsvector_out(tsvector); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION tsvector_out(tsvector) RETURNS cstring
    AS '$libdir/tsearch2', 'tsvector_out'
    LANGUAGE c STRICT;


ALTER FUNCTION public.tsvector_out(tsvector) OWNER TO wd;

--
-- Name: tsvector; Type: TYPE; Schema: public; Owner: wd
--

CREATE TYPE tsvector (
    INTERNALLENGTH = variable,
    INPUT = tsvector_in,
    OUTPUT = tsvector_out,
    ALIGNMENT = int4,
    STORAGE = extended
);


ALTER TYPE public.tsvector OWNER TO wd;

--
-- Name: statinfo; Type: TYPE; Schema: public; Owner: wd
--

CREATE TYPE statinfo AS (
	word text,
	ndoc integer,
	nentry integer
);


ALTER TYPE public.statinfo OWNER TO wd;

--
-- Name: tokenout; Type: TYPE; Schema: public; Owner: wd
--

CREATE TYPE tokenout AS (
	tokid integer,
	token text
);


ALTER TYPE public.tokenout OWNER TO wd;

--
-- Name: tokentype; Type: TYPE; Schema: public; Owner: wd
--

CREATE TYPE tokentype AS (
	tokid integer,
	alias text,
	descr text
);


ALTER TYPE public.tokentype OWNER TO wd;

--
-- Name: tsdebug; Type: TYPE; Schema: public; Owner: wd
--

CREATE TYPE tsdebug AS (
	ts_name text,
	tok_type text,
	description text,
	token text,
	dict_name text[],
	tsvector tsvector
);


ALTER TYPE public.tsdebug OWNER TO wd;

--
-- Name: _get_parser_from_curcfg(); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION _get_parser_from_curcfg() RETURNS text
    AS $$ select prs_name from pg_ts_cfg where oid = show_curcfg() $$
    LANGUAGE sql IMMUTABLE STRICT;


ALTER FUNCTION public._get_parser_from_curcfg() OWNER TO wd;

--
-- Name: concat(tsvector, tsvector); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION concat(tsvector, tsvector) RETURNS tsvector
    AS '$libdir/tsearch2', 'concat'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.concat(tsvector, tsvector) OWNER TO wd;

--
-- Name: dex_init(internal); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION dex_init(internal) RETURNS internal
    AS '$libdir/tsearch2', 'dex_init'
    LANGUAGE c;


ALTER FUNCTION public.dex_init(internal) OWNER TO wd;

--
-- Name: dex_lexize(internal, internal, integer); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION dex_lexize(internal, internal, integer) RETURNS internal
    AS '$libdir/tsearch2', 'dex_lexize'
    LANGUAGE c STRICT;


ALTER FUNCTION public.dex_lexize(internal, internal, integer) OWNER TO wd;

--
-- Name: exectsq(tsvector, tsquery); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION exectsq(tsvector, tsquery) RETURNS boolean
    AS '$libdir/tsearch2', 'exectsq'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.exectsq(tsvector, tsquery) OWNER TO wd;

--
-- Name: FUNCTION exectsq(tsvector, tsquery); Type: COMMENT; Schema: public; Owner: wd
--

COMMENT ON FUNCTION exectsq(tsvector, tsquery) IS 'boolean operation with text index';


--
-- Name: get_covers(tsvector, tsquery); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION get_covers(tsvector, tsquery) RETURNS text
    AS '$libdir/tsearch2', 'get_covers'
    LANGUAGE c STRICT;


ALTER FUNCTION public.get_covers(tsvector, tsquery) OWNER TO wd;

--
-- Name: gtsvector_compress(internal); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION gtsvector_compress(internal) RETURNS internal
    AS '$libdir/tsearch2', 'gtsvector_compress'
    LANGUAGE c;


ALTER FUNCTION public.gtsvector_compress(internal) OWNER TO wd;

--
-- Name: gtsvector_consistent(gtsvector, internal, integer); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION gtsvector_consistent(gtsvector, internal, integer) RETURNS boolean
    AS '$libdir/tsearch2', 'gtsvector_consistent'
    LANGUAGE c;


ALTER FUNCTION public.gtsvector_consistent(gtsvector, internal, integer) OWNER TO wd;

--
-- Name: gtsvector_decompress(internal); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION gtsvector_decompress(internal) RETURNS internal
    AS '$libdir/tsearch2', 'gtsvector_decompress'
    LANGUAGE c;


ALTER FUNCTION public.gtsvector_decompress(internal) OWNER TO wd;

--
-- Name: gtsvector_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION gtsvector_penalty(internal, internal, internal) RETURNS internal
    AS '$libdir/tsearch2', 'gtsvector_penalty'
    LANGUAGE c STRICT;


ALTER FUNCTION public.gtsvector_penalty(internal, internal, internal) OWNER TO wd;

--
-- Name: gtsvector_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION gtsvector_picksplit(internal, internal) RETURNS internal
    AS '$libdir/tsearch2', 'gtsvector_picksplit'
    LANGUAGE c;


ALTER FUNCTION public.gtsvector_picksplit(internal, internal) OWNER TO wd;

--
-- Name: gtsvector_same(gtsvector, gtsvector, internal); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION gtsvector_same(gtsvector, gtsvector, internal) RETURNS internal
    AS '$libdir/tsearch2', 'gtsvector_same'
    LANGUAGE c;


ALTER FUNCTION public.gtsvector_same(gtsvector, gtsvector, internal) OWNER TO wd;

--
-- Name: gtsvector_union(internal, internal); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION gtsvector_union(internal, internal) RETURNS integer[]
    AS '$libdir/tsearch2', 'gtsvector_union'
    LANGUAGE c;


ALTER FUNCTION public.gtsvector_union(internal, internal) OWNER TO wd;

--
-- Name: headline(oid, text, tsquery, text); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION headline(oid, text, tsquery, text) RETURNS text
    AS '$libdir/tsearch2', 'headline'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.headline(oid, text, tsquery, text) OWNER TO wd;

--
-- Name: headline(oid, text, tsquery); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION headline(oid, text, tsquery) RETURNS text
    AS '$libdir/tsearch2', 'headline'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.headline(oid, text, tsquery) OWNER TO wd;

--
-- Name: headline(text, text, tsquery, text); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION headline(text, text, tsquery, text) RETURNS text
    AS '$libdir/tsearch2', 'headline_byname'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.headline(text, text, tsquery, text) OWNER TO wd;

--
-- Name: headline(text, text, tsquery); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION headline(text, text, tsquery) RETURNS text
    AS '$libdir/tsearch2', 'headline_byname'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.headline(text, text, tsquery) OWNER TO wd;

--
-- Name: headline(text, tsquery, text); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION headline(text, tsquery, text) RETURNS text
    AS '$libdir/tsearch2', 'headline_current'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.headline(text, tsquery, text) OWNER TO wd;

--
-- Name: headline(text, tsquery); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION headline(text, tsquery) RETURNS text
    AS '$libdir/tsearch2', 'headline_current'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.headline(text, tsquery) OWNER TO wd;

--
-- Name: length(tsvector); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION length(tsvector) RETURNS integer
    AS '$libdir/tsearch2', 'tsvector_length'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.length(tsvector) OWNER TO wd;

--
-- Name: lexize(oid, text); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION lexize(oid, text) RETURNS text[]
    AS '$libdir/tsearch2', 'lexize'
    LANGUAGE c STRICT;


ALTER FUNCTION public.lexize(oid, text) OWNER TO wd;

--
-- Name: lexize(text, text); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION lexize(text, text) RETURNS text[]
    AS '$libdir/tsearch2', 'lexize_byname'
    LANGUAGE c STRICT;


ALTER FUNCTION public.lexize(text, text) OWNER TO wd;

--
-- Name: lexize(text); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION lexize(text) RETURNS text[]
    AS '$libdir/tsearch2', 'lexize_bycurrent'
    LANGUAGE c STRICT;


ALTER FUNCTION public.lexize(text) OWNER TO wd;

--
-- Name: parse(oid, text); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION parse(oid, text) RETURNS SETOF tokenout
    AS '$libdir/tsearch2', 'parse'
    LANGUAGE c STRICT;


ALTER FUNCTION public.parse(oid, text) OWNER TO wd;

--
-- Name: parse(text, text); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION parse(text, text) RETURNS SETOF tokenout
    AS '$libdir/tsearch2', 'parse_byname'
    LANGUAGE c STRICT;


ALTER FUNCTION public.parse(text, text) OWNER TO wd;

--
-- Name: parse(text); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION parse(text) RETURNS SETOF tokenout
    AS '$libdir/tsearch2', 'parse_current'
    LANGUAGE c STRICT;


ALTER FUNCTION public.parse(text) OWNER TO wd;

--
-- Name: prsd_end(internal); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION prsd_end(internal) RETURNS void
    AS '$libdir/tsearch2', 'prsd_end'
    LANGUAGE c;


ALTER FUNCTION public.prsd_end(internal) OWNER TO wd;

--
-- Name: prsd_getlexeme(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION prsd_getlexeme(internal, internal, internal) RETURNS integer
    AS '$libdir/tsearch2', 'prsd_getlexeme'
    LANGUAGE c;


ALTER FUNCTION public.prsd_getlexeme(internal, internal, internal) OWNER TO wd;

--
-- Name: prsd_headline(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION prsd_headline(internal, internal, internal) RETURNS internal
    AS '$libdir/tsearch2', 'prsd_headline'
    LANGUAGE c;


ALTER FUNCTION public.prsd_headline(internal, internal, internal) OWNER TO wd;

--
-- Name: prsd_lextype(internal); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION prsd_lextype(internal) RETURNS internal
    AS '$libdir/tsearch2', 'prsd_lextype'
    LANGUAGE c;


ALTER FUNCTION public.prsd_lextype(internal) OWNER TO wd;

--
-- Name: prsd_start(internal, integer); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION prsd_start(internal, integer) RETURNS internal
    AS '$libdir/tsearch2', 'prsd_start'
    LANGUAGE c;


ALTER FUNCTION public.prsd_start(internal, integer) OWNER TO wd;

--
-- Name: querytree(tsquery); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION querytree(tsquery) RETURNS text
    AS '$libdir/tsearch2', 'tsquerytree'
    LANGUAGE c STRICT;


ALTER FUNCTION public.querytree(tsquery) OWNER TO wd;

--
-- Name: rank(real[], tsvector, tsquery); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION rank(real[], tsvector, tsquery) RETURNS real
    AS '$libdir/tsearch2', 'rank'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.rank(real[], tsvector, tsquery) OWNER TO wd;

--
-- Name: rank(real[], tsvector, tsquery, integer); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION rank(real[], tsvector, tsquery, integer) RETURNS real
    AS '$libdir/tsearch2', 'rank'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.rank(real[], tsvector, tsquery, integer) OWNER TO wd;

--
-- Name: rank(tsvector, tsquery); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION rank(tsvector, tsquery) RETURNS real
    AS '$libdir/tsearch2', 'rank_def'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.rank(tsvector, tsquery) OWNER TO wd;

--
-- Name: rank(tsvector, tsquery, integer); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION rank(tsvector, tsquery, integer) RETURNS real
    AS '$libdir/tsearch2', 'rank_def'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.rank(tsvector, tsquery, integer) OWNER TO wd;

--
-- Name: rank_cd(integer, tsvector, tsquery); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION rank_cd(integer, tsvector, tsquery) RETURNS real
    AS '$libdir/tsearch2', 'rank_cd'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.rank_cd(integer, tsvector, tsquery) OWNER TO wd;

--
-- Name: rank_cd(integer, tsvector, tsquery, integer); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION rank_cd(integer, tsvector, tsquery, integer) RETURNS real
    AS '$libdir/tsearch2', 'rank_cd'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.rank_cd(integer, tsvector, tsquery, integer) OWNER TO wd;

--
-- Name: rank_cd(tsvector, tsquery); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION rank_cd(tsvector, tsquery) RETURNS real
    AS '$libdir/tsearch2', 'rank_cd_def'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.rank_cd(tsvector, tsquery) OWNER TO wd;

--
-- Name: rank_cd(tsvector, tsquery, integer); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION rank_cd(tsvector, tsquery, integer) RETURNS real
    AS '$libdir/tsearch2', 'rank_cd_def'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.rank_cd(tsvector, tsquery, integer) OWNER TO wd;

--
-- Name: reset_tsearch(); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION reset_tsearch() RETURNS void
    AS '$libdir/tsearch2', 'reset_tsearch'
    LANGUAGE c STRICT;


ALTER FUNCTION public.reset_tsearch() OWNER TO wd;

--
-- Name: rexectsq(tsquery, tsvector); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION rexectsq(tsquery, tsvector) RETURNS boolean
    AS '$libdir/tsearch2', 'rexectsq'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.rexectsq(tsquery, tsvector) OWNER TO wd;

--
-- Name: FUNCTION rexectsq(tsquery, tsvector); Type: COMMENT; Schema: public; Owner: wd
--

COMMENT ON FUNCTION rexectsq(tsquery, tsvector) IS 'boolean operation with text index';


--
-- Name: set_curcfg(integer); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION set_curcfg(integer) RETURNS void
    AS '$libdir/tsearch2', 'set_curcfg'
    LANGUAGE c STRICT;


ALTER FUNCTION public.set_curcfg(integer) OWNER TO wd;

--
-- Name: set_curcfg(text); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION set_curcfg(text) RETURNS void
    AS '$libdir/tsearch2', 'set_curcfg_byname'
    LANGUAGE c STRICT;


ALTER FUNCTION public.set_curcfg(text) OWNER TO wd;

--
-- Name: set_curdict(integer); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION set_curdict(integer) RETURNS void
    AS '$libdir/tsearch2', 'set_curdict'
    LANGUAGE c STRICT;


ALTER FUNCTION public.set_curdict(integer) OWNER TO wd;

--
-- Name: set_curdict(text); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION set_curdict(text) RETURNS void
    AS '$libdir/tsearch2', 'set_curdict_byname'
    LANGUAGE c STRICT;


ALTER FUNCTION public.set_curdict(text) OWNER TO wd;

--
-- Name: set_curprs(integer); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION set_curprs(integer) RETURNS void
    AS '$libdir/tsearch2', 'set_curprs'
    LANGUAGE c STRICT;


ALTER FUNCTION public.set_curprs(integer) OWNER TO wd;

--
-- Name: set_curprs(text); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION set_curprs(text) RETURNS void
    AS '$libdir/tsearch2', 'set_curprs_byname'
    LANGUAGE c STRICT;


ALTER FUNCTION public.set_curprs(text) OWNER TO wd;

--
-- Name: setweight(tsvector, "char"); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION setweight(tsvector, "char") RETURNS tsvector
    AS '$libdir/tsearch2', 'setweight'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.setweight(tsvector, "char") OWNER TO wd;

--
-- Name: show_curcfg(); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION show_curcfg() RETURNS oid
    AS '$libdir/tsearch2', 'show_curcfg'
    LANGUAGE c STRICT;


ALTER FUNCTION public.show_curcfg() OWNER TO wd;

--
-- Name: snb_en_init(internal); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION snb_en_init(internal) RETURNS internal
    AS '$libdir/tsearch2', 'snb_en_init'
    LANGUAGE c;


ALTER FUNCTION public.snb_en_init(internal) OWNER TO wd;

--
-- Name: snb_lexize(internal, internal, integer); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION snb_lexize(internal, internal, integer) RETURNS internal
    AS '$libdir/tsearch2', 'snb_lexize'
    LANGUAGE c STRICT;


ALTER FUNCTION public.snb_lexize(internal, internal, integer) OWNER TO wd;

--
-- Name: snb_ru_init(internal); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION snb_ru_init(internal) RETURNS internal
    AS '$libdir/tsearch2', 'snb_ru_init'
    LANGUAGE c;


ALTER FUNCTION public.snb_ru_init(internal) OWNER TO wd;

--
-- Name: spell_init(internal); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION spell_init(internal) RETURNS internal
    AS '$libdir/tsearch2', 'spell_init'
    LANGUAGE c;


ALTER FUNCTION public.spell_init(internal) OWNER TO wd;

--
-- Name: spell_lexize(internal, internal, integer); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION spell_lexize(internal, internal, integer) RETURNS internal
    AS '$libdir/tsearch2', 'spell_lexize'
    LANGUAGE c STRICT;


ALTER FUNCTION public.spell_lexize(internal, internal, integer) OWNER TO wd;

--
-- Name: stat(text); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION stat(text) RETURNS SETOF statinfo
    AS '$libdir/tsearch2', 'ts_stat'
    LANGUAGE c STRICT;


ALTER FUNCTION public.stat(text) OWNER TO wd;

--
-- Name: stat(text, text); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION stat(text, text) RETURNS SETOF statinfo
    AS '$libdir/tsearch2', 'ts_stat'
    LANGUAGE c STRICT;


ALTER FUNCTION public.stat(text, text) OWNER TO wd;

--
-- Name: strip(tsvector); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION strip(tsvector) RETURNS tsvector
    AS '$libdir/tsearch2', 'strip'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.strip(tsvector) OWNER TO wd;

--
-- Name: syn_init(internal); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION syn_init(internal) RETURNS internal
    AS '$libdir/tsearch2', 'syn_init'
    LANGUAGE c;


ALTER FUNCTION public.syn_init(internal) OWNER TO wd;

--
-- Name: syn_lexize(internal, internal, integer); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION syn_lexize(internal, internal, integer) RETURNS internal
    AS '$libdir/tsearch2', 'syn_lexize'
    LANGUAGE c STRICT;


ALTER FUNCTION public.syn_lexize(internal, internal, integer) OWNER TO wd;

--
-- Name: to_tsquery(oid, text); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION to_tsquery(oid, text) RETURNS tsquery
    AS '$libdir/tsearch2', 'to_tsquery'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.to_tsquery(oid, text) OWNER TO wd;

--
-- Name: to_tsquery(text, text); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION to_tsquery(text, text) RETURNS tsquery
    AS '$libdir/tsearch2', 'to_tsquery_name'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.to_tsquery(text, text) OWNER TO wd;

--
-- Name: to_tsquery(text); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION to_tsquery(text) RETURNS tsquery
    AS '$libdir/tsearch2', 'to_tsquery_current'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.to_tsquery(text) OWNER TO wd;

--
-- Name: to_tsvector(oid, text); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION to_tsvector(oid, text) RETURNS tsvector
    AS '$libdir/tsearch2', 'to_tsvector'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.to_tsvector(oid, text) OWNER TO wd;

--
-- Name: to_tsvector(text, text); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION to_tsvector(text, text) RETURNS tsvector
    AS '$libdir/tsearch2', 'to_tsvector_name'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.to_tsvector(text, text) OWNER TO wd;

--
-- Name: to_tsvector(text); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION to_tsvector(text) RETURNS tsvector
    AS '$libdir/tsearch2', 'to_tsvector_current'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.to_tsvector(text) OWNER TO wd;

--
-- Name: token_type(integer); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION token_type(integer) RETURNS SETOF tokentype
    AS '$libdir/tsearch2', 'token_type'
    LANGUAGE c STRICT;


ALTER FUNCTION public.token_type(integer) OWNER TO wd;

--
-- Name: token_type(text); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION token_type(text) RETURNS SETOF tokentype
    AS '$libdir/tsearch2', 'token_type_byname'
    LANGUAGE c STRICT;


ALTER FUNCTION public.token_type(text) OWNER TO wd;

--
-- Name: token_type(); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION token_type() RETURNS SETOF tokentype
    AS '$libdir/tsearch2', 'token_type_current'
    LANGUAGE c STRICT;


ALTER FUNCTION public.token_type() OWNER TO wd;

--
-- Name: ts_debug(text); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION ts_debug(text) RETURNS SETOF tsdebug
    AS $_$
select 
        m.ts_name,
        t.alias as tok_type,
        t.descr as description,
        p.token,
        m.dict_name,
        strip(to_tsvector(p.token)) as tsvector
from
        parse( _get_parser_from_curcfg(), $1 ) as p,
        token_type() as t,
        pg_ts_cfgmap as m,
        pg_ts_cfg as c
where
        t.tokid=p.tokid and
        t.alias = m.tok_alias and 
        m.ts_name=c.ts_name and 
        c.oid=show_curcfg() 
$_$
    LANGUAGE sql STRICT;


ALTER FUNCTION public.ts_debug(text) OWNER TO wd;

--
-- Name: tsearch2(); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION tsearch2() RETURNS "trigger"
    AS '$libdir/tsearch2', 'tsearch2'
    LANGUAGE c;


ALTER FUNCTION public.tsearch2() OWNER TO wd;

--
-- Name: tsvector_cmp(tsvector, tsvector); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION tsvector_cmp(tsvector, tsvector) RETURNS integer
    AS '$libdir/tsearch2', 'tsvector_cmp'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.tsvector_cmp(tsvector, tsvector) OWNER TO wd;

--
-- Name: tsvector_eq(tsvector, tsvector); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION tsvector_eq(tsvector, tsvector) RETURNS boolean
    AS '$libdir/tsearch2', 'tsvector_eq'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.tsvector_eq(tsvector, tsvector) OWNER TO wd;

--
-- Name: tsvector_ge(tsvector, tsvector); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION tsvector_ge(tsvector, tsvector) RETURNS boolean
    AS '$libdir/tsearch2', 'tsvector_ge'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.tsvector_ge(tsvector, tsvector) OWNER TO wd;

--
-- Name: tsvector_gt(tsvector, tsvector); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION tsvector_gt(tsvector, tsvector) RETURNS boolean
    AS '$libdir/tsearch2', 'tsvector_gt'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.tsvector_gt(tsvector, tsvector) OWNER TO wd;

--
-- Name: tsvector_le(tsvector, tsvector); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION tsvector_le(tsvector, tsvector) RETURNS boolean
    AS '$libdir/tsearch2', 'tsvector_le'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.tsvector_le(tsvector, tsvector) OWNER TO wd;

--
-- Name: tsvector_lt(tsvector, tsvector); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION tsvector_lt(tsvector, tsvector) RETURNS boolean
    AS '$libdir/tsearch2', 'tsvector_lt'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.tsvector_lt(tsvector, tsvector) OWNER TO wd;

--
-- Name: tsvector_ne(tsvector, tsvector); Type: FUNCTION; Schema: public; Owner: wd
--

CREATE FUNCTION tsvector_ne(tsvector, tsvector) RETURNS boolean
    AS '$libdir/tsearch2', 'tsvector_ne'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.tsvector_ne(tsvector, tsvector) OWNER TO wd;

--
-- Name: <; Type: OPERATOR; Schema: public; Owner: wd
--

CREATE OPERATOR < (
    PROCEDURE = tsvector_lt,
    LEFTARG = tsvector,
    RIGHTARG = tsvector,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.< (tsvector, tsvector) OWNER TO wd;

--
-- Name: <=; Type: OPERATOR; Schema: public; Owner: wd
--

CREATE OPERATOR <= (
    PROCEDURE = tsvector_le,
    LEFTARG = tsvector,
    RIGHTARG = tsvector,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.<= (tsvector, tsvector) OWNER TO wd;

--
-- Name: <>; Type: OPERATOR; Schema: public; Owner: wd
--

CREATE OPERATOR <> (
    PROCEDURE = tsvector_ne,
    LEFTARG = tsvector,
    RIGHTARG = tsvector,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (tsvector, tsvector) OWNER TO wd;

--
-- Name: =; Type: OPERATOR; Schema: public; Owner: wd
--

CREATE OPERATOR = (
    PROCEDURE = tsvector_eq,
    LEFTARG = tsvector,
    RIGHTARG = tsvector,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    SORT1 = <,
    SORT2 = <,
    LTCMP = <,
    GTCMP = >
);


ALTER OPERATOR public.= (tsvector, tsvector) OWNER TO wd;

--
-- Name: >; Type: OPERATOR; Schema: public; Owner: wd
--

CREATE OPERATOR > (
    PROCEDURE = tsvector_gt,
    LEFTARG = tsvector,
    RIGHTARG = tsvector,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.> (tsvector, tsvector) OWNER TO wd;

--
-- Name: >=; Type: OPERATOR; Schema: public; Owner: wd
--

CREATE OPERATOR >= (
    PROCEDURE = tsvector_ge,
    LEFTARG = tsvector,
    RIGHTARG = tsvector,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.>= (tsvector, tsvector) OWNER TO wd;

--
-- Name: @@; Type: OPERATOR; Schema: public; Owner: wd
--

CREATE OPERATOR @@ (
    PROCEDURE = rexectsq,
    LEFTARG = tsquery,
    RIGHTARG = tsvector,
    COMMUTATOR = @@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@@ (tsquery, tsvector) OWNER TO wd;

--
-- Name: @@; Type: OPERATOR; Schema: public; Owner: wd
--

CREATE OPERATOR @@ (
    PROCEDURE = exectsq,
    LEFTARG = tsvector,
    RIGHTARG = tsquery,
    COMMUTATOR = @@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@@ (tsvector, tsquery) OWNER TO wd;

--
-- Name: ||; Type: OPERATOR; Schema: public; Owner: wd
--

CREATE OPERATOR || (
    PROCEDURE = concat,
    LEFTARG = tsvector,
    RIGHTARG = tsvector
);


ALTER OPERATOR public.|| (tsvector, tsvector) OWNER TO wd;

--
-- Name: gist_tsvector_ops; Type: OPERATOR CLASS; Schema: public; Owner: wd
--

CREATE OPERATOR CLASS gist_tsvector_ops
    DEFAULT FOR TYPE tsvector USING gist AS
    STORAGE gtsvector ,
    OPERATOR 1 @@(tsvector,tsquery) RECHECK ,
    FUNCTION 1 gtsvector_consistent(gtsvector,internal,integer) ,
    FUNCTION 2 gtsvector_union(internal,internal) ,
    FUNCTION 3 gtsvector_compress(internal) ,
    FUNCTION 4 gtsvector_decompress(internal) ,
    FUNCTION 5 gtsvector_penalty(internal,internal,internal) ,
    FUNCTION 6 gtsvector_picksplit(internal,internal) ,
    FUNCTION 7 gtsvector_same(gtsvector,gtsvector,internal);


ALTER OPERATOR CLASS public.gist_tsvector_ops USING gist OWNER TO wd;

--
-- Name: tsvector_ops; Type: OPERATOR CLASS; Schema: public; Owner: wd
--

CREATE OPERATOR CLASS tsvector_ops
    DEFAULT FOR TYPE tsvector USING btree AS
    OPERATOR 1 <(tsvector,tsvector) ,
    OPERATOR 2 <=(tsvector,tsvector) ,
    OPERATOR 3 =(tsvector,tsvector) ,
    OPERATOR 4 >=(tsvector,tsvector) ,
    OPERATOR 5 >(tsvector,tsvector) ,
    FUNCTION 1 tsvector_cmp(tsvector,tsvector);


ALTER OPERATOR CLASS public.tsvector_ops USING btree OWNER TO wd;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: admin; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE "admin" (
    admin_id serial NOT NULL,
    site_id integer,
    user_id integer,
    founder boolean DEFAULT false
);


ALTER TABLE public."admin" OWNER TO wd;

--
-- Name: admin_admin_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('"admin"', 'admin_id'), 1, false);


--
-- Name: admin_notification; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE admin_notification (
    notification_id serial NOT NULL,
    site_id integer,
    body text,
    "type" character varying(50),
    viewed boolean DEFAULT false,
    date timestamp without time zone,
    extra bytea,
    notify_online boolean DEFAULT false,
    notify_feed boolean DEFAULT false,
    notify_email boolean DEFAULT false
);


ALTER TABLE public.admin_notification OWNER TO wd;

--
-- Name: admin_notification_notification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('admin_notification', 'notification_id'), 1, false);


--
-- Name: anonymous_abuse_flag; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE anonymous_abuse_flag (
    flag_id serial NOT NULL,
    user_id integer,
    address inet,
    proxy boolean DEFAULT false,
    site_id integer,
    site_valid boolean DEFAULT true,
    global_valid boolean DEFAULT true
);


ALTER TABLE public.anonymous_abuse_flag OWNER TO wd;

--
-- Name: anonymous_abuse_flag_flag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('anonymous_abuse_flag', 'flag_id'), 1, false);


--
-- Name: category; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE category (
    category_id serial NOT NULL,
    site_id integer,
    name character varying(80),
    theme_default boolean DEFAULT true,
    theme_id integer,
    permissions_default boolean DEFAULT true,
    permissions character varying(200),
    license_default boolean DEFAULT true,
    license_id integer,
    license_other character varying(350),
    nav_default boolean DEFAULT true,
    top_bar_page_name character varying(128),
    side_bar_page_name character varying(128),
    template_id integer,
    per_page_discussion boolean,
    per_page_discussion_default boolean DEFAULT true,
    rating character varying(10)
);


ALTER TABLE public.category OWNER TO wd;

--
-- Name: category_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('category', 'category_id'), 20, true);


--
-- Name: contact; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE contact (
    contact_id serial NOT NULL,
    user_id integer,
    target_user_id integer
);


ALTER TABLE public.contact OWNER TO wd;

--
-- Name: contact_contact_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('contact', 'contact_id'), 1, false);


--
-- Name: domain_redirect; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE domain_redirect (
    redirect_id serial NOT NULL,
    site_id integer,
    url character varying(80)
);


ALTER TABLE public.domain_redirect OWNER TO wd;

--
-- Name: domain_redirect_redirect_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('domain_redirect', 'redirect_id'), 1, false);


--
-- Name: email_invitation; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE email_invitation (
    invitation_id serial NOT NULL,
    hash character varying(200),
    email character varying(128),
    name character varying(100),
    user_id integer,
    site_id integer,
    become_member boolean DEFAULT true,
    to_contacts boolean,
    message text,
    attempts integer DEFAULT 1,
    accepted boolean DEFAULT false,
    delivered boolean DEFAULT true,
    date timestamp without time zone
);


ALTER TABLE public.email_invitation OWNER TO wd;

--
-- Name: email_invitation_invitation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('email_invitation', 'invitation_id'), 1, false);


--
-- Name: file; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE file (
    file_id serial NOT NULL,
    page_id integer,
    site_id integer,
    filename character varying(100),
    mimetype character varying(100),
    description character varying(200),
    description_short character varying(200),
    "comment" character varying(400),
    size integer,
    date_added timestamp without time zone,
    user_id integer,
    user_string character varying(80),
    has_resized boolean DEFAULT false
);


ALTER TABLE public.file OWNER TO wd;

--
-- Name: file_file_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('file', 'file_id'), 1, false);


--
-- Name: files_event; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE files_event (
    file_event_id serial NOT NULL,
    filename character varying(100),
    date timestamp without time zone,
    user_id integer,
    user_string character varying(80),
    "action" character varying(80),
    action_extra character varying(80)
);


ALTER TABLE public.files_event OWNER TO wd;

--
-- Name: files_event_file_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('files_event', 'file_event_id'), 1, false);


--
-- Name: form_submission_key; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE form_submission_key (
    key_id character varying(90) NOT NULL,
    date_submitted timestamp without time zone
);


ALTER TABLE public.form_submission_key OWNER TO wd;

--
-- Name: forum_category; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE forum_category (
    category_id serial NOT NULL,
    group_id integer,
    name character varying(80),
    description text,
    number_posts integer DEFAULT 0,
    number_threads integer DEFAULT 0,
    last_post_id integer,
    permissions_default boolean DEFAULT true,
    permissions character varying(200),
    max_nest_level integer,
    sort_index integer DEFAULT 0,
    site_id integer,
    per_page_discussion boolean DEFAULT false
);


ALTER TABLE public.forum_category OWNER TO wd;

--
-- Name: forum_category_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('forum_category', 'category_id'), 1, false);


--
-- Name: forum_group; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE forum_group (
    group_id serial NOT NULL,
    name character varying(80),
    description text,
    sort_index integer DEFAULT 0,
    site_id integer,
    visible boolean DEFAULT true
);


ALTER TABLE public.forum_group OWNER TO wd;

--
-- Name: forum_group_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('forum_group', 'group_id'), 1, false);


--
-- Name: forum_post; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE forum_post (
    post_id serial NOT NULL,
    thread_id integer,
    parent_id integer,
    user_id integer,
    user_string character varying(80),
    title character varying(256),
    text text,
    date_posted timestamp without time zone,
    site_id integer,
    revision_number integer DEFAULT 0,
    revision_id integer,
    date_last_edited timestamp without time zone,
    edited_user_id integer,
    edited_user_string character varying(80)
);


ALTER TABLE public.forum_post OWNER TO wd;

--
-- Name: forum_post_post_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('forum_post', 'post_id'), 1, false);


--
-- Name: forum_post_revision; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE forum_post_revision (
    revision_id serial NOT NULL,
    post_id integer,
    user_id integer,
    user_string character varying(80),
    text text,
    title character varying(256),
    date timestamp without time zone
);


ALTER TABLE public.forum_post_revision OWNER TO wd;

--
-- Name: forum_post_revision_revision_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('forum_post_revision', 'revision_id'), 1, false);


--
-- Name: forum_settings; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE forum_settings (
    site_id integer NOT NULL,
    permissions character varying(200),
    per_page_discussion boolean DEFAULT false,
    max_nest_level integer DEFAULT 0
);


ALTER TABLE public.forum_settings OWNER TO wd;

--
-- Name: forum_thread; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE forum_thread (
    thread_id serial NOT NULL,
    user_id integer,
    user_string character varying(80),
    category_id integer,
    title character varying(256),
    description character varying(1000),
    number_posts integer DEFAULT 1,
    date_started timestamp without time zone,
    site_id integer,
    last_post_id integer,
    page_id integer,
    sticky boolean DEFAULT false,
    blocked boolean DEFAULT false
);


ALTER TABLE public.forum_thread OWNER TO wd;

--
-- Name: forum_thread_thread_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('forum_thread', 'thread_id'), 1, false);


--
-- Name: front_forum_feed; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE front_forum_feed (
    feed_id serial NOT NULL,
    page_id integer,
    title character varying(90),
    label character varying(90),
    description character varying(256),
    categories character varying(100),
    parmhash character varying(100),
    site_id integer
);


ALTER TABLE public.front_forum_feed OWNER TO wd;

--
-- Name: front_forum_feed_feed_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('front_forum_feed', 'feed_id'), 1, false);


--
-- Name: fts_entry; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE fts_entry (
    fts_id serial NOT NULL,
    page_id integer,
    title character varying(256),
    unix_name character varying(100),
    thread_id integer,
    site_id integer,
    text text,
    vector tsvector
);


ALTER TABLE public.fts_entry OWNER TO wd;

--
-- Name: fts_entry_fts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('fts_entry', 'fts_id'), 52, true);


--
-- Name: global_ip_block; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE global_ip_block (
    block_id serial NOT NULL,
    address inet,
    flag_proxy boolean DEFAULT false,
    reason text,
    flag_total boolean DEFAULT false,
    date_blocked timestamp without time zone
);


ALTER TABLE public.global_ip_block OWNER TO wd;

--
-- Name: global_ip_block_block_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('global_ip_block', 'block_id'), 1, false);


--
-- Name: global_user_block; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE global_user_block (
    block_id serial NOT NULL,
    site_id integer,
    user_id integer,
    reason text,
    date_blocked timestamp without time zone
);


ALTER TABLE public.global_user_block OWNER TO wd;

--
-- Name: global_user_block_block_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('global_user_block', 'block_id'), 1, false);


--
-- Name: ip_block; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE ip_block (
    block_id serial NOT NULL,
    site_id integer,
    ip inet,
    flag_proxy boolean DEFAULT false,
    reason text,
    date_blocked timestamp without time zone
);


ALTER TABLE public.ip_block OWNER TO wd;

--
-- Name: ip_block_block_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('ip_block', 'block_id'), 1, false);


--
-- Name: license; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE license (
    license_id serial NOT NULL,
    name character varying(100),
    description text,
    sort integer DEFAULT 0
);


ALTER TABLE public.license OWNER TO wd;

--
-- Name: license_license_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('license', 'license_id'), 8, true);


--
-- Name: log_event; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE log_event (
    event_id bigserial NOT NULL,
    date timestamp without time zone,
    user_id integer,
    ip inet,
    proxy inet,
    "type" character varying(256),
    site_id integer,
    page_id integer,
    revision_id integer,
    thread_id integer,
    post_id integer,
    user_agent character varying(512),
    text text
);


ALTER TABLE public.log_event OWNER TO wd;

--
-- Name: log_event_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('log_event', 'event_id'), 85, true);


--
-- Name: member; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE member (
    member_id serial NOT NULL,
    site_id integer,
    user_id integer,
    date_joined timestamp without time zone,
    allow_newsletter boolean DEFAULT true
);


ALTER TABLE public.member OWNER TO wd;

--
-- Name: member_application; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE member_application (
    application_id serial NOT NULL,
    site_id integer,
    user_id integer,
    status character varying(20) DEFAULT 'pending'::character varying,
    date timestamp without time zone,
    "comment" text,
    reply text
);


ALTER TABLE public.member_application OWNER TO wd;

--
-- Name: member_application_application_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('member_application', 'application_id'), 1, false);


--
-- Name: member_invitation; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE member_invitation (
    invitation_id serial NOT NULL,
    site_id integer,
    user_id integer,
    by_user_id integer,
    date timestamp without time zone,
    body text
);


ALTER TABLE public.member_invitation OWNER TO wd;

--
-- Name: member_invitation_invitation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('member_invitation', 'invitation_id'), 1, false);


--
-- Name: member_member_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('member', 'member_id'), 1, false);


--
-- Name: membership_link; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE membership_link (
    link_id serial NOT NULL,
    site_id integer,
    by_user_id integer,
    user_id integer,
    date timestamp without time zone,
    "type" character varying(20)
);


ALTER TABLE public.membership_link OWNER TO wd;

--
-- Name: membership_link_link_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('membership_link', 'link_id'), 1, false);


--
-- Name: moderator; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE moderator (
    moderator_id serial NOT NULL,
    site_id integer,
    user_id integer,
    permissions character(10)
);


ALTER TABLE public.moderator OWNER TO wd;

--
-- Name: moderator_moderator_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('moderator', 'moderator_id'), 1, false);


--
-- Name: notification; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE notification (
    notification_id serial NOT NULL,
    user_id integer,
    body text,
    "type" character varying(50),
    viewed boolean DEFAULT false,
    date timestamp without time zone,
    extra bytea,
    notify_online boolean DEFAULT true,
    notify_feed boolean DEFAULT false,
    notify_email boolean DEFAULT true
);


ALTER TABLE public.notification OWNER TO wd;

--
-- Name: notification_notification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('notification', 'notification_id'), 1, false);


--
-- Name: openid_entry; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE openid_entry (
    openid_id serial NOT NULL,
    site_id integer,
    page_id integer,
    "type" character varying(10),
    user_id integer,
    url character varying(100),
    server_url character varying(100)
);


ALTER TABLE public.openid_entry OWNER TO wd;

--
-- Name: openid_entry_openid_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('openid_entry', 'openid_id'), 1, false);


--
-- Name: ozone_group; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE ozone_group (
    group_id serial NOT NULL,
    parent_group_id integer,
    name character varying(50),
    description text
);


ALTER TABLE public.ozone_group OWNER TO wd;

--
-- Name: ozone_group_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('ozone_group', 'group_id'), 1, false);


--
-- Name: ozone_group_permission_modifier; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE ozone_group_permission_modifier (
    group_permission_id serial NOT NULL,
    group_id character varying(20),
    permission_id character varying(20),
    modifier integer
);


ALTER TABLE public.ozone_group_permission_modifier OWNER TO wd;

--
-- Name: ozone_group_permission_modifier_group_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('ozone_group_permission_modifier', 'group_permission_id'), 1, false);


--
-- Name: ozone_lock; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE ozone_lock (
    "key" character varying(100) NOT NULL
);


ALTER TABLE public.ozone_lock OWNER TO wd;

--
-- Name: ozone_permission; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE ozone_permission (
    permission_id serial NOT NULL,
    name character varying(50),
    description text
);


ALTER TABLE public.ozone_permission OWNER TO wd;

--
-- Name: ozone_permission_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('ozone_permission', 'permission_id'), 1, false);


--
-- Name: ozone_session; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE ozone_session (
    session_id character varying(60) NOT NULL,
    started timestamp without time zone,
    last_accessed timestamp without time zone,
    ip_address character varying(90),
    check_ip boolean DEFAULT false,
    infinite boolean DEFAULT false,
    user_id integer,
    serialized_datablock bytea
);


ALTER TABLE public.ozone_session OWNER TO wd;

--
-- Name: ozone_user; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE ozone_user (
    user_id serial NOT NULL,
    name character varying(99),
    nick_name character varying(70),
    "password" character varying(99),
    email character varying(99),
    unix_name character varying(99),
    last_login timestamp without time zone,
    registered_date timestamp without time zone,
    super_admin boolean DEFAULT false,
    super_moderator boolean DEFAULT false,
    "language" character varying(10) DEFAULT 'en'::character varying
);


ALTER TABLE public.ozone_user OWNER TO wd;

--
-- Name: ozone_user_group_relation; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE ozone_user_group_relation (
    user_group_id serial NOT NULL,
    user_id integer,
    group_id integer
);


ALTER TABLE public.ozone_user_group_relation OWNER TO wd;

--
-- Name: ozone_user_group_relation_user_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('ozone_user_group_relation', 'user_group_id'), 1, false);


--
-- Name: ozone_user_permission_modifier; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE ozone_user_permission_modifier (
    user_permission_id serial NOT NULL,
    user_id integer,
    permission_id character varying(20),
    modifier integer
);


ALTER TABLE public.ozone_user_permission_modifier OWNER TO wd;

--
-- Name: ozone_user_permission_modifier_user_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('ozone_user_permission_modifier', 'user_permission_id'), 1, false);


--
-- Name: ozone_user_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('ozone_user', 'user_id'), 1, true);


--
-- Name: page; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE page (
    page_id serial NOT NULL,
    site_id integer,
    category_id integer,
    parent_page_id integer,
    revision_id integer,
    source_id integer,
    metadata_id integer,
    revision_number integer DEFAULT 0,
    title character varying(256),
    unix_name character varying(256),
    date_created timestamp without time zone,
    date_last_edited timestamp without time zone,
    last_edit_user_id integer,
    last_edit_user_string character varying(80),
    thread_id integer,
    owner_user_id integer,
    blocked boolean DEFAULT false,
    rate integer DEFAULT 0
);


ALTER TABLE public.page OWNER TO wd;

--
-- Name: page_abuse_flag; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE page_abuse_flag (
    flag_id serial NOT NULL,
    user_id integer,
    site_id integer,
    path character varying(100),
    site_valid boolean DEFAULT true,
    global_valid boolean DEFAULT true
);


ALTER TABLE public.page_abuse_flag OWNER TO wd;

--
-- Name: page_abuse_flag_flag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('page_abuse_flag', 'flag_id'), 1, true);


--
-- Name: page_compiled; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE page_compiled (
    page_id integer NOT NULL,
    text text,
    date_compiled timestamp without time zone
);


ALTER TABLE public.page_compiled OWNER TO wd;

--
-- Name: page_edit_lock; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE page_edit_lock (
    lock_id serial NOT NULL,
    page_id integer,
    "mode" character varying(10) DEFAULT 'page'::character varying,
    section_id integer,
    range_start integer,
    range_end integer,
    page_unix_name character varying(100),
    user_id integer,
    user_string character varying(80),
    session_id character varying(60),
    date_started timestamp without time zone,
    date_last_accessed timestamp without time zone,
    secret character varying(100),
    site_id integer
);


ALTER TABLE public.page_edit_lock OWNER TO wd;

--
-- Name: page_edit_lock_lock_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('page_edit_lock', 'lock_id'), 76, true);


--
-- Name: page_inclusion; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE page_inclusion (
    inclusion_id serial NOT NULL,
    including_page_id integer,
    included_page_id integer,
    included_page_name character varying(128),
    site_id integer
);


ALTER TABLE public.page_inclusion OWNER TO wd;

--
-- Name: page_inclusion_inclusion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('page_inclusion', 'inclusion_id'), 1, false);


--
-- Name: page_link; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE page_link (
    link_id serial NOT NULL,
    from_page_id integer,
    to_page_id integer,
    to_page_name character varying(128),
    site_id integer
);


ALTER TABLE public.page_link OWNER TO wd;

--
-- Name: page_link_link_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('page_link', 'link_id'), 67, true);


--
-- Name: page_metadata; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE page_metadata (
    metadata_id serial NOT NULL,
    parent_page_id integer,
    title character varying(256),
    unix_name character varying(80),
    owner_user_id integer
);


ALTER TABLE public.page_metadata OWNER TO wd;

--
-- Name: page_metadata_metadata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('page_metadata', 'metadata_id'), 52, true);


--
-- Name: page_page_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('page', 'page_id'), 48, true);


--
-- Name: page_rate_vote; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE page_rate_vote (
    rate_id serial NOT NULL,
    user_id integer,
    page_id integer,
    rate integer DEFAULT 1,
    date timestamp without time zone
);


ALTER TABLE public.page_rate_vote OWNER TO wd;

--
-- Name: page_rate_vote_rate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('page_rate_vote', 'rate_id'), 1, false);


--
-- Name: page_revision; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE page_revision (
    revision_id serial NOT NULL,
    page_id integer,
    source_id integer,
    metadata_id integer,
    flags character varying(100),
    flag_text boolean DEFAULT false,
    flag_title boolean DEFAULT false,
    flag_file boolean DEFAULT false,
    flag_rename boolean DEFAULT false,
    flag_meta boolean DEFAULT false,
    flag_new boolean DEFAULT false,
    since_full_source integer DEFAULT 0,
    diff_source boolean DEFAULT false,
    revision_number integer DEFAULT 0,
    date_last_edited timestamp without time zone,
    user_id integer,
    user_string character varying(80),
    comments text,
    flag_new_site boolean DEFAULT false,
    site_id integer
);


ALTER TABLE public.page_revision OWNER TO wd;

--
-- Name: page_revision_revision_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('page_revision', 'revision_id'), 59, true);


--
-- Name: page_source; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE page_source (
    source_id serial NOT NULL,
    text text
);


ALTER TABLE public.page_source OWNER TO wd;

--
-- Name: page_source_source_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('page_source', 'source_id'), 58, true);


--
-- Name: page_tag; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE page_tag (
    tag_id bigserial NOT NULL,
    site_id integer,
    page_id integer,
    tag character varying(20)
);


ALTER TABLE public.page_tag OWNER TO wd;

--
-- Name: page_tag_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('page_tag', 'tag_id'), 1, true);


--
-- Name: petition_campaign; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE petition_campaign (
    campaign_id serial NOT NULL,
    site_id integer,
    name character varying(256),
    identifier character varying(256),
    active boolean DEFAULT true,
    number_signatures integer DEFAULT 0,
    deleted boolean DEFAULT false,
    collect_address boolean DEFAULT true,
    collect_city boolean DEFAULT true,
    collect_state boolean DEFAULT true,
    collect_zip boolean DEFAULT true,
    collect_country boolean DEFAULT true,
    collect_comments boolean DEFAULT true,
    show_city boolean DEFAULT true,
    show_state boolean DEFAULT true,
    show_zip boolean DEFAULT false,
    show_country boolean DEFAULT true,
    show_comments boolean DEFAULT false,
    thank_you_page character varying(256)
);


ALTER TABLE public.petition_campaign OWNER TO wd;

--
-- Name: petition_campaign_campaign_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('petition_campaign', 'campaign_id'), 1, false);


--
-- Name: petition_signature; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE petition_signature (
    signature_id serial NOT NULL,
    campaign_id integer,
    first_name character varying(256),
    last_name character varying(256),
    address1 character varying(256),
    address2 character varying(256),
    zip character varying(256),
    city character varying(256),
    state character varying(256),
    country character varying(256),
    country_code character varying(8),
    comments text,
    email character varying(256),
    confirmed boolean DEFAULT false,
    confirmation_hash character varying(256),
    confirmation_url character varying(256),
    date timestamp without time zone
);


ALTER TABLE public.petition_signature OWNER TO wd;

--
-- Name: petition_signature_signature_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('petition_signature', 'signature_id'), 1, false);


SET default_with_oids = true;

--
-- Name: pg_ts_cfg; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE pg_ts_cfg (
    ts_name text NOT NULL,
    prs_name text NOT NULL,
    locale text
);


ALTER TABLE public.pg_ts_cfg OWNER TO wd;

--
-- Name: pg_ts_cfgmap; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE pg_ts_cfgmap (
    ts_name text NOT NULL,
    tok_alias text NOT NULL,
    dict_name text[]
);


ALTER TABLE public.pg_ts_cfgmap OWNER TO wd;

--
-- Name: pg_ts_dict; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE pg_ts_dict (
    dict_name text NOT NULL,
    dict_init regprocedure,
    dict_initoption text,
    dict_lexize regprocedure NOT NULL,
    dict_comment text
);


ALTER TABLE public.pg_ts_dict OWNER TO wd;

--
-- Name: pg_ts_parser; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE pg_ts_parser (
    prs_name text NOT NULL,
    prs_start regprocedure NOT NULL,
    prs_nexttoken regprocedure NOT NULL,
    prs_end regprocedure NOT NULL,
    prs_headline regprocedure NOT NULL,
    prs_lextype regprocedure NOT NULL,
    prs_comment text
);


ALTER TABLE public.pg_ts_parser OWNER TO wd;

SET default_with_oids = false;

--
-- Name: private_message; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE private_message (
    message_id serial NOT NULL,
    from_user_id integer,
    to_user_id integer,
    subject character varying(256),
    body text,
    date timestamp without time zone,
    flag integer DEFAULT 0,
    flag_new boolean DEFAULT true
);


ALTER TABLE public.private_message OWNER TO wd;

--
-- Name: private_message_message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('private_message', 'message_id'), 1, false);


--
-- Name: private_user_block; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE private_user_block (
    block_id serial NOT NULL,
    user_id integer,
    blocked_user_id integer
);


ALTER TABLE public.private_user_block OWNER TO wd;

--
-- Name: private_user_block_block_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('private_user_block', 'block_id'), 1, false);


--
-- Name: profile; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE profile (
    user_id integer NOT NULL,
    real_name character varying(70),
    gender character(1),
    birthday_day integer,
    birthday_month integer,
    birthday_year integer,
    about text,
    "location" character varying(70),
    website character varying(100),
    im_aim character varying(100),
    im_gadu_gadu character varying(100),
    im_google_talk character varying(100),
    im_icq character varying(100),
    im_jabber character varying(100),
    im_msn character varying(100),
    im_yahoo character varying(100),
    change_screen_name_count integer DEFAULT 0
);


ALTER TABLE public.profile OWNER TO wd;

--
-- Name: simpletodo_list; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE simpletodo_list (
    list_id serial NOT NULL,
    site_id integer,
    label character varying(256),
    title character varying(256),
    data text
);


ALTER TABLE public.simpletodo_list OWNER TO wd;

--
-- Name: simpletodo_list_list_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('simpletodo_list', 'list_id'), 1, false);


--
-- Name: site; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE site (
    site_id serial NOT NULL,
    name character varying(50),
    subtitle character varying(60),
    unix_name character varying(80),
    description text,
    "language" character varying(10) DEFAULT 'en'::character varying,
    date_created timestamp without time zone,
    custom_domain character varying(60),
    visible boolean DEFAULT true,
    default_page character varying(80) DEFAULT 'start'::character varying,
    private boolean DEFAULT false,
    deleted boolean DEFAULT false
);


ALTER TABLE public.site OWNER TO wd;

--
-- Name: site_backup; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE site_backup (
    backup_id serial NOT NULL,
    site_id integer,
    status character varying(50),
    backup_source boolean DEFAULT true,
    backup_files boolean DEFAULT true,
    date timestamp without time zone,
    rand character varying(100)
);


ALTER TABLE public.site_backup OWNER TO wd;

--
-- Name: site_backup_backup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('site_backup', 'backup_id'), 1, false);


--
-- Name: site_settings; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE site_settings (
    site_id integer NOT NULL,
    allow_membership_by_apply boolean DEFAULT true,
    allow_membership_by_password boolean DEFAULT false,
    membership_password character varying(80),
    file_storage_size integer DEFAULT 314572800,
    use_ganalytics boolean DEFAULT false,
    private_landing_page character varying(80) DEFAULT 'system:join'::character varying,
    max_private_members integer DEFAULT 50,
    max_private_viewers integer DEFAULT 20,
    hide_navigation_unauthorized boolean DEFAULT true,
    ssl_mode character varying(20),
    openid_enabled boolean DEFAULT false,
    allow_members_invite boolean DEFAULT false,
    max_upload_file_size integer DEFAULT 10485760
);


ALTER TABLE public.site_settings OWNER TO wd;

--
-- Name: site_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('site', 'site_id'), 3, true);


--
-- Name: site_super_settings; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE site_super_settings (
    site_id integer NOT NULL,
    can_custom_domain boolean DEFAULT true
);


ALTER TABLE public.site_super_settings OWNER TO wd;

--
-- Name: site_tag; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE site_tag (
    tag_id serial NOT NULL,
    site_id integer,
    tag character varying(20)
);


ALTER TABLE public.site_tag OWNER TO wd;

--
-- Name: site_tag_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('site_tag', 'tag_id'), 1, true);


--
-- Name: site_viewer; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE site_viewer (
    viewer_id serial NOT NULL,
    site_id integer,
    user_id integer
);


ALTER TABLE public.site_viewer OWNER TO wd;

--
-- Name: site_viewer_viewer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('site_viewer', 'viewer_id'), 1, false);


--
-- Name: storage_item; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE storage_item (
    item_id character varying(256) NOT NULL,
    date timestamp without time zone,
    timeout integer,
    data bytea
);


ALTER TABLE public.storage_item OWNER TO wd;

--
-- Name: theme; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE theme (
    theme_id serial NOT NULL,
    name character varying(100),
    unix_name character varying(100),
    abstract boolean DEFAULT false,
    extends_theme_id integer,
    variant_of_theme_id integer,
    custom boolean DEFAULT false,
    site_id integer,
    use_side_bar boolean DEFAULT true,
    use_top_bar boolean DEFAULT true,
    sort_index integer DEFAULT 0,
    sync_page_name character varying(100),
    revision_number integer DEFAULT 0
);


ALTER TABLE public.theme OWNER TO wd;

--
-- Name: theme_preview; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE theme_preview (
    theme_id integer NOT NULL,
    body text
);


ALTER TABLE public.theme_preview OWNER TO wd;

--
-- Name: theme_theme_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('theme', 'theme_id'), 23, true);


--
-- Name: unique_string_broker; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE unique_string_broker (
    last_index integer
);


ALTER TABLE public.unique_string_broker OWNER TO wd;

--
-- Name: user_abuse_flag; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE user_abuse_flag (
    flag_id serial NOT NULL,
    user_id integer,
    target_user_id integer,
    site_id integer,
    site_valid boolean DEFAULT true,
    global_valid boolean DEFAULT true
);


ALTER TABLE public.user_abuse_flag OWNER TO wd;

--
-- Name: user_abuse_flag_flag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('user_abuse_flag', 'flag_id'), 1, false);


--
-- Name: user_block; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE user_block (
    block_id serial NOT NULL,
    site_id integer,
    user_id integer,
    reason text,
    date_blocked timestamp without time zone
);


ALTER TABLE public.user_block OWNER TO wd;

--
-- Name: user_block_block_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('user_block', 'block_id'), 1, false);


--
-- Name: user_settings; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE user_settings (
    user_id integer NOT NULL,
    receive_invitations boolean DEFAULT true,
    receive_pm character(5) DEFAULT 'a'::bpchar,
    notify_online character varying(512) DEFAULT '*'::character varying,
    notify_feed character varying(512) DEFAULT '*'::character varying,
    notify_email character varying(512),
    receive_newsletter boolean DEFAULT true,
    receive_digest boolean DEFAULT true,
    allow_site_newsletters_default boolean DEFAULT true,
    max_sites_admin integer DEFAULT 3
);


ALTER TABLE public.user_settings OWNER TO wd;

--
-- Name: watched_forum_thread; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE watched_forum_thread (
    watched_id serial NOT NULL,
    user_id integer,
    thread_id integer
);


ALTER TABLE public.watched_forum_thread OWNER TO wd;

--
-- Name: watched_forum_thread_watched_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('watched_forum_thread', 'watched_id'), 1, false);


--
-- Name: watched_page; Type: TABLE; Schema: public; Owner: wd; Tablespace: 
--

CREATE TABLE watched_page (
    watched_id serial NOT NULL,
    user_id integer,
    page_id integer
);


ALTER TABLE public.watched_page OWNER TO wd;

--
-- Name: watched_page_watched_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wd
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('watched_page', 'watched_id'), 1, false);


--
-- Data for Name: admin; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY "admin" (admin_id, site_id, user_id, founder) FROM stdin;
\.


--
-- Data for Name: admin_notification; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY admin_notification (notification_id, site_id, body, "type", viewed, date, extra, notify_online, notify_feed, notify_email) FROM stdin;
\.


--
-- Data for Name: anonymous_abuse_flag; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY anonymous_abuse_flag (flag_id, user_id, address, proxy, site_id, site_valid, global_valid) FROM stdin;
\.


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY category (category_id, site_id, name, theme_default, theme_id, permissions_default, permissions, license_default, license_id, license_other, nav_default, top_bar_page_name, side_bar_page_name, template_id, per_page_discussion, per_page_discussion_default, rating) FROM stdin;
6	2	nav	t	20	t	v:arm;e:;c:;m:;d:;a:;r:;z:;o:	t	1	\N	t	nav:top	nav:side	\N	\N	t	\N
7	3	_default	t	20	f	v:arm;e:;c:;m:;d:;a:;r:;z:;o:	f	1	\N	f	nav:top	nav:side	\N	\N	t	\N
9	3	admin	f	21	t	v:arm;e:;c:;m:;d:;a:;r:;z:;o:	t	1	\N	t	nav:top	nav:side	\N	\N	t	\N
11	3	nav	t	20	t	v:arm;e:;c:;m:;d:;a:;r:;z:;o:	t	1	\N	t	nav:top	nav:side	\N	\N	t	\N
14	2	search	t	20	t	v:arm;e:;c:;m:;d:;a:;r:;z:;o:	t	1	\N	t	nav:top	nav:side	\N	\N	t	\N
15	1	nav	t	20	t	v:arm;e:;c:;m:;d:;a:;r:;z:;o:	t	1	\N	t	nav:top	nav:side	\N	\N	t	\N
2	2	_default	t	20	f	e:m;c:m;m:m;d:;a:m;r:m;z:;o:arm	f	1	\N	f	nav:top	nav:side	\N	f	t	\N
13	2	admin	f	21	f	v:arm;e:;c:;m:;d:;a:;r:;z:;o:	t	1	\N	t	nav:top	nav:side	\N	\N	t	\N
17	2	forum	t	20	f	v:arm;e:;c:;m:;d:;a:;r:;z:;o:	t	1	\N	t	nav:top	nav:side	\N	\N	t	\N
12	2	system	t	20	f	v:arm;e:;c:;m:;d:;a:;r:;z:;o:	t	1	\N	t	nav:top	nav:side	\N	\N	t	\N
1	1	_default	t	20	f	e:m;c:m;m:m;d:;a:m;r:m;z:;o:arm	f	1	\N	f	nav:top	nav:side	\N	f	t	\N
4	1	account	f	21	f	v:arm;e:;c:;m:;d:;a:;r:;z:;o:	t	1	\N	t	nav:top	nav:side	\N	\N	t	\N
3	1	admin	f	21	f	v:arm;e:;c:;m:;d:;a:;r:;z:;o:	t	1	\N	t	nav:top	nav:side	\N	\N	t	\N
16	1	search	t	20	f	v:arm;e:;c:;m:;d:;a:;r:;z:;o:	t	1	\N	t	nav:top	nav:side	\N	\N	t	\N
5	1	user	f	21	f	v:arm;e:;c:;m:;d:;a:;r:;z:;o:	t	1	\N	t	nav:top	nav:side	\N	\N	t	\N
8	3	profile	f	20	f	e:o;c:;m:;d:;a:;r:;z:;o:o	t	1	\N	f	nav:top	nav:profile-side	\N	\N	t	\N
18	2	profile	t	20	t	e:m;c:m;m:m;d:;a:m;r:m;z:;o:arm	t	1	\N	t	nav:top	nav:side	\N	\N	t	\N
19	1	system-all	t	20	t	e:m;c:m;m:m;d:;a:m;r:m;z:;o:arm	t	1	\N	t	nav:top	nav:side	\N	\N	t	\N
20	1	system	t	20	t	e:m;c:m;m:m;d:;a:m;r:m;z:;o:arm	t	1	\N	t	nav:top	nav:side	\N	\N	t	\N
\.


--
-- Data for Name: contact; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY contact (contact_id, user_id, target_user_id) FROM stdin;
\.


--
-- Data for Name: domain_redirect; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY domain_redirect (redirect_id, site_id, url) FROM stdin;
\.


--
-- Data for Name: email_invitation; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY email_invitation (invitation_id, hash, email, name, user_id, site_id, become_member, to_contacts, message, attempts, accepted, delivered, date) FROM stdin;
\.


--
-- Data for Name: file; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY file (file_id, page_id, site_id, filename, mimetype, description, description_short, "comment", size, date_added, user_id, user_string, has_resized) FROM stdin;
\.


--
-- Data for Name: files_event; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY files_event (file_event_id, filename, date, user_id, user_string, "action", action_extra) FROM stdin;
\.


--
-- Data for Name: form_submission_key; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY form_submission_key (key_id, date_submitted) FROM stdin;
\.


--
-- Data for Name: forum_category; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY forum_category (category_id, group_id, name, description, number_posts, number_threads, last_post_id, permissions_default, permissions, max_nest_level, sort_index, site_id, per_page_discussion) FROM stdin;
\.


--
-- Data for Name: forum_group; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY forum_group (group_id, name, description, sort_index, site_id, visible) FROM stdin;
\.


--
-- Data for Name: forum_post; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY forum_post (post_id, thread_id, parent_id, user_id, user_string, title, text, date_posted, site_id, revision_number, revision_id, date_last_edited, edited_user_id, edited_user_string) FROM stdin;
\.


--
-- Data for Name: forum_post_revision; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY forum_post_revision (revision_id, post_id, user_id, user_string, text, title, date) FROM stdin;
\.


--
-- Data for Name: forum_settings; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY forum_settings (site_id, permissions, per_page_discussion, max_nest_level) FROM stdin;
2	t:m;p:m;e:o;s:	f	2
\.


--
-- Data for Name: forum_thread; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY forum_thread (thread_id, user_id, user_string, category_id, title, description, number_posts, date_started, site_id, last_post_id, page_id, sticky, blocked) FROM stdin;
\.


--
-- Data for Name: front_forum_feed; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY front_forum_feed (feed_id, page_id, title, label, description, categories, parmhash, site_id) FROM stdin;
\.


--
-- Data for Name: fts_entry; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY fts_entry (fts_id, page_id, title, unix_name, thread_id, site_id, text, vector) FROM stdin;
32	32	Top	nav:top	\N	2	\n\n\nexample menu\n\nsubmenu\n\n\ncontact\n\n	'nav':2C 'top':1C,3C 'menu':5 'exampl':4 'contact':7 'submenu':6
33	33	Template	profile:template	\N	2	\n\nProfile has not been created (yet).\n	'yet':9 'creat':8 'profil':2C,4 'templat':1C,3C
34	5	Side	nav:side	\N	2	\n\n\nWelcome page\n\n\nWhat is a Wiki Site?\nHow to edit pages?\n\n\nHow to join this site?\nSite members\n\n\nRecent changes\nList all pages\nPage Tags\n\n\nSite Manager\n\nPage tags\n\n\nAdd a new page\n\n\nedit this panel\n	'add':33 'nav':2C 'new':35 'tag':28,32 'edit':13,37 'join':17 'list':24 'page':5,14,26,27,31,36 'side':1C,3C 'site':10,19,20,29 'wiki':9 'chang':23 'manag':30 'panel':39 'member':21 'recent':22 'welcom':4
37	36	Congratulations, welcome to your new wiki!	start	\N	2	\n\nIf this is your first site\nThen there are some things you need to know:\n\nYou can configure all security and other settings online, using the Site Manager. When you invite other people to help build this site they don't have access to the Site Manager unless you make them administrators like yourself. Check out the Permissions section.\nYour Wikidot site has two menus, one at the side called 'nav:side', and one at the top called 'nav:top'. These are Wikidot pages, and you can edit them like any page.\nTo edit a page, go to the page and click the Edit button at the bottom. You can change everything in the main area of your page. The Wikidot system is easy to learn and powerful.\nYou can attach images and other files to any page, then display them and link to them in the page.\nEvery Wikidot page has a history of edits, and you can undo anything. So feel secure, and experiment.\nTo start a forum on your site, see the Site Manager » Forum.\nThe license for this Wikidot site has been set to Creative Commons Attribution-Share Alike 3.0 License. If you want to change this, use the Site Manager.\nIf you want to learn more, make sure you visit the Documentation section at www.wikidot.org\n\nMore information about the Wikidot project can be found at www.wikidot.org.\n	'go':104 '�':185 '3.0':203 'nav':78,86 'new':5C 'one':73,81 'see':181 'set':30,195 'top':84,87 'two':71 'use':32,211 'alik':202 'area':123 'call':77,85 'easi':131 'edit':95,101,111,163 'feel':170 'file':142 'help':42 'imag':139 'know':22 'like':60,97 'link':150 'main':122 'make':57,221 'need':20 'page':91,99,103,107,126,145,155,158 'side':76,79 'site':13,34,45,53,69,180,183,192,213 'sure':222 'undo':167 'want':207,217 'wiki':6C 'anyth':168 'build':43 'chang':118,209 'check':62 'click':109 'everi':156 'first':12 'forum':177,186 'found':238 'invit':38 'learn':133,219 'manag':35,54,184,214 'menus':72 'onlin':31 'peopl':40 'power':135 'secur':27,171 'share':201 'start':7C,175 'thing':18 'visit':224 'access':50 'attach':138 'bottom':115 'button':112 'common':198 'experi':173 'inform':231 'licens':188,204 'system':129 'unless':55 'welcom':2C 'creativ':197 'display':147 'everyth':119 'histori':161 'permiss':65 'project':235 'section':66,227 'wikidot':68,90,128,157,191,234 'attribut':200 'configur':25 'document':226 'administr':59 'congratul':1C 'www.wikidot.org':229,240 'attribution-shar':199
39	37	List of all wikis	system-all:all-sites	\N	1	\n\nBelow is the list of public visible Wikis hosted at this service:\n\n	'host':19 'list':1C,14 'site':10C 'wiki':4C,18 'public':16 'servic':22 'system':6C 'visibl':17 'all-sit':8C 'system-al':5C
40	38	List wikis by tags	system-all:sites-by-tags	\N	1	\n\n\n\n	'tag':4C,11C 'list':1C 'site':9C 'wiki':2C 'system':6C 'system-al':5C 'sites-by-tag':8C
41	39	Search	system-all:search	\N	1	\n\n\nSearch all Wikis\nPerform a search through all public and visible wikis.\n\n\n\nSearch users\nTo look for someone, please enter:\n\nemail address of a person you are looking for (this will look for exact match)\nany part of the screen name or realname (lists all Users matching the query)\n\n\n\n	'list':49 'look':21,33,37 'name':46 'part':42 'user':19,51 'wiki':8,17 'email':26 'enter':25 'exact':39 'match':40,52 'pleas':24 'queri':54 'person':30 'public':14 'screen':45 'search':1C,5C,6,11,18 'someon':23 'system':3C 'visibl':16 'address':27 'perform':9 'realnam':48 'system-al':2C
42	40	Activity across all wikis	system-all:activity	\N	1	\n\n\n\n\nRecent edits (all wikis)\n\n\n\nTop Sites\n\n\nTop Forums\n\n\nNew users\n\n\nSome statistics\n\n\n\n\n	'new':17 'top':13,15 'edit':10 'site':14 'user':18 'wiki':4C,12 'activ':1C,8C 'forum':16 'across':2C 'recent':9 'system':6C 'statist':20 'system-al':5C
43	23	Welcome to your new Wikidot installation!	start	\N	1	\n\nCongratulations, you have successfully installed Wikidot software on your computer!\nWhat to do next\nCustomize this wiki\nWikidot consists of several wiki sites, not just one. Right now you are on the main wiki. Customize it!\n\nYou can configure all security and other settings online, using the Site Manager. When you invite other people to help build this site they don't have access to the Site Manager unless you make them administrators like yourself. Check out the Permissions section.\nYour Wikidot site has two menus, one at the side called 'nav:side', and one at the top called 'nav:top'. These are Wikidot pages, and you can edit them like any page.\nTo edit a page, go to the page and click the Edit button at the bottom. You can change everything in the main area of your page. The Wikidot system is easy to learn and powerful.\nYou can attach images and other files to any page, then display them and link to them in the page.\nEvery Wikidot page has a history of edits, and you can undo anything. So feel secure, and experiment.\nTo start a forum on your site, see the Site Manager » Forum.\nThe license for this Wikidot site has been set to Creative Commons Attribution-Share Alike 3.0 License. If you want to change this, use the Site Manager.\nIf you want to learn more, make sure you visit the Documentation section at www.wikidot.org\n\nCustomize default template\nDefault initial template for other wikis is located at template-en. If someone creates a new wiki, this one is cloned to the new address. A good thing to do is to go to template-en and customize it.\nCreate more templates\nSimply create wikis with unix names starting with "template-" (e.g. "template-pl", "template-blog") and your users will be able to choose which wiki they want to start with.\nVisit Wikidot.org\nGo to www.wikidot.org — home of the Wikidot software — for extra documentation, howtos, tips and support.\n\nMore information about the Wikidot project can be found at www.wikidot.org.\nSearch all wikis\n\n\nSearch users\n\n	'en':265,291 'go':125,287,331 'pl':310 '�':206 '3.0':224 'abl':319 'e.g':307 'nav':99,107 'new':4C,270,278 'one':33,94,102,273 'see':202 'set':51,216 'tip':345 'top':105,108 'two':92 'use':53,232 '—':334,340 'alik':223 'area':144 'blog':313 'call':98,106 'easi':152 'edit':116,122,132,184 'feel':191 'file':163 'good':281 'help':63 'home':335 'imag':160 'like':81,118 'link':171 'main':40,143 'make':78,242 'name':303 'next':21 'page':112,120,124,128,147,166,176,179 'side':97,100 'site':30,55,66,74,90,201,204,213,234 'sure':243 'undo':188 'unix':302 'user':316,363 'want':228,238,325 'wiki':24,29,41,259,271,300,323,361 'anyth':189 'build':64 'chang':139,230 'check':83 'choos':321 'click':130 'clone':275 'creat':268,295,299 'everi':177 'extra':342 'forum':198,207 'found':356 'howto':344 'initi':255 'invit':59 'learn':154,240 'locat':261 'manag':56,75,205,235 'menus':93 'onlin':52 'peopl':61 'power':156 'right':34 'secur':48,192 'sever':28 'share':222 'start':7C,196,304,327 'thing':282 'visit':245,329 'access':71 'attach':159 'bottom':136 'button':133 'common':219 'comput':17 'custom':22,42,251,293 'experi':194 'inform':349 'instal':6C,12 'licens':209,225 'search':359,362 'simpli':298 'someon':267 'system':150 'unless':76 'welcom':1C 'address':279 'consist':26 'creativ':218 'default':252,254 'display':168 'everyth':140 'histori':182 'permiss':86 'project':353 'section':87,248 'softwar':14,339 'success':11 'support':347 'templat':253,256,264,290,297,306,309,312 'wikidot':5C,13,25,89,111,149,178,212,338,352 'attribut':221 'configur':46 'document':247,343 'administr':80 'congratul':8 'template-en':263,289 'template-pl':308 'wikidot.org':330 'template-blog':311 'www.wikidot.org':250,333,358 'attribution-shar':220
44	41	What Is A Wiki	what-is-a-wiki	\N	1	\n\nAccording to Wikipedia, the world largest wiki site:\n\nA Wiki ([ˈwiː.kiː] &lt;wee-kee&gt; or [ˈwɪ.kiː] &lt;wick-ey&gt;) is a type of website that allows users to add, remove, or otherwise edit and change most content very quickly and easily.\n\nAnd that is it! As a part of a farm of wikis this site is a great tool that you can use to publish content, upload files, communicate and collaborate.\n	'ey':30 'add':40 'kee':24 'use':74 'wee':23 'edit':44 'farm':62 'file':79 'ki�':21,27 'part':59 'site':17,66 'tool':70 'type':33 'user':38 'wick':29 'wiki':4C,9C,16,19,64 'allow':37 'chang':46 'great':69 'quick':50 'remov':41 'world':14 '�w�':26 'accord':10 'easili':52 'upload':78 'websit':35 'wee-ke':22 '�wi�':20 'content':48,77 'largest':15 'publish':76 'wick-ey':28 'collabor':82 'communic':80 'otherwis':43 'wikipedia':12 'what-is-a-wiki':5C
45	13	How To Edit Pages - Quickstart	how-to-edit-pages	\N	2	\n\nIf you are allowed to edit pages in this Site, simply click on edit button at the bottom of the page. This will open an editor with a toolbar pallette with options.\nTo create a link to a new page, use syntax: [[[new page name]]] or [[[new page name | text to display]]]. Follow the link (which should have a different color if page does not exist) and create a new page and edit it!\nAlthough creating and editing pages is easy, there are a lot more options that allows creating powerful sites. Please visit Documentation pages (at wikidot.org) to learn more.\n	'lot':95 'new':49,53,57,80 'use':51 'easi':91 'edit':3C,9C,16,24,83,88 'link':46,65 'name':55,59 'open':34 'page':4C,10C,17,31,50,54,58,73,81,89,106 'site':20,102 'text':60 'allow':14,99 'click':22 'color':71 'creat':44,78,86,100 'exist':76 'learn':110 'pleas':103 'power':101 'visit':104 'bottom':28 'button':25 'differ':70 'editor':36 'follow':63 'option':42,97 'simpli':21 'syntax':52 'display':62 'pallett':40 'toolbar':39 'although':85 'document':105 'quickstart':5C 'wikidot.org':108 'how-to-edit-pag':6C
46	42	How To Edit Pages	how-to-edit-pages	\N	1	\n\nIf you are allowed to edit pages in this Site, simply click on edit button at the bottom of the page. This will open an editor with a toolbar pallette with options.\nTo create a link to a new page, use syntax: [[[new page name]]] or [[[new page name | text to display]]]. Follow the link (which should have a different color if page does not exist) and create a new page and edit it!\nAlthough creating and editing pages is easy, there are a lot more options that allows creating powerful sites. Please visit Documentation pages (at wikidot.org) to learn more.\n	'lot':94 'new':48,52,56,79 'use':50 'easi':90 'edit':3C,8C,15,23,82,87 'link':45,64 'name':54,58 'open':33 'page':4C,9C,16,30,49,53,57,72,80,88,105 'site':19,101 'text':59 'allow':13,98 'click':21 'color':70 'creat':43,77,85,99 'exist':75 'learn':109 'pleas':102 'power':100 'visit':103 'bottom':27 'button':24 'differ':69 'editor':35 'follow':62 'option':41,96 'simpli':20 'syntax':51 'display':61 'pallett':39 'toolbar':38 'although':84 'document':104 'wikidot.org':107 'how-to-edit-pag':5C
47	43	Wiki Members	system:members	\N	1	\n\nMembers:\n\n\nModerators\n\n\nAdmins\n\n	'wiki':1C 'admin':7 'moder':6 'member':2C,4C,5 'system':3C
48	44	How to join this wiki?	system:join	\N	1	\n\n\nPlease change this page according to your policy (configure first using Site Manager) and remove this note.\n\nWho can join?\nYou can write here who can become a member of this site.\nJoin!\nSo you want to become a member of this site? Tell us why and apply now!\n\n\nOr, if you already know a "secret password", go for it!\n\n	'go':65 'us':52 'use':18 'join':3C,7C,27,40 'know':61 'note':24 'page':11 'site':19,39,50 'tell':51 'want':43 'wiki':5C 'appli':55 'becom':34,45 'chang':9 'first':17 'manag':20 'pleas':8 'remov':22 'write':30 'accord':12 'member':36,47 'polici':15 'secret':63 'system':6C 'alreadi':60 'configur':16 'password':64
49	45	Recent changes	system:recent-changes	\N	1	\n\n\n	'chang':2C,6C 'recent':1C,5C 'system':3C 'recent-chang':4C
50	46	List all pages	system:list-all-pages	\N	1	\n\n\n	'list':1C,6C 'page':3C,8C 'system':4C 'list-all-pag':5C
38	22	Side	nav:side	\N	1	\n\n\nWelcome page\n\n\nWhat is a Wiki?\nHow to edit pages?\nGet a new wiki!\n\nAll wikis\n\nRecent activity\nAll wikis\nWikis by tags\nSearch\n\nThis wiki\n\nHow to join this site?\nSite members\n\n\nRecent changes\nList all pages\nPage Tags\n\n\nSite Manager\n\nPage tags\n\n\nAdd a new page\n\n\nedit this panel\n	'add':48 'get':14 'nav':2C 'new':16,50 'tag':26,43,47 'edit':12,52 'join':32 'list':39 'page':5,13,41,42,46,51 'side':1C,3C 'site':34,35,44 'wiki':9,17,19,23,24,29 'activ':21 'chang':38 'manag':45 'panel':54 'member':36 'recent':20,37 'search':27 'welcom':4
51	47	Page Tags List	system:page-tags-list	\N	1	\n\n\n	'tag':2C,7C 'list':3C,8C 'page':1C,6C 'system':4C 'page-tags-list':5C
52	48	Page Tags	system:page-tags	\N	1	\n\n\n\n\n	'tag':2C,6C 'page':1C,5C 'system':3C 'page-tag':4C
\.


--
-- Data for Name: global_ip_block; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY global_ip_block (block_id, address, flag_proxy, reason, flag_total, date_blocked) FROM stdin;
\.


--
-- Data for Name: global_user_block; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY global_user_block (block_id, site_id, user_id, reason, date_blocked) FROM stdin;
\.


--
-- Data for Name: ip_block; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY ip_block (block_id, site_id, ip, flag_proxy, reason, date_blocked) FROM stdin;
\.


--
-- Data for Name: license; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY license (license_id, name, description, sort) FROM stdin;
1	Creative Commons Attribution-ShareAlike 3.0 License (recommended)	%%UNLESS%% <a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/">Creative Commons Attribution-ShareAlike 3.0 License</a>	1
2	Creative Commons Attribution 3.0 License	%%UNLESS%% <a rel="license" href="http://creativecommons.org/licenses/by/3.0/">Creative Commons Attribution 3.0 License</a>	2
3	Creative Commons Attribution-NoDerivs 3.0 License	%%UNLESS%% <a rel="license" href="http://creativecommons.org/licenses/by-nd/3.0/">Creative Commons Attribution-NoDerivs 3.0 License</a>	3
4	Creative Commons Attribution-NonCommercial 3.0 License	%%UNLESS%% <a rel="license" href="http://creativecommons.org/licenses/by-nc/3.0/">Creative Commons Attribution-NonCommercial 3.0 License</a>	4
5	Creative Commons Attribution-NonCommercial-ShareAlike 3.0 License	%%UNLESS%% <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/">Creative Commons Attribution-NonCommercial-ShareAlike 3.0 License</a>	5
6	Creative Commons Attribution-NonCommercial-NoDerivs 3.0 License	%%UNLESS%% <a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/3.0/">Creative Commons Attribution-NonCommercial-NoDerivs 3.0 License</a>	6
7	GNU Free Documentation License 1.2	%%UNLESS%%  \n<a href="http://www.gnu.org/copyleft/fdl.html" title="http://www.gnu.org/copyleft/fdl.html" rel="license">GNU \nFree Documentation License</a>.	100
8	Standard copyright (not recommended)	\N	1000
\.


--
-- Data for Name: log_event; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY log_event (event_id, date, user_id, ip, proxy, "type", site_id, page_id, revision_id, thread_id, post_id, user_agent, text) FROM stdin;
1	2008-01-18 01:34:52	\N	127.0.0.1	\N	FAILED_LOGIN	1	\N	\N	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	Failed login for username "asd"
2	2008-01-18 01:46:00	\N	127.0.0.1	\N	FAILED_LOGIN	1	\N	\N	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	Failed login for username "sadasd"
3	2008-01-18 01:46:47	1	127.0.0.1	\N	LOGIN	1	\N	\N	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	User "Admin" (admin@wikidot) logged in.
4	2008-01-18 01:48:27	1	127.0.0.1	\N	LOGOUT	1	\N	\N	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	User "Admin" (admin@wikidot) logged out.
5	2008-01-18 01:48:38	\N	127.0.0.1	\N	FAILED_LOGIN	1	\N	\N	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	Failed login for username "asd"
6	2008-01-18 01:48:46	\N	127.0.0.1	\N	FAILED_LOGIN	1	\N	\N	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	Failed login for username "admin@wikidot"
7	2008-01-18 01:48:50	1	127.0.0.1	\N	LOGIN	1	\N	\N	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	User "Admin" (admin@wikidot) logged in.
8	2008-01-21 00:16:09	\N	127.0.0.1	\N	FAILED_LOGIN	1	\N	\N	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	Failed login for username "undefined"
9	2008-01-21 00:19:00	\N	127.0.0.1	\N	FAILED_LOGIN	1	\N	\N	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	Failed login for username "undefined"
10	2008-01-21 00:19:02	\N	127.0.0.1	\N	FAILED_LOGIN	1	\N	\N	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	Failed login for username "undefined"
11	2008-01-21 00:19:05	\N	127.0.0.1	\N	FAILED_LOGIN	1	\N	\N	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	Failed login for username "undefined"
12	2008-01-21 00:20:47	1	127.0.0.1	\N	LOGIN	1	\N	\N	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	User "Admin" (admin@wikidot) logged in.
13	2008-01-24 12:16:07	1	127.0.0.1	\N	LOGIN	1	\N	\N	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	User "Admin" (admin@wikidot) logged in.
14	2008-01-24 12:16:35	1	127.0.0.1	\N	PAGE_NEW	1	1	1	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "admin:manage" has been saved on site "Wikidot - Community Edition".
15	2008-01-24 12:22:02	1	127.0.0.1	\N	PAGE_NEW	1	2	2	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "account:you" has been saved on site "Wikidot - Community Edition".
16	2008-01-24 12:27:11	1	127.0.0.1	\N	PAGE_NEW	1	3	3	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "new-site" has been saved on site "Wikidot - Community Edition".
17	2008-01-24 12:32:21	1	127.0.0.1	\N	PAGE_NEW	1	4	4	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "user:info" has been saved on site "Wikidot - Community Edition".
18	2008-01-25 00:35:23	1	127.0.0.1	\N	PAGE_NEW	2	5	5	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "nav:side" has been saved on site "Template site (en)".
19	2008-01-25 00:45:30	1	127.0.0.1	\N	PAGE_NEW	2	6	6	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "what-is-a-wiki-site" has been saved on site "Template site (en)".
20	2008-01-25 01:05:59	1	127.0.0.1	\N	PAGE_NEW	3	7	7	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "profile:admin" has been saved on site "User profiles".
21	2008-01-25 01:06:39	1	127.0.0.1	\N	PAGE_NEW	3	8	8	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "admin:manage" has been saved on site "User profiles".
22	2008-01-25 01:08:10	1	127.0.0.1	\N	PAGE_NEW	1	9	9	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "nav:profile-side" has been saved on site "Wikidot - Community Edition".
23	2008-01-25 01:09:41	1	127.0.0.1	\N	PAGE_NEW	3	10	10	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "nav:profile-side" has been saved on site "User profiles".
24	2008-01-25 01:13:41	1	127.0.0.1	\N	PAGE_NEW	3	11	11	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "nav:side" has been saved on site "User profiles".
25	2008-01-25 01:14:31	1	127.0.0.1	\N	PAGE_EDIT	3	11	12	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	Page "nav:side" has been (edited and) saved on site "User profiles".
26	2008-01-25 01:15:35	1	127.0.0.1	\N	PAGE_NEW	3	12	13	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "start" has been saved on site "User profiles".
27	2008-01-25 03:19:18	1	127.0.0.1	\N	LOGOUT	3	\N	\N	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	User "Admin" (admin@wikidot) logged out.
28	2008-01-25 03:43:38	1	127.0.0.1	\N	LOGIN	1	\N	\N	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	User "Admin" (admin@wikidot) logged in.
29	2008-01-25 03:43:43	1	127.0.0.1	\N	ABUSE_PAGE_FLAG	3	\N	\N	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	Path "/profile:admin" has been flagged by user "Admin" on site "User profiles".
30	2008-01-25 03:43:44	1	127.0.0.1	\N	ABUSE_PAGE_UNFLAG	3	\N	\N	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	Path "/profile:admin" has been unflagged by user "Admin" on site "User profiles".
31	2008-01-25 18:43:03	1	127.0.0.1	\N	LOGOUT	1	\N	\N	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	User "Admin" (admin@wikidot) logged out.
32	2008-01-25 18:46:27	\N	127.0.0.1	\N	FAILED_LOGIN	1	\N	\N	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	Failed login for username "asdasd"
33	2008-01-25 18:49:13	\N	127.0.0.1	\N	FAILED_LOGIN	1	\N	\N	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	Failed login for username "sad"
34	2008-01-29 00:09:14	1	127.0.0.1	\N	LOGIN	1	\N	\N	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	User "Admin" (admin@wikidot) logged in.
35	2008-01-29 00:10:02	1	127.0.0.1	\N	PAGE_NEW	2	13	14	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "how-to-edit-pages" has been saved on site "Template site (en)".
36	2008-01-29 00:56:59	1	127.0.0.1	\N	PAGE_NEW	2	14	15	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "system:join" has been saved on site "Template site (en)".
37	2008-01-29 00:57:39	1	127.0.0.1	\N	PAGE_NEW	2	15	16	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "admin:manage" has been saved on site "Template site (en)".
38	2008-01-29 00:58:44	1	127.0.0.1	\N	PAGE_NEW	2	16	17	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "system:page-tags-list" has been saved on site "Template site (en)".
39	2008-01-29 00:59:15	1	127.0.0.1	\N	PAGE_NEW	2	17	18	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "system:recent-changes" has been saved on site "Template site (en)".
40	2008-01-29 00:59:41	1	127.0.0.1	\N	PAGE_NEW	2	18	19	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "system:members" has been saved on site "Template site (en)".
41	2008-01-29 01:01:49	1	127.0.0.1	\N	PAGE_NEW	2	19	20	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "search:site" has been saved on site "Template site (en)".
42	2008-01-29 01:03:43	1	127.0.0.1	\N	PAGE_NEW	2	20	21	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "system:page-tags" has been saved on site "Template site (en)".
43	2008-01-29 01:04:53	1	127.0.0.1	\N	PAGE_NEW	2	21	22	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "system:list-all-pages" has been saved on site "Template site (en)".
44	2008-01-29 01:05:47	1	127.0.0.1	\N	PAGE_NEW	1	22	23	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "nav:side" has been saved on site "Wikidot - Community Edition".
45	2008-01-29 01:07:41	1	127.0.0.1	\N	PAGE_NEW	1	23	24	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "start" has been saved on site "Wikidot - Community Edition".
46	2008-01-29 01:09:17	1	127.0.0.1	\N	PAGE_NEW	1	24	25	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "search:all" has been saved on site "Wikidot - Community Edition".
47	2008-01-29 01:34:41	1	127.0.0.1	\N	PAGE_NEW	1	25	26	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "search:site" has been saved on site "Wikidot - Community Edition".
48	2008-01-29 01:34:57	1	127.0.0.1	\N	PAGE_EDIT	1	25	27	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	Page "search:site" has been (edited and) saved on site "Wikidot - Community Edition".
49	2008-01-29 01:35:41	1	127.0.0.1	\N	PAGE_EDIT	1	23	28	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	Page "start" has been (edited and) saved on site "Wikidot - Community Edition".
50	2008-01-29 01:36:56	1	127.0.0.1	\N	PAGE_NEW	1	26	29	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "search:users" has been saved on site "Wikidot - Community Edition".
51	2008-01-29 01:37:12	1	127.0.0.1	\N	PAGE_EDIT	1	26	30	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	Page "search:users" has been (edited and) saved on site "Wikidot - Community Edition".
52	2008-01-29 01:40:24	1	127.0.0.1	\N	PAGE_NEW	2	27	31	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "forum:start" has been saved on site "Template site (en)".
53	2008-01-29 01:40:59	1	127.0.0.1	\N	PAGE_NEW	2	28	32	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "forum:category" has been saved on site "Template site (en)".
54	2008-01-29 01:41:32	1	127.0.0.1	\N	PAGE_NEW	2	29	33	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "forum:thread" has been saved on site "Template site (en)".
55	2008-01-29 01:42:10	1	127.0.0.1	\N	PAGE_NEW	2	30	34	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "forum:new-thread" has been saved on site "Template site (en)".
56	2008-01-29 01:42:42	1	127.0.0.1	\N	PAGE_NEW	2	31	35	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "forum:recent-posts" has been saved on site "Template site (en)".
57	2008-01-29 23:29:52	1	127.0.0.1	\N	PAGE_NEW	2	32	36	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "nav:top" has been saved on site "Template site (en)".
58	2008-01-29 23:30:18	1	127.0.0.1	\N	PAGE_NEW	2	33	37	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "profile:template" has been saved on site "Template site (en)".
59	2008-01-30 08:33:13	1	127.0.0.1	\N	LOGIN	1	\N	\N	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	User "Admin" (admin@wikidot) logged in.
60	2008-01-30 08:39:25	1	127.0.0.1	\N	PAGE_NEW	2	34	38	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "start" has been saved on site "Template site (en)".
61	2008-01-30 08:40:31	1	127.0.0.1	\N	PAGE_NEW	2	35	39	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "start" has been saved on site "Template site (en)".
62	2008-01-30 08:43:22	1	127.0.0.1	\N	PAGE_NEW	2	36	40	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "start" has been saved on site "Template site (en)".
63	2008-01-30 08:53:14	1	127.0.0.1	\N	PAGE_EDIT	1	22	41	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	Page "nav:side" has been (edited and) saved on site "Wikidot - Community Edition".
64	2008-01-30 08:54:57	1	127.0.0.1	\N	PAGE_NEW	1	37	42	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "system-all:all-sites" has been saved on site "Wikidot - Community Edition".
65	2008-01-30 08:55:33	1	127.0.0.1	\N	PAGE_NEW	1	38	43	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "system-all:sites-by-tags" has been saved on site "Wikidot - Community Edition".
66	2008-01-30 09:00:00	1	127.0.0.1	\N	PAGE_EDIT	1	38	44	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	Page "system-all:sites-by-tags" has been (edited and) saved on site "Wikidot - Community Edition".
67	2008-01-30 09:01:51	1	127.0.0.1	\N	PAGE_EDIT	1	22	45	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	Page "nav:side" has been (edited and) saved on site "Wikidot - Community Edition".
68	2008-01-30 09:07:05	1	127.0.0.1	\N	PAGE_NEW	1	39	46	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "system-all:search" has been saved on site "Wikidot - Community Edition".
69	2008-01-30 09:16:38	1	127.0.0.1	\N	PAGE_NEW	1	40	47	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "system-all:activity" has been saved on site "Wikidot - Community Edition".
70	2008-01-30 09:17:41	1	127.0.0.1	\N	PAGE_EDIT	1	40	48	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	Page "system-all:activity" has been (edited and) saved on site "Wikidot - Community Edition".
71	2008-01-30 12:52:26	1	127.0.0.1	\N	PAGE_EDIT	1	23	49	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	Page "start" has been (edited and) saved on site "Wikidot - Community Edition".
72	2008-01-30 16:08:05	1	127.0.0.1	\N	PAGE_EDIT	1	23	50	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	Page "start" has been (edited and) saved on site "Wikidot - Community Edition".
73	2008-01-30 16:08:40	1	127.0.0.1	\N	LOGOUT	1	\N	\N	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	User "Admin" (admin@wikidot) logged out.
74	2008-01-30 16:08:47	\N	127.0.0.1	\N	FAILED_LOGIN	1	\N	\N	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	Failed login for username "undefined"
75	2008-01-30 16:08:49	1	127.0.0.1	\N	LOGIN	1	\N	\N	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	User "Admin" (admin@wikidot) logged in.
76	2008-01-30 16:11:57	1	127.0.0.1	\N	PAGE_NEW	1	41	51	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "what-is-a-wiki" has been saved on site "Wikidot - Free Wiki Software".
77	2008-01-30 16:12:40	1	127.0.0.1	\N	PAGE_EDIT	2	13	52	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	Page "how-to-edit-pages" has been (edited and) saved on site "Template site (en)".
78	2008-01-30 16:12:49	1	127.0.0.1	\N	PAGE_NEW	1	42	53	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "how-to-edit-pages" has been saved on site "Wikidot - Free Wiki Software".
79	2008-01-30 16:13:32	1	127.0.0.1	\N	PAGE_NEW	1	43	54	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "system:members" has been saved on site "Wikidot - Free Wiki Software".
80	2008-01-30 16:14:13	1	127.0.0.1	\N	PAGE_NEW	1	44	55	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "system:join" has been saved on site "Wikidot - Free Wiki Software".
81	2008-01-30 16:14:42	1	127.0.0.1	\N	PAGE_NEW	1	45	56	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "system:recent-changes" has been saved on site "Wikidot - Free Wiki Software".
82	2008-01-30 16:15:23	1	127.0.0.1	\N	PAGE_NEW	1	46	57	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "system:list-all-pages" has been saved on site "Wikidot - Free Wiki Software".
83	2008-01-30 16:15:56	1	127.0.0.1	\N	PAGE_NEW	1	47	58	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "system:page-tags-list" has been saved on site "Wikidot - Free Wiki Software".
84	2008-01-30 16:16:22	1	127.0.0.1	\N	PAGE_NEW	1	48	59	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	New page "system:page-tags" has been saved on site "Wikidot - Free Wiki Software".
85	2008-01-30 16:16:53	1	127.0.0.1	\N	LOGOUT	1	\N	\N	\N	\N	Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11	User "Admin" (admin@wikidot) logged out.
\.


--
-- Data for Name: member; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY member (member_id, site_id, user_id, date_joined, allow_newsletter) FROM stdin;
\.


--
-- Data for Name: member_application; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY member_application (application_id, site_id, user_id, status, date, "comment", reply) FROM stdin;
\.


--
-- Data for Name: member_invitation; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY member_invitation (invitation_id, site_id, user_id, by_user_id, date, body) FROM stdin;
\.


--
-- Data for Name: membership_link; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY membership_link (link_id, site_id, by_user_id, user_id, date, "type") FROM stdin;
\.


--
-- Data for Name: moderator; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY moderator (moderator_id, site_id, user_id, permissions) FROM stdin;
\.


--
-- Data for Name: notification; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY notification (notification_id, user_id, body, "type", viewed, date, extra, notify_online, notify_feed, notify_email) FROM stdin;
\.


--
-- Data for Name: openid_entry; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY openid_entry (openid_id, site_id, page_id, "type", user_id, url, server_url) FROM stdin;
\.


--
-- Data for Name: ozone_group; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY ozone_group (group_id, parent_group_id, name, description) FROM stdin;
\.


--
-- Data for Name: ozone_group_permission_modifier; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY ozone_group_permission_modifier (group_permission_id, group_id, permission_id, modifier) FROM stdin;
\.


--
-- Data for Name: ozone_lock; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY ozone_lock ("key") FROM stdin;
\.


--
-- Data for Name: ozone_permission; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY ozone_permission (permission_id, name, description) FROM stdin;
\.


--
-- Data for Name: ozone_session; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY ozone_session (session_id, started, last_accessed, ip_address, check_ip, infinite, user_id, serialized_datablock) FROM stdin;
1201231196_10	2008-01-25 03:19:56	2008-01-25 03:19:56	127.0.0.1	f	f	\N	a:2:{s:11:"captchaCode";s:4:"94D9";s:5:"rstep";i:0;}
1201286587_14	2008-01-25 18:43:07	2008-01-25 18:43:07	127.0.0.1	f	f	\N	a:1:{s:10:"login_seed";s:4:"noj7";}
1201286592_15	2008-01-25 18:43:12	2008-01-25 18:43:12	127.0.0.1	f	f	\N	a:1:{s:10:"login_seed";s:4:"wcph";}
\.


--
-- Data for Name: ozone_user; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY ozone_user (user_id, name, nick_name, "password", email, unix_name, last_login, registered_date, super_admin, super_moderator, "language") FROM stdin;
-2	Automatic	Automatic	\N	automatic@wikidot	automatic	\N	\N	f	f	en
-1	Anonymous	Anonymous	\N	anonymous@wikidot	anonymous	\N	\N	f	f	en
1	admin@wikidot	Admin	a9e7f4848e40deb03cba8edd294d3a17	admin@wikidot	admin	2008-01-30 16:08:49	\N	t	f	en
\.


--
-- Data for Name: ozone_user_group_relation; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY ozone_user_group_relation (user_group_id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: ozone_user_permission_modifier; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY ozone_user_permission_modifier (user_permission_id, user_id, permission_id, modifier) FROM stdin;
\.


--
-- Data for Name: page; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY page (page_id, site_id, category_id, parent_page_id, revision_id, source_id, metadata_id, revision_number, title, unix_name, date_created, date_last_edited, last_edit_user_id, last_edit_user_string, thread_id, owner_user_id, blocked, rate) FROM stdin;
1	1	3	\N	1	1	1	0	\N	admin:manage	2008-01-24 12:16:34	2008-01-24 12:16:34	1	\N	\N	1	f	0
2	1	4	\N	2	2	2	0	\N	account:you	2008-01-24 12:22:02	2008-01-24 12:22:02	1	\N	\N	1	f	0
3	1	1	\N	3	3	3	0	Get a new wiki	new-site	2008-01-24 12:27:10	2008-01-24 12:27:10	1	\N	\N	1	f	0
4	1	5	\N	4	4	4	0	\N	user:info	2008-01-24 12:32:21	2008-01-24 12:32:21	1	\N	\N	1	f	0
5	2	6	\N	5	5	5	0	Side	nav:side	2008-01-25 00:35:20	2008-01-25 00:35:20	1	\N	\N	1	f	0
6	2	2	\N	6	6	6	0	What Is A Wiki Site	what-is-a-wiki-site	2008-01-25 00:45:30	2008-01-25 00:45:30	1	\N	\N	1	f	0
7	3	8	\N	7	7	7	0	Admin	profile:admin	2008-01-25 01:05:59	2008-01-25 01:05:59	1	\N	\N	1	f	0
8	3	9	\N	8	8	8	0	\N	admin:manage	2008-01-25 01:06:39	2008-01-25 01:06:39	1	\N	\N	1	f	0
10	3	11	\N	10	10	10	0	Profile Side	nav:profile-side	2008-01-25 01:09:41	2008-01-25 01:09:41	1	\N	\N	1	f	0
11	3	11	\N	12	12	11	1	Side	nav:side	2008-01-25 01:13:41	2008-01-25 01:14:31	1	\N	\N	1	f	0
12	3	7	\N	13	13	12	0	\N	start	2008-01-25 01:15:35	2008-01-25 01:15:35	1	\N	\N	1	f	0
14	2	12	\N	15	15	14	0	Join This Wiki	system:join	2008-01-29 00:56:59	2008-01-29 00:56:59	1	\N	\N	1	f	0
15	2	13	\N	16	16	15	0	\N	admin:manage	2008-01-29 00:57:39	2008-01-29 00:57:39	1	\N	\N	1	f	0
16	2	12	\N	17	17	16	0	Page Tags List	system:page-tags-list	2008-01-29 00:58:44	2008-01-29 00:58:44	1	\N	\N	1	f	0
17	2	12	\N	18	18	17	0	Recent Changes	system:recent-changes	2008-01-29 00:59:14	2008-01-29 00:59:14	1	\N	\N	1	f	0
18	2	12	\N	19	19	18	0	Members	system:members	2008-01-29 00:59:40	2008-01-29 00:59:40	1	\N	\N	1	f	0
19	2	14	\N	20	20	19	0	Wiki Search	search:site	2008-01-29 01:01:49	2008-01-29 01:01:49	1	\N	\N	1	f	0
20	2	12	\N	21	21	20	0	\N	system:page-tags	2008-01-29 01:03:43	2008-01-29 01:03:43	1	\N	\N	1	f	0
21	2	12	\N	22	22	21	0	List All Pages	system:list-all-pages	2008-01-29 01:04:52	2008-01-29 01:04:52	1	\N	\N	1	f	0
24	1	16	\N	25	25	24	0	Search All Wikis	search:all	2008-01-29 01:09:17	2008-01-29 01:09:17	1	\N	\N	1	f	0
25	1	16	\N	27	26	26	1	Search This Wiki	search:site	2008-01-29 01:34:40	2008-01-29 01:34:57	1	\N	\N	1	f	0
26	1	16	\N	30	29	27	1	Search Users	search:users	2008-01-29 01:36:56	2008-01-29 01:37:12	1	\N	\N	1	f	0
27	2	17	\N	31	30	28	0	Forum Categories	forum:start	2008-01-29 01:40:23	2008-01-29 01:40:23	1	\N	\N	1	f	0
28	2	17	\N	32	31	29	0	Forum Category	forum:category	2008-01-29 01:40:59	2008-01-29 01:40:59	1	\N	\N	1	f	0
29	2	17	\N	33	32	30	0	Forum Thread	forum:thread	2008-01-29 01:41:32	2008-01-29 01:41:32	1	\N	\N	1	f	0
30	2	17	\N	34	33	31	0	New Forum Thread	forum:new-thread	2008-01-29 01:42:10	2008-01-29 01:42:10	1	\N	\N	1	f	0
31	2	17	\N	35	34	32	0	Recent Forum Posts	forum:recent-posts	2008-01-29 01:42:42	2008-01-29 01:42:42	1	\N	\N	1	f	0
32	2	6	\N	36	35	33	0	Top	nav:top	2008-01-29 23:29:51	2008-01-29 23:29:51	1	\N	\N	1	f	0
33	2	18	\N	37	36	34	0	Template	profile:template	2008-01-29 23:30:18	2008-01-29 23:30:18	1	\N	\N	1	f	0
36	2	2	\N	40	39	37	0	Congratulations, welcome to your new wiki!	start	2008-01-30 08:43:22	2008-01-30 08:43:22	1	\N	\N	1	f	0
37	1	19	\N	42	41	38	0	List of all wikis	system-all:all-sites	2008-01-30 08:54:56	2008-01-30 08:54:56	1	\N	\N	1	f	0
38	1	19	\N	44	43	40	1	List wikis by tags	system-all:sites-by-tags	2008-01-30 08:55:33	2008-01-30 09:00:00	1	\N	\N	1	f	0
22	1	15	\N	45	44	22	2	Side	nav:side	2008-01-29 01:05:47	2008-01-30 09:01:50	1	\N	\N	1	f	0
39	1	19	\N	46	45	41	0	Search	system-all:search	2008-01-30 09:07:05	2008-01-30 09:07:05	1	\N	\N	1	f	0
40	1	19	\N	48	47	43	1	Activity across all wikis	system-all:activity	2008-01-30 09:16:38	2008-01-30 09:17:40	1	\N	\N	1	f	0
23	1	1	\N	50	49	44	3	Welcome to your new Wikidot installation!	start	2008-01-29 01:07:41	2008-01-30 16:08:02	1	\N	\N	1	f	0
41	1	1	\N	51	50	45	0	What Is A Wiki	what-is-a-wiki	2008-01-30 16:11:56	2008-01-30 16:11:56	1	\N	\N	1	f	0
13	2	2	\N	52	51	13	1	How To Edit Pages - Quickstart	how-to-edit-pages	2008-01-29 00:09:59	2008-01-30 16:12:40	1	\N	\N	1	f	0
42	1	1	\N	53	52	46	0	How To Edit Pages	how-to-edit-pages	2008-01-30 16:12:48	2008-01-30 16:12:48	1	\N	\N	1	f	0
43	1	20	\N	54	53	47	0	Wiki Members	system:members	2008-01-30 16:13:32	2008-01-30 16:13:32	1	\N	\N	1	f	0
44	1	20	\N	55	54	48	0	How to join this wiki?	system:join	2008-01-30 16:14:13	2008-01-30 16:14:13	1	\N	\N	1	f	0
45	1	20	\N	56	55	49	0	Recent changes	system:recent-changes	2008-01-30 16:14:41	2008-01-30 16:14:41	1	\N	\N	1	f	0
46	1	20	\N	57	56	50	0	List all pages	system:list-all-pages	2008-01-30 16:15:22	2008-01-30 16:15:22	1	\N	\N	1	f	0
47	1	20	\N	58	57	51	0	Page Tags List	system:page-tags-list	2008-01-30 16:15:56	2008-01-30 16:15:56	1	\N	\N	1	f	0
48	1	20	\N	59	58	52	0	Page Tags	system:page-tags	2008-01-30 16:16:22	2008-01-30 16:16:22	1	\N	\N	1	f	0
\.


--
-- Data for Name: page_abuse_flag; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY page_abuse_flag (flag_id, user_id, site_id, path, site_valid, global_valid) FROM stdin;
\.


--
-- Data for Name: page_compiled; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY page_compiled (page_id, text, date_compiled) FROM stdin;
1	\n\nþmodule "managesite/ManageSiteModule"þ	2008-01-24 12:16:35
2	\n\nþmodule "account/AccountModule"þ	2008-01-24 12:22:02
3	\n\n<p>Use this simple form to create a new wiki.</p>\n<p>To admins: you can customize this page by simply clicking "edit" at the bottom of the page.</p>\nþmodule "newsite/NewSiteModule"þ	2008-01-24 12:27:11
4	\n\nþmodule "userinfo/UserInfoModule"þ	2008-01-24 12:32:21
6	\n\n<p>According to <a href="http://en.wikipedia.org/wiki/Wiki">Wikipedia</a>, the world largest wiki site:</p>\n<blockquote>\n<p>A <em>Wiki</em> ([ˈwiː.kiː] &lt;wee-kee&gt; or [ˈwɪ.kiː] &lt;wick-ey&gt;) is a type of website that allows users to add, remove, or otherwise edit and change most content very quickly and easily.</p>\n</blockquote>\n<p>And that is it! As a part of a farm of wikis this site is a great tool that you can use to publish content, upload files, communicate and collaborate.</p>\n	2008-01-25 00:45:30
7	\n\n<p>Admin of this Wikidot installation.</p>\n	2008-01-25 01:05:59
8	\n\nþmodule "managesite/ManageSiteModule"þ	2008-01-25 01:06:39
10	\n\n<p>The profiles site is used to host user profiles. Each <tt>profile:username</tt> page contains a user-editable text that is included in the user's profile page.</p>\n<p>If you are viewing your own profile content page, feel free to edit it. You are the only one allowed to edit this page.</p>\n	2008-01-25 01:09:41
12	\n\n<p>The purpose of this wiki is to store user profiles.</p>\n	2008-01-25 01:15:35
11	\n\n<p>The profiles site is used to host user profiles. Each <tt>profile:username</tt> page contains a user-editable text that is included in the user's profile page.</p>\n<ul>\n<li><a href="/start">Main page</a></li>\n<li><a href="/admin:manage">Manage this wiki</a></li>\n</ul>\n	2008-01-25 01:15:35
15	\n\nþmodule "managesite/ManageSiteModule"þ	2008-01-29 00:57:39
14	\n\n<div class="wiki-note">\n<p>Please change this page according to your policy (configure first using <a href="/admin:manage">Site Manager</a>) and remove this note.</p>\n</div>\n<h1 id="toc0"><span>Who can join?</span></h1>\n<p>You can write here who can become a member of this site.</p>\n<h1 id="toc1"><span>Join!</span></h1>\n<p>So you want to become a member of this site? Tell us why and apply now!</p>\nþmodule "membership/MembershipApplyModule"þ<br />\n<p>Or, if you already know a "secret password", go for it!</p>\nþmodule "membership/MembershipByPasswordModule"þ	2008-01-29 00:57:39
16	\n\nþmodule "wiki/pagestagcloud/PagesTagCloudModule" limit%3D%22200%22+target%3D%22system%3Apage-tags%22 þ	2008-01-29 00:58:44
17	\n\nþmodule "changes/SiteChangesModule"þ	2008-01-29 00:59:15
18	\n\n<h1 id="toc0"><span>Members:</span></h1>\nþmodule "membership/MembersListModule"þ\n<h1 id="toc1"><span>Moderators</span></h1>\nþmodule "membership/MembersListModule" group%3D%22moderators%22 þ\n<h1 id="toc2"><span>Admins</span></h1>\nþmodule "membership/MembersListModule" group%3D%22admins%22 þ	2008-01-29 00:59:40
19	\n\nþmodule "search/SearchModule"þ	2008-01-29 01:01:49
20	\n\n<div style="float:right; width: 50%;">þmodule "wiki/pagestagcloud/PagesTagCloudModule" limit%3D%22200%22+target%3D%22system%3Apage-tags%22 þ</div>\nþmodule "wiki/pagestagcloud/PagesListByTagModule"þ	2008-01-29 01:03:43
21	\n\nþmodule "list/WikiPagesModule" preview%3D%22true%22 þ	2008-01-29 01:04:52
24	\n\nþmodule "search/SearchAllModule"þ	2008-01-29 01:09:17
25	\n\nþmodule "search/SearchModule"þ	2008-01-29 01:34:41
26	\n\n<p>To look for someone, please enter:</p>\n<ul>\n<li>email address of a person you are looking for (this will look for exact match)</li>\n<li>any part of the screen name or realname (lists all Users matching the query)</li>\n</ul>\nþmodule "search/UserSearchModule"þ	2008-01-29 01:37:12
27	\n\nþmodule "forum/ForumStartModule"þ	2008-01-29 01:40:24
28	\n\nþmodule "forum/ForumViewCategoryModule"þ	2008-01-29 01:40:59
29	\n\nþmodule "forum/ForumViewThreadModule"þ	2008-01-29 01:41:32
30	\n\nþmodule "forum/ForumNewThreadModule"þ	2008-01-29 01:42:10
31	\n\nþmodule "forum/ForumRecentPostsModule"þ	2008-01-29 01:42:42
32	\n\n<ul>\n<li><a href="javascript:;">example menu</a>\n<ul>\n<li><a class="newpage" href="/submenu">submenu</a></li>\n</ul>\n</li>\n<li><a class="newpage" href="/contact">contact</a></li>\n</ul>\n	2008-01-29 23:29:51
33	\n\n<p>Profile has not been created (yet).</p>\n	2008-01-29 23:30:18
5	\n\n<ul>\n<li><a href="/start">Welcome page</a></li>\n</ul>\n<ul>\n<li><a href="/what-is-a-wiki-site">What is a Wiki Site?</a></li>\n<li><a href="/how-to-edit-pages">How to edit pages?</a></li>\n</ul>\n<ul>\n<li><a href="/system:join">How to join this site?</a></li>\n<li><a href="/system:members">Site members</a></li>\n</ul>\n<ul>\n<li><a href="/system:recent-changes">Recent changes</a></li>\n<li><a href="/system:list-all-pages">List all pages</a></li>\n<li><a href="/system:page-tags-list">Page Tags</a></li>\n</ul>\n<ul>\n<li><a href="/admin:manage">Site Manager</a></li>\n</ul>\n<h2 id="toc0"><span>Page tags</span></h2>\nþmodule "wiki/pagestagcloud/PagesTagCloudModule" minFontSize%3D%2280%25%22+maxFontSize%3D%22200%25%22++maxColor%3D%228%2C8%2C64%22+minColor%3D%22100%2C100%2C128%22+target%3D%22system%3Apage-tags%22+limit%3D%2230%22 þ\n<h2 id="toc1"><span>Add a new page</span></h2>\nþmodule "misc/NewPageHelperModule" size%3D%2215%22+button%3D%22new+page%22 þ\n<p style="text-align: center;"><span style="font-size:80%;"><a href="/nav:side">edit this panel</a></span></p>\n	2008-01-30 08:39:25
36	\n\n<h2 id="toc0"><span>If this is your first site</span></h2>\n<p>Then there are some things you need to know:</p>\n<ul>\n<li>You can configure all security and other settings online, using the <a href="/admin:manage">Site Manager</a>. When you invite other people to help build this site they don't have access to the Site Manager unless you make them administrators like yourself. Check out the <em>Permissions</em> section.</li>\n<li>Your Wikidot site has two menus, <a href="/nav:side">one at the side</a> called '<tt>nav:side</tt>', and <a href="/nav:top">one at the top</a> called '<tt>nav:top</tt>'. These are Wikidot pages, and you can edit them like any page.</li>\n<li>To edit a page, go to the page and click the <strong>Edit</strong> button at the bottom. You can change everything in the main area of your page. The Wikidot system is <a href="http://www.wikidot.org/doc" onclick="window.open(this.href, '_blank'); return false;">easy to learn and powerful</a>.</li>\n<li>You can attach images and other files to any page, then display them and link to them in the page.</li>\n<li>Every Wikidot page has a history of edits, and you can undo anything. So feel secure, and experiment.</li>\n<li>To start a forum on your site, see the <a href="/admin:manage">Site Manager</a> » <em>Forum</em>.</li>\n<li>The license for this Wikidot site has been set to <a href="http://creativecommons.org/licenses/by-sa/3.0/" onclick="window.open(this.href, '_blank'); return false;">Creative Commons Attribution-Share Alike 3.0 License</a>. If you want to change this, use the Site Manager.</li>\n<li>If you want to learn more, make sure you visit the <a href="http://www.wikidot.org/doc" onclick="window.open(this.href, '_blank'); return false;">Documentation section at www.wikidot.org</a></li>\n</ul>\n<p>More information about the Wikidot project can be found at <a href="http://www.wikidot.org" onclick="window.open(this.href, '_blank'); return false;">www.wikidot.org</a>.</p>\n	2008-01-30 08:43:22
37	\n\n<p>Below is the list of public visible Wikis hosted at this service:</p>\nþmodule "wiki/listallwikis/ListAllWikisModule"þ	2008-01-30 08:54:57
38	\n\nþmodule "wiki/sitestagcloud/SitesTagCloudModule" limit%3D%22100%22+target%3D%22system-all%3Asites-by-tags%22 þþmodule "wiki/sitestagcloud/SitesListByTagModule"þ	2008-01-30 09:00:00
39	\n\n<div style="text-align: center;">\n<h1 id="toc0"><span>Search all Wikis</span></h1>\n<p>Perform a search through all public and visible wikis.</p>\nþmodule "search/SearchAllModule"þ\n<hr />\n<h1 id="toc1"><span>Search users</span></h1>\n<p>To look for someone, please enter:</p>\n<ul>\n<li>email address of a person you are looking for (this will look for exact match)</li>\n<li>any part of the screen name or realname (lists all Users matching the query)</li>\n</ul>\nþmodule "search/UserSearchModule"þ</div>\n	2008-01-30 09:07:05
40	\n\n<table>\n<tr>\n<td style="width: 45%; padding-right: 2%; border-right: 1px solid #999; vertical-align:top;">\n<h2 id="toc0"><span>Recent edits (all wikis)</span></h2>\nþmodule "wiki/sitesactivity/RecentWPageRevisionsModule"þ</td>\n<td style="width: 45%; padding-left: 2%; vertical-align:top;">\n<h2 id="toc1"><span>Top Sites</span></h2>\nþmodule "wiki/sitesactivity/MostActiveSitesModule"þ\n<h2 id="toc2"><span>Top Forums</span></h2>\nþmodule "wiki/sitesactivity/MostActiveForumsModule"þ\n<h2 id="toc3"><span>New users</span></h2>\nþmodule "wiki/sitesactivity/NewWUsersModule"þ\n<h2 id="toc4"><span>Some statistics</span></h2>\nþmodule "wiki/sitesactivity/SomeGlobalStatsModule"þ</td>\n</tr>\n</table>\n	2008-01-30 09:17:40
23	\n\n<p>Congratulations, you have successfully installed Wikidot software on your computer!</p>\n<h1 id="toc0"><span>What to do next</span></h1>\n<h2 id="toc1"><span>Customize this wiki</span></h2>\n<p>Wikidot consists of several wiki sites, not just one. Right now you are on the main wiki. Customize it!</p>\n<ul>\n<li>You can configure all security and other settings online, using the <a href="/admin:manage">Site Manager</a>. When you invite other people to help build this site they don't have access to the Site Manager unless you make them administrators like yourself. Check out the <em>Permissions</em> section.</li>\n<li>Your Wikidot site has two menus, <a href="/nav:side">one at the side</a> called '<tt>nav:side</tt>', and <a class="newpage" href="/nav:top">one at the top</a> called '<tt>nav:top</tt>'. These are Wikidot pages, and you can edit them like any page.</li>\n<li>To edit a page, go to the page and click the <strong>Edit</strong> button at the bottom. You can change everything in the main area of your page. The Wikidot system is <a href="http://www.wikidot.org/doc" onclick="window.open(this.href, '_blank'); return false;">easy to learn and powerful</a>.</li>\n<li>You can attach images and other files to any page, then display them and link to them in the page.</li>\n<li>Every Wikidot page has a history of edits, and you can undo anything. So feel secure, and experiment.</li>\n<li>To start a forum on your site, see the <a href="/admin:manage">Site Manager</a> » <em>Forum</em>.</li>\n<li>The license for this Wikidot site has been set to <a href="http://creativecommons.org/licenses/by-sa/3.0/" onclick="window.open(this.href, '_blank'); return false;">Creative Commons Attribution-Share Alike 3.0 License</a>. If you want to change this, use the Site Manager.</li>\n<li>If you want to learn more, make sure you visit the <a href="http://www.wikidot.org/doc" onclick="window.open(this.href, '_blank'); return false;">Documentation section at www.wikidot.org</a></li>\n</ul>\n<h2 id="toc2"><span>Customize default template</span></h2>\n<p>Default initial template for other wikis is located at <a href="http://template-en.wikidotos.com/template-en">template-en</a>. If someone creates a new wiki, this one is cloned to the new address. A good thing to do is to go to <a href="http://template-en.wikidotos.com/template-en">template-en</a> and customize it.</p>\n<h2 id="toc3"><span>Create more templates</span></h2>\n<p>Simply create wikis with unix names starting with "template-" (e.g. "template-pl", "template-blog") and your users will be able to choose which wiki they want to start with.</p>\n<h2 id="toc4"><span>Visit Wikidot.org</span></h2>\n<p>Go to <strong><a href="http://www.wikidot.org">www.wikidot.org</a></strong> — home of the Wikidot software — for extra documentation, howtos, tips and support.</p>\n<hr />\n<p>More information about the Wikidot project can be found at <a href="http://www.wikidot.org" onclick="window.open(this.href, '_blank'); return false;">www.wikidot.org</a>.</p>\n<h1 id="toc5"><span>Search all wikis</span></h1>\nþmodule "search/SearchAllModule"þ\n<h1 id="toc6"><span>Search users</span></h1>\nþmodule "search/UserSearchModule"þ	2008-01-30 16:08:03
41	\n\n<p>According to <a href="http://en.wikipedia.org/wiki/Wiki">Wikipedia</a>, the world largest wiki site:</p>\n<blockquote>\n<p>A <em>Wiki</em> ([ˈwiː.kiː] &lt;wee-kee&gt; or [ˈwɪ.kiː] &lt;wick-ey&gt;) is a type of website that allows users to add, remove, or otherwise edit and change most content very quickly and easily.</p>\n</blockquote>\n<p>And that is it! As a part of a farm of wikis this site is a great tool that you can use to publish content, upload files, communicate and collaborate.</p>\n	2008-01-30 16:11:57
13	\n\n<p>If you are allowed to edit pages in this Site, simply click on <em>edit</em> button at the bottom of the page. This will open an editor with a toolbar pallette with options.</p>\n<p>To create a link to a new page, use syntax: <tt>[[[new page name]]]</tt> or <tt>[[[new page name | text to display]]]</tt>. Follow the link (which should have a different color if page does not exist) and create a new page and edit it!</p>\n<p>Although creating and editing pages is easy, there are a lot more options that allows creating powerful sites. Please visit <a href="http://www.wikidot.org/doc" onclick="window.open(this.href, '_blank'); return false;">Documentation pages</a> (at wikidot.org) to learn more.</p>\n	2008-01-30 16:12:40
42	\n\n<p>If you are allowed to edit pages in this Site, simply click on <em>edit</em> button at the bottom of the page. This will open an editor with a toolbar pallette with options.</p>\n<p>To create a link to a new page, use syntax: <tt>[[[new page name]]]</tt> or <tt>[[[new page name | text to display]]]</tt>. Follow the link (which should have a different color if page does not exist) and create a new page and edit it!</p>\n<p>Although creating and editing pages is easy, there are a lot more options that allows creating powerful sites. Please visit <a href="http://www.wikidot.org/doc" onclick="window.open(this.href, '_blank'); return false;">Documentation pages</a> (at wikidot.org) to learn more.</p>\n	2008-01-30 16:12:49
43	\n\n<h1 id="toc0"><span>Members:</span></h1>\nþmodule "membership/MembersListModule"þ\n<h1 id="toc1"><span>Moderators</span></h1>\nþmodule "membership/MembersListModule" group%3D%22moderators%22 þ\n<h1 id="toc2"><span>Admins</span></h1>\nþmodule "membership/MembersListModule" group%3D%22admins%22 þ	2008-01-30 16:13:32
44	\n\n<div class="wiki-note">\n<p>Please change this page according to your policy (configure first using <a href="/admin:manage">Site Manager</a>) and remove this note.</p>\n</div>\n<h1 id="toc0"><span>Who can join?</span></h1>\n<p>You can write here who can become a member of this site.</p>\n<h1 id="toc1"><span>Join!</span></h1>\n<p>So you want to become a member of this site? Tell us why and apply now!</p>\nþmodule "membership/MembershipApplyModule"þ<br />\n<p>Or, if you already know a "secret password", go for it!</p>\nþmodule "membership/MembershipByPasswordModule"þ	2008-01-30 16:14:13
45	\n\nþmodule "changes/SiteChangesModule"þ	2008-01-30 16:14:41
46	\n\nþmodule "list/WikiPagesModule" preview%3D%22true%22 þ	2008-01-30 16:15:22
47	\n\nþmodule "wiki/pagestagcloud/PagesTagCloudModule" limit%3D%22200%22+target%3D%22system%3Apage-tags%22 þ	2008-01-30 16:15:56
22	\n\n<ul>\n<li><a href="/start">Welcome page</a></li>\n</ul>\n<ul>\n<li><a href="/what-is-a-wiki">What is a Wiki?</a></li>\n<li><a href="/how-to-edit-pages">How to edit pages?</a></li>\n<li><a href="/new-site">Get a new wiki!</a></li>\n</ul>\n<h1 id="toc0"><span>All wikis</span></h1>\n<ul>\n<li><a href="/system-all:activity">Recent activity</a></li>\n<li><a href="/system-all:all-sites">All wikis</a></li>\n<li><a href="/system-all:sites-by-tags">Wikis by tags</a></li>\n<li><a href="/system-all:search">Search</a></li>\n</ul>\n<h1 id="toc1"><span>This wiki</span></h1>\n<ul>\n<li><a href="/system:join">How to join this site?</a></li>\n<li><a href="/system:members">Site members</a></li>\n</ul>\n<ul>\n<li><a href="/system:recent-changes">Recent changes</a></li>\n<li><a href="/system:list-all-pages">List all pages</a></li>\n<li><a href="/system:page-tags-list">Page Tags</a></li>\n</ul>\n<ul>\n<li><a href="/admin:manage">Site Manager</a></li>\n</ul>\n<h2 id="toc2"><span>Page tags</span></h2>\nþmodule "wiki/pagestagcloud/PagesTagCloudModule" minFontSize%3D%2280%25%22+maxFontSize%3D%22200%25%22++maxColor%3D%228%2C8%2C64%22+minColor%3D%22100%2C100%2C128%22+target%3D%22system%3Apage-tags%22+limit%3D%2230%22 þ\n<h2 id="toc3"><span>Add a new page</span></h2>\nþmodule "misc/NewPageHelperModule" size%3D%2215%22+button%3D%22new+page%22 þ\n<p style="text-align: center;"><span style="font-size:80%;"><a href="/nav:side">edit this panel</a></span></p>\n	2008-01-30 16:15:56
48	\n\n<div style="float:right; width: 50%;">þmodule "wiki/pagestagcloud/PagesTagCloudModule" limit%3D%22200%22+target%3D%22system%3Apage-tags%22 þ</div>\nþmodule "wiki/pagestagcloud/PagesListByTagModule"þ	2008-01-30 16:16:22
\.


--
-- Data for Name: page_edit_lock; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY page_edit_lock (lock_id, page_id, "mode", section_id, range_start, range_end, page_unix_name, user_id, user_string, session_id, date_started, date_last_accessed, secret, site_id) FROM stdin;
\.


--
-- Data for Name: page_inclusion; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY page_inclusion (inclusion_id, including_page_id, included_page_id, included_page_name, site_id) FROM stdin;
\.


--
-- Data for Name: page_link; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY page_link (link_id, from_page_id, to_page_id, to_page_name, site_id) FROM stdin;
1	5	5	\N	2
11	5	6	\N	2
12	11	8	\N	3
14	11	12	\N	3
15	5	13	\N	2
16	5	14	\N	2
18	14	15	\N	2
19	5	15	\N	2
20	5	16	\N	2
21	5	17	\N	2
22	5	18	\N	2
23	5	21	\N	2
24	22	1	\N	1
25	22	22	\N	1
34	22	23	\N	1
35	32	\N	submenu	2
36	32	\N	contact	2
44	36	15	\N	2
45	36	5	\N	2
46	36	32	\N	2
52	22	37	\N	1
53	22	38	\N	1
54	22	3	\N	1
55	22	39	\N	1
56	22	40	\N	1
57	23	1	\N	1
58	23	22	\N	1
59	23	\N	nav:top	1
60	22	41	\N	1
61	22	42	\N	1
62	22	43	\N	1
63	22	44	\N	1
64	44	1	\N	1
65	22	45	\N	1
66	22	46	\N	1
67	22	47	\N	1
\.


--
-- Data for Name: page_metadata; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY page_metadata (metadata_id, parent_page_id, title, unix_name, owner_user_id) FROM stdin;
1	\N	\N	admin:manage	1
2	\N	\N	account:you	1
3	\N	Get a new wiki	new-site	1
4	\N	\N	user:info	1
5	\N	Side	nav:side	1
6	\N	What Is A Wiki Site	what-is-a-wiki-site	1
7	\N	Admin	profile:admin	1
8	\N	\N	admin:manage	1
10	\N	Profile Side	nav:profile-side	1
11	\N	Side	nav:side	1
12	\N	\N	start	1
13	\N	How To Edit Pages - Quickstart	how-to-edit-pages	1
14	\N	Join This Wiki	system:join	1
15	\N	\N	admin:manage	1
16	\N	Page Tags List	system:page-tags-list	1
17	\N	Recent Changes	system:recent-changes	1
18	\N	Members	system:members	1
19	\N	Wiki Search	search:site	1
20	\N	\N	system:page-tags	1
21	\N	List All Pages	system:list-all-pages	1
22	\N	Side	nav:side	1
23	\N	Welcome to Wikidot	start	1
24	\N	Search All Wikis	search:all	1
25	\N	Search	search:site	1
26	\N	Search This Wiki	search:site	1
27	\N	Search Users	search:users	1
28	\N	Forum Categories	forum:start	1
29	\N	Forum Category	forum:category	1
30	\N	Forum Thread	forum:thread	1
31	\N	New Forum Thread	forum:new-thread	1
32	\N	Recent Forum Posts	forum:recent-posts	1
33	\N	Top	nav:top	1
34	\N	Template	profile:template	1
37	\N	Congratulations, welcome to your new wiki!	start	1
38	\N	List of all wikis	system-all:all-sites	1
39	\N	Sites By Tags	system-all:sites-by-tags	1
40	\N	List wikis by tags	system-all:sites-by-tags	1
41	\N	Search	system-all:search	1
42	\N	Activity	system-all:activity	1
43	\N	Activity across all wikis	system-all:activity	1
44	\N	Welcome to your new Wikidot installation!	start	1
45	\N	What Is A Wiki	what-is-a-wiki	1
46	\N	How To Edit Pages	how-to-edit-pages	1
47	\N	Wiki Members	system:members	1
48	\N	How to join this wiki?	system:join	1
49	\N	Recent changes	system:recent-changes	1
50	\N	List all pages	system:list-all-pages	1
51	\N	Page Tags List	system:page-tags-list	1
52	\N	Page Tags	system:page-tags	1
\.


--
-- Data for Name: page_rate_vote; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY page_rate_vote (rate_id, user_id, page_id, rate, date) FROM stdin;
\.


--
-- Data for Name: page_revision; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY page_revision (revision_id, page_id, source_id, metadata_id, flags, flag_text, flag_title, flag_file, flag_rename, flag_meta, flag_new, since_full_source, diff_source, revision_number, date_last_edited, user_id, user_string, comments, flag_new_site, site_id) FROM stdin;
1	1	1	1	\N	f	f	f	f	f	t	0	f	0	2008-01-24 12:16:34	1	\N		f	1
2	2	2	2	\N	f	f	f	f	f	t	0	f	0	2008-01-24 12:22:02	1	\N		f	1
3	3	3	3	\N	f	f	f	f	f	t	0	f	0	2008-01-24 12:27:10	1	\N		f	1
4	4	4	4	\N	f	f	f	f	f	t	0	f	0	2008-01-24 12:32:21	1	\N		f	1
5	5	5	5	\N	f	f	f	f	f	t	0	f	0	2008-01-25 00:35:20	1	\N		f	2
6	6	6	6	\N	f	f	f	f	f	t	0	f	0	2008-01-25 00:45:30	1	\N		f	2
7	7	7	7	\N	f	f	f	f	f	t	0	f	0	2008-01-25 01:05:59	1	\N		f	3
8	8	8	8	\N	f	f	f	f	f	t	0	f	0	2008-01-25 01:06:39	1	\N		f	3
9	9	9	9	\N	f	f	f	f	f	t	0	f	0	2008-01-25 01:08:10	1	\N		f	1
10	10	10	10	\N	f	f	f	f	f	t	0	f	0	2008-01-25 01:09:41	1	\N		f	3
11	11	11	11	\N	f	f	f	f	f	t	0	f	0	2008-01-25 01:13:41	1	\N		f	3
12	11	12	11	\N	t	f	f	f	f	f	0	f	1	2008-01-25 01:14:31	1	\N		f	3
13	12	13	12	\N	f	f	f	f	f	t	0	f	0	2008-01-25 01:15:35	1	\N		f	3
14	13	14	13	\N	f	f	f	f	f	t	0	f	0	2008-01-29 00:09:59	1	\N		f	2
15	14	15	14	\N	f	f	f	f	f	t	0	f	0	2008-01-29 00:56:59	1	\N		f	2
16	15	16	15	\N	f	f	f	f	f	t	0	f	0	2008-01-29 00:57:39	1	\N		f	2
17	16	17	16	\N	f	f	f	f	f	t	0	f	0	2008-01-29 00:58:44	1	\N		f	2
18	17	18	17	\N	f	f	f	f	f	t	0	f	0	2008-01-29 00:59:14	1	\N		f	2
19	18	19	18	\N	f	f	f	f	f	t	0	f	0	2008-01-29 00:59:40	1	\N		f	2
20	19	20	19	\N	f	f	f	f	f	t	0	f	0	2008-01-29 01:01:49	1	\N		f	2
21	20	21	20	\N	f	f	f	f	f	t	0	f	0	2008-01-29 01:03:43	1	\N		f	2
22	21	22	21	\N	f	f	f	f	f	t	0	f	0	2008-01-29 01:04:52	1	\N		f	2
23	22	23	22	\N	f	f	f	f	f	t	0	f	0	2008-01-29 01:05:47	1	\N		f	1
24	23	24	23	\N	f	f	f	f	f	t	0	f	0	2008-01-29 01:07:41	1	\N		f	1
25	24	25	24	\N	f	f	f	f	f	t	0	f	0	2008-01-29 01:09:17	1	\N		f	1
26	25	26	25	\N	f	f	f	f	f	t	0	f	0	2008-01-29 01:34:40	1	\N		f	1
27	25	26	26	\N	f	t	f	f	f	f	0	f	1	2008-01-29 01:34:57	1	\N		f	1
28	23	27	23	\N	t	f	f	f	f	f	0	f	1	2008-01-29 01:35:41	1	\N		f	1
29	26	28	27	\N	f	f	f	f	f	t	0	f	0	2008-01-29 01:36:56	1	\N		f	1
30	26	29	27	\N	t	f	f	f	f	f	0	f	1	2008-01-29 01:37:12	1	\N		f	1
31	27	30	28	\N	f	f	f	f	f	t	0	f	0	2008-01-29 01:40:23	1	\N		f	2
32	28	31	29	\N	f	f	f	f	f	t	0	f	0	2008-01-29 01:40:59	1	\N		f	2
33	29	32	30	\N	f	f	f	f	f	t	0	f	0	2008-01-29 01:41:32	1	\N		f	2
34	30	33	31	\N	f	f	f	f	f	t	0	f	0	2008-01-29 01:42:10	1	\N		f	2
35	31	34	32	\N	f	f	f	f	f	t	0	f	0	2008-01-29 01:42:42	1	\N		f	2
36	32	35	33	\N	f	f	f	f	f	t	0	f	0	2008-01-29 23:29:51	1	\N		f	2
37	33	36	34	\N	f	f	f	f	f	t	0	f	0	2008-01-29 23:30:18	1	\N		f	2
38	34	37	35	\N	f	f	f	f	f	t	0	f	0	2008-01-30 08:39:24	1	\N		f	2
39	35	38	36	\N	f	f	f	f	f	t	0	f	0	2008-01-30 08:40:31	1	\N		f	2
40	36	39	37	\N	f	f	f	f	f	t	0	f	0	2008-01-30 08:43:22	1	\N		f	2
41	22	40	22	\N	t	f	f	f	f	f	0	f	1	2008-01-30 08:53:14	1	\N		f	1
42	37	41	38	\N	f	f	f	f	f	t	0	f	0	2008-01-30 08:54:56	1	\N		f	1
43	38	42	39	\N	f	f	f	f	f	t	0	f	0	2008-01-30 08:55:33	1	\N		f	1
44	38	43	40	\N	t	t	f	f	f	f	0	f	1	2008-01-30 09:00:00	1	\N		f	1
45	22	44	22	\N	t	f	f	f	f	f	0	f	2	2008-01-30 09:01:50	1	\N		f	1
46	39	45	41	\N	f	f	f	f	f	t	0	f	0	2008-01-30 09:07:05	1	\N		f	1
47	40	46	42	\N	f	f	f	f	f	t	0	f	0	2008-01-30 09:16:38	1	\N		f	1
48	40	47	43	\N	t	t	f	f	f	f	0	f	1	2008-01-30 09:17:40	1	\N		f	1
49	23	48	44	\N	t	t	f	f	f	f	0	f	2	2008-01-30 12:52:23	1	\N		f	1
50	23	49	44	\N	t	f	f	f	f	f	0	f	3	2008-01-30 16:08:02	1	\N		f	1
51	41	50	45	\N	f	f	f	f	f	t	0	f	0	2008-01-30 16:11:56	1	\N		f	1
52	13	51	13	\N	t	f	f	f	f	f	0	f	1	2008-01-30 16:12:40	1	\N		f	2
53	42	52	46	\N	f	f	f	f	f	t	0	f	0	2008-01-30 16:12:48	1	\N		f	1
54	43	53	47	\N	f	f	f	f	f	t	0	f	0	2008-01-30 16:13:32	1	\N		f	1
55	44	54	48	\N	f	f	f	f	f	t	0	f	0	2008-01-30 16:14:13	1	\N		f	1
56	45	55	49	\N	f	f	f	f	f	t	0	f	0	2008-01-30 16:14:41	1	\N		f	1
57	46	56	50	\N	f	f	f	f	f	t	0	f	0	2008-01-30 16:15:22	1	\N		f	1
58	47	57	51	\N	f	f	f	f	f	t	0	f	0	2008-01-30 16:15:56	1	\N		f	1
59	48	58	52	\N	f	f	f	f	f	t	0	f	0	2008-01-30 16:16:22	1	\N		f	1
\.


--
-- Data for Name: page_source; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY page_source (source_id, text) FROM stdin;
1	[[module ManageSite]]
2	[[module Account]]
3	Use this simple form to create a new wiki.\n\nTo admins: you can customize this page by simply clicking "edit" at the bottom of the page.\n\n[[module NewSite]]
4	[[module UserInfo]]
5	* [[[start | Welcome page]]]\n\n* [[[What is a Wiki Site?]]]\n* [[[How to edit pages?]]]\n\n* [[[system: join | How to join this site?]]]\n* [[[system:members | Site members]]] \n\n* [[[system: Recent changes]]]\n* [[[system: List all pages]]]\n* [[[system:page-tags-list|Page Tags]]]\n\n* [[[admin:manage|Site Manager]]]\n\n++ Page tags\n[[module TagCloud minFontSize="80%" maxFontSize="200%"  maxColor="8,8,64" minColor="100,100,128" target="system:page-tags" limit="30"]]\n\n++ Add a new page\n[[module NewPage size="15" button="new page"]]\n\n= [[size 80%]][[[nav:side | edit this panel]]][[/size]]
6	According to [http://en.wikipedia.org/wiki/Wiki Wikipedia], the world largest wiki site:\n\n> A //Wiki// ([ˈwiː.kiː] <wee-kee> or [ˈwɪ.kiː] <wick-ey>) is a type of website that allows users to add, remove, or otherwise edit and change most content very quickly and easily.\n\nAnd that is it! As a part of a farm of wikis this site is a great tool that you can use to publish content, upload files, communicate and collaborate.
7	Admin of this Wikidot installation.
8	[[module ManageSite]]
10	The profiles site is used to host user profiles. Each {{profile:username}} page contains a user-editable text that is included in the user's profile page.\n\nIf you are viewing your own profile content page, feel free to edit it. You are the only one allowed to edit this page.
11	* [[[start | Main page]]]\n* [[[admin:manage | Manage this wiki]]]
12	The profiles site is used to host user profiles. Each {{profile:username}} page contains a user-editable text that is included in the user's profile page.\n\n* [[[start | Main page]]]\n* [[[admin:manage | Manage this wiki]]]
13	The purpose of this wiki is to store user profiles.
14	If you are allowed to edit pages in this Site, simply click on //edit// button at the bottom of the page. This will open an editor with a toolbar pallette with options.\n\nTo create a link to a new page, use syntax: {{``[[[new page name]]]``}} or {{``[[[new page name | text to display]]]``}}. Follow the link (which should have a different color if page does not exist) and create a new page and edit it!\n\nAlthough creating and editing pages is easy, there are a lot more options that allows creating powerful sites. Please visit [*http://www.wikidot.com/doc Documentation pages] (at wikidot.com) to learn more.
15	[[note]]\nPlease change this page according to your policy (configure first using [[[admin:manage|Site Manager]]]) and remove this note.\n[[/note]]\n\n+ Who can join?\n\nYou can write here who can become a member of this site.\n\n+ Join!\n\nSo you want to become a member of this site? Tell us why and apply now!\n\n[[module MembershipApply]] \n\nOr, if you already know a "secret password", go for it!\n\n[[module MembershipByPassword]]
16	[[module ManageSite]]
17	[[module TagCloud limit="200" target="system:page-tags"]]\n\n[!--\n\nYou can edit parameters of the TagCloud module as described in http://www.wikidot.com/doc:tagcloud-module \nBut if you want to keep the tag functionality working - do not remove these modules.\n\n--]
18	[[module SiteChanges]]
19	+ Members:\n\n[[module Members]]\n\n+ Moderators\n\n[[module Members group="moderators"]]\n\n+ Admins\n\n[[module Members group="admins"]]
20	[[module Search]]\n\n[!-- please do not remove or change this page if you want to keep the search function working --]
21	[[div style="float:right; width: 50%;"]]\n[[module TagCloud limit="200" target="system:page-tags"]]\n[[/div]]\n[[module PagesByTag]]\n\n[!--\n\nYou can edit parameters of the TagCloud module as described in http://www.wikidot.com/doc:tagcloud-module \nBut if you want to keep the tag functionality working - do not remove these modules.\n\n--]
22	[[module Pages preview="true"]]
23	* [[[start | Welcome page]]]\n\n* [[[What is a Wiki Site?]]]\n* [[[How to edit pages?]]]\n\n* [[[system: join | How to join this site?]]]\n* [[[system:members | Site members]]]\n\n* [[[system: Recent changes]]]\n* [[[system: List all pages]]]\n* [[[system:page-tags-list|Page Tags]]]\n\n* [[[admin:manage|Site Manager]]]\n\n++ Page tags\n[[module TagCloud minFontSize="80%" maxFontSize="200%"  maxColor="8,8,64" minColor="100,100,128" target="system:page-tags" limit="30"]]\n\n++ Add a new page\n[[module NewPage size="15" button="new page"]]\n\n= [[size 80%]][[[nav:side | edit this panel]]][[/size]]
24	Welcome to your new Wikidot installation. \n\n+ Search all wikis\n\n[[module SearchAll]]
25	[[module SearchAll]]
26	[[module Search]]
27	Welcome to your new Wikidot installation. \n\n+ Search all wikis\n\n[[module SearchAll]]\n\n+ Search users\n\n[[module SearchUsers]]
28	To look for someone, please enter:\n\n* email address of a person you are looking for (this will look for exact match)\n* any part of the screen name or realname (lists all Users matching the query)\n\n[[module UserSearch]]
29	To look for someone, please enter:\n\n* email address of a person you are looking for (this will look for exact match)\n* any part of the screen name or realname (lists all Users matching the query)\n\n[[module SearchUsers]]
30	[[module ForumStart]]\n[!-- please do not alter this page if you want to keep your forum working --]
31	[[module ForumCategory]]\n\n[!-- please do not alter this page if you want to keep your forum working --]
32	[[module ForumThread]]\n\n[!-- please do not alter this page if you want to keep your forum working --]
33	[[module ForumNewThread]]\n\n[!-- please do not alter this page if you want to keep your forum working --]
34	[[module RecentPosts]]\n\n[!-- please do not alter this page if you want to keep your forum working --]
35	* [# example menu]\n * [[[submenu]]]\n* [[[contact]]]\n\n[!-- top nav menu, use only one bulleted list above --]
36	Profile has not been created (yet).
39	++ If this is your first site\n\nThen there are some things you need to know:\n\n* You can configure all security and other settings online, using the [[[admin:manage | Site Manager]]].  When you invite other people to help build this site they don't have access to the Site Manager unless you make them administrators like yourself.  Check out the //Permissions// section.\n* Your Wikidot site has two menus, [[[nav:side | one at the side]]] called '{{nav:side}}', and [[[nav:top | one at the top]]] called '{{nav:top}}'.  These are Wikidot pages, and you can edit them like any page.\n* To edit a page, go to the page and click the **Edit** button at the bottom.  You can change everything in the main area of your page.  The Wikidot system is [*http://www.wikidot.org/doc easy to learn and powerful].\n* You can attach images and other files to any page, then display them and link to them in the page.\n* Every Wikidot page has a history of edits, and you can undo anything.  So feel secure, and experiment.\n* To start a forum on your site, see the [[[admin:manage | Site Manager]]] >> //Forum//.\n* The license for this Wikidot site has been set to [*http://creativecommons.org/licenses/by-sa/3.0/ Creative Commons Attribution-Share Alike 3.0 License].  If you want to change this, use the Site Manager.\n* If you want to learn more, make sure you visit the [*http://www.wikidot.org/doc Documentation section at www.wikidot.org]\n\nMore information about the Wikidot project can be found at [*http://www.wikidot.org www.wikidot.org].
40	* [[[start | Welcome page]]]\n\n* [[[What is a Wiki?]]]\n* [[[How to edit pages?]]]\n\n+ All wikis\n\n* [[[system-all:activity | Recent activity]]]\n* [[[system-all:all-sites | All wikis]]]\n* [[[system-all:sites-by-tags]]]\n* [[[system-all:search]]]\n\n+ This wiki\n\n* [[[system: join | How to join this site?]]]\n* [[[system:members | Site members]]]\n\n* [[[system: Recent changes]]]\n* [[[system: List all pages]]]\n* [[[system:page-tags-list|Page Tags]]]\n\n* [[[admin:manage|Site Manager]]]\n\n++ Page tags\n[[module TagCloud minFontSize="80%" maxFontSize="200%"  maxColor="8,8,64" minColor="100,100,128" target="system:page-tags" limit="30"]]\n\n++ Add a new page\n[[module NewPage size="15" button="new page"]]\n\n= [[size 80%]][[[nav:side | edit this panel]]][[/size]]
41	Below is the list of public visible Wikis hosted at this service:\n\n[[module ListAllWikis]]
42	[[module SitesTagCloud limit=100]]\n\n\n[[module SitesListByTag]]
43	[[module SitesTagCloud limit="100" target="system-all:sites-by-tags"]]\n\n\n[[module SitesListByTag]]
44	* [[[start | Welcome page]]]\n\n* [[[What is a Wiki?]]]\n* [[[How to edit pages?]]]\n* [[[new-site | Get a new wiki!]]]\n\n+ All wikis\n\n* [[[system-all:activity | Recent activity]]]\n* [[[system-all:all-sites | All wikis]]]\n* [[[system-all:sites-by-tags | Wikis by tags]]]\n* [[[system-all:search | Search]]]\n\n+ This wiki\n\n* [[[system: join | How to join this site?]]]\n* [[[system:members | Site members]]]\n\n* [[[system: Recent changes]]]\n* [[[system: List all pages]]]\n* [[[system:page-tags-list|Page Tags]]]\n\n* [[[admin:manage|Site Manager]]]\n\n++ Page tags\n[[module TagCloud minFontSize="80%" maxFontSize="200%"  maxColor="8,8,64" minColor="100,100,128" target="system:page-tags" limit="30"]]\n\n++ Add a new page\n[[module NewPage size="15" button="new page"]]\n\n= [[size 80%]][[[nav:side | edit this panel]]][[/size]]
45	[[=]]\n+ Search all Wikis\n\nPerform a search through all public and visible wikis.\n\n[[module SearchAll]]\n\n---------------\n\n+ Search users\n\nTo look for someone, please enter:\n\n* email address of a person you are looking for (this will look for exact match)\n* any part of the screen name or realname (lists all Users matching the query)\n\n[[module SearchUsers]]\n\n[[/=]]
46	[[table]]\n[[row]]\n[[cell style="width: 45%; padding-right: 2%; border-right: 1px solid #999;"]]\n\n++ Recent edits (all wikis)\n\n[[module RecentWRevisions]]\n\n[[/cell]]\n[[cell style="width: 45%; padding-left: 2%;"]]\n\n++ Top Sites\n\n[[module MostActiveSites]]\n\n++ Top Forums\n\n[[module MostActiveForums]]\n\n++ New users\n\n[[module NewWUsers]]\n\n++ Some statistics\n\n[[module SomeGlobalStats]]\n\n[[/cell]]\n[[/row]]\n[[/table]]
47	[[table]]\n[[row]]\n[[cell style="width: 45%; padding-right: 2%; border-right: 1px solid #999; vertical-align:top;"]]\n\n++ Recent edits (all wikis)\n\n[[module RecentWRevisions]]\n\n[[/cell]]\n[[cell style="width: 45%; padding-left: 2%; vertical-align:top;"]]\n\n++ Top Sites\n\n[[module MostActiveSites]]\n\n++ Top Forums\n\n[[module MostActiveForums]]\n\n++ New users\n\n[[module NewWUsers]]\n\n++ Some statistics\n\n[[module SomeGlobalStats]]\n\n[[/cell]]\n[[/row]]\n[[/table]]
48	Congratulations, you have successfully installed Wikidot software on your computer!\n\n+ What to do next\n\n++ Customize this wiki\n\nWikidot consists of several wiki sites, not just one. Right now you are on the main wiki. Customize it!\n\n* You can configure all security and other settings online, using the [[[admin:manage | Site Manager]]].  When you invite other people to help build this site they don't have access to the Site Manager unless you make them administrators like yourself.  Check out the //Permissions// section.\n* Your Wikidot site has two menus, [[[nav:side | one at the side]]] called '{{nav:side}}', and [[[nav:top | one at the top]]] called '{{nav:top}}'.  These are Wikidot pages, and you can edit them like any page.\n* To edit a page, go to the page and click the **Edit** button at the bottom.  You can change everything in the main area of your page.  The Wikidot system is [*http://www.wikidot.org/doc easy to learn and powerful].\n* You can attach images and other files to any page, then display them and link to them in the page.\n* Every Wikidot page has a history of edits, and you can undo anything.  So feel secure, and experiment.\n* To start a forum on your site, see the [[[admin:manage | Site Manager]]] >> //Forum//.\n* The license for this Wikidot site has been set to [*http://creativecommons.org/licenses/by-sa/3.0/ Creative Commons Attribution-Share Alike 3.0 License].  If you want to change this, use the Site Manager.\n* If you want to learn more, make sure you visit the [*http://www.wikidot.org/doc Documentation section at www.wikidot.org]\n\n++ Customize default template\n\nDefault initial template for other wikis is located at [[[template-en::]]]. If someone creates a new wiki, this one is cloned to the new address. A good thing to do is to go to [[[template-en::]]] and customize it.\n\n++ Create more templates\n\nSimply create wikis with unix names starting with "template-" (e.g. "template-pl", "template-blog") and your users will be able to choose which wiki they want to start with. \n\n---------------\n\nMore information about the Wikidot project can be found at [*http://www.wikidot.org www.wikidot.org].\n\n+ Search all wikis\n\n[[module SearchAll]]\n\n+ Search users\n\n[[module SearchUsers]]
49	Congratulations, you have successfully installed Wikidot software on your computer!\n\n+ What to do next\n\n++ Customize this wiki\n\nWikidot consists of several wiki sites, not just one. Right now you are on the main wiki. Customize it!\n\n* You can configure all security and other settings online, using the [[[admin:manage | Site Manager]]].  When you invite other people to help build this site they don't have access to the Site Manager unless you make them administrators like yourself.  Check out the //Permissions// section.\n* Your Wikidot site has two menus, [[[nav:side | one at the side]]] called '{{nav:side}}', and [[[nav:top | one at the top]]] called '{{nav:top}}'.  These are Wikidot pages, and you can edit them like any page.\n* To edit a page, go to the page and click the **Edit** button at the bottom.  You can change everything in the main area of your page.  The Wikidot system is [*http://www.wikidot.org/doc easy to learn and powerful].\n* You can attach images and other files to any page, then display them and link to them in the page.\n* Every Wikidot page has a history of edits, and you can undo anything.  So feel secure, and experiment.\n* To start a forum on your site, see the [[[admin:manage | Site Manager]]] >> //Forum//.\n* The license for this Wikidot site has been set to [*http://creativecommons.org/licenses/by-sa/3.0/ Creative Commons Attribution-Share Alike 3.0 License].  If you want to change this, use the Site Manager.\n* If you want to learn more, make sure you visit the [*http://www.wikidot.org/doc Documentation section at www.wikidot.org]\n\n++ Customize default template\n\nDefault initial template for other wikis is located at [[[template-en::]]]. If someone creates a new wiki, this one is cloned to the new address. A good thing to do is to go to [[[template-en::]]] and customize it.\n\n++ Create more templates\n\nSimply create wikis with unix names starting with "template-" (e.g. "template-pl", "template-blog") and your users will be able to choose which wiki they want to start with. \n\n++ Visit Wikidot.org\n\nGo to **[http://www.wikidot.org www.wikidot.org]** -- home of the Wikidot software -- for extra documentation, howtos, tips and support.\n\n---------------\n\nMore information about the Wikidot project can be found at [*http://www.wikidot.org www.wikidot.org].\n\n+ Search all wikis\n\n[[module SearchAll]]\n\n+ Search users\n\n[[module SearchUsers]]
50	According to [http://en.wikipedia.org/wiki/Wiki Wikipedia], the world largest wiki site:\n\n> A //Wiki// ([ˈwiː.kiː] <wee-kee> or [ˈwɪ.kiː] <wick-ey>) is a type of website that allows users to add, remove, or otherwise edit and change most content very quickly and easily.\n\nAnd that is it! As a part of a farm of wikis this site is a great tool that you can use to publish content, upload files, communicate and collaborate.
51	If you are allowed to edit pages in this Site, simply click on //edit// button at the bottom of the page. This will open an editor with a toolbar pallette with options.\n\nTo create a link to a new page, use syntax: {{``[[[new page name]]]``}} or {{``[[[new page name | text to display]]]``}}. Follow the link (which should have a different color if page does not exist) and create a new page and edit it!\n\nAlthough creating and editing pages is easy, there are a lot more options that allows creating powerful sites. Please visit [*http://www.wikidot.org/doc Documentation pages] (at wikidot.org) to learn more.
52	If you are allowed to edit pages in this Site, simply click on //edit// button at the bottom of the page. This will open an editor with a toolbar pallette with options.\n\nTo create a link to a new page, use syntax: {{``[[[new page name]]]``}} or {{``[[[new page name | text to display]]]``}}. Follow the link (which should have a different color if page does not exist) and create a new page and edit it!\n\nAlthough creating and editing pages is easy, there are a lot more options that allows creating powerful sites. Please visit [*http://www.wikidot.org/doc Documentation pages] (at wikidot.org) to learn more.
53	+ Members:\n\n[[module Members]]\n\n+ Moderators\n\n[[module Members group="moderators"]]\n\n+ Admins\n\n[[module Members group="admins"]]
54	[[note]]\nPlease change this page according to your policy (configure first using [[[admin:manage|Site Manager]]]) and remove this note.\n[[/note]]\n\n+ Who can join?\n\nYou can write here who can become a member of this site.\n\n+ Join!\n\nSo you want to become a member of this site? Tell us why and apply now!\n\n[[module MembershipApply]] \n\nOr, if you already know a "secret password", go for it!\n\n[[module MembershipByPassword]]
55	[[module SiteChanges]]
56	[[module Pages preview="true"]]
57	[[module TagCloud limit="200" target="system:page-tags"]]\n\n[!--\n\nYou can edit parameters of the TagCloud module as described in http://www.wikidot.com/doc:tagcloud-module\nBut if you want to keep the tag functionality working - do not remove these modules.\n\n--]
58	[[div style="float:right; width: 50%;"]]\n[[module TagCloud limit="200" target="system:page-tags"]]\n[[/div]]\n[[module PagesByTag]]\n\n[!--\n\nYou can edit parameters of the TagCloud module as described in http://www.wikidot.com/doc:tagcloud-module\nBut if you want to keep the tag functionality working - do not remove these modules.\n\n--]
\.


--
-- Data for Name: page_tag; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY page_tag (tag_id, site_id, page_id, tag) FROM stdin;
\.


--
-- Data for Name: petition_campaign; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY petition_campaign (campaign_id, site_id, name, identifier, active, number_signatures, deleted, collect_address, collect_city, collect_state, collect_zip, collect_country, collect_comments, show_city, show_state, show_zip, show_country, show_comments, thank_you_page) FROM stdin;
\.


--
-- Data for Name: petition_signature; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY petition_signature (signature_id, campaign_id, first_name, last_name, address1, address2, zip, city, state, country, country_code, comments, email, confirmed, confirmation_hash, confirmation_url, date) FROM stdin;
\.


--
-- Data for Name: pg_ts_cfg; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY pg_ts_cfg (ts_name, prs_name, locale) FROM stdin;
default	default	C
default_russian	default	ru_RU.KOI8-R
simple	default	\N
\.


--
-- Data for Name: pg_ts_cfgmap; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY pg_ts_cfgmap (ts_name, tok_alias, dict_name) FROM stdin;
default	lword	{en_stem}
default	nlword	{simple}
default	word	{simple}
default	email	{simple}
default	url	{simple}
default	host	{simple}
default	sfloat	{simple}
default	version	{simple}
default	part_hword	{simple}
default	nlpart_hword	{simple}
default	lpart_hword	{en_stem}
default	hword	{simple}
default	lhword	{en_stem}
default	nlhword	{simple}
default	uri	{simple}
default	file	{simple}
default	float	{simple}
default	int	{simple}
default	uint	{simple}
default_russian	lword	{en_stem}
default_russian	nlword	{ru_stem}
default_russian	word	{ru_stem}
default_russian	email	{simple}
default_russian	url	{simple}
default_russian	host	{simple}
default_russian	sfloat	{simple}
default_russian	version	{simple}
default_russian	part_hword	{simple}
default_russian	nlpart_hword	{ru_stem}
default_russian	lpart_hword	{en_stem}
default_russian	hword	{ru_stem}
default_russian	lhword	{en_stem}
default_russian	nlhword	{ru_stem}
default_russian	uri	{simple}
default_russian	file	{simple}
default_russian	float	{simple}
default_russian	int	{simple}
default_russian	uint	{simple}
simple	lword	{simple}
simple	nlword	{simple}
simple	word	{simple}
simple	email	{simple}
simple	url	{simple}
simple	host	{simple}
simple	sfloat	{simple}
simple	version	{simple}
simple	part_hword	{simple}
simple	nlpart_hword	{simple}
simple	lpart_hword	{simple}
simple	hword	{simple}
simple	lhword	{simple}
simple	nlhword	{simple}
simple	uri	{simple}
simple	file	{simple}
simple	float	{simple}
simple	int	{simple}
simple	uint	{simple}
\.


--
-- Data for Name: pg_ts_dict; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY pg_ts_dict (dict_name, dict_init, dict_initoption, dict_lexize, dict_comment) FROM stdin;
simple	dex_init(internal)	\N	dex_lexize(internal,internal,integer)	Simple example of dictionary.
en_stem	snb_en_init(internal)	contrib/english.stop	snb_lexize(internal,internal,integer)	English Stemmer. Snowball.
ru_stem	snb_ru_init(internal)	contrib/russian.stop	snb_lexize(internal,internal,integer)	Russian Stemmer. Snowball.
ispell_template	spell_init(internal)	\N	spell_lexize(internal,internal,integer)	ISpell interface. Must have .dict and .aff files
synonym	syn_init(internal)	\N	syn_lexize(internal,internal,integer)	Example of synonym dictionary
\.


--
-- Data for Name: pg_ts_parser; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY pg_ts_parser (prs_name, prs_start, prs_nexttoken, prs_end, prs_headline, prs_lextype, prs_comment) FROM stdin;
default	prsd_start(internal,integer)	prsd_getlexeme(internal,internal,internal)	prsd_end(internal)	prsd_headline(internal,internal,internal)	prsd_lextype(internal)	Parser from OpenFTS v0.34
\.


--
-- Data for Name: private_message; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY private_message (message_id, from_user_id, to_user_id, subject, body, date, flag, flag_new) FROM stdin;
\.


--
-- Data for Name: private_user_block; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY private_user_block (block_id, user_id, blocked_user_id) FROM stdin;
\.


--
-- Data for Name: profile; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY profile (user_id, real_name, gender, birthday_day, birthday_month, birthday_year, about, "location", website, im_aim, im_gadu_gadu, im_google_talk, im_icq, im_jabber, im_msn, im_yahoo, change_screen_name_count) FROM stdin;
1	\N	\N	\N	\N	\N	Wikidot administrator.	\N	\N	\N	\N	\N	\N	\N	\N	\N	0
\.


--
-- Data for Name: simpletodo_list; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY simpletodo_list (list_id, site_id, label, title, data) FROM stdin;
\.


--
-- Data for Name: site; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY site (site_id, name, subtitle, unix_name, description, "language", date_created, custom_domain, visible, default_page, private, deleted) FROM stdin;
3	User profiles	\N	profiles	\N	en	\N	\N	t	start	f	f
2	Template site (en)	Default template wiki	template-en		en	\N	\N	t	start	f	f
1	Wikidot - Free Wiki Software	fresh installation	www		en	\N	\N	t	start	f	f
\.


--
-- Data for Name: site_backup; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY site_backup (backup_id, site_id, status, backup_source, backup_files, date, rand) FROM stdin;
\.


--
-- Data for Name: site_settings; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY site_settings (site_id, allow_membership_by_apply, allow_membership_by_password, membership_password, file_storage_size, use_ganalytics, private_landing_page, max_private_members, max_private_viewers, hide_navigation_unauthorized, ssl_mode, openid_enabled, allow_members_invite, max_upload_file_size) FROM stdin;
1	t	f	\N	314572800	f	system:join	50	20	t	\N	f	f	10485760
3	t	f	\N	314572800	f	system:join	50	20	t	\N	f	f	10485760
2	f	f		314572800	f	system:join	50	20	t	\N	f	f	10485760
\.


--
-- Data for Name: site_super_settings; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY site_super_settings (site_id, can_custom_domain) FROM stdin;
1	t
2	t
3	t
\.


--
-- Data for Name: site_tag; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY site_tag (tag_id, site_id, tag) FROM stdin;
1	2	template
\.


--
-- Data for Name: site_viewer; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY site_viewer (viewer_id, site_id, user_id) FROM stdin;
\.


--
-- Data for Name: storage_item; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY storage_item (item_id, date, timeout, data) FROM stdin;
\.


--
-- Data for Name: theme; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY theme (theme_id, name, unix_name, abstract, extends_theme_id, variant_of_theme_id, custom, site_id, use_side_bar, use_top_bar, sort_index, sync_page_name, revision_number) FROM stdin;
1	Base	base	t	\N	\N	f	\N	t	t	0	\N	0
2	Clean	clean	f	1	\N	f	\N	t	t	0	\N	0
4	Flannel	flannel	f	1	\N	f	\N	t	t	0	\N	0
6	Flannel Ocean	flannel-ocean	f	1	\N	f	\N	t	t	0	\N	0
8	Flannel Nature	flannel-nature	f	1	\N	f	\N	t	t	0	\N	0
10	Cappuccino	cappuccino	f	1	\N	f	\N	t	t	0	\N	0
12	Gila	gila	f	1	\N	f	\N	t	t	0	\N	0
14	Co	co	f	1	\N	f	\N	t	t	0	\N	0
15	Flower Blossom	flower-blossom	f	1	\N	f	\N	t	t	0	\N	0
16	Localize	localize	f	1	\N	f	\N	t	t	0	\N	0
20	Webbish	webbish2	f	1	\N	f	\N	t	t	0	\N	0
3	Clean - no side bar	clean-no-side-bar	f	2	2	f	\N	f	t	0	\N	0
5	Flannel - no side bar	flannel-no-side-bar	f	4	4	f	\N	f	t	0	\N	0
7	Flannel Ocean - no side bar	flannel-ocean-no-side-bar	f	6	6	f	\N	f	t	0	\N	0
9	Flannel Nature - no side bar	flannel-nature-no-side-bar	f	8	8	f	\N	f	t	0	\N	0
11	Cappuccino - no side bar	cappuccino-no-side-bar	f	10	10	f	\N	f	t	0	\N	0
13	Gila - no side bar	gila-no-side-bar	f	12	12	f	\N	f	t	0	\N	0
17	Localize - no side bar	localize-no-side-bar	f	16	16	f	\N	f	t	0	\N	0
18	Flower Blossom - no side bar	flower-blossom-no-side-bar	f	15	15	f	\N	f	t	0	\N	0
19	Co - no side bar	co-no-side-bar	f	14	14	f	\N	f	t	0	\N	0
21	Webbish - no side bar	webbish2-no-side-bar	f	20	20	f	\N	f	t	0	\N	0
22	Shiny	shiny	f	1	\N	f	\N	t	t	0	\N	0
23	Shiny - no side bar	shiny-no-side-bar	f	22	22	f	\N	f	t	0	\N	0
\.


--
-- Data for Name: theme_preview; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY theme_preview (theme_id, body) FROM stdin;
\.


--
-- Data for Name: unique_string_broker; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY unique_string_broker (last_index) FROM stdin;
22
\.


--
-- Data for Name: user_abuse_flag; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY user_abuse_flag (flag_id, user_id, target_user_id, site_id, site_valid, global_valid) FROM stdin;
\.


--
-- Data for Name: user_block; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY user_block (block_id, site_id, user_id, reason, date_blocked) FROM stdin;
\.


--
-- Data for Name: user_settings; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY user_settings (user_id, receive_invitations, receive_pm, notify_online, notify_feed, notify_email, receive_newsletter, receive_digest, allow_site_newsletters_default, max_sites_admin) FROM stdin;
\.


--
-- Data for Name: watched_forum_thread; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY watched_forum_thread (watched_id, user_id, thread_id) FROM stdin;
\.


--
-- Data for Name: watched_page; Type: TABLE DATA; Schema: public; Owner: wd
--

COPY watched_page (watched_id, user_id, page_id) FROM stdin;
\.


--
-- Name: admin__site_id__user_id__unique; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY "admin"
    ADD CONSTRAINT admin__site_id__user_id__unique UNIQUE (site_id, user_id);


--
-- Name: admin_notification_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY admin_notification
    ADD CONSTRAINT admin_notification_pkey PRIMARY KEY (notification_id);


--
-- Name: admin_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY "admin"
    ADD CONSTRAINT admin_pkey PRIMARY KEY (admin_id);


--
-- Name: anonymous_abuse_flag_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY anonymous_abuse_flag
    ADD CONSTRAINT anonymous_abuse_flag_pkey PRIMARY KEY (flag_id);


--
-- Name: category_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY category
    ADD CONSTRAINT category_pkey PRIMARY KEY (category_id);


--
-- Name: contact__unique; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY contact
    ADD CONSTRAINT contact__unique UNIQUE (user_id, target_user_id);


--
-- Name: contact_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY contact
    ADD CONSTRAINT contact_pkey PRIMARY KEY (contact_id);


--
-- Name: domain_redirect__unique; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY domain_redirect
    ADD CONSTRAINT domain_redirect__unique UNIQUE (site_id, url);


--
-- Name: domain_redirect_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY domain_redirect
    ADD CONSTRAINT domain_redirect_pkey PRIMARY KEY (redirect_id);


--
-- Name: email_invitation_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY email_invitation
    ADD CONSTRAINT email_invitation_pkey PRIMARY KEY (invitation_id);


--
-- Name: file_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY file
    ADD CONSTRAINT file_pkey PRIMARY KEY (file_id);


--
-- Name: files_event_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY files_event
    ADD CONSTRAINT files_event_pkey PRIMARY KEY (file_event_id);


--
-- Name: form_submission_key_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY form_submission_key
    ADD CONSTRAINT form_submission_key_pkey PRIMARY KEY (key_id);


--
-- Name: forum_category_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY forum_category
    ADD CONSTRAINT forum_category_pkey PRIMARY KEY (category_id);


--
-- Name: forum_group_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY forum_group
    ADD CONSTRAINT forum_group_pkey PRIMARY KEY (group_id);


--
-- Name: forum_post_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY forum_post
    ADD CONSTRAINT forum_post_pkey PRIMARY KEY (post_id);


--
-- Name: forum_post_revision_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY forum_post_revision
    ADD CONSTRAINT forum_post_revision_pkey PRIMARY KEY (revision_id);


--
-- Name: forum_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY forum_settings
    ADD CONSTRAINT forum_settings_pkey PRIMARY KEY (site_id);


--
-- Name: forum_thread_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY forum_thread
    ADD CONSTRAINT forum_thread_pkey PRIMARY KEY (thread_id);


--
-- Name: front_forum_feed_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY front_forum_feed
    ADD CONSTRAINT front_forum_feed_pkey PRIMARY KEY (feed_id);


--
-- Name: fts_entry_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY fts_entry
    ADD CONSTRAINT fts_entry_pkey PRIMARY KEY (fts_id);


--
-- Name: global_ip_block_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY global_ip_block
    ADD CONSTRAINT global_ip_block_pkey PRIMARY KEY (block_id);


--
-- Name: global_user_block_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY global_user_block
    ADD CONSTRAINT global_user_block_pkey PRIMARY KEY (block_id);


--
-- Name: ip_block_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY ip_block
    ADD CONSTRAINT ip_block_pkey PRIMARY KEY (block_id);


--
-- Name: license_name_key; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY license
    ADD CONSTRAINT license_name_key UNIQUE (name);


--
-- Name: license_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY license
    ADD CONSTRAINT license_pkey PRIMARY KEY (license_id);


--
-- Name: log_event_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY log_event
    ADD CONSTRAINT log_event_pkey PRIMARY KEY (event_id);


--
-- Name: member__unique; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY member
    ADD CONSTRAINT member__unique UNIQUE (site_id, user_id);


--
-- Name: member_application__unique; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY member_application
    ADD CONSTRAINT member_application__unique UNIQUE (site_id, user_id);


--
-- Name: member_application_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY member_application
    ADD CONSTRAINT member_application_pkey PRIMARY KEY (application_id);


--
-- Name: member_invitation_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY member_invitation
    ADD CONSTRAINT member_invitation_pkey PRIMARY KEY (invitation_id);


--
-- Name: member_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY member
    ADD CONSTRAINT member_pkey PRIMARY KEY (member_id);


--
-- Name: membership_link_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY membership_link
    ADD CONSTRAINT membership_link_pkey PRIMARY KEY (link_id);


--
-- Name: moderator__unique; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY moderator
    ADD CONSTRAINT moderator__unique UNIQUE (site_id, user_id);


--
-- Name: moderator_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY moderator
    ADD CONSTRAINT moderator_pkey PRIMARY KEY (moderator_id);


--
-- Name: notification_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY notification
    ADD CONSTRAINT notification_pkey PRIMARY KEY (notification_id);


--
-- Name: openid_entry_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY openid_entry
    ADD CONSTRAINT openid_entry_pkey PRIMARY KEY (openid_id);


--
-- Name: ozone_group_name_key; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY ozone_group
    ADD CONSTRAINT ozone_group_name_key UNIQUE (name);


--
-- Name: ozone_group_permission_modifier_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY ozone_group_permission_modifier
    ADD CONSTRAINT ozone_group_permission_modifier_pkey PRIMARY KEY (group_permission_id);


--
-- Name: ozone_group_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY ozone_group
    ADD CONSTRAINT ozone_group_pkey PRIMARY KEY (group_id);


--
-- Name: ozone_lock_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY ozone_lock
    ADD CONSTRAINT ozone_lock_pkey PRIMARY KEY ("key");


--
-- Name: ozone_permission_name_key; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY ozone_permission
    ADD CONSTRAINT ozone_permission_name_key UNIQUE (name);


--
-- Name: ozone_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY ozone_permission
    ADD CONSTRAINT ozone_permission_pkey PRIMARY KEY (permission_id);


--
-- Name: ozone_session_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY ozone_session
    ADD CONSTRAINT ozone_session_pkey PRIMARY KEY (session_id);


--
-- Name: ozone_user_group_relation_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY ozone_user_group_relation
    ADD CONSTRAINT ozone_user_group_relation_pkey PRIMARY KEY (user_group_id);


--
-- Name: ozone_user_name_key; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY ozone_user
    ADD CONSTRAINT ozone_user_name_key UNIQUE (name);


--
-- Name: ozone_user_permission_modifier_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY ozone_user_permission_modifier
    ADD CONSTRAINT ozone_user_permission_modifier_pkey PRIMARY KEY (user_permission_id);


--
-- Name: ozone_user_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY ozone_user
    ADD CONSTRAINT ozone_user_pkey PRIMARY KEY (user_id);


--
-- Name: ozone_user_unix_name_key; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY ozone_user
    ADD CONSTRAINT ozone_user_unix_name_key UNIQUE (unix_name);


--
-- Name: page__unique; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY page
    ADD CONSTRAINT page__unique UNIQUE (site_id, unix_name);


--
-- Name: page_abuse_flag_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY page_abuse_flag
    ADD CONSTRAINT page_abuse_flag_pkey PRIMARY KEY (flag_id);


--
-- Name: page_compiled_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY page_compiled
    ADD CONSTRAINT page_compiled_pkey PRIMARY KEY (page_id);


--
-- Name: page_edit_lock_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY page_edit_lock
    ADD CONSTRAINT page_edit_lock_pkey PRIMARY KEY (lock_id);


--
-- Name: page_inclusion__unique; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY page_inclusion
    ADD CONSTRAINT page_inclusion__unique UNIQUE (including_page_id, included_page_id, included_page_name);


--
-- Name: page_inclusion_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY page_inclusion
    ADD CONSTRAINT page_inclusion_pkey PRIMARY KEY (inclusion_id);


--
-- Name: page_link__unique; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY page_link
    ADD CONSTRAINT page_link__unique UNIQUE (from_page_id, to_page_id, to_page_name);


--
-- Name: page_link_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY page_link
    ADD CONSTRAINT page_link_pkey PRIMARY KEY (link_id);


--
-- Name: page_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY page_metadata
    ADD CONSTRAINT page_metadata_pkey PRIMARY KEY (metadata_id);


--
-- Name: page_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY page
    ADD CONSTRAINT page_pkey PRIMARY KEY (page_id);


--
-- Name: page_rate_vote_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY page_rate_vote
    ADD CONSTRAINT page_rate_vote_pkey PRIMARY KEY (rate_id);


--
-- Name: page_rate_vote_user_id_key; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY page_rate_vote
    ADD CONSTRAINT page_rate_vote_user_id_key UNIQUE (user_id, page_id);


--
-- Name: page_revision_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY page_revision
    ADD CONSTRAINT page_revision_pkey PRIMARY KEY (revision_id);


--
-- Name: page_source_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY page_source
    ADD CONSTRAINT page_source_pkey PRIMARY KEY (source_id);


--
-- Name: page_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY page_tag
    ADD CONSTRAINT page_tag_pkey PRIMARY KEY (tag_id);


--
-- Name: petition_campaign_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY petition_campaign
    ADD CONSTRAINT petition_campaign_pkey PRIMARY KEY (campaign_id);


--
-- Name: petition_signature_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY petition_signature
    ADD CONSTRAINT petition_signature_pkey PRIMARY KEY (signature_id);


--
-- Name: pg_ts_cfg_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY pg_ts_cfg
    ADD CONSTRAINT pg_ts_cfg_pkey PRIMARY KEY (ts_name);


--
-- Name: pg_ts_cfgmap_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY pg_ts_cfgmap
    ADD CONSTRAINT pg_ts_cfgmap_pkey PRIMARY KEY (ts_name, tok_alias);


--
-- Name: pg_ts_dict_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY pg_ts_dict
    ADD CONSTRAINT pg_ts_dict_pkey PRIMARY KEY (dict_name);


--
-- Name: pg_ts_parser_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY pg_ts_parser
    ADD CONSTRAINT pg_ts_parser_pkey PRIMARY KEY (prs_name);


--
-- Name: private_message_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY private_message
    ADD CONSTRAINT private_message_pkey PRIMARY KEY (message_id);


--
-- Name: private_user_block__unique; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY private_user_block
    ADD CONSTRAINT private_user_block__unique UNIQUE (user_id, blocked_user_id);


--
-- Name: private_user_block_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY private_user_block
    ADD CONSTRAINT private_user_block_pkey PRIMARY KEY (block_id);


--
-- Name: profile_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY profile
    ADD CONSTRAINT profile_pkey PRIMARY KEY (user_id);


--
-- Name: simpletodo_list__unique; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY simpletodo_list
    ADD CONSTRAINT simpletodo_list__unique UNIQUE (site_id, label);


--
-- Name: simpletodo_list_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY simpletodo_list
    ADD CONSTRAINT simpletodo_list_pkey PRIMARY KEY (list_id);


--
-- Name: site_backup_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY site_backup
    ADD CONSTRAINT site_backup_pkey PRIMARY KEY (backup_id);


--
-- Name: site_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY site
    ADD CONSTRAINT site_pkey PRIMARY KEY (site_id);


--
-- Name: site_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY site_settings
    ADD CONSTRAINT site_settings_pkey PRIMARY KEY (site_id);


--
-- Name: site_super_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY site_super_settings
    ADD CONSTRAINT site_super_settings_pkey PRIMARY KEY (site_id);


--
-- Name: site_tag__unique; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY site_tag
    ADD CONSTRAINT site_tag__unique UNIQUE (site_id, tag);


--
-- Name: site_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY site_tag
    ADD CONSTRAINT site_tag_pkey PRIMARY KEY (tag_id);


--
-- Name: site_viewer_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY site_viewer
    ADD CONSTRAINT site_viewer_pkey PRIMARY KEY (viewer_id);


--
-- Name: storage_item_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY storage_item
    ADD CONSTRAINT storage_item_pkey PRIMARY KEY (item_id);


--
-- Name: theme_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY theme
    ADD CONSTRAINT theme_pkey PRIMARY KEY (theme_id);


--
-- Name: theme_preview_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY theme_preview
    ADD CONSTRAINT theme_preview_pkey PRIMARY KEY (theme_id);


--
-- Name: user_abuse_flag_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY user_abuse_flag
    ADD CONSTRAINT user_abuse_flag_pkey PRIMARY KEY (flag_id);


--
-- Name: user_block__unique; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY user_block
    ADD CONSTRAINT user_block__unique UNIQUE (site_id, user_id);


--
-- Name: user_block_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY user_block
    ADD CONSTRAINT user_block_pkey PRIMARY KEY (block_id);


--
-- Name: user_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY user_settings
    ADD CONSTRAINT user_settings_pkey PRIMARY KEY (user_id);


--
-- Name: wached_page__unique; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY watched_page
    ADD CONSTRAINT wached_page__unique UNIQUE (user_id, page_id);


--
-- Name: watched_forum_thread__unique; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY watched_forum_thread
    ADD CONSTRAINT watched_forum_thread__unique UNIQUE (user_id, thread_id);


--
-- Name: watched_forum_thread_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY watched_forum_thread
    ADD CONSTRAINT watched_forum_thread_pkey PRIMARY KEY (watched_id);


--
-- Name: watched_page_pkey; Type: CONSTRAINT; Schema: public; Owner: wd; Tablespace: 
--

ALTER TABLE ONLY watched_page
    ADD CONSTRAINT watched_page_pkey PRIMARY KEY (watched_id);


--
-- Name: admin_notification__site_id__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX admin_notification__site_id__idx ON admin_notification USING btree (site_id);


--
-- Name: anonymous_abuse_flag__address__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX anonymous_abuse_flag__address__idx ON anonymous_abuse_flag USING btree (address);


--
-- Name: anonymous_abuse_flag__site_id__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX anonymous_abuse_flag__site_id__idx ON anonymous_abuse_flag USING btree (site_id);


--
-- Name: category__name__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX category__name__idx ON category USING btree (name);


--
-- Name: category__site_id__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX category__site_id__idx ON category USING btree (site_id);


--
-- Name: email_invitation__site_id; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX email_invitation__site_id ON email_invitation USING btree (site_id);


--
-- Name: email_invitation__user_id; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX email_invitation__user_id ON email_invitation USING btree (user_id);


--
-- Name: file__page_id__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX file__page_id__idx ON file USING btree (page_id);


--
-- Name: file__site_id__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX file__site_id__idx ON file USING btree (site_id);


--
-- Name: fki_forum_category__forum_post; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX fki_forum_category__forum_post ON forum_category USING btree (last_post_id);


--
-- Name: forum_category__group_id__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX forum_category__group_id__idx ON forum_category USING btree (group_id);


--
-- Name: forum_category__site_id__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX forum_category__site_id__idx ON forum_category USING btree (site_id);


--
-- Name: forum_group__site_id__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX forum_group__site_id__idx ON forum_group USING btree (site_id);


--
-- Name: forum_post__site_id__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX forum_post__site_id__idx ON forum_post USING btree (site_id);


--
-- Name: forum_post__thread_id__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX forum_post__thread_id__idx ON forum_post USING btree (thread_id);


--
-- Name: forum_post__user_id__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX forum_post__user_id__idx ON forum_post USING btree (user_id);


--
-- Name: forum_post_revision__post_id__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX forum_post_revision__post_id__idx ON forum_post_revision USING btree (post_id);


--
-- Name: forum_thread__category_id__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX forum_thread__category_id__idx ON forum_thread USING btree (category_id);


--
-- Name: forum_thread__last_post_id__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX forum_thread__last_post_id__idx ON forum_thread USING btree (last_post_id);


--
-- Name: forum_thread__page_id__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX forum_thread__page_id__idx ON forum_thread USING btree (page_id);


--
-- Name: forum_thread__site_id__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX forum_thread__site_id__idx ON forum_thread USING btree (site_id);


--
-- Name: forum_thread__user_id__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX forum_thread__user_id__idx ON forum_thread USING btree (user_id);


--
-- Name: front_forum_feed__site_id__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX front_forum_feed__site_id__idx ON front_forum_feed USING btree (site_id);


--
-- Name: fts_entry__forum_thread__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX fts_entry__forum_thread__idx ON fts_entry USING btree (thread_id);


--
-- Name: fts_entry__page_id__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX fts_entry__page_id__idx ON fts_entry USING btree (page_id);


--
-- Name: fts_entry__site_id__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX fts_entry__site_id__idx ON fts_entry USING btree (site_id);


--
-- Name: fts_entry__vector__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX fts_entry__vector__idx ON fts_entry USING gist (vector);


--
-- Name: ip_block__ip__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX ip_block__ip__idx ON ip_block USING btree (ip);


--
-- Name: ip_block__site_id__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX ip_block__site_id__idx ON ip_block USING btree (site_id);


--
-- Name: log_event__site_id__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX log_event__site_id__idx ON log_event USING btree (site_id);


--
-- Name: log_event__type__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX log_event__type__idx ON log_event USING btree ("type");


--
-- Name: member__site_id_user_id__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE UNIQUE INDEX member__site_id_user_id__idx ON member USING btree (site_id, user_id);


--
-- Name: member_application__site_id__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX member_application__site_id__idx ON member_application USING btree (site_id);


--
-- Name: member_application__user_id__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX member_application__user_id__idx ON member_application USING btree (user_id);


--
-- Name: member_invitation__site_id__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX member_invitation__site_id__idx ON member_invitation USING btree (site_id);


--
-- Name: member_invitation__user_id__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX member_invitation__user_id__idx ON member_invitation USING btree (user_id);


--
-- Name: moderator__site_id__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX moderator__site_id__idx ON moderator USING btree (site_id);


--
-- Name: moderator__user_id__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX moderator__user_id__idx ON moderator USING btree (user_id);


--
-- Name: notification__user_id__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX notification__user_id__idx ON notification USING btree (user_id);


--
-- Name: ozone_session__user_id__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX ozone_session__user_id__idx ON ozone_session USING btree (user_id);


--
-- Name: ozone_user__name__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE UNIQUE INDEX ozone_user__name__idx ON ozone_user USING btree (name);


--
-- Name: ozone_user__nick_name__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE UNIQUE INDEX ozone_user__nick_name__idx ON ozone_user USING btree (nick_name);


--
-- Name: ozone_user__unix_name__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE UNIQUE INDEX ozone_user__unix_name__idx ON ozone_user USING btree (unix_name);


--
-- Name: page__category_id__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX page__category_id__idx ON page USING btree (category_id);


--
-- Name: page__parent_page_id; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX page__parent_page_id ON page USING btree (parent_page_id);


--
-- Name: page__revision_id__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX page__revision_id__idx ON page USING btree (revision_id);


--
-- Name: page__site_id__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX page__site_id__idx ON page USING btree (site_id);


--
-- Name: page__unix_name__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX page__unix_name__idx ON page USING btree (unix_name);


--
-- Name: page_abuse_flag__site_id__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX page_abuse_flag__site_id__idx ON page_abuse_flag USING btree (site_id);


--
-- Name: page_edit_lock__page_id__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX page_edit_lock__page_id__idx ON page_edit_lock USING btree (page_id);


--
-- Name: page_edit_lock__site_id_page_unix_name; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX page_edit_lock__site_id_page_unix_name ON page_edit_lock USING btree (site_id, page_unix_name);


--
-- Name: page_edit_lock__user_id__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX page_edit_lock__user_id__idx ON page_edit_lock USING btree (user_id);


--
-- Name: page_inclusion__site_id; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX page_inclusion__site_id ON page_inclusion USING btree (site_id);


--
-- Name: page_link__site_id; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX page_link__site_id ON page_link USING btree (site_id);


--
-- Name: page_revision__page_id__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX page_revision__page_id__idx ON page_revision USING btree (page_id);


--
-- Name: page_revision__site_id__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX page_revision__site_id__idx ON page_revision USING btree (site_id);


--
-- Name: page_revision__user_id__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX page_revision__user_id__idx ON page_revision USING btree (user_id);


--
-- Name: private_message__from_user_id__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX private_message__from_user_id__idx ON private_message USING btree (from_user_id);


--
-- Name: private_message__to_user_id__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX private_message__to_user_id__idx ON private_message USING btree (to_user_id);


--
-- Name: ront_forum_feed__page_id__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX ront_forum_feed__page_id__idx ON front_forum_feed USING btree (page_id);


--
-- Name: simpletodo_list__site_id__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX simpletodo_list__site_id__idx ON simpletodo_list USING btree (site_id);


--
-- Name: site__custom_domain__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX site__custom_domain__idx ON site USING btree (custom_domain);


--
-- Name: site__unix_name__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE UNIQUE INDEX site__unix_name__idx ON site USING btree (unix_name);


--
-- Name: site__visible__private__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX site__visible__private__idx ON site USING btree (visible, private);


--
-- Name: user_abuse_flag__site_id__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX user_abuse_flag__site_id__idx ON user_abuse_flag USING btree (site_id);


--
-- Name: user_block__site_id__idx; Type: INDEX; Schema: public; Owner: wd; Tablespace: 
--

CREATE INDEX user_block__site_id__idx ON user_block USING btree (site_id);


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO ozone_user DO SELECT currval('ozone_user_user_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO ozone_group DO SELECT currval('ozone_group_group_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO ozone_permission DO SELECT currval('ozone_permission_permission_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO ozone_user_group_relation DO SELECT currval('ozone_user_group_relation_user_group_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO ozone_user_permission_modifier DO SELECT currval('ozone_user_permission_modifier_user_permission_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO ozone_group_permission_modifier DO SELECT currval('ozone_group_permission_modifier_group_permission_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO site DO SELECT currval('site_site_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO site_tag DO SELECT currval('site_tag_tag_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO category DO SELECT currval('category_category_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO page DO SELECT currval('page_page_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO page_revision DO SELECT currval('page_revision_revision_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO page_source DO SELECT currval('page_source_source_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO page_metadata DO SELECT currval('page_metadata_metadata_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO fts_entry DO SELECT currval('fts_entry_fts_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO file DO SELECT currval('file_file_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO files_event DO SELECT currval('files_event_file_event_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO page_link DO SELECT currval('page_link_link_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO page_inclusion DO SELECT currval('page_inclusion_inclusion_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO member DO SELECT currval('member_member_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO "admin" DO SELECT currval('admin_admin_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO moderator DO SELECT currval('moderator_moderator_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO member_application DO SELECT currval('member_application_application_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO member_invitation DO SELECT currval('member_invitation_invitation_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO page_edit_lock DO SELECT currval('page_edit_lock_lock_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO theme DO SELECT currval('theme_theme_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO license DO SELECT currval('license_license_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO notification DO SELECT currval('notification_notification_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO private_message DO SELECT currval('private_message_message_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO global_ip_block DO SELECT currval('global_ip_block_block_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO ip_block DO SELECT currval('ip_block_block_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO global_user_block DO SELECT currval('global_user_block_block_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO user_block DO SELECT currval('user_block_block_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO private_user_block DO SELECT currval('private_user_block_block_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO watched_page DO SELECT currval('watched_page_watched_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO watched_forum_thread DO SELECT currval('watched_forum_thread_watched_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO page_abuse_flag DO SELECT currval('page_abuse_flag_flag_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO user_abuse_flag DO SELECT currval('user_abuse_flag_flag_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO anonymous_abuse_flag DO SELECT currval('anonymous_abuse_flag_flag_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO admin_notification DO SELECT currval('admin_notification_notification_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO forum_group DO SELECT currval('forum_group_group_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO forum_category DO SELECT currval('forum_category_category_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO forum_thread DO SELECT currval('forum_thread_thread_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO forum_post DO SELECT currval('forum_post_post_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO forum_post_revision DO SELECT currval('forum_post_revision_revision_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO front_forum_feed DO SELECT currval('front_forum_feed_feed_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO contact DO SELECT currval('contact_contact_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO page_rate_vote DO SELECT currval('page_rate_vote_rate_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO email_invitation DO SELECT currval('email_invitation_invitation_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO site_backup DO SELECT currval('site_backup_backup_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO domain_redirect DO SELECT currval('domain_redirect_redirect_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO site_viewer DO SELECT currval('site_viewer_viewer_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO openid_entry DO SELECT currval('openid_entry_openid_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO membership_link DO SELECT currval('membership_link_link_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO petition_campaign DO SELECT currval('petition_campaign_campaign_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO petition_signature DO SELECT currval('petition_signature_signature_id_seq'::regclass) AS id;


--
-- Name: get_pkey_on_insert; Type: RULE; Schema: public; Owner: wd
--

CREATE RULE get_pkey_on_insert AS ON INSERT TO simpletodo_list DO SELECT currval('simpletodo_list_list_id_seq'::regclass) AS id;


--
-- Name: admin__ozone_user; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY "admin"
    ADD CONSTRAINT admin__ozone_user FOREIGN KEY (user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: admin__site; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY "admin"
    ADD CONSTRAINT admin__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: admin_notification__site; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY admin_notification
    ADD CONSTRAINT admin_notification__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: anonymous_abuse_flag__ozone_user; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY anonymous_abuse_flag
    ADD CONSTRAINT anonymous_abuse_flag__ozone_user FOREIGN KEY (user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: anonymous_abuse_flag__site; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY anonymous_abuse_flag
    ADD CONSTRAINT anonymous_abuse_flag__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: category__site; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY category
    ADD CONSTRAINT category__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: contact__ozone_user__tagret_user_id; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY contact
    ADD CONSTRAINT contact__ozone_user__tagret_user_id FOREIGN KEY (target_user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: contact__ozone_user__user_id; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY contact
    ADD CONSTRAINT contact__ozone_user__user_id FOREIGN KEY (user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: domain_redirect__site; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY domain_redirect
    ADD CONSTRAINT domain_redirect__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: email_inviation__ozone_user; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY email_invitation
    ADD CONSTRAINT email_inviation__ozone_user FOREIGN KEY (user_id) REFERENCES ozone_user(user_id);


--
-- Name: email_invitation__site; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY email_invitation
    ADD CONSTRAINT email_invitation__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: file__page; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY file
    ADD CONSTRAINT file__page FOREIGN KEY (page_id) REFERENCES page(page_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: file__site; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY file
    ADD CONSTRAINT file__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: file__user; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY file
    ADD CONSTRAINT file__user FOREIGN KEY (user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: forum_category__forum_group; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY forum_category
    ADD CONSTRAINT forum_category__forum_group FOREIGN KEY (group_id) REFERENCES forum_group(group_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: forum_category__forum_post; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY forum_category
    ADD CONSTRAINT forum_category__forum_post FOREIGN KEY (last_post_id) REFERENCES forum_post(post_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: forum_category__site; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY forum_category
    ADD CONSTRAINT forum_category__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: forum_group__site; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY forum_group
    ADD CONSTRAINT forum_group__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: forum_post__ozone_user; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY forum_post
    ADD CONSTRAINT forum_post__ozone_user FOREIGN KEY (user_id) REFERENCES ozone_user(user_id);


--
-- Name: forum_post__site; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY forum_post
    ADD CONSTRAINT forum_post__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: forum_settings__site; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY forum_settings
    ADD CONSTRAINT forum_settings__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: forum_thread__forum_category; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY forum_thread
    ADD CONSTRAINT forum_thread__forum_category FOREIGN KEY (category_id) REFERENCES forum_category(category_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: forum_thread__ozone_user; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY forum_thread
    ADD CONSTRAINT forum_thread__ozone_user FOREIGN KEY (user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: forum_thread__page; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY forum_thread
    ADD CONSTRAINT forum_thread__page FOREIGN KEY (page_id) REFERENCES page(page_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: forum_thread__post; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY forum_thread
    ADD CONSTRAINT forum_thread__post FOREIGN KEY (last_post_id) REFERENCES forum_post(post_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: forum_thread__site; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY forum_thread
    ADD CONSTRAINT forum_thread__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: front_forum_feed__page; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY front_forum_feed
    ADD CONSTRAINT front_forum_feed__page FOREIGN KEY (page_id) REFERENCES page(page_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: front_forum_feed__site; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY front_forum_feed
    ADD CONSTRAINT front_forum_feed__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fts_entry__forum_thread; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY fts_entry
    ADD CONSTRAINT fts_entry__forum_thread FOREIGN KEY (thread_id) REFERENCES forum_thread(thread_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fts_entry__page; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY fts_entry
    ADD CONSTRAINT fts_entry__page FOREIGN KEY (page_id) REFERENCES page(page_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fts_entry__site; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY fts_entry
    ADD CONSTRAINT fts_entry__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ip_block__site; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY ip_block
    ADD CONSTRAINT ip_block__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: log_event__site; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY log_event
    ADD CONSTRAINT log_event__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: member__ozone_user; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY member
    ADD CONSTRAINT member__ozone_user FOREIGN KEY (user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: member__site; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY member
    ADD CONSTRAINT member__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: member_application__ozone_user; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY member_application
    ADD CONSTRAINT member_application__ozone_user FOREIGN KEY (user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: member_application__site; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY member_application
    ADD CONSTRAINT member_application__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: member_invitation__ozone_user__by_user_id; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY member_invitation
    ADD CONSTRAINT member_invitation__ozone_user__by_user_id FOREIGN KEY (by_user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: member_invitation__ozone_user__user_id; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY member_invitation
    ADD CONSTRAINT member_invitation__ozone_user__user_id FOREIGN KEY (user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: member_invitation__site; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY member_invitation
    ADD CONSTRAINT member_invitation__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: moderator__ozone_user; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY moderator
    ADD CONSTRAINT moderator__ozone_user FOREIGN KEY (user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: moderator__site; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY moderator
    ADD CONSTRAINT moderator__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: notification__ozone_user; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY notification
    ADD CONSTRAINT notification__ozone_user FOREIGN KEY (user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ozone_session__ozone_user; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY ozone_session
    ADD CONSTRAINT ozone_session__ozone_user FOREIGN KEY (user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: page__parent_page; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY page
    ADD CONSTRAINT page__parent_page FOREIGN KEY (parent_page_id) REFERENCES page(page_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: page__site; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY page
    ADD CONSTRAINT page__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: page_abuse_flag__ozone_user; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY page_abuse_flag
    ADD CONSTRAINT page_abuse_flag__ozone_user FOREIGN KEY (user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: page_abuse_flag__site; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY page_abuse_flag
    ADD CONSTRAINT page_abuse_flag__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: page_compiled__page; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY page_compiled
    ADD CONSTRAINT page_compiled__page FOREIGN KEY (page_id) REFERENCES page(page_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: page_edit_lock__ozone_user; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY page_edit_lock
    ADD CONSTRAINT page_edit_lock__ozone_user FOREIGN KEY (user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: page_edit_lock__page; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY page_edit_lock
    ADD CONSTRAINT page_edit_lock__page FOREIGN KEY (page_id) REFERENCES page(page_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: page_inclusion__page__included_page_id; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY page_inclusion
    ADD CONSTRAINT page_inclusion__page__included_page_id FOREIGN KEY (included_page_id) REFERENCES page(page_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: page_inclusion__page__including_page_id; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY page_inclusion
    ADD CONSTRAINT page_inclusion__page__including_page_id FOREIGN KEY (including_page_id) REFERENCES page(page_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: page_link__page__from_page_id; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY page_link
    ADD CONSTRAINT page_link__page__from_page_id FOREIGN KEY (from_page_id) REFERENCES page(page_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: page_link__page__to_page_id; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY page_link
    ADD CONSTRAINT page_link__page__to_page_id FOREIGN KEY (to_page_id) REFERENCES page(page_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: page_rate_vote__ozone_user; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY page_rate_vote
    ADD CONSTRAINT page_rate_vote__ozone_user FOREIGN KEY (user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: page_rate_vote__page; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY page_rate_vote
    ADD CONSTRAINT page_rate_vote__page FOREIGN KEY (page_id) REFERENCES page(page_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: page_tag__page; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY page_tag
    ADD CONSTRAINT page_tag__page FOREIGN KEY (page_id) REFERENCES page(page_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: page_viewer__site; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY site_viewer
    ADD CONSTRAINT page_viewer__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: private_message__ozone_user__from_user_id; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY private_message
    ADD CONSTRAINT private_message__ozone_user__from_user_id FOREIGN KEY (from_user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: private_message__ozone_user__to_user_id; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY private_message
    ADD CONSTRAINT private_message__ozone_user__to_user_id FOREIGN KEY (to_user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: private_user_block__ozone_user__blocked_user_id; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY private_user_block
    ADD CONSTRAINT private_user_block__ozone_user__blocked_user_id FOREIGN KEY (blocked_user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: private_user_block__ozone_user__user_id; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY private_user_block
    ADD CONSTRAINT private_user_block__ozone_user__user_id FOREIGN KEY (user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: profile__ozone_user; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY profile
    ADD CONSTRAINT profile__ozone_user FOREIGN KEY (user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: simpletedo_list__site; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY simpletodo_list
    ADD CONSTRAINT simpletedo_list__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: site_backup__site; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY site_backup
    ADD CONSTRAINT site_backup__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: site_settings__site; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY site_settings
    ADD CONSTRAINT site_settings__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: site_super_settings__site; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY site_super_settings
    ADD CONSTRAINT site_super_settings__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: site_tag__site; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY site_tag
    ADD CONSTRAINT site_tag__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: site_viewer__ozone_user; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY site_viewer
    ADD CONSTRAINT site_viewer__ozone_user FOREIGN KEY (user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: theme__site; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY theme
    ADD CONSTRAINT theme__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_abuse_flag__ozone_user__target_user_id; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY user_abuse_flag
    ADD CONSTRAINT user_abuse_flag__ozone_user__target_user_id FOREIGN KEY (user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_abuse_flag__ozone_user__user_id; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY user_abuse_flag
    ADD CONSTRAINT user_abuse_flag__ozone_user__user_id FOREIGN KEY (user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_abuse_flag__site; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY user_abuse_flag
    ADD CONSTRAINT user_abuse_flag__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_block__ozone_user; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY user_block
    ADD CONSTRAINT user_block__ozone_user FOREIGN KEY (user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_block__site; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY user_block
    ADD CONSTRAINT user_block__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_settings__ozone_user; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY user_settings
    ADD CONSTRAINT user_settings__ozone_user FOREIGN KEY (user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: wached_forum_thread__ozone_user; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY watched_forum_thread
    ADD CONSTRAINT wached_forum_thread__ozone_user FOREIGN KEY (user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: watched_forum_thread__forum_thread; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY watched_forum_thread
    ADD CONSTRAINT watched_forum_thread__forum_thread FOREIGN KEY (thread_id) REFERENCES forum_thread(thread_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: watched_page__ozone_user; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY watched_page
    ADD CONSTRAINT watched_page__ozone_user FOREIGN KEY (user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: watched_page__page; Type: FK CONSTRAINT; Schema: public; Owner: wd
--

ALTER TABLE ONLY watched_page
    ADD CONSTRAINT watched_page__page FOREIGN KEY (page_id) REFERENCES page(page_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres81
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres81;
GRANT ALL ON SCHEMA public TO postgres81;
GRANT ALL ON SCHEMA public TO wd;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

