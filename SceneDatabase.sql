drop table if exists events_users cascade;
drop table if exists collaborators_events cascade;
drop table if exists artist_group cascade;
drop table if exists artist_event cascade;
drop table if exists job_assignments cascade;
drop table if exists events cascade;
drop table if exists rooms cascade;
drop table if exists artist cascade;
drop table if exists collaborators cascade;
drop table if exists users cascade;

create table rooms
(
    id_room      int primary key generated always as identity,
    name         varchar(50) not null,
    localisation varchar(50) not null,
    capacity     smallint    not null check ( capacity > 0 )
);


create table events
(
    id_event    int primary key generated always as identity,
    id_room     int            not null references rooms (id_room),
    started_at  timestamp      not null,
    finished_at timestamp      not null,
    price       decimal(10, 2) not null check (price >= 0),
    image       varchar(255)   not null,
    description varchar(255)   not null,
    constraint check_dates check (finished_at > started_at)
);

alter table events
    add column name_event varchar(255) null;



create table collaborators
(
    id_collaborators int primary key generated always as identity,
    name             varchar(50) not null,
    surname          varchar(50) not null,
    telephone        varchar(20) not null

);


create table job_assignments
(
    id_assignment    int primary key generated always as identity,
    role_name        varchar(50) not null,
    id_collaborators int         not null references collaborators (id_collaborators)
);

create table artist
(
    id_artist   int primary key generated always as identity,
    name        varchar(50) not null,
    surname     varchar(50) not null,
    scene_name  varchar(50) not null,
    music_genre varchar(30) not null,
    social      text,
    description varchar(255)
);


create table artist_event
(
    id_artist int not null references artist (id_artist),
    id_event  int not null references events (id_event),
    primary key (id_artist, id_event)
);

create table artist_group
(
    id_artist  int  not null references artist (id_artist),
    group_name text not null unique,
    primary key (id_artist, group_name)
);

create table collaborators_events
(
    id_collaborators int not null references collaborators (id_collaborators),
    id_event         int not null references events (id_event),
    primary key (id_collaborators, id_event)
);

create table users
(
    id_user       int primary key generated always as identity,
    name          varchar(50)  not null,
    surname       varchar(50)  not null,
    email         varchar(255) not null unique,
    password_hash text         not null,
    created_at    timestamp    not null default now()

);

create table events_users
(
    id_user  int not null references users (id_user),
    id_event int not null references events (id_event),
    paid_at  timestamp default now(),
    primary key (id_user, id_event)
);

-- Inserts to bring ROOMS to 10 total
insert into rooms (name, localisation, capacity)
values ('The Gallery', 'Upper Mezzanine', 30),
       ('Green Room', 'Backstage Access', 10),
       ('Conference Hall A', 'Business Center, Level 1', 500),
       ('Lecture Room 101', 'Academic Building', 90),
       ('Workshop Bay', 'Basement 3', 70),
       ('VIP Lounge', 'Exclusive Area', 20),
       ('Screening Room', 'Lower Level', 120),
       ('Main Auditorium', 'Ground Floor, East Wing', 800),
       ('The Studio', 'Level 2, West Side', 150),
       ('Rooftop Terrace', 'Top Floor, Outdoor Area', 50);

-- Inserts to bring EVENTS to 10 total (referencing Room IDs 1-10)
insert into events (id_room, started_at, finished_at, price, image, description, name_event)
values (8,
        '2026-03-15 19:00:00',
        '2026-03-15 23:30:00',
        45.00,
        '/images/concert_spring.jpg',
        'Annual Spring Music Festival featuring top rock bands.',
        'whatever'),
       (9,
        '2026-04-01 10:00:00',
        '2026-04-01 17:00:00',
        150.00,
        '/images/design_workshop.jpg',
        'Full-day UX/UI design workshop.',
        'whateodqiwjoqw'),
       (10,
        '2026-06-20 18:30:00',
        '2026-06-20 22:00:00',
        25.50,
        '/images/jazz_night.jpg',
        'Intimate jazz session with local artists.',
        'whatever'),
       (1,
        '2026-07-10 17:00:00',
        '2026-07-10 19:00:00',
        10.00,
        '/images/art_exhibit.jpg',
        'Opening night for contemporary art.',
        'thomas'),
       (2,
        '2026-08-05 13:00:00',
        '2026-08-05 15:00:00',
        0.00,
        '/images/meet_greet.jpg',
        'Artist and crew meet and greet session.',
        'qpwdjqwojdp'),
       (3,
        '2026-09-12 09:00:00',
        '2026-09-12 17:00:00',
        250.00,
        '/images/tech_summit.jpg',
        'Annual Tech Industry Summit.',
        'oqwhdoiqwdjqw'),
       (4,
        '2026-10-25 14:00:00',
        '2026-10-25 16:00:00',
        5.00,
        '/images/guest_lecture.jpg',
        'Lecture on sustainable engineering.',
        'whatever'),
       (5,
        '2026-11-18 11:00:00',
        '2026-11-18 16:00:00',
        75.00,
        '/images/pottery_workshop.jpg',
        'Hands-on pottery making class.',
        'whatever'),
       (6,
        '2026-12-31 21:00:00',
        '2027-01-01 02:00:00',
        199.99,
        '/images/new_years_eve.jpg',
        'Exclusive New Years Eve party.',
        'whatever'),
       (7,
        '2027-01-15 19:30:00',
        '2027-01-15 21:30:00',
        12.50,
        '/images/short_film.jpg',
        'Independent short film screening.',
        'whatever');

-- Inserts to bring COLLABORATORS to 10 total
insert into collaborators (name, surname, telephone)
values ('Alice', 'Smith', '555-0101'),
       ('Bob', 'Johnson', '555-0102'),
       ('Charlie', 'Brown', '555-0103'),
       ('Diana', 'Evans', '555-0104'),
       ('Ethan', 'Fisher', '555-0105'),
       ('Fiona', 'Grant', '555-0106'),
       ('Gary', 'Hill', '555-0107'),
       ('Hannah', 'Ivy', '555-0108'),
       ('Ian', 'Jones', '555-0109'),
       ('Jackie', 'King', '555-0110');

-- Inserts to bring JOB_ASSIGNMENTS to 10 total
insert into job_assignments (role_name, id_collaborators)
values ('Event Manager', 1),
       ('Security Coordinator', 1),
       ('Technical Support', 2),
       ('Ticket Counter', 3),
       ('Technical Support', 3),
       ('Venue Coordinator', 4),
       ('Marketing Lead', 5),
       ('Catering Staff', 6),
       ('Box Office Lead', 7),
       ('Cleaning Crew', 8);

-- Inserts to bring ARTIST to 10 total
insert into artist (name, surname, scene_name, music_genre, social, description)
values ('David',
        'Lee',
        'The Vinyl Prophet',
        'Classic Rock',
        '{"instagram": "vinylprophet_official"}',
        'A high-energy rock band known for 80s throwbacks.'),
       ('Eve',
        'Martinez',
        'E-Vibe',
        'Electronic/Ambient',
        '{"twitter": "@evibe_music", "spotify": "evibe_channel"}',
        'A solo artist creating atmospheric soundscapes.'),
       ('Frank',
        'Gotti',
        'F-Jazz Trio',
        'Jazz',
        NULL,
        'A smooth jazz collective.'),

       ('Grace',
        'Hall',
        'G-Hype',
        'Hip Hop',
        '{"youtube": "ghype_official"}',
        'Rising star in the underground hip hop scene.'),
       ('Henry',
        'Ivy',
        'The Maestro',
        'Classical',
        NULL,
        'A renowned concert pianist.'),
       ('Ivy',
        'Jones',
        'The Silent Observer',
        'Mime/Performance',
        '{"website": "silentobserver.com"}',
        'Physical comedian and mime artist.'),
       ('Jake',
        'Kelly',
        'JK',
        'Indie Pop',
        '{"instagram": "jk_songs"}',
        'A singer-songwriter with catchy tunes.'),
       ('Kelly',
        'Lopez',
        'KL Crew',
        'Salsa',
        '{"facebook": "klcrewsalsa"}',
        'Large salsa and latin dance ensemble.'),
       ('Liam',
        'Moore',
        'L-Dubs',
        'Dubstep',
        NULL,
        'DJ known for heavy bass drops.'),
       ('Mia',
        'Nash',
        'M N Duo',
        'Folk',
        '{"bandcamp": "mnduo"}',
        'A soft acoustic folk duo.');


-- Each row is a unique pair (Artist, Event)
-- This respects the Primary Key (id_artist, id_event)
-- 1. Clear old links
truncate table artist_event cascade;

-- 2. Insert unbalanced data
insert into artist_event (id_artist, id_event)
values
    -- Artist 1: Very busy (6 events)
    (1, 1),
    (1, 2),
    (1, 3),
    (1, 4),
    (1, 5),
    (1, 6),
    -- Artist 2: Busy (4 events)
    (2, 1),
    (2, 2),
    (2, 7),
    (2, 8),
    -- Artist 3: Moderate (3 events)
    (3, 3),
    (3, 4),
    (3, 9),
    -- Artist 4: Only 1 event
    (4, 10),
    -- ARTIST 5: SKIPPED (0 events)

    -- Artist 6: Shared events (3 events)
    (6, 1),
    (6, 2),
    (6, 3),
    -- Artist 7: (2 events)
    (7, 7),
    (7, 10),
    -- ARTIST 8: SKIPPED (0 events)

    -- Artist 9: (3 events)
    (9, 9),
    (9, 1),
    (9, 2),
    -- Artist 10: (2 events)
    (10, 10),
    (10, 5)
on conflict (id_artist, id_event) do nothing;

-- Inserts to bring ARTIST_GROUP to 10 total
insert into artist_group (id_artist, group_name)
values (1, 'The Rock Legends'),
       (2, 'Future Sound Collective'),
       (2, 'Solo Performers Guild'),
       (3, 'The Jazz Collective'),
       (4, 'Rhyme Masters'),
       (5, 'Soloists International'),
       (7, 'Indie Artists Network'),
       (8, 'Global Dance Federation'),
       (9, 'Electronic Music Alliance'),
       (10, 'Acoustic Sessions');

-- Inserts to bring COLLABORATORS_EVENTS to 10 total
insert into collaborators_events (id_collaborators, id_event)
values (1, 1),
       (2, 1),
       (3, 3),
       (4, 4),
       (5, 5),
       (6, 6),
       (7, 7),
       (8, 8),
       (9, 9),
       (10, 10);

-- Inserts to bring USERS to 10 total
insert into users (name, surname, email, password_hash)
values ('George',
        'Harrison',
        'g.harrison@example.com',
        'hashed_secret_value_123'),
       ('Ringo',
        'Starr',
        'r.starr@example.com',
        'another_secret_hash_value'),
       ('Paul',
        'McCartney',
        'p.mccartney@example.com',
        'hash_pmc_456'),
       ('John',
        'Lennon',
        'j.lennon@example.com',
        'hash_jl_789'),
       ('Yoko',
        'Ono',
        'y.ono@example.com',
        'hash_yoko_111'),
       ('Mick',
        'Jagger',
        'm.jagger@example.com',
        'hash_mick_222'),
       ('Keith',
        'Richards',
        'k.richards@example.com',
        'hash_keith_333'),
       ('Freddie',
        'Mercury',
        'f.mercury@example.com',
        'hash_fred_444'),
       ('Brian',
        'May',
        'b.may@example.com',
        'hash_brian_555'),
       ('Roger',
        'Taylor',
        'r.taylor@example.com',
        'hash_roger_666');


insert into events_users (id_user, id_event, paid_at)
values (1, 1, '2025-11-27 15:30:00'),
       (2, 1, '2025-11-28 08:00:00'),
       (2, 3, '2025-11-28 08:05:00'),
       (3, 1, '2025-11-29 09:00:00'),
       (4, 2, '2025-11-29 10:00:00'),
       (5, 3, '2025-11-29 11:00:00'),
       (6, 4, '2025-11-29 12:00:00'),
       (7, 6, '2025-11-29 13:00:00'),
       (8, 7, '2025-11-29 14:00:00'),
       (9, 9, '2025-11-29 15:00:00');







/*

Here is the logical path your query needs to follow:
rooms -> events (via id_room) -> artist_event (via id_event) -> artist (via id_artist).
*/


/*
select artist.name,
       count(events.id_event)
from artist
    join artist_event on artist.id_artist = artist_event.id_artist
group by artist.name, rooms.name
order by count(rooms.id_room);
*/

select artist.name, count(events.id_event)
from artist
         join artist_event on artist.id_artist = artist_event.id_artist
         join events on artist_event.id_event = events.id_event
group by artist.name, events.name_event
order by count(events.id_event) desc;



-- artists -> artists_event -> events

select r.name as room_name,
       a.name as artist_name
from rooms r
         join events e on r.id_room = e.id_room
         join artist_event ae on e.id_event = ae.id_event
         join artist a on ae.id_artist = a.id_artist
group by r.name, a.name
order by r.name, a.name;


select events.name_event, count(*) from events
    left join events_users on events_users.id_event = events.id_event
group by events.name_event;









-- rooms -> events -> artist_event -> artist



begin;
EXPLAIN ANALYZE
SELECT *
FROM rooms;
EXPLAIN ANALYZE

SELECT *
FROM events;
rollback;


SELECT *
FROM rooms;

SELECT *
FROM events;

SELECT *
FROM collaborators;

SELECT *
FROM job_assignments;

SELECT name
FROM artist;

SELECT *
FROM artist_event;

SELECT *
FROM artist_group;

SELECT *
FROM collaborators_events;

SELECT *
FROM users;

SELECT *
FROM events_users;