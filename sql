create database wmsdb;

use wmsdb;



create table states
(
  state_id int auto_increment primary key,
  state char(35) not null
);



create table cities
(
  city_id int auto_increment primary key,
  city char(35) not null,
  state_id int not null,
  constraint fk_cities_states foreign key (state_id) references states(state_id)
);


create table users
(
   user_id int auto_increment primary key,
   user_name char(50) not null unique,
   name char(50) not null,
   gender char(1) not null,
   profile_pic char(255),
   password char(250) not null,
   city_id int null,
   constraint fk_user_cities foreign key (city_id) references cities(city_id),
   uid char(12) not null,
   role bool not null default 1,
   activation_code char(100),
   rating int
);


create table contact_types
(
  contact_type_id int auto_increment primary key,
  type char(25) not null
);
insert into contact_types (type) values ('contact1'),('contact2'),('first_email'),('second_email'),('website'),('address');



create table contacts
(
   contact_id int auto_increment primary key,
   user_id int not null,
   constraint fk_contacts_users foreign key (user_id) references users(user_id),
   contact char(255) not null,
   contact_type_id int null,
   constraint fk_contacts_contact_types foreign key (contact_type_id) references contact_types(contact_type_id)
);


create table skills
(
  skill_id int auto_increment primary key,
  skill char(30) not null
);


create table worker_skills
(
   worker_skill_id int auto_increment primary key,
   user_id int not null,
   constraint fk_worker_skills_users foreign key (user_id) references users(user_id),
   skill_id int null,
   constraint fk_worker_skills_skills foreign key (skill_id) references skills(skill_id),
   experience int not null default 0,
   rating int not null default 0,
   job_count int not null default 0,
   expert bool not null default 0
);


create table work_status
(
  work_status_id int auto_increment primary key,
  status char(35) not null
);
insert into work_status (status) values ('initiated'),('reached_client'),('working'),('completed'),('payment_completed');



create table deal_status
(
  deal_status_id int auto_increment primary key,
  status char(35) not null
);
insert into deal_status (status) values ('initiated'),('cancelled'),('completed');



create table deals 
(
  deal_id int auto_increment primary key,
  worker_skill_id int not null,
  constraint fk_deals_worker_skills foreign key (worker_skill_id) references worker_skills(worker_skill_id),
  user_id int not null,
  constraint fk_deals_users foreign key (user_id) references users(user_id),
  registeration_date datetime not null,
  work_description varchar(3000),
  start_date datetime not null,
  end_date datetime not null,
  deal_amount int not null,
  payment_status bool not null default 1,
  work_status_id int not null,
  constraint fk_deals_work_status foreign key (work_status_id) references work_status(work_status_id),
  deal_status_id int not null,
  constraint fk_deals_deal_status foreign key (deal_status_id) references deal_status(deal_status_id),
  review_date datetime,
  review char(200)
);


create table chats
(
   chat_id int auto_increment primary key,
   worker_skill_id int not null,
  constraint fk_chats_worker_skills foreign key (worker_skill_id) references worker_skills(worker_skill_id),
  user_id int not null,
  constraint fk_chats_users foreign key (user_id) references users(user_id),
  from_to bool not null,
  post_date datetime not null,
  message varchar(2000) not null
);

