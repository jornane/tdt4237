delete from school;
delete from country;
delete from admin_users;
delete from user_reviews;
delete from users;


insert into admin_users values ('admin','53P6uKTxQCi4VFTUrVdr986aQ3CIk3YiXDx8jOiy+N6V98hSwC0PFWD5Bq5eIuKlRhuGdI04k7OY
4uxMwgt1Ww==','hzxUOP8lWes2Yg==');


insert into country values ('NO','Norway');
insert into country values ('SWE','Sweden');
insert into country values ('DK','Denmark');
insert into country values ('USA','United States');
insert into country values ('IT','Italy');
insert into country values ('JP','Japan');
insert into country values ('MEX','Mexico');
insert into country values ('CAN','Canada');
insert into country values ('RUS','Russia');
insert into country values ('FR','France');

insert into school values (1,'Norwegian University of Science and Technology','NTNU','Trondheim',7491,'NO');
insert into school values (2,'Kungliga Tekniska Hogskulan','KTH','Stockhom',7777,'SWE');
insert into school values (3,'University of Oslo','UiO','Oslo',0316,'NO');
insert into school values (4,'IT University of Copenhagen','ITUniv','Copenhagen',2300,'DK');
insert into school values (5,'Massachusetts Insitute of Technology','MIT','Boston',77491,'USA');
insert into school values (6,'University of Insubria','UoS','Milan',2222,'IT');
insert into school values (7,'Tokyo University','TokyU','Tokyo',3434,'JP');
insert into school values (8,'Instituto Tecnológico de Acapulco','ITA','Acapulco',7171,'MEX');
insert into school values (9,'University of Toronto','UoT','Toronto',4949,'CAN');
insert into school values (10,'University of Alberta','UoA','Edmonton',7887,'CAN');
insert into school values (11,'Sorbonne','SORB','Paris',4914,'FR');
insert into school values (12,'Grenoble Institute of Technology','GIT','Grenoble',6555,'FR');
insert into school values (13,'Stanford University','STAN','San Francisco',7911,'USA');
insert into school values (14,'University of California Santa Barbara','UCSB','Santa Barbara',1199,'USA');

insert into user_reviews values (1,'Michelle','Excellent, fun and interesting.');
insert into user_reviews values (2,'Michelle','Great campus. Interesting classes.');
insert into user_reviews values (3,'Michelle','Loved it. Especially the class computers101.');
insert into user_reviews values (4,'Michelle','Some great classes. Some not so great.');
insert into user_reviews values (5,'Michelle','Great place to study computer science.');
insert into user_reviews values (6,'Michelle','Stayed there for two semesters. Studied physiscs and computer science. They have a great lab. ');

