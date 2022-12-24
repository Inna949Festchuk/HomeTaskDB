-- Сущность Жанр
create table if not exists Genre(
	genre_id serial primary key,
	name_genre varchar(20) not null UNIQUE -- Уникальность значений
);

-- Пробуем добавить строку Жанр 
--insert into Genre(name_genre) values('three Genre')

-- Сущность Исполнитель
create table if not exists Performer(
	performer_id serial primary key,
	name_performer varchar(40) not null
);

-- Пробуем добавить строку Performer 
--insert into Performer(name_performer) values('two Performer')

-- Кординальность N:M
-- Исполнители могут петь в разных жанрах, 
-- Как и одному жанру могут принадлежать несколько исполнителей
create table if not exists GenrePerformer(
	genre_field integer references Genre(genre_id),
	performer_field integer references Performer(performer_id),
	constraint pk primary key (genre_field, performer_field)
);

-- Пробуем связать Жанры и Исполнителей N:M
--insert into GenrePerformer(genre_field, performer_field) values(3, 2)

-- Сущность Альбом
create table if not exists Album(
	album_id serial primary key,
	name_album varchar(40) not null,
	date_album date not null CHECK(date_album > make_date(2000, 1, 1)) -- Ограничение даты альбома 
);

-- Пробуем добавить строку в Альбом 
--insert into Album(name_album, date_album) values('one Album', '2000-1-2')

-- Кординальность N:M
-- Альбом могут выпустить несколько исполнителей вместе, 
-- Как и исполнитель может принимать участие во множестве альбомов
create table if not exists PerformerAlbum(
	album_field integer references Album(album_id),
	performer_field integer references Performer(performer_id),
	constraint pk2 primary key (album_field, performer_field)
);

-- Сущность Трек. Кординальность 1:M. Трек принадлежит строго одному альбому
create table if not exists Track(
	track_id serial primary key,
	name_track varchar(200) not null,
	duratioon_track time(1) not null,
	album_field integer not null references Album(album_id)
);

-- Сущность Сборник
create table if not exists Collection(
	cool_id serial primary key,
	name_cool varchar(60) not null,
	date_cool date not null
);

-- Кординальность N:M
-- В Сборник входят различные Треки из разных Альбомов.
create table if not exists TrackCollection(
	track_field integer references Track(track_id),
	cool_field integer references Collection(cool_id),
	constraint pk3 primary key (track_field, cool_field)
);


