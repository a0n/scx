--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2 (Debian 14.2-1.pgdg110+1)
-- Dumped by pg_dump version 14.2

-- Started on 2022-04-10 04:20:11 UTC

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
-- TOC entry 6 (class 2615 OID 16385)
-- Name: blog; Type: SCHEMA; Schema: -; Owner: root
--

CREATE SCHEMA blog;


ALTER SCHEMA blog OWNER TO root;

--
-- TOC entry 3350 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA blog; Type: COMMENT; Schema: -; Owner: root
--

COMMENT ON SCHEMA blog IS 'scx blog schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 212 (class 1259 OID 16405)
-- Name: comment; Type: TABLE; Schema: blog; Owner: root
--

CREATE TABLE blog.comment (
    id integer NOT NULL,
    user_id integer NOT NULL,
    post_id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    deleted_at timestamp with time zone,
    content text,
    comment_id integer
);


ALTER TABLE blog.comment OWNER TO root;

--
-- TOC entry 3351 (class 0 OID 0)
-- Dependencies: 212
-- Name: COLUMN comment.comment_id; Type: COMMENT; Schema: blog; Owner: root
--

COMMENT ON COLUMN blog.comment.comment_id IS 'The parent comment id of this comment';


--
-- TOC entry 213 (class 1259 OID 16422)
-- Name: edit; Type: TABLE; Schema: blog; Owner: root
--

CREATE TABLE blog.edit (
    id integer NOT NULL,
    user_id integer NOT NULL,
    entity_name text,
    "from" text
);


ALTER TABLE blog.edit OWNER TO root;

--
-- TOC entry 211 (class 1259 OID 16393)
-- Name: post; Type: TABLE; Schema: blog; Owner: root
--

CREATE TABLE blog.post (
    id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp with time zone,
    deleted_at timestamp with time zone,
    content text NOT NULL,
    published_at timestamp with time zone
);


ALTER TABLE blog.post OWNER TO root;

--
-- TOC entry 215 (class 1259 OID 16449)
-- Name: star; Type: TABLE; Schema: blog; Owner: root
--

CREATE TABLE blog.star (
    id integer NOT NULL,
    user_id integer NOT NULL,
    entity_name text NOT NULL,
    entity_id integer NOT NULL
);


ALTER TABLE blog.star OWNER TO root;

--
-- TOC entry 210 (class 1259 OID 16386)
-- Name: user; Type: TABLE; Schema: blog; Owner: root
--

CREATE TABLE blog."user" (
    id integer NOT NULL,
    name text,
    surname text,
    username text,
    email text,
    joined_at timestamp with time zone,
    deleted_at timestamp with time zone
);


ALTER TABLE blog."user" OWNER TO root;

--
-- TOC entry 214 (class 1259 OID 16434)
-- Name: view; Type: TABLE; Schema: blog; Owner: root
--

CREATE TABLE blog.view (
    id integer NOT NULL,
    user_id integer NOT NULL,
    post_id integer NOT NULL,
    "timestamp" timestamp with time zone
);


ALTER TABLE blog.view OWNER TO root;

--
-- TOC entry 3192 (class 2606 OID 16411)
-- Name: comment comment_pkey; Type: CONSTRAINT; Schema: blog; Owner: root
--

ALTER TABLE ONLY blog.comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (id);


--
-- TOC entry 3194 (class 2606 OID 16428)
-- Name: edit edit_pkey; Type: CONSTRAINT; Schema: blog; Owner: root
--

ALTER TABLE ONLY blog.edit
    ADD CONSTRAINT edit_pkey PRIMARY KEY (id);


--
-- TOC entry 3190 (class 2606 OID 16399)
-- Name: post post_pkey; Type: CONSTRAINT; Schema: blog; Owner: root
--

ALTER TABLE ONLY blog.post
    ADD CONSTRAINT post_pkey PRIMARY KEY (id);


--
-- TOC entry 3198 (class 2606 OID 16455)
-- Name: star star_pkey; Type: CONSTRAINT; Schema: blog; Owner: root
--

ALTER TABLE ONLY blog.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (id);


--
-- TOC entry 3188 (class 2606 OID 16392)
-- Name: user user_pkey; Type: CONSTRAINT; Schema: blog; Owner: root
--

ALTER TABLE ONLY blog."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- TOC entry 3196 (class 2606 OID 16438)
-- Name: view view_pkey; Type: CONSTRAINT; Schema: blog; Owner: root
--

ALTER TABLE ONLY blog.view
    ADD CONSTRAINT view_pkey PRIMARY KEY (id);


--
-- TOC entry 3201 (class 2606 OID 16417)
-- Name: comment comment_depends_on_post; Type: FK CONSTRAINT; Schema: blog; Owner: root
--

ALTER TABLE ONLY blog.comment
    ADD CONSTRAINT comment_depends_on_post FOREIGN KEY (post_id) REFERENCES blog.post(id);


--
-- TOC entry 3200 (class 2606 OID 16412)
-- Name: comment comment_depends_on_user; Type: FK CONSTRAINT; Schema: blog; Owner: root
--

ALTER TABLE ONLY blog.comment
    ADD CONSTRAINT comment_depends_on_user FOREIGN KEY (user_id) REFERENCES blog."user"(id);


--
-- TOC entry 3202 (class 2606 OID 16429)
-- Name: edit edit_depends_on_user; Type: FK CONSTRAINT; Schema: blog; Owner: root
--

ALTER TABLE ONLY blog.edit
    ADD CONSTRAINT edit_depends_on_user FOREIGN KEY (user_id) REFERENCES blog."user"(id);


--
-- TOC entry 3199 (class 2606 OID 16400)
-- Name: post post_depends_on_user; Type: FK CONSTRAINT; Schema: blog; Owner: root
--

ALTER TABLE ONLY blog.post
    ADD CONSTRAINT post_depends_on_user FOREIGN KEY (user_id) REFERENCES blog."user"(id);


--
-- TOC entry 3205 (class 2606 OID 16456)
-- Name: star star_depends_on_user; Type: FK CONSTRAINT; Schema: blog; Owner: root
--

ALTER TABLE ONLY blog.star
    ADD CONSTRAINT star_depends_on_user FOREIGN KEY (user_id) REFERENCES blog."user"(id);


--
-- TOC entry 3204 (class 2606 OID 16444)
-- Name: view view_depends_on_post; Type: FK CONSTRAINT; Schema: blog; Owner: root
--

ALTER TABLE ONLY blog.view
    ADD CONSTRAINT view_depends_on_post FOREIGN KEY (post_id) REFERENCES blog.post(id);


--
-- TOC entry 3203 (class 2606 OID 16439)
-- Name: view view_depends_on_user; Type: FK CONSTRAINT; Schema: blog; Owner: root
--

ALTER TABLE ONLY blog.view
    ADD CONSTRAINT view_depends_on_user FOREIGN KEY (user_id) REFERENCES blog."user"(id);


-- Completed on 2022-04-10 04:20:12 UTC

--
-- PostgreSQL database dump complete
--

