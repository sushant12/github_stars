--
-- PostgreSQL database dump
--

-- Dumped from database version 10.12 (Ubuntu 10.12-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 10.12 (Ubuntu 10.12-0ubuntu0.18.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


--
-- Name: starred_repo_tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.starred_repo_tags (
    id bigint NOT NULL,
    starred_repo_id bigint,
    tag_id bigint
);


--
-- Name: TABLE starred_repo_tags; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.starred_repo_tags IS 'Join table for starred repo and tags';


--
-- Name: starred_repo_tags_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.starred_repo_tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: starred_repo_tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.starred_repo_tags_id_seq OWNED BY public.starred_repo_tags.id;


--
-- Name: starred_repos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.starred_repos (
    id bigint NOT NULL,
    name character varying(255),
    description character varying(255),
    ref_id character varying(255),
    github_url character varying(255),
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    language character varying(255),
    user_id bigint
);


--
-- Name: TABLE starred_repos; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.starred_repos IS 'Starred Repos of users';


--
-- Name: COLUMN starred_repos.name; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.starred_repos.name IS 'name of the repo';


--
-- Name: COLUMN starred_repos.description; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.starred_repos.description IS 'description of the repo';


--
-- Name: COLUMN starred_repos.ref_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.starred_repos.ref_id IS 'unique id of the repo';


--
-- Name: COLUMN starred_repos.github_url; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.starred_repos.github_url IS 'github link of the repo';


--
-- Name: COLUMN starred_repos.language; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.starred_repos.language IS 'Programming language used';


--
-- Name: starred_repos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.starred_repos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: starred_repos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.starred_repos_id_seq OWNED BY public.starred_repos.id;


--
-- Name: tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tags (
    id bigint NOT NULL,
    name character varying(255),
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


--
-- Name: TABLE tags; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.tags IS 'Tags of all the repos';


--
-- Name: COLUMN tags.name; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.tags.name IS 'Tags to define a repo';


--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tags_id_seq OWNED BY public.tags.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    username character varying(255),
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: starred_repo_tags id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.starred_repo_tags ALTER COLUMN id SET DEFAULT nextval('public.starred_repo_tags_id_seq'::regclass);


--
-- Name: starred_repos id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.starred_repos ALTER COLUMN id SET DEFAULT nextval('public.starred_repos_id_seq'::regclass);


--
-- Name: tags id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tags ALTER COLUMN id SET DEFAULT nextval('public.tags_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: tags languages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT languages_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: starred_repo_tags starred_repo_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.starred_repo_tags
    ADD CONSTRAINT starred_repo_tags_pkey PRIMARY KEY (id);


--
-- Name: starred_repos starred_repos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.starred_repos
    ADD CONSTRAINT starred_repos_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: starred_repo_tags_starred_repo_id_tag_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX starred_repo_tags_starred_repo_id_tag_id_index ON public.starred_repo_tags USING btree (starred_repo_id, tag_id);


--
-- Name: tags_name_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX tags_name_index ON public.tags USING btree (name);


--
-- Name: users_username_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX users_username_index ON public.users USING btree (username);


--
-- Name: starred_repo_tags starred_repo_tags_starred_repo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.starred_repo_tags
    ADD CONSTRAINT starred_repo_tags_starred_repo_id_fkey FOREIGN KEY (starred_repo_id) REFERENCES public.starred_repos(id) ON DELETE CASCADE;


--
-- Name: starred_repo_tags starred_repo_tags_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.starred_repo_tags
    ADD CONSTRAINT starred_repo_tags_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tags(id) ON DELETE CASCADE;


--
-- Name: starred_repos starred_repos_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.starred_repos
    ADD CONSTRAINT starred_repos_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

INSERT INTO public."schema_migrations" (version) VALUES (20200517070025), (20200518093611), (20200518093738), (20200518151016), (20200522021053), (20200522021414), (20200522024330), (20200522033522), (20200522033655), (20200522052245), (20200522053156), (20200522074558);

