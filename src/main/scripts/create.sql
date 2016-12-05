create sequence hibernate_sequence minvalue 10000;

create table wallets(
	wallet_id varchar(255) primary key
);

create table users(
	user_id integer primary key,
	username varchar(255) not null unique,
	email varchar(255) not null unique,
	name varchar(255),
	password varchar(255) not null,
	phone varchar(255) not null,
	enabled boolean not null default 't',
	wallet_id varchar(255) not null references wallets(wallet_id)
);

create table addressbook(
	address_book_id integer not null primary key,
	name varchar(255),
	owner_id integer not null references users(user_id),
	contact_id integer not null references users(user_id)
);

create table authorities (
    user_id bigint not null references users(user_id),
    role    varchar(255)
);

create table addresses(
	address_id integer primary key,
	address varchar(255),
	is_primary boolean not null default 'f',
	label varchar(255),
	USD integer not null default 0,
	bitcoins integer not null default 0,
	archived boolean not null default 'f',
	wallet_id varchar(255) not null references wallets(wallet_id)
);

create table transactions(
	transaction_id integer primary key,
	tx_id varchar(255) not null unique,
	USD integer not null,
	bitcoin integer not null,
	confirmations integer not null,
	trans_date timestamp not null,
	sender_address_id integer not null references addresses(address_id),
	receiver_address_id integer not null references addresses(address_id),
	sender_user_id integer not null references users(user_id),
	receiver_user_id integer not null references users(user_id),
	notified_sender boolean default 'f',
	notified_receiver boolean default 'f',
	message varchar(255)
);


create table invoices(
	invoice_id integer primary key,
	paid boolean default 'f',
	USD integer not null,
	bitcoin integer not null,
	invoice_date timestamp not null,
	sender_address_id integer references addresses(address_id),
	receiver_address_id integer references addresses(address_id),
	sender_user_id integer not null references users(user_id),
	receiver_user_id integer not null references users(user_id),
	notified_sender boolean default 'f',
	notified_receiver boolean default 'f',
	message varchar(255)
);


insert into wallets(wallet_id) values ('admin123wallet');

insert into users(user_id, username, email, name, password,phone, wallet_id) values
(100,'admin', 'connect2dkp@gmail.com', 'Admin', 'Admin123', '6572539465' ,'admin123wallet');

insert into authorities values(100, 'ROLE_ADMIN');

