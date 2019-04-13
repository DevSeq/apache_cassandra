create schema if not exists killrvideo;

create table if not exists killrvideo.users
(
    id uuid not null constraint user_pk primary key,
    first         varchar default 100 not null,
    last          varchar default 100 not null,
    email varchar default 150 not null,
    password varchar default 100 not null,
    created_date timestamp
);

create table if not exists killrvideo.videos
(
    id uuid not null constraint video_pk primary key,
    userid uuid not null
        constraint videos_users_fk
        references killrvideo.users
        on update cascade on delete set default,
    name varchar default 100 not null,
    description varchar default 500 not null,
    location varchar default 100 not null,
    location_type int not null,
    added_date timestamp not null
);

create table if not exists killrvideo.video_event
(
    id uuid not null constraint video_event_pk primary key,
    userid uuid not null
        constraint video_event_users_fk
        references killrvideo.users
        on update cascade on delete set default,
    videoid uuid not null
        constraint video_event_videos_fk
        references killrvideo.videos
        on update cascade on delete set default,
    event varchar default 255 not null,
    event_timestamp timestamp,
    video_timestamp timestamp
);

create table if not exists killrvideo.comments
(
    id uuid not null constraint comment_pk primary key,
    userid uuid not null
        constraint comments_users_fk
        references killrvideo.users
        on update cascade on delete set default,
    videoid uuid not null
        constraint comments_videos_fk
        references killrvideo.videos
        on update cascade on delete set default,
    comment_text varchar default 500 not null ,
    comment_time timestamp not null
);

create table if not exists killrvideo.tags
(
    id uuid not null constraint tag_pk primary key ,
    tag varchar default 255 not null
);

create table if not exists killrvideo.videos_tags
(
    videoid uuid not null
        constraint videos_videos_fk
        references killrvideo.videos
        on update cascade on delete set default ,
    tagid uuid not null
        constraint videos_tags_fk
        references killrvideo.tags
        on update cascade on delete set default
);

create table if not exists killrvideo.preview_thumbnails
(
     videoid uuid not null
        constraint preview_thumbnails_videos_fk
        references killrvideo.videos
        on update cascade on delete set default ,
    position varchar default 20,
    url varchar default 255,
    PRIMARY KEY(videoid, position)
);

create table if not exists killrvideo.video_metadata
(
    id uuid not null constraint video_metadata_pk primary key,
    height float not null ,
    width float not null ,
    video_bit_rate varchar(20),
    encoding varchar(20)
);

create table if not exists killrvideo.video_video_metadata
(
     videoid uuid not null
        constraint video_video_fk
        references killrvideo.videos
        on update cascade on delete set default ,
     video_metadataid uuid not null
        constraint video_metadata_fk
        references killrvideo.video_metadata
        on update cascade on delete set default
);
