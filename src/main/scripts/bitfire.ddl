create sequence hibernate_sequence start 1 increment 1

    create table addresses (
        address_id int4 not null,
        USD int default 0 not null,
        address varchar(255),
        archived boolean not null,
        bitcoins int default 0 not null,
        label varchar(255),
        is_primary boolean,
        wallet_id varchar(255) not null,
        primary key (address_id)
    )

    create table authorities (
        user_id int4 not null,
        role varchar(255)
    )

    create table transactions (
        transaction_id int4 not null,
        USD int4 not null,
        bitcoin int4 not null,
        confirmations int4 not null,
        trans_date timestamp,
        notified_receiver boolean,
        notified_sender boolean,
        tx_id varchar(255),
        receiver_address_id int4,
        receiver_user_id int4,
        sender_address_id int4,
        sender_user_id int4,
        primary key (transaction_id)
    )

    create table users (
        user_id int4 not null,
        email varchar(255) not null,
        enabled boolean,
        name varchar(255) not null,
        password varchar(255) not null,
        phone varchar(255),
        username varchar(255) not null,
        wallet_id varchar(255),
        primary key (user_id)
    )

    create table wallets (
        wallet_id varchar(255) not null,
        primary key (wallet_id)
    )

    alter table transactions 
        add constraint UK_4kt0way4tvb9u1ihd1hp18fps unique (tx_id)

    alter table users 
        add constraint UK_6dotkott2kjsp8vw4d0m25fb7 unique (email)

    alter table users 
        add constraint UK_r43af9ap4edm43mmtq01oddj6 unique (username)

    alter table addresses 
        add constraint FKf46h3157sftlhw1o20jdept2h 
        foreign key (wallet_id) 
        references wallets

    alter table authorities 
        add constraint FKk91upmbueyim93v469wj7b2qh 
        foreign key (user_id) 
        references users

    alter table transactions 
        add constraint FKklnj7dcrd7k9wlr96hv619mc4 
        foreign key (receiver_address_id) 
        references addresses

    alter table transactions 
        add constraint FK3s89q54ulm9mkiyoj2ddijc5c 
        foreign key (receiver_user_id) 
        references users

    alter table transactions 
        add constraint FK66mjsfsmmjulwiop67xbkpjmd 
        foreign key (sender_address_id) 
        references addresses

    alter table transactions 
        add constraint FKc3t78itbvdqu2lpn8fj0gxvu6 
        foreign key (sender_user_id) 
        references users

    alter table users 
        add constraint FKcf6cgic6n7ek155uj81npsbcm 
        foreign key (wallet_id) 
        references wallets
