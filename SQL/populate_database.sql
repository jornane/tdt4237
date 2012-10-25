delete from school;
delete from country;
delete from admin_users;
delete from user_reviews;
delete from users;


insert into admin_users values ('troll','9CdekjyOY7zm58Pja1GSHsPuzoJIqTxFdgoct2yjK6frFf6xYS/udPLGvLSvps+tpv8IxZtZBD0xvuds0kA9Mw==','vz7vzU8mxrCwuw==');
insert into users values ('troll','9CdekjyOY7zm58Pja1GSHsPuzoJIqTxFdgoct2yjK6frFf6xYS/udPLGvLSvps+tpv8IxZtZBD0xvuds0kA9Mw==','vz7vzU8mxrCwuw==','Admin');

INSERT INTO `users` (`uname`, `pw`, `salt`, `name`)
VALUES
	('tiina', '01puwwjMnPJ5jpEtp2x/NuUVgQKgPZ93I3lk6uDrg/Cfh0iJ46rs2WGKlS+iI7SKwi/QySgsrPyO+SgWxVjAKg==', 'FQFk69XCpNQ0GQ==', 'Tiina'),
	('dat', 'c9XJV1Z34Ej8WQFUKOh/Y4JMNzfGgTbgpFJU0+uLhN2vLrG7VkMm9vtUHcFg+I1WH7/yPezIF3kGUsBjFsfX/w==', '5qUFrNagRspdfA==', 'Dat'),
	('yorn', 'NOeast7Q2Ad0G6KbNP05UZGjQHwvXLKgpNANcrKXv4OV97ts3FM0rZEAZ+7js1UjaRoqJ6tK/KV6gePQ2EFkxA==', 'bPdA8PkfRrqnUQ==', 'Yorn'),
	('peter', 'q7VKPHX93A4nQIVxcRilixLx9jl+PiOkX8iQq0aO08k8r17oks3RgffgVSK83/jKnReKsBHWBMpmmfEHoet9Tw==', '6JHfI2AR9Q2cZw==', 'Peter'),
	('saad', 't8lTn3VsXOppL5YkSU4FrF/s+5rGUvna24qrkr3sx9UE4sYiKtL5g7f4Gof8qqZoD1Dpg2LushTub70NNUAhmw==', '7CdfaF1Dfg//WQ==', 'Saad');






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

insert into user_reviews values (1,'peter','Excellent, fun and interesting.');
insert into user_reviews values (2,'saad','Great campus. Interesting classes.');
insert into user_reviews values (3,'yorn','Loved it. Especially the class computers101.');
insert into user_reviews values (4,'dat','Some great classes. Some not so great.');
insert into user_reviews values (5,'tiina','Great place to study computer science.');
insert into user_reviews values (6,'peter','Stayed there for two semesters. Studied physiscs and computer science. They have a great lab. ');

