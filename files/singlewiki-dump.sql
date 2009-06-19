





CREATE TABLE admin (
    admin_id integer NOT NULL,
    site_id integer,
    user_id integer,
    founder boolean DEFAULT false
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE admin_admin_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE admin_admin_id_seq OWNED BY admin.admin_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('admin_admin_id_seq', 1, false);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE admin_notification (
    notification_id integer NOT NULL,
    site_id integer,
    body text,
    type character varying(50),
    viewed boolean DEFAULT false,
    date timestamp without time zone,
    extra bytea,
    notify_online boolean DEFAULT false,
    notify_feed boolean DEFAULT false,
    notify_email boolean DEFAULT false
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE admin_notification_notification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE admin_notification_notification_id_seq OWNED BY admin_notification.notification_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('admin_notification_notification_id_seq', 1, false);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE anonymous_abuse_flag (
    flag_id integer NOT NULL,
    user_id integer,
    address inet,
    proxy boolean DEFAULT false,
    site_id integer,
    site_valid boolean DEFAULT true,
    global_valid boolean DEFAULT true
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE anonymous_abuse_flag_flag_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE anonymous_abuse_flag_flag_id_seq OWNED BY anonymous_abuse_flag.flag_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('anonymous_abuse_flag_flag_id_seq', 1, false);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE api_key (
    key character varying(64) NOT NULL,
    user_id integer
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE TABLE category (
    category_id integer NOT NULL,
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
    rating character varying(10),
    category_template_id integer,
    theme_external_url character varying(512),
    enable_pingback_out boolean DEFAULT true,
    enable_pingback_in boolean DEFAULT false,
    autonumerate boolean DEFAULT false,
    page_title_template character varying(256)
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE category_category_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE category_category_id_seq OWNED BY category.category_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('category_category_id_seq', 24, true);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE category_template (
    category_template_id integer NOT NULL,
    source text
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE category_template_category_template_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE category_template_category_template_id_seq OWNED BY category_template.category_template_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('category_template_category_template_id_seq', 1, false);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE comment (
    comment_id integer NOT NULL,
    page_id integer,
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
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE comment_comment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE comment_comment_id_seq OWNED BY comment.comment_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('comment_comment_id_seq', 1, false);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE comment_revision (
    revision_id integer NOT NULL,
    comment_id integer,
    user_id integer,
    user_string character varying(80),
    text text,
    title character varying(256),
    date timestamp without time zone
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE comment_revision_revision_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE comment_revision_revision_id_seq OWNED BY comment_revision.revision_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('comment_revision_revision_id_seq', 1, false);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE contact (
    contact_id integer NOT NULL,
    user_id integer,
    target_user_id integer
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE contact_contact_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE contact_contact_id_seq OWNED BY contact.contact_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('contact_contact_id_seq', 1, false);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE domain_redirect (
    redirect_id integer NOT NULL,
    site_id integer,
    url character varying(80)
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE domain_redirect_redirect_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE domain_redirect_redirect_id_seq OWNED BY domain_redirect.redirect_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('domain_redirect_redirect_id_seq', 1, false);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE email_invitation (
    invitation_id integer NOT NULL,
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
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE email_invitation_invitation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE email_invitation_invitation_id_seq OWNED BY email_invitation.invitation_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('email_invitation_invitation_id_seq', 1, false);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE file (
    file_id integer NOT NULL,
    page_id integer,
    site_id integer,
    filename character varying(100),
    mimetype character varying(100),
    description character varying(200),
    description_short character varying(200),
    comment character varying(400),
    size integer,
    date_added timestamp without time zone,
    user_id integer,
    user_string character varying(80),
    has_resized boolean DEFAULT false
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE file_file_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE file_file_id_seq OWNED BY file.file_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('file_file_id_seq', 1, false);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE files_event (
    file_event_id integer NOT NULL,
    filename character varying(100),
    date timestamp without time zone,
    user_id integer,
    user_string character varying(80),
    action character varying(80),
    action_extra character varying(80)
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE files_event_file_event_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE files_event_file_event_id_seq OWNED BY files_event.file_event_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('files_event_file_event_id_seq', 1, false);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE form_submission_key (
    key_id character varying(90) NOT NULL,
    date_submitted timestamp without time zone
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE TABLE forum_category (
    category_id integer NOT NULL,
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
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE forum_category_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE forum_category_category_id_seq OWNED BY forum_category.category_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('forum_category_category_id_seq', 1, false);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE forum_group (
    group_id integer NOT NULL,
    name character varying(80),
    description text,
    sort_index integer DEFAULT 0,
    site_id integer,
    visible boolean DEFAULT true
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE forum_group_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE forum_group_group_id_seq OWNED BY forum_group.group_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('forum_group_group_id_seq', 1, false);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE forum_post (
    post_id integer NOT NULL,
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
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE forum_post_post_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE forum_post_post_id_seq OWNED BY forum_post.post_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('forum_post_post_id_seq', 1, false);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE forum_post_revision (
    revision_id integer NOT NULL,
    post_id integer,
    user_id integer,
    user_string character varying(80),
    text text,
    title character varying(256),
    date timestamp without time zone
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE forum_post_revision_revision_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE forum_post_revision_revision_id_seq OWNED BY forum_post_revision.revision_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('forum_post_revision_revision_id_seq', 1, false);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE forum_settings (
    site_id integer NOT NULL,
    permissions character varying(200),
    per_page_discussion boolean DEFAULT false,
    max_nest_level integer DEFAULT 0
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE TABLE forum_thread (
    thread_id integer NOT NULL,
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
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE forum_thread_thread_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE forum_thread_thread_id_seq OWNED BY forum_thread.thread_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('forum_thread_thread_id_seq', 1, false);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE front_forum_feed (
    feed_id integer NOT NULL,
    page_id integer,
    title character varying(90),
    label character varying(90),
    description character varying(256),
    categories character varying(100),
    parmhash character varying(100),
    site_id integer
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE front_forum_feed_feed_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE front_forum_feed_feed_id_seq OWNED BY front_forum_feed.feed_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('front_forum_feed_feed_id_seq', 1, false);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE fts_entry (
    fts_id integer NOT NULL,
    page_id integer,
    title character varying(256),
    unix_name character varying(100),
    thread_id integer,
    site_id integer,
    text text,
    vector tsvector
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE fts_entry_fts_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE fts_entry_fts_id_seq OWNED BY fts_entry.fts_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('fts_entry_fts_id_seq', 72, true);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE global_ip_block (
    block_id integer NOT NULL,
    address inet,
    flag_proxy boolean DEFAULT false,
    reason text,
    flag_total boolean DEFAULT false,
    date_blocked timestamp without time zone
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE global_ip_block_block_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE global_ip_block_block_id_seq OWNED BY global_ip_block.block_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('global_ip_block_block_id_seq', 1, false);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE global_user_block (
    block_id integer NOT NULL,
    site_id integer,
    user_id integer,
    reason text,
    date_blocked timestamp without time zone
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE global_user_block_block_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE global_user_block_block_id_seq OWNED BY global_user_block.block_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('global_user_block_block_id_seq', 1, false);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE ip_block (
    block_id integer NOT NULL,
    site_id integer,
    ip inet,
    flag_proxy boolean DEFAULT false,
    reason text,
    date_blocked timestamp without time zone
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE ip_block_block_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE ip_block_block_id_seq OWNED BY ip_block.block_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('ip_block_block_id_seq', 1, false);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE license (
    license_id integer NOT NULL,
    name character varying(100),
    description text,
    sort integer DEFAULT 0
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE license_license_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE license_license_id_seq OWNED BY license.license_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('license_license_id_seq', 8, true);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE log_event (
    event_id bigint NOT NULL,
    date timestamp without time zone,
    user_id integer,
    ip inet,
    proxy inet,
    type character varying(256),
    site_id integer,
    page_id integer,
    revision_id integer,
    thread_id integer,
    post_id integer,
    user_agent character varying(512),
    text text
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE log_event_event_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE log_event_event_id_seq OWNED BY log_event.event_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('log_event_event_id_seq', 99, true);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE member (
    member_id integer NOT NULL,
    site_id integer,
    user_id integer,
    date_joined timestamp without time zone,
    allow_newsletter boolean DEFAULT true
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE TABLE member_application (
    application_id integer NOT NULL,
    site_id integer,
    user_id integer,
    status character varying(20) DEFAULT 'pending'::character varying,
    date timestamp without time zone,
    comment text,
    reply text
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE member_application_application_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE member_application_application_id_seq OWNED BY member_application.application_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('member_application_application_id_seq', 1, false);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE member_invitation (
    invitation_id integer NOT NULL,
    site_id integer,
    user_id integer,
    by_user_id integer,
    date timestamp without time zone,
    body text
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE member_invitation_invitation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE member_invitation_invitation_id_seq OWNED BY member_invitation.invitation_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('member_invitation_invitation_id_seq', 1, false);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE SEQUENCE member_member_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE member_member_id_seq OWNED BY member.member_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('member_member_id_seq', 1, false);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE membership_link (
    link_id integer NOT NULL,
    site_id integer,
    by_user_id integer,
    user_id integer,
    date timestamp without time zone,
    type character varying(20)
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE membership_link_link_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE membership_link_link_id_seq OWNED BY membership_link.link_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('membership_link_link_id_seq', 1, false);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE moderator (
    moderator_id integer NOT NULL,
    site_id integer,
    user_id integer,
    permissions character(10)
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE moderator_moderator_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE moderator_moderator_id_seq OWNED BY moderator.moderator_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('moderator_moderator_id_seq', 1, false);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE notification (
    notification_id integer NOT NULL,
    user_id integer,
    body text,
    type character varying(50),
    viewed boolean DEFAULT false,
    date timestamp without time zone,
    extra bytea,
    notify_online boolean DEFAULT true,
    notify_feed boolean DEFAULT false,
    notify_email boolean DEFAULT true
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE notification_notification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE notification_notification_id_seq OWNED BY notification.notification_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('notification_notification_id_seq', 1, false);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE openid_entry (
    openid_id integer NOT NULL,
    site_id integer,
    page_id integer,
    type character varying(10),
    user_id integer,
    url character varying(100),
    server_url character varying(100)
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE openid_entry_openid_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE openid_entry_openid_id_seq OWNED BY openid_entry.openid_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('openid_entry_openid_id_seq', 1, false);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE ozone_group (
    group_id integer NOT NULL,
    parent_group_id integer,
    name character varying(50),
    description text
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE ozone_group_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE ozone_group_group_id_seq OWNED BY ozone_group.group_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('ozone_group_group_id_seq', 1, false);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE ozone_group_permission_modifier (
    group_permission_id integer NOT NULL,
    group_id character varying(20),
    permission_id character varying(20),
    modifier integer
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE ozone_group_permission_modifier_group_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE ozone_group_permission_modifier_group_permission_id_seq OWNED BY ozone_group_permission_modifier.group_permission_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('ozone_group_permission_modifier_group_permission_id_seq', 1, false);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE ozone_lock (
    key character varying(100) NOT NULL
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE TABLE ozone_permission (
    permission_id integer NOT NULL,
    name character varying(50),
    description text
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE ozone_permission_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE ozone_permission_permission_id_seq OWNED BY ozone_permission.permission_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('ozone_permission_permission_id_seq', 1, false);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE ozone_session (
    session_id character varying(60) NOT NULL,
    started timestamp without time zone,
    last_accessed timestamp without time zone,
    ip_address character varying(90),
    check_ip boolean DEFAULT false,
    infinite boolean DEFAULT false,
    user_id integer,
    serialized_datablock bytea,
    ip_address_ssl character varying(90),
    ua_hash character varying(256)
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE TABLE ozone_user (
    user_id integer NOT NULL,
    name character varying(99),
    nick_name character varying(70),
    password character varying(99),
    email character varying(99),
    unix_name character varying(99),
    last_login timestamp without time zone,
    registered_date timestamp without time zone,
    super_admin boolean DEFAULT false,
    super_moderator boolean DEFAULT false,
    language character varying(10) DEFAULT 'en'::character varying
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE TABLE ozone_user_group_relation (
    user_group_id integer NOT NULL,
    user_id integer,
    group_id integer
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE ozone_user_group_relation_user_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE ozone_user_group_relation_user_group_id_seq OWNED BY ozone_user_group_relation.user_group_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('ozone_user_group_relation_user_group_id_seq', 1, false);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE ozone_user_permission_modifier (
    user_permission_id integer NOT NULL,
    user_id integer,
    permission_id character varying(20),
    modifier integer
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE ozone_user_permission_modifier_user_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE ozone_user_permission_modifier_user_permission_id_seq OWNED BY ozone_user_permission_modifier.user_permission_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('ozone_user_permission_modifier_user_permission_id_seq', 1, false);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE SEQUENCE ozone_user_user_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE ozone_user_user_id_seq OWNED BY ozone_user.user_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('ozone_user_user_id_seq', 1, true);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE page (
    page_id integer NOT NULL,
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
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE TABLE page_abuse_flag (
    flag_id integer NOT NULL,
    user_id integer,
    site_id integer,
    path character varying(100),
    site_valid boolean DEFAULT true,
    global_valid boolean DEFAULT true
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE page_abuse_flag_flag_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE page_abuse_flag_flag_id_seq OWNED BY page_abuse_flag.flag_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('page_abuse_flag_flag_id_seq', 1, true);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE page_compiled (
    page_id integer NOT NULL,
    text text,
    date_compiled timestamp without time zone
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE TABLE page_edit_lock (
    lock_id integer NOT NULL,
    page_id integer,
    mode character varying(10) DEFAULT 'page'::character varying,
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
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE page_edit_lock_lock_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE page_edit_lock_lock_id_seq OWNED BY page_edit_lock.lock_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('page_edit_lock_lock_id_seq', 95, true);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE page_external_link (
    link_id integer NOT NULL,
    site_id integer,
    page_id integer,
    to_url character varying(512),
    pinged boolean DEFAULT false,
    ping_status character varying(256),
    date timestamp without time zone
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE page_external_link_link_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE page_external_link_link_id_seq OWNED BY page_external_link.link_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('page_external_link_link_id_seq', 6, true);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE page_inclusion (
    inclusion_id integer NOT NULL,
    including_page_id integer,
    included_page_id integer,
    included_page_name character varying(128),
    site_id integer
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE page_inclusion_inclusion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE page_inclusion_inclusion_id_seq OWNED BY page_inclusion.inclusion_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('page_inclusion_inclusion_id_seq', 1, false);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE page_link (
    link_id integer NOT NULL,
    from_page_id integer,
    to_page_id integer,
    to_page_name character varying(128),
    site_id integer
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE page_link_link_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE page_link_link_id_seq OWNED BY page_link.link_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('page_link_link_id_seq', 76, true);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE page_metadata (
    metadata_id integer NOT NULL,
    parent_page_id integer,
    title character varying(256),
    unix_name character varying(80),
    owner_user_id integer
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE page_metadata_metadata_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE page_metadata_metadata_id_seq OWNED BY page_metadata.metadata_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('page_metadata_metadata_id_seq', 66, true);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE SEQUENCE page_page_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE page_page_id_seq OWNED BY page.page_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('page_page_id_seq', 61, true);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE page_rate_vote (
    rate_id integer NOT NULL,
    user_id integer,
    page_id integer,
    rate integer DEFAULT 1,
    date timestamp without time zone
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE page_rate_vote_rate_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE page_rate_vote_rate_id_seq OWNED BY page_rate_vote.rate_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('page_rate_vote_rate_id_seq', 1, false);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE page_revision (
    revision_id integer NOT NULL,
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
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE page_revision_revision_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE page_revision_revision_id_seq OWNED BY page_revision.revision_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('page_revision_revision_id_seq', 75, true);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE page_source (
    source_id integer NOT NULL,
    text text
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE page_source_source_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE page_source_source_id_seq OWNED BY page_source.source_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('page_source_source_id_seq', 74, true);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE page_tag (
    tag_id bigint NOT NULL,
    site_id integer,
    page_id integer,
    tag character varying(20)
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE page_tag_tag_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE page_tag_tag_id_seq OWNED BY page_tag.tag_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('page_tag_tag_id_seq', 1, true);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE petition_campaign (
    campaign_id integer NOT NULL,
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
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE petition_campaign_campaign_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE petition_campaign_campaign_id_seq OWNED BY petition_campaign.campaign_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('petition_campaign_campaign_id_seq', 1, false);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE petition_signature (
    signature_id integer NOT NULL,
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
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE petition_signature_signature_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE petition_signature_signature_id_seq OWNED BY petition_signature.signature_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('petition_signature_signature_id_seq', 1, false);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE private_message (
    message_id integer NOT NULL,
    from_user_id integer,
    to_user_id integer,
    subject character varying(256),
    body text,
    date timestamp without time zone,
    flag integer DEFAULT 0,
    flag_new boolean DEFAULT true
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE private_message_message_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE private_message_message_id_seq OWNED BY private_message.message_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('private_message_message_id_seq', 1, false);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE private_user_block (
    block_id integer NOT NULL,
    user_id integer,
    blocked_user_id integer
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE private_user_block_block_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE private_user_block_block_id_seq OWNED BY private_user_block.block_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('private_user_block_block_id_seq', 1, false);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE profile (
    user_id integer NOT NULL,
    real_name character varying(70),
    gender character(1),
    birthday_day integer,
    birthday_month integer,
    birthday_year integer,
    about text,
    location character varying(70),
    website character varying(100),
    im_aim character varying(100),
    im_gadu_gadu character varying(100),
    im_google_talk character varying(100),
    im_icq character varying(100),
    im_jabber character varying(100),
    im_msn character varying(100),
    im_yahoo character varying(100),
    change_screen_name_count integer DEFAULT 0
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE TABLE simpletodo_list (
    list_id integer NOT NULL,
    site_id integer,
    label character varying(256),
    title character varying(256),
    data text
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE simpletodo_list_list_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE simpletodo_list_list_id_seq OWNED BY simpletodo_list.list_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('simpletodo_list_list_id_seq', 1, false);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE site (
    site_id integer NOT NULL,
    name character varying(50),
    subtitle character varying(60),
    unix_name character varying(80),
    description text,
    language character varying(10) DEFAULT 'en'::character varying,
    date_created timestamp without time zone,
    custom_domain character varying(60),
    visible boolean DEFAULT true,
    default_page character varying(80) DEFAULT 'start'::character varying,
    private boolean DEFAULT false,
    deleted boolean DEFAULT false
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE TABLE site_backup (
    backup_id integer NOT NULL,
    site_id integer,
    status character varying(50),
    backup_source boolean DEFAULT true,
    backup_files boolean DEFAULT true,
    date timestamp without time zone,
    rand character varying(100)
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE site_backup_backup_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE site_backup_backup_id_seq OWNED BY site_backup.backup_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('site_backup_backup_id_seq', 1, false);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



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
    max_upload_file_size integer DEFAULT 10485760,
    enable_all_pingback_out boolean DEFAULT true
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE site_site_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE site_site_id_seq OWNED BY site.site_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('site_site_id_seq', 3, true);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE site_super_settings (
    site_id integer NOT NULL,
    can_custom_domain boolean DEFAULT true
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE TABLE site_tag (
    tag_id integer NOT NULL,
    site_id integer,
    tag character varying(20)
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE site_tag_tag_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE site_tag_tag_id_seq OWNED BY site_tag.tag_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('site_tag_tag_id_seq', 1, true);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE site_viewer (
    viewer_id integer NOT NULL,
    site_id integer,
    user_id integer
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE site_viewer_viewer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE site_viewer_viewer_id_seq OWNED BY site_viewer.viewer_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('site_viewer_viewer_id_seq', 1, false);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE storage_item (
    item_id character varying(256) NOT NULL,
    date timestamp without time zone,
    timeout integer,
    data bytea
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE TABLE theme (
    theme_id integer NOT NULL,
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
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE TABLE theme_preview (
    theme_id integer NOT NULL,
    body text
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE theme_theme_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE theme_theme_id_seq OWNED BY theme.theme_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('theme_theme_id_seq', 26, true);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE ucookie (
    ucookie_id character varying(100) NOT NULL,
    site_id integer,
    session_id character varying(60),
    date_granted timestamp without time zone
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE TABLE unique_string_broker (
    last_index integer
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE TABLE user_abuse_flag (
    flag_id integer NOT NULL,
    user_id integer,
    target_user_id integer,
    site_id integer,
    site_valid boolean DEFAULT true,
    global_valid boolean DEFAULT true
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE user_abuse_flag_flag_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE user_abuse_flag_flag_id_seq OWNED BY user_abuse_flag.flag_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('user_abuse_flag_flag_id_seq', 1, false);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE user_block (
    block_id integer NOT NULL,
    site_id integer,
    user_id integer,
    reason text,
    date_blocked timestamp without time zone
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE user_block_block_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE user_block_block_id_seq OWNED BY user_block.block_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('user_block_block_id_seq', 1, false);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE user_karma (
    user_id integer NOT NULL,
    points integer DEFAULT 0,
    level integer DEFAULT 0
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




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
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE TABLE watched_forum_thread (
    watched_id integer NOT NULL,
    user_id integer,
    thread_id integer
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE watched_forum_thread_watched_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE watched_forum_thread_watched_id_seq OWNED BY watched_forum_thread.watched_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('watched_forum_thread_watched_id_seq', 1, false);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE TABLE watched_page (
    watched_id integer NOT NULL,
    user_id integer,
    page_id integer
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CREATE SEQUENCE watched_page_watched_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




ALTER SEQUENCE watched_page_watched_id_seq OWNED BY watched_page.watched_id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



SELECT pg_catalog.setval('watched_page_watched_id_seq', 1, false);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE admin ALTER COLUMN admin_id SET DEFAULT nextval('admin_admin_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE admin_notification ALTER COLUMN notification_id SET DEFAULT nextval('admin_notification_notification_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE anonymous_abuse_flag ALTER COLUMN flag_id SET DEFAULT nextval('anonymous_abuse_flag_flag_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE category ALTER COLUMN category_id SET DEFAULT nextval('category_category_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE category_template ALTER COLUMN category_template_id SET DEFAULT nextval('category_template_category_template_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE comment ALTER COLUMN comment_id SET DEFAULT nextval('comment_comment_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE comment_revision ALTER COLUMN revision_id SET DEFAULT nextval('comment_revision_revision_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE contact ALTER COLUMN contact_id SET DEFAULT nextval('contact_contact_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE domain_redirect ALTER COLUMN redirect_id SET DEFAULT nextval('domain_redirect_redirect_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE email_invitation ALTER COLUMN invitation_id SET DEFAULT nextval('email_invitation_invitation_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE file ALTER COLUMN file_id SET DEFAULT nextval('file_file_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE files_event ALTER COLUMN file_event_id SET DEFAULT nextval('files_event_file_event_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE forum_category ALTER COLUMN category_id SET DEFAULT nextval('forum_category_category_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE forum_group ALTER COLUMN group_id SET DEFAULT nextval('forum_group_group_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE forum_post ALTER COLUMN post_id SET DEFAULT nextval('forum_post_post_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE forum_post_revision ALTER COLUMN revision_id SET DEFAULT nextval('forum_post_revision_revision_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE forum_thread ALTER COLUMN thread_id SET DEFAULT nextval('forum_thread_thread_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE front_forum_feed ALTER COLUMN feed_id SET DEFAULT nextval('front_forum_feed_feed_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE fts_entry ALTER COLUMN fts_id SET DEFAULT nextval('fts_entry_fts_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE global_ip_block ALTER COLUMN block_id SET DEFAULT nextval('global_ip_block_block_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE global_user_block ALTER COLUMN block_id SET DEFAULT nextval('global_user_block_block_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ip_block ALTER COLUMN block_id SET DEFAULT nextval('ip_block_block_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE license ALTER COLUMN license_id SET DEFAULT nextval('license_license_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE log_event ALTER COLUMN event_id SET DEFAULT nextval('log_event_event_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE member ALTER COLUMN member_id SET DEFAULT nextval('member_member_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE member_application ALTER COLUMN application_id SET DEFAULT nextval('member_application_application_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE member_invitation ALTER COLUMN invitation_id SET DEFAULT nextval('member_invitation_invitation_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE membership_link ALTER COLUMN link_id SET DEFAULT nextval('membership_link_link_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE moderator ALTER COLUMN moderator_id SET DEFAULT nextval('moderator_moderator_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE notification ALTER COLUMN notification_id SET DEFAULT nextval('notification_notification_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE openid_entry ALTER COLUMN openid_id SET DEFAULT nextval('openid_entry_openid_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ozone_group ALTER COLUMN group_id SET DEFAULT nextval('ozone_group_group_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ozone_group_permission_modifier ALTER COLUMN group_permission_id SET DEFAULT nextval('ozone_group_permission_modifier_group_permission_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ozone_permission ALTER COLUMN permission_id SET DEFAULT nextval('ozone_permission_permission_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ozone_user ALTER COLUMN user_id SET DEFAULT nextval('ozone_user_user_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ozone_user_group_relation ALTER COLUMN user_group_id SET DEFAULT nextval('ozone_user_group_relation_user_group_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ozone_user_permission_modifier ALTER COLUMN user_permission_id SET DEFAULT nextval('ozone_user_permission_modifier_user_permission_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE page ALTER COLUMN page_id SET DEFAULT nextval('page_page_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE page_abuse_flag ALTER COLUMN flag_id SET DEFAULT nextval('page_abuse_flag_flag_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE page_edit_lock ALTER COLUMN lock_id SET DEFAULT nextval('page_edit_lock_lock_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE page_external_link ALTER COLUMN link_id SET DEFAULT nextval('page_external_link_link_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE page_inclusion ALTER COLUMN inclusion_id SET DEFAULT nextval('page_inclusion_inclusion_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE page_link ALTER COLUMN link_id SET DEFAULT nextval('page_link_link_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE page_metadata ALTER COLUMN metadata_id SET DEFAULT nextval('page_metadata_metadata_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE page_rate_vote ALTER COLUMN rate_id SET DEFAULT nextval('page_rate_vote_rate_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE page_revision ALTER COLUMN revision_id SET DEFAULT nextval('page_revision_revision_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE page_source ALTER COLUMN source_id SET DEFAULT nextval('page_source_source_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE page_tag ALTER COLUMN tag_id SET DEFAULT nextval('page_tag_tag_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE petition_campaign ALTER COLUMN campaign_id SET DEFAULT nextval('petition_campaign_campaign_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE petition_signature ALTER COLUMN signature_id SET DEFAULT nextval('petition_signature_signature_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE private_message ALTER COLUMN message_id SET DEFAULT nextval('private_message_message_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE private_user_block ALTER COLUMN block_id SET DEFAULT nextval('private_user_block_block_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE simpletodo_list ALTER COLUMN list_id SET DEFAULT nextval('simpletodo_list_list_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE site ALTER COLUMN site_id SET DEFAULT nextval('site_site_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE site_backup ALTER COLUMN backup_id SET DEFAULT nextval('site_backup_backup_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE site_tag ALTER COLUMN tag_id SET DEFAULT nextval('site_tag_tag_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE site_viewer ALTER COLUMN viewer_id SET DEFAULT nextval('site_viewer_viewer_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE theme ALTER COLUMN theme_id SET DEFAULT nextval('theme_theme_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE user_abuse_flag ALTER COLUMN flag_id SET DEFAULT nextval('user_abuse_flag_flag_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE user_block ALTER COLUMN block_id SET DEFAULT nextval('user_block_block_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE watched_forum_thread ALTER COLUMN watched_id SET DEFAULT nextval('watched_forum_thread_watched_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE watched_page ALTER COLUMN watched_id SET DEFAULT nextval('watched_page_watched_id_seq'::regclass);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;















INSERT INTO category VALUES (21, 1, 'auth', true, 20, false, 'e:;c:;m:;d:;a:;r:;z:;o:', false, 1, NULL, false, 'nav:top', 'nav:side', NULL, false, true, NULL, NULL, NULL, true, false, false, NULL);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO category VALUES (20, 1, 'system', true, 20, false, 'e:;c:;m:;d:;a:;r:;z:;o:', true, 1, NULL, true, 'nav:top', 'nav:side', NULL, NULL, true, NULL, NULL, NULL, true, false, false, NULL);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO category VALUES (22, 1, 'search', true, 20, true, 'e:rm;c:rm;m:rm;d:rm;a:rm;r:rm;z:rm;o:rm', true, 1, NULL, true, 'nav:top', 'nav:side', NULL, NULL, true, NULL, NULL, NULL, true, false, false, NULL);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO category VALUES (23, 1, 'nav', true, 20, true, 'e:rm;c:rm;m:rm;d:rm;a:rm;r:rm;z:rm;o:rm', true, 1, NULL, true, 'nav:top', 'nav:side', NULL, NULL, true, NULL, NULL, NULL, true, false, false, NULL);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO category VALUES (24, 1, 'admin', true, 20, true, 'e:rm;c:rma;m:rm;d:rm;a:rm;r:rm;z:rm;o:rm', true, 1, NULL, true, 'nav:top', 'nav:side', NULL, NULL, true, NULL, NULL, NULL, true, false, false, NULL);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO category VALUES (1, 1, '_default', true, 20, false, 'e:rm;c:rm;m:rm;d:rm;a:rm;r:rm;z:rm;o:rm', false, 1, NULL, false, 'nav:top', 'nav:side', NULL, false, true, NULL, NULL, NULL, true, false, false, NULL);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO admin VALUES (1, 1, 1, 'T');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



















































INSERT INTO fts_entry VALUES (49, 45, 'Recent changes', 'system:recent-changes', NULL, 1, '
', '''chang'':2C,6C ''recent'':1C,5C ''system'':3C ''recent-chang'':4C');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO fts_entry VALUES (52, 48, 'Page Tags', 'system:page-tags', NULL, 1, '
', '''tag'':2C,6C ''page'':1C,5C ''system'':3C ''page-tag'':4C');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO fts_entry VALUES (44, 41, 'What Is A Wiki', 'what-is-a-wiki', NULL, 1, '
According to Wikipedia, the world largest wiki site:
A Wiki ([ˈwiː.kiː] &lt;wee-kee&gt; or [ˈwɪ.kiː] &lt;wick-ey&gt;) is a type of website that allows users to add, remove, or otherwise edit and change most content very quickly and easily.
And that is it! As a part of a farm of wikis this site is a great tool that you can use to publish content, upload files, communicate and collaborate.
', '''ey'':30 ''add'':40 ''kee'':24 ''use'':74 ''wee'':23 ''edit'':44 ''farm'':62 ''file'':79 ''kiː'':21,27 ''part'':59 ''site'':17,66 ''tool'':70 ''type'':33 ''user'':38 ''wick'':29 ''wiki'':4C,9C,16,19,64 ''allow'':37 ''chang'':46 ''great'':69 ''quick'':50 ''remov'':41 ''world'':14 ''ˈwɪ'':26 ''accord'':10 ''easili'':52 ''upload'':78 ''websit'':35 ''wee-ke'':22 ''ˈwiː'':20 ''content'':48,77 ''largest'':15 ''publish'':76 ''wick-ey'':28 ''collabor'':82 ''communic'':80 ''otherwis'':43 ''wikipedia'':12 ''what-is-a-wiki'':5C');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO fts_entry VALUES (46, 42, 'How To Edit Pages', 'how-to-edit-pages', NULL, 1, '
If you are allowed to edit pages in this Site, simply click on edit button at the bottom of the page. This will open an editor with a toolbar pallette with options.
To create a link to a new page, use syntax: [[[new page name]]] or [[[new page name | text to display]]]. Follow the link (which should have a different color if page does not exist) and create a new page and edit it!
Although creating and editing pages is easy, there are a lot more options that allows creating powerful sites. Please visit Documentation pages (at wikidot.org) to learn more.
', '''lot'':94 ''new'':48,52,56,79 ''use'':50 ''easi'':90 ''edit'':3C,8C,15,23,82,87 ''link'':45,64 ''name'':54,58 ''open'':33 ''page'':4C,9C,16,30,49,53,57,72,80,88,105 ''site'':19,101 ''text'':59 ''allow'':13,98 ''click'':21 ''color'':70 ''creat'':43,77,85,99 ''exist'':75 ''learn'':109 ''pleas'':102 ''power'':100 ''visit'':103 ''bottom'':27 ''button'':24 ''differ'':69 ''editor'':35 ''follow'':62 ''option'':41,96 ''simpli'':20 ''syntax'':51 ''display'':61 ''pallett'':39 ''toolbar'':38 ''although'':84 ''document'':104 ''wikidot.org'':107 ''how-to-edit-pag'':5C');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO fts_entry VALUES (50, 46, 'List all pages', 'system:list-all-pages', NULL, 1, '
', '''list'':1C,6C ''page'':3C,8C ''system'':4C ''list-all-pag'':5C');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO fts_entry VALUES (51, 47, 'Page Tags List', 'system:page-tags-list', NULL, 1, '
', '''tag'':2C,7C ''list'':3C,8C ''page'':1C,6C ''system'':4C ''page-tags-list'':5C');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO fts_entry VALUES (60, 49, 'Log in', 'auth:login', NULL, 1, '
', '''log'':1C ''auth'':2C ''login'':3C');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO fts_entry VALUES (61, 50, 'Create account - step 1', 'auth:newaccount', NULL, 1, '
', '''1'':4C ''auth'':5C ''step'':3C ''creat'':1C ''account'':2C ''newaccount'':6C');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO fts_entry VALUES (64, 53, 'Welcome on your new wiki', 'start', NULL, 1, '
Congratulations, you have successfully installed a new wiki using wdLite — custom simplified Wikidot installation tool.
What to do next
Customize this wiki
Your Wikidot site has two menus, one at the side called ''nav:side'', and one at the top called ''nav:top''. These are Wikidot pages, and you can edit them like any page.
To edit a page, go to the page and click the Edit button at the bottom. You can change everything in the main area of your page. The Wikidot system is easy to learn and powerful.
You can attach images and other files to any page, then display them and link to them in the page.
Every Wikidot page has a history of edits, and you can undo anything. So feel secure, and experiment.
If you want to learn more, make sure you visit the Documentation section at www.wikidot.org
Visit Wikidot.org
Go to www.wikidot.org — home of the Wikidot software — for extra documentation, howtos, tips and support.
Explore more at Wikidot.com
If you want more feature rich wiki reliably hosted, consider creating a wiki within Wikidot.com
', '''a'':11,63,121,182 ''at'':35,43,74,148,169 ''do'':23 ''go'':65,152 ''if'':135,171 ''in'':81,114 ''is'':91 ''of'':85,123,156 ''on'':2A ''so'':130 ''to'':22,61,66,93,104,112,138,153 ''and'':41,53,69,95,101,110,125,133,165 ''any'':59,105 ''are'':50 ''can'':55,78,98,127 ''for'':160 ''has'':31,120 ''nav'':39,47 ''new'':4A,12 ''one'':34,42 ''the'':36,44,67,71,75,82,88,115,145,157 ''top'':45,48 ''two'':32 ''you'':7,54,77,97,126,136,143,172 ''area'':84 ''easy'':92 ''edit'':56,62,72 ''feel'':131 ''have'':8 ''home'':155 ''like'':58 ''link'':111 ''main'':83 ''make'':141 ''more'':140,168,174 ''next'':24 ''page'':60,64,68,87,106,116,119 ''rich'':176 ''side'':37,40 ''site'':30 ''sure'':142 ''them'':57,109,113 ''then'':107 ''this'':26 ''tips'':164 ''tool'':20 ''undo'':128 ''want'':137,173 ''what'':21 ''wiki'':5A,13,27,177,183 ''your'':3A,28,86 ''click'':70 ''edits'':124 ''every'':117 ''extra'':161 ''files'':103 ''learn'':94,139 ''menus'':33 ''other'':102 ''pages'':52 ''these'':49 ''using'':14 ''visit'':144,150 ''attach'':99 ''bottom'':76 ''button'':73 ''called'':38,46 ''change'':79 ''custom'':16 ''hosted'':179 ''howtos'':163 ''images'':100 ''secure'':132 ''system'':90 ''wdlite'':15 ''within'':184 ''display'':108 ''explore'':167 ''feature'':175 ''history'':122 ''section'':147 ''support'':166 ''welcome'':1A ''wikidot'':18,29,51,89,118,158 ''anything'':129 ''consider'':180 ''creating'':181 ''powerful'':96 ''reliably'':178 ''software'':159 ''customize'':25 ''installed'':10 ''everything'':80 ''experiment'':134 ''simplified'':17 ''wikidot.com'':170,185 ''wikidot.org'':151 ''installation'':19 ''successfully'':9 ''documentation'':146,162 ''congratulations'':6 ''www.wikidot.org'':149,154');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO fts_entry VALUES (65, 54, 'Search this site', 'search:site', NULL, 1, '
', '''site'':3A ''this'':2A ''search'':1A');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO fts_entry VALUES (66, 55, 'Side', 'nav:side', NULL, 1, '
Welcome page
Recent changes
List all pages
Page Tags
What is a Wiki?
How to edit pages?
Page tags
Add a new page
edit this panel
', '''a'':13,22 ''is'':12 ''to'':16 ''add'':21 ''all'':7 ''how'':15 ''new'':23 ''edit'':17,25 ''list'':6 ''page'':3,9,19,24 ''side'':1A ''tags'':10,20 ''this'':26 ''what'':11 ''wiki'':14 ''pages'':8,18 ''panel'':27 ''recent'':4 ''changes'':5 ''welcome'':2');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO fts_entry VALUES (69, 58, 'Create account - step 2', 'auth:newaccount2', NULL, 1, '
Check your Inbox for verification email and click the verification link.
', '''2'':4A ''and'':11 ''for'':8 ''the'':13 ''link'':15 ''step'':3A ''your'':6 ''check'':5 ''click'':12 ''email'':10 ''inbox'':7 ''create'':1A ''account'':2A ''verification'':9,14');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO fts_entry VALUES (71, 60, 'Congratulations', 'auth:newaccount3', NULL, 1, '
You''ve just registered to this wiki.
Use the left hand menu to navigate.
', '''to'':6,14 ''ve'':3 ''the'':10 ''use'':9 ''you'':2 ''hand'':12 ''just'':4 ''left'':11 ''menu'':13 ''this'':7 ''wiki'':8 ''navigate'':15 ''registered'':5 ''congratulations'':1A');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO fts_entry VALUES (72, 61, 'Manage Super Admin Account', 'admin:superadmin', NULL, 1, '


', '''admin'':3A ''super'':2A ''manage'':1A ''account'':4A');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;












INSERT INTO license VALUES (1, 'Creative Commons Attribution-ShareAlike 3.0 License (recommended)', '%%UNLESS%% <a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/">Creative Commons Attribution-ShareAlike 3.0 License</a>', 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO license VALUES (2, 'Creative Commons Attribution 3.0 License', '%%UNLESS%% <a rel="license" href="http://creativecommons.org/licenses/by/3.0/">Creative Commons Attribution 3.0 License</a>', 2);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO license VALUES (3, 'Creative Commons Attribution-NoDerivs 3.0 License', '%%UNLESS%% <a rel="license" href="http://creativecommons.org/licenses/by-nd/3.0/">Creative Commons Attribution-NoDerivs 3.0 License</a>', 3);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO license VALUES (4, 'Creative Commons Attribution-NonCommercial 3.0 License', '%%UNLESS%% <a rel="license" href="http://creativecommons.org/licenses/by-nc/3.0/">Creative Commons Attribution-NonCommercial 3.0 License</a>', 4);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO license VALUES (5, 'Creative Commons Attribution-NonCommercial-ShareAlike 3.0 License', '%%UNLESS%% <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/">Creative Commons Attribution-NonCommercial-ShareAlike 3.0 License</a>', 5);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO license VALUES (6, 'Creative Commons Attribution-NonCommercial-NoDerivs 3.0 License', '%%UNLESS%% <a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/3.0/">Creative Commons Attribution-NonCommercial-NoDerivs 3.0 License</a>', 6);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO license VALUES (7, 'GNU Free Documentation License 1.2', '%%UNLESS%%  
<a href="http://www.gnu.org/copyleft/fdl.html" title="http://www.gnu.org/copyleft/fdl.html" rel="license">GNU 
Free Documentation License</a>.', 100);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO license VALUES (8, 'Standard copyright (not recommended)', NULL, 1000);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



INSERT INTO log_event VALUES (99, '2009-05-13 14:03:02', NULL, '127.0.0.1', NULL, 'PAGE_NEW', 1, 61, 75, NULL, NULL, 'Mozilla/5.0 (X11; U; Linux x86_64; pl-PL; rv:1.9.0.10) Gecko/2009042523 Ubuntu/9.04 (jaunty) Firefox/3.0.10', 'New page "admin:superadmin" has been saved on site "My Wiki".');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




































INSERT INTO ozone_session VALUES ('1242223341_26', '2009-05-13 14:02:21', '2009-05-13 14:03:04', '127.0.0.1', false, false, NULL, 'b:0;', NULL, 'dd073144f8a65f78a3d9bf4b449b5652');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



INSERT INTO ozone_user VALUES (-1, 'Automatic', 'Automatic', NULL, 'automatic@wikidot', 'automatic', NULL, NULL, false, false, 'en');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO ozone_user VALUES (0, 'Anonymous', 'Anonymous', NULL, 'anonymous@wikidot', 'anonymous', NULL, NULL, false, false, 'en');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO ozone_user VALUES (1, 'admin@wikidot', 'Admin', 'a0987642602a842d8f325a7d1bbb7fdb', 'admin@wikidot', 'admin', '2009-02-05 23:52:51', NULL, true, false, 'en');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;









INSERT INTO page VALUES (41, 1, 1, NULL, 51, 50, 45, 0, 'What Is A Wiki', 'what-is-a-wiki', '2008-01-30 16:11:56', '2008-01-30 16:11:56', 1, NULL, NULL, 1, false, 0);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page VALUES (42, 1, 1, NULL, 53, 52, 46, 0, 'How To Edit Pages', 'how-to-edit-pages', '2008-01-30 16:12:48', '2008-01-30 16:12:48', 1, NULL, NULL, 1, false, 0);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page VALUES (45, 1, 20, NULL, 56, 55, 49, 0, 'Recent changes', 'system:recent-changes', '2008-01-30 16:14:41', '2008-01-30 16:14:41', 1, NULL, NULL, 1, false, 0);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page VALUES (46, 1, 20, NULL, 57, 56, 50, 0, 'List all pages', 'system:list-all-pages', '2008-01-30 16:15:22', '2008-01-30 16:15:22', 1, NULL, NULL, 1, false, 0);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page VALUES (47, 1, 20, NULL, 58, 57, 51, 0, 'Page Tags List', 'system:page-tags-list', '2008-01-30 16:15:56', '2008-01-30 16:15:56', 1, NULL, NULL, 1, false, 0);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page VALUES (48, 1, 20, NULL, 59, 58, 52, 0, 'Page Tags', 'system:page-tags', '2008-01-30 16:16:22', '2008-01-30 16:16:22', 1, NULL, NULL, 1, false, 0);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page VALUES (49, 1, 21, NULL, 60, 59, 53, 0, 'Log in', 'auth:login', '2008-08-19 16:25:58', '2008-08-19 16:25:58', 1, NULL, NULL, 1, false, 0);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page VALUES (50, 1, 21, NULL, 61, 60, 54, 0, 'Create account - step 1', 'auth:newaccount', '2008-08-19 16:25:58', '2008-08-19 16:25:58', 1, NULL, NULL, 1, false, 0);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page VALUES (53, 1, 1, NULL, 67, 66, 58, 0, 'Welcome on your new wiki', 'start', '2009-02-05 23:28:16', '2009-02-05 23:28:16', 1, NULL, NULL, 1, false, 0);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page VALUES (54, 1, 22, NULL, 68, 67, 59, 0, 'Search this site', 'search:site', '2009-02-05 23:29:17', '2009-02-05 23:29:17', 1, NULL, NULL, 1, false, 0);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page VALUES (55, 1, 23, NULL, 69, 68, 60, 0, 'Side', 'nav:side', '2009-02-05 23:29:53', '2009-02-05 23:29:53', 1, NULL, NULL, 1, false, 0);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page VALUES (58, 1, 21, NULL, 72, 71, 63, 0, 'Create account - step 2', 'auth:newaccount2', '2009-02-05 23:54:30', '2009-02-05 23:54:30', 1, NULL, NULL, 1, false, 0);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page VALUES (60, 1, 21, NULL, 74, 73, 65, 0, 'Congratulations', 'auth:newaccount3', '2009-02-05 23:56:54', '2009-02-05 23:56:54', 1, NULL, NULL, 1, false, 0);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page VALUES (61, 1, 24, NULL, 75, 74, 66, 0, 'Manage Super Admin Account', 'admin:superadmin', '2009-05-13 14:03:01', '2009-05-13 14:03:01', 0, '127.0.0.1', NULL, NULL, false, 0);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;






INSERT INTO page_compiled VALUES (45, '
þmodule "changes/SiteChangesModule"þ', '2008-08-19 16:25:59');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_compiled VALUES (41, '
<p>According to <a href="http://en.wikipedia.org/wiki/Wiki">Wikipedia</a>, the world largest wiki site:</p>
<blockquote>
<p>A <em>Wiki</em> ([ˈwiː.kiː] &lt;wee-kee&gt; or [ˈwɪ.kiː] &lt;wick-ey&gt;) is a type of website that allows users to add, remove, or otherwise edit and change most content very quickly and easily.</p>
</blockquote>
<p>And that is it! As a part of a farm of wikis this site is a great tool that you can use to publish content, upload files, communicate and collaborate.</p>
', '2008-08-19 16:25:59');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_compiled VALUES (42, '
<p>If you are allowed to edit pages in this Site, simply click on <em>edit</em> button at the bottom of the page. This will open an editor with a toolbar pallette with options.</p>
<p>To create a link to a new page, use syntax: <tt>[[[new page name]]]</tt> or <tt>[[[new page name | text to display]]]</tt>. Follow the link (which should have a different color if page does not exist) and create a new page and edit it!</p>
<p>Although creating and editing pages is easy, there are a lot more options that allows creating powerful sites. Please visit <a href="http://www.wikidot.org/doc" onclick="window.open(this.href, ''_blank''); return false;">Documentation pages</a> (at wikidot.org) to learn more.</p>
', '2008-08-19 16:25:59');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_compiled VALUES (46, '
þmodule "list/WikiPagesModule" preview%3D%22true%22 þ', '2008-08-19 16:25:59');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_compiled VALUES (49, '
þmodule "login/LoginModule"þ', '2008-08-19 16:25:59');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_compiled VALUES (47, '
þmodule "wiki/pagestagcloud/PagesTagCloudModule" limit%3D%22200%22+target%3D%22system%3Apage-tags%22 þ', '2008-08-19 16:25:59');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_compiled VALUES (48, '
<div style="float:right; width: 50%;">þmodule "wiki/pagestagcloud/PagesTagCloudModule" limit%3D%22200%22+target%3D%22system%3Apage-tags%22 þ</div>
þmodule "wiki/pagestagcloud/PagesListByTagModule"þ', '2008-08-19 16:25:59');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_compiled VALUES (50, '
þmodule "createaccount2/CreateAccountModule"þ', '2008-08-19 16:25:59');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_compiled VALUES (53, '
<p>Congratulations, you have successfully installed a new wiki using wdLite — custom simplified Wikidot installation tool.</p>
<h1 id="toc0"><span>What to do next</span></h1>
<h2 id="toc1"><span>Customize this wiki</span></h2>
<ul>
<li>Your Wikidot site has two menus, <a href="/nav:side">one at the side</a> called ''<tt>nav:side</tt>'', and <a class="newpage" href="/nav:top">one at the top</a> called ''<tt>nav:top</tt>''. These are Wikidot pages, and you can edit them like any page.</li>
<li>To edit a page, go to the page and click the <strong>Edit</strong> button at the bottom. You can change everything in the main area of your page. The Wikidot system is <a href="http://www.wikidot.org/doc" onclick="window.open(this.href, ''_blank''); return false;">easy to learn and powerful</a>.</li>
<li>You can attach images and other files to any page, then display them and link to them in the page.</li>
<li>Every Wikidot page has a history of edits, and you can undo anything. So feel secure, and experiment.</li>
<li>If you want to learn more, make sure you visit the <a href="http://www.wikidot.org/doc" onclick="window.open(this.href, ''_blank''); return false;">Documentation section at www.wikidot.org</a></li>
</ul>
<h2 id="toc2"><span>Visit Wikidot.org</span></h2>
<p>Go to <strong><a href="http://www.wikidot.org">www.wikidot.org</a></strong> — home of the Wikidot software — for extra documentation, howtos, tips and support.</p>
<h2 id="toc3"><span>Explore more at Wikidot.com</span></h2>
<p>If you want more feature rich wiki reliably hosted, consider creating a wiki within <strong><a href="http://www.wikidot.com/">Wikidot.com</a></strong></p>
', '2009-02-05 23:28:16');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_compiled VALUES (54, '
þmodule "search/SearchModule"þ', '2009-02-05 23:29:18');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_compiled VALUES (55, '
<ul>
<li><a href="/start">Welcome page</a></li>
<li><a href="/system:recent-changes">Recent changes</a></li>
<li><a href="/system:list-all-pages">List all pages</a></li>
<li><a href="/system:page-tags-list">Page Tags</a></li>
<li><a href="/what-is-a-wiki">What is a Wiki?</a></li>
<li><a href="/how-to-edit-pages">How to edit pages?</a></li>
</ul>
<h2 id="toc0"><span>Page tags</span></h2>
þmodule "wiki/pagestagcloud/PagesTagCloudModule" minFontSize%3D%2280%25%22+maxFontSize%3D%22200%25%22++maxColor%3D%228%2C8%2C64%22+minColor%3D%22100%2C100%2C128%22+target%3D%22system%3Apage-tags%22+limit%3D%2230%22 þ
<h2 id="toc1"><span>Add a new page</span></h2>
þmodule "misc/NewPageHelperModule" size%3D%2215%22+button%3D%22new+page%22 þ
<p style="text-align: center;"><span style="font-size:80%;"><a href="/nav:side">edit this panel</a></span></p>
', '2009-02-05 23:29:53');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_compiled VALUES (58, '
<div class="wdlite-please-hide-this">þmodule "createaccount2/CreateAccount2Module"þ</div>
<p>Check your Inbox for verification email and click the verification link.</p>
', '2009-02-05 23:54:30');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_compiled VALUES (60, '
<p>You''ve just registered to this wiki.</p>
<p>Use the left hand menu to navigate.</p>
', '2009-02-05 23:56:55');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_compiled VALUES (61, '

þmodule "manage/ManageSuperUserModule"þ', '2009-05-13 14:03:02');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;






INSERT INTO page_external_link VALUES (1, 1, 23, 'http://www.wikidot.org/doc', false, NULL, '2009-02-05 23:26:12');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_external_link VALUES (2, 1, 23, 'http://www.wikidot.org', false, NULL, '2009-02-05 23:26:12');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_external_link VALUES (3, 1, 23, 'http://www.wikidot.com/', false, NULL, '2009-02-05 23:26:12');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_external_link VALUES (4, 1, 53, 'http://www.wikidot.org/doc', false, NULL, '2009-02-05 23:28:16');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_external_link VALUES (5, 1, 53, 'http://www.wikidot.org', false, NULL, '2009-02-05 23:28:16');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_external_link VALUES (6, 1, 53, 'http://www.wikidot.com/', false, NULL, '2009-02-05 23:28:16');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;






INSERT INTO page_link VALUES (69, 53, NULL, 'nav:top', 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_link VALUES (70, 55, 53, NULL, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_link VALUES (71, 55, 45, NULL, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_link VALUES (72, 55, 46, NULL, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_link VALUES (73, 55, 47, NULL, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_link VALUES (74, 55, 41, NULL, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_link VALUES (75, 55, 42, NULL, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_link VALUES (76, 55, 55, NULL, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



INSERT INTO page_metadata VALUES (5, NULL, 'Side', 'nav:side', 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_metadata VALUES (6, NULL, 'What Is A Wiki Site', 'what-is-a-wiki-site', 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_metadata VALUES (7, NULL, 'Admin', 'profile:admin', 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_metadata VALUES (8, NULL, NULL, 'admin:manage', 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_metadata VALUES (10, NULL, 'Profile Side', 'nav:profile-side', 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_metadata VALUES (11, NULL, 'Side', 'nav:side', 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_metadata VALUES (12, NULL, NULL, 'start', 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_metadata VALUES (13, NULL, 'How To Edit Pages - Quickstart', 'how-to-edit-pages', 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_metadata VALUES (14, NULL, 'Join This Wiki', 'system:join', 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_metadata VALUES (15, NULL, NULL, 'admin:manage', 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_metadata VALUES (16, NULL, 'Page Tags List', 'system:page-tags-list', 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_metadata VALUES (17, NULL, 'Recent Changes', 'system:recent-changes', 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_metadata VALUES (18, NULL, 'Members', 'system:members', 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_metadata VALUES (19, NULL, 'Wiki Search', 'search:site', 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_metadata VALUES (20, NULL, NULL, 'system:page-tags', 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_metadata VALUES (21, NULL, 'List All Pages', 'system:list-all-pages', 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_metadata VALUES (28, NULL, 'Forum Categories', 'forum:start', 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_metadata VALUES (29, NULL, 'Forum Category', 'forum:category', 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_metadata VALUES (30, NULL, 'Forum Thread', 'forum:thread', 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_metadata VALUES (31, NULL, 'New Forum Thread', 'forum:new-thread', 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_metadata VALUES (32, NULL, 'Recent Forum Posts', 'forum:recent-posts', 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_metadata VALUES (33, NULL, 'Top', 'nav:top', 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_metadata VALUES (34, NULL, 'Template', 'profile:template', 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_metadata VALUES (37, NULL, 'Congratulations, welcome to your new wiki!', 'start', 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_metadata VALUES (45, NULL, 'What Is A Wiki', 'what-is-a-wiki', 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_metadata VALUES (46, NULL, 'How To Edit Pages', 'how-to-edit-pages', 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_metadata VALUES (49, NULL, 'Recent changes', 'system:recent-changes', 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_metadata VALUES (50, NULL, 'List all pages', 'system:list-all-pages', 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_metadata VALUES (51, NULL, 'Page Tags List', 'system:page-tags-list', 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_metadata VALUES (52, NULL, 'Page Tags', 'system:page-tags', 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_metadata VALUES (53, NULL, 'Log in', 'auth:login', 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_metadata VALUES (54, NULL, 'Create account - step 1', 'auth:newaccount', 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_metadata VALUES (58, NULL, 'Welcome on your new wiki', 'start', 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_metadata VALUES (59, NULL, 'Search this site', 'search:site', 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_metadata VALUES (60, NULL, 'Side', 'nav:side', 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_metadata VALUES (63, NULL, 'Create account - step 2', 'auth:newaccount2', 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_metadata VALUES (65, NULL, 'Congratulations', 'auth:newaccount3', 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_metadata VALUES (66, NULL, 'Manage Super Admin Account', 'admin:superadmin', NULL);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;






INSERT INTO page_revision VALUES (1, 1, 1, 1, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-24 12:16:34', 1, NULL, '', false, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (2, 2, 2, 2, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-24 12:22:02', 1, NULL, '', false, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (3, 3, 3, 3, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-24 12:27:10', 1, NULL, '', false, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (4, 4, 4, 4, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-24 12:32:21', 1, NULL, '', false, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (5, 5, 5, 5, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-25 00:35:20', 1, NULL, '', false, 2);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (6, 6, 6, 6, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-25 00:45:30', 1, NULL, '', false, 2);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (7, 7, 7, 7, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-25 01:05:59', 1, NULL, '', false, 3);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (8, 8, 8, 8, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-25 01:06:39', 1, NULL, '', false, 3);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (9, 9, 9, 9, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-25 01:08:10', 1, NULL, '', false, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (10, 10, 10, 10, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-25 01:09:41', 1, NULL, '', false, 3);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (11, 11, 11, 11, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-25 01:13:41', 1, NULL, '', false, 3);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (12, 11, 12, 11, NULL, true, false, false, false, false, false, 0, false, 1, '2008-01-25 01:14:31', 1, NULL, '', false, 3);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (13, 12, 13, 12, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-25 01:15:35', 1, NULL, '', false, 3);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (14, 13, 14, 13, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-29 00:09:59', 1, NULL, '', false, 2);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (15, 14, 15, 14, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-29 00:56:59', 1, NULL, '', false, 2);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (16, 15, 16, 15, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-29 00:57:39', 1, NULL, '', false, 2);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (17, 16, 17, 16, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-29 00:58:44', 1, NULL, '', false, 2);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (18, 17, 18, 17, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-29 00:59:14', 1, NULL, '', false, 2);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (19, 18, 19, 18, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-29 00:59:40', 1, NULL, '', false, 2);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (20, 19, 20, 19, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-29 01:01:49', 1, NULL, '', false, 2);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (21, 20, 21, 20, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-29 01:03:43', 1, NULL, '', false, 2);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (22, 21, 22, 21, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-29 01:04:52', 1, NULL, '', false, 2);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (23, 22, 23, 22, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-29 01:05:47', 1, NULL, '', false, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (24, 23, 24, 23, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-29 01:07:41', 1, NULL, '', false, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (25, 24, 25, 24, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-29 01:09:17', 1, NULL, '', false, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (26, 25, 26, 25, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-29 01:34:40', 1, NULL, '', false, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (27, 25, 26, 26, NULL, false, true, false, false, false, false, 0, false, 1, '2008-01-29 01:34:57', 1, NULL, '', false, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (28, 23, 27, 23, NULL, true, false, false, false, false, false, 0, false, 1, '2008-01-29 01:35:41', 1, NULL, '', false, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (29, 26, 28, 27, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-29 01:36:56', 1, NULL, '', false, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (30, 26, 29, 27, NULL, true, false, false, false, false, false, 0, false, 1, '2008-01-29 01:37:12', 1, NULL, '', false, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (31, 27, 30, 28, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-29 01:40:23', 1, NULL, '', false, 2);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (32, 28, 31, 29, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-29 01:40:59', 1, NULL, '', false, 2);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (33, 29, 32, 30, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-29 01:41:32', 1, NULL, '', false, 2);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (34, 30, 33, 31, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-29 01:42:10', 1, NULL, '', false, 2);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (35, 31, 34, 32, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-29 01:42:42', 1, NULL, '', false, 2);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (36, 32, 35, 33, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-29 23:29:51', 1, NULL, '', false, 2);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (37, 33, 36, 34, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-29 23:30:18', 1, NULL, '', false, 2);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (38, 34, 37, 35, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-30 08:39:24', 1, NULL, '', false, 2);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (39, 35, 38, 36, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-30 08:40:31', 1, NULL, '', false, 2);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (40, 36, 39, 37, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-30 08:43:22', 1, NULL, '', false, 2);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (41, 22, 40, 22, NULL, true, false, false, false, false, false, 0, false, 1, '2008-01-30 08:53:14', 1, NULL, '', false, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (42, 37, 41, 38, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-30 08:54:56', 1, NULL, '', false, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (43, 38, 42, 39, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-30 08:55:33', 1, NULL, '', false, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (44, 38, 43, 40, NULL, true, true, false, false, false, false, 0, false, 1, '2008-01-30 09:00:00', 1, NULL, '', false, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (45, 22, 44, 22, NULL, true, false, false, false, false, false, 0, false, 2, '2008-01-30 09:01:50', 1, NULL, '', false, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (46, 39, 45, 41, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-30 09:07:05', 1, NULL, '', false, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (47, 40, 46, 42, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-30 09:16:38', 1, NULL, '', false, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (48, 40, 47, 43, NULL, true, true, false, false, false, false, 0, false, 1, '2008-01-30 09:17:40', 1, NULL, '', false, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (49, 23, 48, 44, NULL, true, true, false, false, false, false, 0, false, 2, '2008-01-30 12:52:23', 1, NULL, '', false, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (50, 23, 49, 44, NULL, true, false, false, false, false, false, 0, false, 3, '2008-01-30 16:08:02', 1, NULL, '', false, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (51, 41, 50, 45, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-30 16:11:56', 1, NULL, '', false, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (52, 13, 51, 13, NULL, true, false, false, false, false, false, 0, false, 1, '2008-01-30 16:12:40', 1, NULL, '', false, 2);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (53, 42, 52, 46, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-30 16:12:48', 1, NULL, '', false, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (54, 43, 53, 47, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-30 16:13:32', 1, NULL, '', false, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (55, 44, 54, 48, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-30 16:14:13', 1, NULL, '', false, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (56, 45, 55, 49, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-30 16:14:41', 1, NULL, '', false, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (57, 46, 56, 50, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-30 16:15:22', 1, NULL, '', false, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (58, 47, 57, 51, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-30 16:15:56', 1, NULL, '', false, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (59, 48, 58, 52, NULL, false, false, false, false, false, true, 0, false, 0, '2008-01-30 16:16:22', 1, NULL, '', false, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (60, 49, 59, 53, NULL, false, false, false, false, false, true, 0, false, 0, '2008-08-19 16:25:58', 1, NULL, NULL, false, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (61, 50, 60, 54, NULL, false, false, false, false, false, true, 0, false, 0, '2008-08-19 16:25:58', 1, NULL, NULL, false, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (62, 51, 61, 55, NULL, false, false, false, false, false, true, 0, false, 0, '2008-08-19 16:25:58', 1, NULL, NULL, false, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (63, 52, 62, 56, NULL, false, false, false, false, false, true, 0, false, 0, '2008-08-19 16:25:58', 1, NULL, NULL, false, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (64, 22, 63, 22, NULL, true, false, false, false, false, false, 0, false, 3, '2009-02-05 23:22:00', 1, NULL, '', false, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (65, 23, 64, 57, NULL, true, true, false, false, false, false, 0, false, 4, '2009-02-05 23:26:12', 1, NULL, '', false, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (66, 23, 65, 57, NULL, true, false, false, false, false, false, 0, false, 5, '2009-02-05 23:26:49', 1, NULL, '', false, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (67, 53, 66, 58, NULL, false, false, false, false, false, true, 0, false, 0, '2009-02-05 23:28:16', 1, NULL, '', false, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (68, 54, 67, 59, NULL, false, false, false, false, false, true, 0, false, 0, '2009-02-05 23:29:17', 1, NULL, '', false, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (69, 55, 68, 60, NULL, false, false, false, false, false, true, 0, false, 0, '2009-02-05 23:29:53', 1, NULL, '', false, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (70, 56, 69, 61, NULL, false, false, false, false, false, true, 0, false, 0, '2009-02-05 23:53:26', 1, NULL, '', false, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (71, 57, 70, 62, NULL, false, false, false, false, false, true, 0, false, 0, '2009-02-05 23:54:02', 1, NULL, '', false, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (72, 58, 71, 63, NULL, false, false, false, false, false, true, 0, false, 0, '2009-02-05 23:54:30', 1, NULL, '', false, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (73, 59, 72, 64, NULL, false, false, false, false, false, true, 0, false, 0, '2009-02-05 23:56:28', 1, NULL, '', false, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (74, 60, 73, 65, NULL, false, false, false, false, false, true, 0, false, 0, '2009-02-05 23:56:54', 1, NULL, '', false, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_revision VALUES (75, 61, 74, 66, NULL, false, false, false, false, false, true, 0, false, 0, '2009-05-13 14:03:01', 0, '127.0.0.1', '', false, 1);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



INSERT INTO page_source VALUES (5, '* [[[start | Welcome page]]]
* [[[What is a Wiki Site?]]]
* [[[How to edit pages?]]]
* [[[system: join | How to join this site?]]]
* [[[system:members | Site members]]] 
* [[[system: Recent changes]]]
* [[[system: List all pages]]]
* [[[system:page-tags-list|Page Tags]]]
* [[[admin:manage|Site Manager]]]
++ Page tags
[[module TagCloud minFontSize="80%" maxFontSize="200%"  maxColor="8,8,64" minColor="100,100,128" target="system:page-tags" limit="30"]]
++ Add a new page
[[module NewPage size="15" button="new page"]]
= [[size 80%]][[[nav:side | edit this panel]]][[/size]]');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_source VALUES (6, 'According to [http://en.wikipedia.org/wiki/Wiki Wikipedia], the world largest wiki site:
> A //Wiki// ([ˈwiː.kiː] <wee-kee> or [ˈwɪ.kiː] <wick-ey>) is a type of website that allows users to add, remove, or otherwise edit and change most content very quickly and easily.
And that is it! As a part of a farm of wikis this site is a great tool that you can use to publish content, upload files, communicate and collaborate.');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_source VALUES (7, 'Admin of this Wikidot installation.');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_source VALUES (8, '[[module ManageSite]]');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_source VALUES (10, 'The profiles site is used to host user profiles. Each {{profile:username}} page contains a user-editable text that is included in the user''s profile page.
If you are viewing your own profile content page, feel free to edit it. You are the only one allowed to edit this page.');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_source VALUES (11, '* [[[start | Main page]]]
* [[[admin:manage | Manage this wiki]]]');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_source VALUES (12, 'The profiles site is used to host user profiles. Each {{profile:username}} page contains a user-editable text that is included in the user''s profile page.
* [[[start | Main page]]]
* [[[admin:manage | Manage this wiki]]]');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_source VALUES (13, 'The purpose of this wiki is to store user profiles.');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_source VALUES (14, 'If you are allowed to edit pages in this Site, simply click on //edit// button at the bottom of the page. This will open an editor with a toolbar pallette with options.
To create a link to a new page, use syntax: {{``[[[new page name]]]``}} or {{``[[[new page name | text to display]]]``}}. Follow the link (which should have a different color if page does not exist) and create a new page and edit it!
Although creating and editing pages is easy, there are a lot more options that allows creating powerful sites. Please visit [*http://www.wikidot.com/doc Documentation pages] (at wikidot.com) to learn more.');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_source VALUES (15, '[[note]]
Please change this page according to your policy (configure first using [[[admin:manage|Site Manager]]]) and remove this note.
[[/note]]
+ Who can join?
You can write here who can become a member of this site.
+ Join!
So you want to become a member of this site? Tell us why and apply now!
[[module MembershipApply]] 
Or, if you already know a "secret password", go for it!
[[module MembershipByPassword]]');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_source VALUES (16, '[[module ManageSite]]');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_source VALUES (17, '[[module TagCloud limit="200" target="system:page-tags"]]
[!--
You can edit parameters of the TagCloud module as described in http://www.wikidot.com/doc:tagcloud-module 
But if you want to keep the tag functionality working - do not remove these modules.
--]');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_source VALUES (18, '[[module SiteChanges]]');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_source VALUES (19, '+ Members:
[[module Members]]
+ Moderators
[[module Members group="moderators"]]
+ Admins
[[module Members group="admins"]]');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_source VALUES (20, '[[module Search]]
[!-- please do not remove or change this page if you want to keep the search function working --]');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_source VALUES (21, '[[div style="float:right; width: 50%;"]]
[[module TagCloud limit="200" target="system:page-tags"]]
[[/div]]
[[module PagesByTag]]
[!--
You can edit parameters of the TagCloud module as described in http://www.wikidot.com/doc:tagcloud-module 
But if you want to keep the tag functionality working - do not remove these modules.
--]');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_source VALUES (22, '[[module Pages preview="true"]]');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_source VALUES (30, '[[module ForumStart]]
[!-- please do not alter this page if you want to keep your forum working --]');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_source VALUES (31, '[[module ForumCategory]]
[!-- please do not alter this page if you want to keep your forum working --]');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_source VALUES (32, '[[module ForumThread]]
[!-- please do not alter this page if you want to keep your forum working --]');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_source VALUES (33, '[[module ForumNewThread]]
[!-- please do not alter this page if you want to keep your forum working --]');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_source VALUES (34, '[[module RecentPosts]]
[!-- please do not alter this page if you want to keep your forum working --]');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_source VALUES (35, '* [# example menu]
 * [[[submenu]]]
* [[[contact]]]
[!-- top nav menu, use only one bulleted list above --]');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_source VALUES (36, 'Profile has not been created (yet).');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_source VALUES (39, '++ If this is your first site
Then there are some things you need to know:
* You can configure all security and other settings online, using the [[[admin:manage | Site Manager]]].  When you invite other people to help build this site they don''t have access to the Site Manager unless you make them administrators like yourself.  Check out the //Permissions// section.
* Your Wikidot site has two menus, [[[nav:side | one at the side]]] called ''{{nav:side}}'', and [[[nav:top | one at the top]]] called ''{{nav:top}}''.  These are Wikidot pages, and you can edit them like any page.
* To edit a page, go to the page and click the **Edit** button at the bottom.  You can change everything in the main area of your page.  The Wikidot system is [*http://www.wikidot.org/doc easy to learn and powerful].
* You can attach images and other files to any page, then display them and link to them in the page.
* Every Wikidot page has a history of edits, and you can undo anything.  So feel secure, and experiment.
* To start a forum on your site, see the [[[admin:manage | Site Manager]]] >> //Forum//.
* The license for this Wikidot site has been set to [*http://creativecommons.org/licenses/by-sa/3.0/ Creative Commons Attribution-Share Alike 3.0 License].  If you want to change this, use the Site Manager.
* If you want to learn more, make sure you visit the [*http://www.wikidot.org/doc Documentation section at www.wikidot.org]
More information about the Wikidot project can be found at [*http://www.wikidot.org www.wikidot.org].');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_source VALUES (50, 'According to [http://en.wikipedia.org/wiki/Wiki Wikipedia], the world largest wiki site:
> A //Wiki// ([ˈwiː.kiː] <wee-kee> or [ˈwɪ.kiː] <wick-ey>) is a type of website that allows users to add, remove, or otherwise edit and change most content very quickly and easily.
And that is it! As a part of a farm of wikis this site is a great tool that you can use to publish content, upload files, communicate and collaborate.');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_source VALUES (51, 'If you are allowed to edit pages in this Site, simply click on //edit// button at the bottom of the page. This will open an editor with a toolbar pallette with options.
To create a link to a new page, use syntax: {{``[[[new page name]]]``}} or {{``[[[new page name | text to display]]]``}}. Follow the link (which should have a different color if page does not exist) and create a new page and edit it!
Although creating and editing pages is easy, there are a lot more options that allows creating powerful sites. Please visit [*http://www.wikidot.org/doc Documentation pages] (at wikidot.org) to learn more.');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_source VALUES (52, 'If you are allowed to edit pages in this Site, simply click on //edit// button at the bottom of the page. This will open an editor with a toolbar pallette with options.
To create a link to a new page, use syntax: {{``[[[new page name]]]``}} or {{``[[[new page name | text to display]]]``}}. Follow the link (which should have a different color if page does not exist) and create a new page and edit it!
Although creating and editing pages is easy, there are a lot more options that allows creating powerful sites. Please visit [*http://www.wikidot.org/doc Documentation pages] (at wikidot.org) to learn more.');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_source VALUES (55, '[[module SiteChanges]]');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_source VALUES (56, '[[module Pages preview="true"]]');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_source VALUES (57, '[[module TagCloud limit="200" target="system:page-tags"]]
[!--
You can edit parameters of the TagCloud module as described in http://www.wikidot.com/doc:tagcloud-module
But if you want to keep the tag functionality working - do not remove these modules.
--]');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_source VALUES (58, '[[div style="float:right; width: 50%;"]]
[[module TagCloud limit="200" target="system:page-tags"]]
[[/div]]
[[module PagesByTag]]
[!--
You can edit parameters of the TagCloud module as described in http://www.wikidot.com/doc:tagcloud-module
But if you want to keep the tag functionality working - do not remove these modules.
--]');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_source VALUES (59, '[[module LoginModule]]');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_source VALUES (60, '[[div class="wdlite-please-hide-this"]]
[[module CreateAccount2]]
[[/div]]
Check your Inbox for verification email and click the verification link.');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_source VALUES (66, 'Congratulations, you have successfully installed a new wiki using wdLite -- custom simplified Wikidot installation tool.
+ What to do next
++ Customize this wiki
* Your Wikidot site has two menus, [[[nav:side | one at the side]]] called ''{{nav:side}}'', and [[[nav:top | one at the top]]] called ''{{nav:top}}''.  These are Wikidot pages, and you can edit them like any page.
* To edit a page, go to the page and click the **Edit** button at the bottom.  You can change everything in the main area of your page.  The Wikidot system is [*http://www.wikidot.org/doc easy to learn and powerful].
* You can attach images and other files to any page, then display them and link to them in the page.
* Every Wikidot page has a history of edits, and you can undo anything.  So feel secure, and experiment.
* If you want to learn more, make sure you visit the [*http://www.wikidot.org/doc Documentation section at www.wikidot.org]
++ Visit Wikidot.org
Go to **[http://www.wikidot.org www.wikidot.org]** -- home of the Wikidot software -- for extra documentation, howtos, tips and support.
++ Explore more at Wikidot.com
If you want more feature rich wiki reliably hosted, consider creating a wiki within **[http://www.wikidot.com/ Wikidot.com]**');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_source VALUES (67, '[[module Search]]');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_source VALUES (68, '* [[[start | Welcome page]]]
* [[[system: Recent changes]]]
* [[[system: List all pages]]]
* [[[system:page-tags-list|Page Tags]]]
* [[[What is a Wiki?]]]
* [[[How to edit pages?]]]
++ Page tags
[[module TagCloud minFontSize="80%" maxFontSize="200%"  maxColor="8,8,64" minColor="100,100,128" target="system:page-tags" limit="30"]]
++ Add a new page
[[module NewPage size="15" button="new page"]]
= [[size 80%]][[[nav:side | edit this panel]]][[/size]]');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_source VALUES (71, '[[div class="wdlite-please-hide-this"]]
[[module CreateAccount2]]
[[/div]]
Check your Inbox for verification email and click the verification link.');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_source VALUES (73, 'You''ve just registered to this wiki.
Use the left hand menu to navigate.');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO page_source VALUES (74, '[[module ManageSuperUser]]');;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


















INSERT INTO profile VALUES (1, NULL, NULL, NULL, NULL, NULL, 'Wikidot administrator.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;






INSERT INTO site VALUES (1, 'My Wiki', 'powered by wikidot', 'www', '', 'en', NULL, NULL, true, 'start', false, false);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;






INSERT INTO site_settings VALUES (1, false, false, '', 314572800, false, 'system:join', 50, 20, true, NULL, false, false, 10485760, true);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



INSERT INTO site_super_settings VALUES (1, true);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;












INSERT INTO theme VALUES (1, 'Base', 'base', true, NULL, NULL, false, NULL, true, true, 0, NULL, 0);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO theme VALUES (2, 'Clean', 'clean', false, 1, NULL, false, NULL, true, true, 0, NULL, 0);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO theme VALUES (4, 'Flannel', 'flannel', false, 1, NULL, false, NULL, true, true, 0, NULL, 0);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO theme VALUES (6, 'Flannel Ocean', 'flannel-ocean', false, 1, NULL, false, NULL, true, true, 0, NULL, 0);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO theme VALUES (8, 'Flannel Nature', 'flannel-nature', false, 1, NULL, false, NULL, true, true, 0, NULL, 0);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO theme VALUES (10, 'Cappuccino', 'cappuccino', false, 1, NULL, false, NULL, true, true, 0, NULL, 0);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO theme VALUES (12, 'Gila', 'gila', false, 1, NULL, false, NULL, true, true, 0, NULL, 0);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO theme VALUES (14, 'Co', 'co', false, 1, NULL, false, NULL, true, true, 0, NULL, 0);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO theme VALUES (15, 'Flower Blossom', 'flower-blossom', false, 1, NULL, false, NULL, true, true, 0, NULL, 0);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO theme VALUES (16, 'Localize', 'localize', false, 1, NULL, false, NULL, true, true, 0, NULL, 0);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO theme VALUES (20, 'Webbish', 'webbish2', false, 1, NULL, false, NULL, true, true, 0, NULL, 0);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO theme VALUES (3, 'Clean - no side bar', 'clean-no-side-bar', false, 2, 2, false, NULL, false, true, 0, NULL, 0);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO theme VALUES (5, 'Flannel - no side bar', 'flannel-no-side-bar', false, 4, 4, false, NULL, false, true, 0, NULL, 0);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO theme VALUES (7, 'Flannel Ocean - no side bar', 'flannel-ocean-no-side-bar', false, 6, 6, false, NULL, false, true, 0, NULL, 0);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO theme VALUES (9, 'Flannel Nature - no side bar', 'flannel-nature-no-side-bar', false, 8, 8, false, NULL, false, true, 0, NULL, 0);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO theme VALUES (11, 'Cappuccino - no side bar', 'cappuccino-no-side-bar', false, 10, 10, false, NULL, false, true, 0, NULL, 0);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO theme VALUES (13, 'Gila - no side bar', 'gila-no-side-bar', false, 12, 12, false, NULL, false, true, 0, NULL, 0);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO theme VALUES (17, 'Localize - no side bar', 'localize-no-side-bar', false, 16, 16, false, NULL, false, true, 0, NULL, 0);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO theme VALUES (18, 'Flower Blossom - no side bar', 'flower-blossom-no-side-bar', false, 15, 15, false, NULL, false, true, 0, NULL, 0);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO theme VALUES (19, 'Co - no side bar', 'co-no-side-bar', false, 14, 14, false, NULL, false, true, 0, NULL, 0);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO theme VALUES (21, 'Webbish - no side bar', 'webbish2-no-side-bar', false, 20, 20, false, NULL, false, true, 0, NULL, 0);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO theme VALUES (22, 'Shiny', 'shiny', false, 1, NULL, false, NULL, true, true, 0, NULL, 0);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO theme VALUES (23, 'Shiny - no side bar', 'shiny-no-side-bar', false, 22, 22, false, NULL, false, true, 0, NULL, 0);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO theme VALUES (24, 'Bloo', 'bloo', false, 1, NULL, false, NULL, true, true, 0, NULL, 0);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO theme VALUES (25, 'Bloo - no side bar', 'bloo-no-side-bar', false, 24, 24, false, NULL, false, true, 0, NULL, 0);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT INTO theme VALUES (26, 'Basic', 'basic', false, 1, NULL, false, NULL, true, true, 0, NULL, 0);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;









INSERT INTO unique_string_broker VALUES (26);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;












INSERT INTO user_settings VALUES (1, true, 'a    ', '*', '*', NULL, true, true, true, 3);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;









ALTER TABLE ONLY admin
    ADD CONSTRAINT admin__site_id__user_id__unique UNIQUE (site_id, user_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY admin_notification
    ADD CONSTRAINT admin_notification_pkey PRIMARY KEY (notification_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY (admin_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY anonymous_abuse_flag
    ADD CONSTRAINT anonymous_abuse_flag_pkey PRIMARY KEY (flag_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY api_key
    ADD CONSTRAINT api_key_pkey PRIMARY KEY (key);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY category
    ADD CONSTRAINT category_pkey PRIMARY KEY (category_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY category_template
    ADD CONSTRAINT category_template_pkey PRIMARY KEY (category_template_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (comment_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY comment_revision
    ADD CONSTRAINT comment_revision_pkey PRIMARY KEY (revision_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY contact
    ADD CONSTRAINT contact__unique UNIQUE (user_id, target_user_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY contact
    ADD CONSTRAINT contact_pkey PRIMARY KEY (contact_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY domain_redirect
    ADD CONSTRAINT domain_redirect__unique UNIQUE (site_id, url);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY domain_redirect
    ADD CONSTRAINT domain_redirect_pkey PRIMARY KEY (redirect_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY email_invitation
    ADD CONSTRAINT email_invitation_pkey PRIMARY KEY (invitation_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY file
    ADD CONSTRAINT file_pkey PRIMARY KEY (file_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY files_event
    ADD CONSTRAINT files_event_pkey PRIMARY KEY (file_event_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY form_submission_key
    ADD CONSTRAINT form_submission_key_pkey PRIMARY KEY (key_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY forum_category
    ADD CONSTRAINT forum_category_pkey PRIMARY KEY (category_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY forum_group
    ADD CONSTRAINT forum_group_pkey PRIMARY KEY (group_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY forum_post
    ADD CONSTRAINT forum_post_pkey PRIMARY KEY (post_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY forum_post_revision
    ADD CONSTRAINT forum_post_revision_pkey PRIMARY KEY (revision_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY forum_settings
    ADD CONSTRAINT forum_settings_pkey PRIMARY KEY (site_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY forum_thread
    ADD CONSTRAINT forum_thread_pkey PRIMARY KEY (thread_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY front_forum_feed
    ADD CONSTRAINT front_forum_feed_pkey PRIMARY KEY (feed_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY fts_entry
    ADD CONSTRAINT fts_entry_pkey PRIMARY KEY (fts_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY global_ip_block
    ADD CONSTRAINT global_ip_block_pkey PRIMARY KEY (block_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY global_user_block
    ADD CONSTRAINT global_user_block_pkey PRIMARY KEY (block_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY ip_block
    ADD CONSTRAINT ip_block_pkey PRIMARY KEY (block_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY license
    ADD CONSTRAINT license_name_key UNIQUE (name);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY license
    ADD CONSTRAINT license_pkey PRIMARY KEY (license_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY log_event
    ADD CONSTRAINT log_event_pkey PRIMARY KEY (event_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY member
    ADD CONSTRAINT member__unique UNIQUE (site_id, user_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY member_application
    ADD CONSTRAINT member_application__unique UNIQUE (site_id, user_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY member_application
    ADD CONSTRAINT member_application_pkey PRIMARY KEY (application_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY member_invitation
    ADD CONSTRAINT member_invitation_pkey PRIMARY KEY (invitation_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY member
    ADD CONSTRAINT member_pkey PRIMARY KEY (member_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY membership_link
    ADD CONSTRAINT membership_link_pkey PRIMARY KEY (link_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY moderator
    ADD CONSTRAINT moderator__unique UNIQUE (site_id, user_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY moderator
    ADD CONSTRAINT moderator_pkey PRIMARY KEY (moderator_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY notification
    ADD CONSTRAINT notification_pkey PRIMARY KEY (notification_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY openid_entry
    ADD CONSTRAINT openid_entry_pkey PRIMARY KEY (openid_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY ozone_group
    ADD CONSTRAINT ozone_group_name_key UNIQUE (name);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY ozone_group_permission_modifier
    ADD CONSTRAINT ozone_group_permission_modifier_pkey PRIMARY KEY (group_permission_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY ozone_group
    ADD CONSTRAINT ozone_group_pkey PRIMARY KEY (group_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY ozone_lock
    ADD CONSTRAINT ozone_lock_pkey PRIMARY KEY (key);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY ozone_permission
    ADD CONSTRAINT ozone_permission_name_key UNIQUE (name);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY ozone_permission
    ADD CONSTRAINT ozone_permission_pkey PRIMARY KEY (permission_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY ozone_session
    ADD CONSTRAINT ozone_session_pkey PRIMARY KEY (session_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY ozone_user_group_relation
    ADD CONSTRAINT ozone_user_group_relation_pkey PRIMARY KEY (user_group_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY ozone_user
    ADD CONSTRAINT ozone_user_name_key UNIQUE (name);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY ozone_user_permission_modifier
    ADD CONSTRAINT ozone_user_permission_modifier_pkey PRIMARY KEY (user_permission_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY ozone_user
    ADD CONSTRAINT ozone_user_pkey PRIMARY KEY (user_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY ozone_user
    ADD CONSTRAINT ozone_user_unix_name_key UNIQUE (unix_name);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY page
    ADD CONSTRAINT page__unique UNIQUE (site_id, unix_name);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY page_abuse_flag
    ADD CONSTRAINT page_abuse_flag_pkey PRIMARY KEY (flag_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY page_compiled
    ADD CONSTRAINT page_compiled_pkey PRIMARY KEY (page_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY page_edit_lock
    ADD CONSTRAINT page_edit_lock_pkey PRIMARY KEY (lock_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY page_external_link
    ADD CONSTRAINT page_external_link_pkey PRIMARY KEY (link_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY page_inclusion
    ADD CONSTRAINT page_inclusion__unique UNIQUE (including_page_id, included_page_id, included_page_name);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY page_inclusion
    ADD CONSTRAINT page_inclusion_pkey PRIMARY KEY (inclusion_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY page_link
    ADD CONSTRAINT page_link__unique UNIQUE (from_page_id, to_page_id, to_page_name);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY page_link
    ADD CONSTRAINT page_link_pkey PRIMARY KEY (link_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY page_metadata
    ADD CONSTRAINT page_metadata_pkey PRIMARY KEY (metadata_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY page
    ADD CONSTRAINT page_pkey PRIMARY KEY (page_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY page_rate_vote
    ADD CONSTRAINT page_rate_vote_pkey PRIMARY KEY (rate_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY page_rate_vote
    ADD CONSTRAINT page_rate_vote_user_id_key UNIQUE (user_id, page_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY page_revision
    ADD CONSTRAINT page_revision_pkey PRIMARY KEY (revision_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY page_source
    ADD CONSTRAINT page_source_pkey PRIMARY KEY (source_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY page_tag
    ADD CONSTRAINT page_tag_pkey PRIMARY KEY (tag_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY petition_campaign
    ADD CONSTRAINT petition_campaign_pkey PRIMARY KEY (campaign_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY petition_signature
    ADD CONSTRAINT petition_signature_pkey PRIMARY KEY (signature_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY private_message
    ADD CONSTRAINT private_message_pkey PRIMARY KEY (message_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY private_user_block
    ADD CONSTRAINT private_user_block__unique UNIQUE (user_id, blocked_user_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY private_user_block
    ADD CONSTRAINT private_user_block_pkey PRIMARY KEY (block_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY profile
    ADD CONSTRAINT profile_pkey PRIMARY KEY (user_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY simpletodo_list
    ADD CONSTRAINT simpletodo_list__unique UNIQUE (site_id, label);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY simpletodo_list
    ADD CONSTRAINT simpletodo_list_pkey PRIMARY KEY (list_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY site_backup
    ADD CONSTRAINT site_backup_pkey PRIMARY KEY (backup_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY site
    ADD CONSTRAINT site_pkey PRIMARY KEY (site_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY site_settings
    ADD CONSTRAINT site_settings_pkey PRIMARY KEY (site_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY site_super_settings
    ADD CONSTRAINT site_super_settings_pkey PRIMARY KEY (site_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY site_tag
    ADD CONSTRAINT site_tag__unique UNIQUE (site_id, tag);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY site_tag
    ADD CONSTRAINT site_tag_pkey PRIMARY KEY (tag_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY site_viewer
    ADD CONSTRAINT site_viewer_pkey PRIMARY KEY (viewer_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY storage_item
    ADD CONSTRAINT storage_item_pkey PRIMARY KEY (item_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY theme
    ADD CONSTRAINT theme_pkey PRIMARY KEY (theme_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY theme_preview
    ADD CONSTRAINT theme_preview_pkey PRIMARY KEY (theme_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY ucookie
    ADD CONSTRAINT ucookie_pkey PRIMARY KEY (ucookie_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY user_abuse_flag
    ADD CONSTRAINT user_abuse_flag_pkey PRIMARY KEY (flag_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY user_block
    ADD CONSTRAINT user_block__unique UNIQUE (site_id, user_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY user_block
    ADD CONSTRAINT user_block_pkey PRIMARY KEY (block_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY user_karma
    ADD CONSTRAINT user_karma_pkey PRIMARY KEY (user_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY user_settings
    ADD CONSTRAINT user_settings_pkey PRIMARY KEY (user_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY watched_page
    ADD CONSTRAINT wached_page__unique UNIQUE (user_id, page_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY watched_forum_thread
    ADD CONSTRAINT watched_forum_thread__unique UNIQUE (user_id, thread_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY watched_forum_thread
    ADD CONSTRAINT watched_forum_thread_pkey PRIMARY KEY (watched_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY watched_page
    ADD CONSTRAINT watched_page_pkey PRIMARY KEY (watched_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX admin_notification__site_id__idx ON admin_notification USING btree (site_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX anonymous_abuse_flag__address__idx ON anonymous_abuse_flag USING btree (address);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX anonymous_abuse_flag__site_id__idx ON anonymous_abuse_flag USING btree (site_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX category__name__idx ON category USING btree (name);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX category__site_id__idx ON category USING btree (site_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX email_invitation__site_id ON email_invitation USING btree (site_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX email_invitation__user_id ON email_invitation USING btree (user_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX file__page_id__idx ON file USING btree (page_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX file__site_id__idx ON file USING btree (site_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX fki_forum_category__forum_post ON forum_category USING btree (last_post_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX forum_category__group_id__idx ON forum_category USING btree (group_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX forum_category__site_id__idx ON forum_category USING btree (site_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX forum_group__site_id__idx ON forum_group USING btree (site_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX forum_post__site_id__idx ON forum_post USING btree (site_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX forum_post__thread_id__idx ON forum_post USING btree (thread_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX forum_post__user_id__idx ON forum_post USING btree (user_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX forum_post_revision__post_id__idx ON forum_post_revision USING btree (post_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX forum_thread__category_id__idx ON forum_thread USING btree (category_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX forum_thread__last_post_id__idx ON forum_thread USING btree (last_post_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX forum_thread__page_id__idx ON forum_thread USING btree (page_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX forum_thread__site_id__idx ON forum_thread USING btree (site_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX forum_thread__user_id__idx ON forum_thread USING btree (user_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX front_forum_feed__site_id__idx ON front_forum_feed USING btree (site_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX fts_entry__forum_thread__idx ON fts_entry USING btree (thread_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX fts_entry__page_id__idx ON fts_entry USING btree (page_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX fts_entry__site_id__idx ON fts_entry USING btree (site_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX fts_entry__vector__idx ON fts_entry USING gist (vector);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX ip_block__ip__idx ON ip_block USING btree (ip);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX ip_block__site_id__idx ON ip_block USING btree (site_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX log_event__site_id__idx ON log_event USING btree (site_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX log_event__type__idx ON log_event USING btree (type);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE UNIQUE INDEX member__site_id_user_id__idx ON member USING btree (site_id, user_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX member_application__site_id__idx ON member_application USING btree (site_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX member_application__user_id__idx ON member_application USING btree (user_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX member_invitation__site_id__idx ON member_invitation USING btree (site_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX member_invitation__user_id__idx ON member_invitation USING btree (user_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX moderator__site_id__idx ON moderator USING btree (site_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX moderator__user_id__idx ON moderator USING btree (user_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX notification__user_id__idx ON notification USING btree (user_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX ozone_session__user_id__idx ON ozone_session USING btree (user_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE UNIQUE INDEX ozone_user__name__idx ON ozone_user USING btree (name);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE UNIQUE INDEX ozone_user__nick_name__idx ON ozone_user USING btree (nick_name);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE UNIQUE INDEX ozone_user__unix_name__idx ON ozone_user USING btree (unix_name);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX page__category_id__idx ON page USING btree (category_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX page__parent_page_id ON page USING btree (parent_page_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX page__revision_id__idx ON page USING btree (revision_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX page__site_id__idx ON page USING btree (site_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX page__unix_name__idx ON page USING btree (unix_name);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX page_abuse_flag__site_id__idx ON page_abuse_flag USING btree (site_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX page_edit_lock__page_id__idx ON page_edit_lock USING btree (page_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX page_edit_lock__site_id_page_unix_name ON page_edit_lock USING btree (site_id, page_unix_name);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX page_edit_lock__user_id__idx ON page_edit_lock USING btree (user_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX page_inclusion__site_id ON page_inclusion USING btree (site_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX page_link__site_id ON page_link USING btree (site_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX page_revision__page_id__idx ON page_revision USING btree (page_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX page_revision__site_id__idx ON page_revision USING btree (site_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX page_revision__user_id__idx ON page_revision USING btree (user_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX page_tag__page_id__idx ON page_tag USING btree (page_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX page_tag__site_id__idx ON page_tag USING btree (site_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX private_message__from_user_id__idx ON private_message USING btree (from_user_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX private_message__to_user_id__idx ON private_message USING btree (to_user_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX ront_forum_feed__page_id__idx ON front_forum_feed USING btree (page_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX simpletodo_list__site_id__idx ON simpletodo_list USING btree (site_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX site__custom_domain__idx ON site USING btree (custom_domain);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE UNIQUE INDEX site__unix_name__idx ON site USING btree (unix_name);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX site__visible__private__idx ON site USING btree (visible, private);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX ucookie__session_id_idx ON ucookie USING btree (session_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX ucookie__site_id ON ucookie USING btree (site_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX user_abuse_flag__site_id__idx ON user_abuse_flag USING btree (site_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE INDEX user_block__site_id__idx ON user_block USING btree (site_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO ozone_user DO SELECT currval('ozone_user_user_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO ozone_group DO SELECT currval('ozone_group_group_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO ozone_permission DO SELECT currval('ozone_permission_permission_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO ozone_user_group_relation DO SELECT currval('ozone_user_group_relation_user_group_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO ozone_user_permission_modifier DO SELECT currval('ozone_user_permission_modifier_user_permission_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO ozone_group_permission_modifier DO SELECT currval('ozone_group_permission_modifier_group_permission_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO site DO SELECT currval('site_site_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO site_tag DO SELECT currval('site_tag_tag_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO category DO SELECT currval('category_category_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO page DO SELECT currval('page_page_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO page_revision DO SELECT currval('page_revision_revision_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO page_source DO SELECT currval('page_source_source_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO page_metadata DO SELECT currval('page_metadata_metadata_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO fts_entry DO SELECT currval('fts_entry_fts_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO file DO SELECT currval('file_file_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO files_event DO SELECT currval('files_event_file_event_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO page_link DO SELECT currval('page_link_link_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO page_inclusion DO SELECT currval('page_inclusion_inclusion_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO member DO SELECT currval('member_member_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO admin DO SELECT currval('admin_admin_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO moderator DO SELECT currval('moderator_moderator_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO member_application DO SELECT currval('member_application_application_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO member_invitation DO SELECT currval('member_invitation_invitation_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO page_edit_lock DO SELECT currval('page_edit_lock_lock_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO theme DO SELECT currval('theme_theme_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO license DO SELECT currval('license_license_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO notification DO SELECT currval('notification_notification_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO private_message DO SELECT currval('private_message_message_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO global_ip_block DO SELECT currval('global_ip_block_block_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO ip_block DO SELECT currval('ip_block_block_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO global_user_block DO SELECT currval('global_user_block_block_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO user_block DO SELECT currval('user_block_block_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO private_user_block DO SELECT currval('private_user_block_block_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO watched_page DO SELECT currval('watched_page_watched_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO watched_forum_thread DO SELECT currval('watched_forum_thread_watched_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO page_abuse_flag DO SELECT currval('page_abuse_flag_flag_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO user_abuse_flag DO SELECT currval('user_abuse_flag_flag_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO anonymous_abuse_flag DO SELECT currval('anonymous_abuse_flag_flag_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO admin_notification DO SELECT currval('admin_notification_notification_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO forum_group DO SELECT currval('forum_group_group_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO forum_category DO SELECT currval('forum_category_category_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO forum_thread DO SELECT currval('forum_thread_thread_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO forum_post DO SELECT currval('forum_post_post_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO forum_post_revision DO SELECT currval('forum_post_revision_revision_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO front_forum_feed DO SELECT currval('front_forum_feed_feed_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO contact DO SELECT currval('contact_contact_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO page_rate_vote DO SELECT currval('page_rate_vote_rate_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO email_invitation DO SELECT currval('email_invitation_invitation_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO site_backup DO SELECT currval('site_backup_backup_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO domain_redirect DO SELECT currval('domain_redirect_redirect_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO site_viewer DO SELECT currval('site_viewer_viewer_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO openid_entry DO SELECT currval('openid_entry_openid_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO membership_link DO SELECT currval('membership_link_link_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO petition_campaign DO SELECT currval('petition_campaign_campaign_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO petition_signature DO SELECT currval('petition_signature_signature_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO simpletodo_list DO SELECT currval('simpletodo_list_list_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO comment DO SELECT currval('comment_comment_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO comment_revision DO SELECT currval('comment_revision_revision_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CREATE RULE get_pkey_on_insert AS ON INSERT TO page_external_link DO SELECT currval('page_external_link_link_id_seq'::regclass) AS id;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY admin
    ADD CONSTRAINT admin__ozone_user FOREIGN KEY (user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY admin
    ADD CONSTRAINT admin__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY admin_notification
    ADD CONSTRAINT admin_notification__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY anonymous_abuse_flag
    ADD CONSTRAINT anonymous_abuse_flag__ozone_user FOREIGN KEY (user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY anonymous_abuse_flag
    ADD CONSTRAINT anonymous_abuse_flag__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY category
    ADD CONSTRAINT category__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY contact
    ADD CONSTRAINT contact__ozone_user__tagret_user_id FOREIGN KEY (target_user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY contact
    ADD CONSTRAINT contact__ozone_user__user_id FOREIGN KEY (user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY domain_redirect
    ADD CONSTRAINT domain_redirect__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY email_invitation
    ADD CONSTRAINT email_inviation__ozone_user FOREIGN KEY (user_id) REFERENCES ozone_user(user_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY email_invitation
    ADD CONSTRAINT email_invitation__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY file
    ADD CONSTRAINT file__page FOREIGN KEY (page_id) REFERENCES page(page_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY file
    ADD CONSTRAINT file__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE SET NULL;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY file
    ADD CONSTRAINT file__user FOREIGN KEY (user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE SET NULL;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY forum_category
    ADD CONSTRAINT forum_category__forum_group FOREIGN KEY (group_id) REFERENCES forum_group(group_id) ON UPDATE CASCADE ON DELETE RESTRICT;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY forum_category
    ADD CONSTRAINT forum_category__forum_post FOREIGN KEY (last_post_id) REFERENCES forum_post(post_id) ON UPDATE CASCADE ON DELETE SET NULL;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY forum_category
    ADD CONSTRAINT forum_category__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY forum_group
    ADD CONSTRAINT forum_group__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY forum_post
    ADD CONSTRAINT forum_post__ozone_user FOREIGN KEY (user_id) REFERENCES ozone_user(user_id);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY forum_post
    ADD CONSTRAINT forum_post__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY forum_settings
    ADD CONSTRAINT forum_settings__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY forum_thread
    ADD CONSTRAINT forum_thread__forum_category FOREIGN KEY (category_id) REFERENCES forum_category(category_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY forum_thread
    ADD CONSTRAINT forum_thread__ozone_user FOREIGN KEY (user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE SET NULL;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY forum_thread
    ADD CONSTRAINT forum_thread__page FOREIGN KEY (page_id) REFERENCES page(page_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY forum_thread
    ADD CONSTRAINT forum_thread__post FOREIGN KEY (last_post_id) REFERENCES forum_post(post_id) ON UPDATE CASCADE ON DELETE SET NULL;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY forum_thread
    ADD CONSTRAINT forum_thread__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY front_forum_feed
    ADD CONSTRAINT front_forum_feed__page FOREIGN KEY (page_id) REFERENCES page(page_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY front_forum_feed
    ADD CONSTRAINT front_forum_feed__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY fts_entry
    ADD CONSTRAINT fts_entry__forum_thread FOREIGN KEY (thread_id) REFERENCES forum_thread(thread_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY fts_entry
    ADD CONSTRAINT fts_entry__page FOREIGN KEY (page_id) REFERENCES page(page_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY fts_entry
    ADD CONSTRAINT fts_entry__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY ip_block
    ADD CONSTRAINT ip_block__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY log_event
    ADD CONSTRAINT log_event__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE SET NULL;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY member
    ADD CONSTRAINT member__ozone_user FOREIGN KEY (user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY member
    ADD CONSTRAINT member__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY member_application
    ADD CONSTRAINT member_application__ozone_user FOREIGN KEY (user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY member_application
    ADD CONSTRAINT member_application__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY member_invitation
    ADD CONSTRAINT member_invitation__ozone_user__by_user_id FOREIGN KEY (by_user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY member_invitation
    ADD CONSTRAINT member_invitation__ozone_user__user_id FOREIGN KEY (user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY member_invitation
    ADD CONSTRAINT member_invitation__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY moderator
    ADD CONSTRAINT moderator__ozone_user FOREIGN KEY (user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY moderator
    ADD CONSTRAINT moderator__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY notification
    ADD CONSTRAINT notification__ozone_user FOREIGN KEY (user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY ozone_session
    ADD CONSTRAINT ozone_session__ozone_user FOREIGN KEY (user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY page
    ADD CONSTRAINT page__parent_page FOREIGN KEY (parent_page_id) REFERENCES page(page_id) ON UPDATE CASCADE ON DELETE SET NULL;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY page
    ADD CONSTRAINT page__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY page_abuse_flag
    ADD CONSTRAINT page_abuse_flag__ozone_user FOREIGN KEY (user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY page_abuse_flag
    ADD CONSTRAINT page_abuse_flag__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY page_compiled
    ADD CONSTRAINT page_compiled__page FOREIGN KEY (page_id) REFERENCES page(page_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY page_edit_lock
    ADD CONSTRAINT page_edit_lock__ozone_user FOREIGN KEY (user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY page_edit_lock
    ADD CONSTRAINT page_edit_lock__page FOREIGN KEY (page_id) REFERENCES page(page_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY page_inclusion
    ADD CONSTRAINT page_inclusion__page__included_page_id FOREIGN KEY (included_page_id) REFERENCES page(page_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY page_inclusion
    ADD CONSTRAINT page_inclusion__page__including_page_id FOREIGN KEY (including_page_id) REFERENCES page(page_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY page_link
    ADD CONSTRAINT page_link__page__from_page_id FOREIGN KEY (from_page_id) REFERENCES page(page_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY page_link
    ADD CONSTRAINT page_link__page__to_page_id FOREIGN KEY (to_page_id) REFERENCES page(page_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY page_rate_vote
    ADD CONSTRAINT page_rate_vote__ozone_user FOREIGN KEY (user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY page_rate_vote
    ADD CONSTRAINT page_rate_vote__page FOREIGN KEY (page_id) REFERENCES page(page_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY page_tag
    ADD CONSTRAINT page_tag__page FOREIGN KEY (page_id) REFERENCES page(page_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY site_viewer
    ADD CONSTRAINT page_viewer__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY private_message
    ADD CONSTRAINT private_message__ozone_user__from_user_id FOREIGN KEY (from_user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY private_message
    ADD CONSTRAINT private_message__ozone_user__to_user_id FOREIGN KEY (to_user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY private_user_block
    ADD CONSTRAINT private_user_block__ozone_user__blocked_user_id FOREIGN KEY (blocked_user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY private_user_block
    ADD CONSTRAINT private_user_block__ozone_user__user_id FOREIGN KEY (user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY profile
    ADD CONSTRAINT profile__ozone_user FOREIGN KEY (user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY simpletodo_list
    ADD CONSTRAINT simpletedo_list__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY site_backup
    ADD CONSTRAINT site_backup__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY site_settings
    ADD CONSTRAINT site_settings__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY site_super_settings
    ADD CONSTRAINT site_super_settings__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY site_tag
    ADD CONSTRAINT site_tag__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY site_viewer
    ADD CONSTRAINT site_viewer__ozone_user FOREIGN KEY (user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY theme
    ADD CONSTRAINT theme__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY ucookie
    ADD CONSTRAINT ucookie__ozone_session FOREIGN KEY (session_id) REFERENCES ozone_session(session_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY ucookie
    ADD CONSTRAINT ucookie__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY user_abuse_flag
    ADD CONSTRAINT user_abuse_flag__ozone_user__target_user_id FOREIGN KEY (user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY user_abuse_flag
    ADD CONSTRAINT user_abuse_flag__ozone_user__user_id FOREIGN KEY (user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY user_abuse_flag
    ADD CONSTRAINT user_abuse_flag__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY user_block
    ADD CONSTRAINT user_block__ozone_user FOREIGN KEY (user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY user_block
    ADD CONSTRAINT user_block__site FOREIGN KEY (site_id) REFERENCES site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY user_settings
    ADD CONSTRAINT user_settings__ozone_user FOREIGN KEY (user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY watched_forum_thread
    ADD CONSTRAINT wached_forum_thread__ozone_user FOREIGN KEY (user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY watched_forum_thread
    ADD CONSTRAINT watched_forum_thread__forum_thread FOREIGN KEY (thread_id) REFERENCES forum_thread(thread_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY watched_page
    ADD CONSTRAINT watched_page__ozone_user FOREIGN KEY (user_id) REFERENCES ozone_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



ALTER TABLE ONLY watched_page
    ADD CONSTRAINT watched_page__page FOREIGN KEY (page_id) REFERENCES page(page_id) ON UPDATE CASCADE ON DELETE CASCADE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



REVOKE ALL ON SCHEMA public FROM PUBLIC;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
REVOKE ALL ON SCHEMA public FROM postgres;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GRANT ALL ON SCHEMA public TO postgres;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GRANT ALL ON SCHEMA public TO PUBLIC;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



