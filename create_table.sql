CREATE TABLE Person (
   pid number default NULL,
   fname varchar2(255) default NULL,
   lname varchar2(255) default NULL,
   Email varchar2(255) default NULL,
   PRIMARY KEY (pid)
);

CREATE TABLE Author (
   pid number NOT NULL references person(pid),
   penname varchar2(255),
   PRIMARY KEY (pid)
);

CREATE TABLE Publisher(
   pubid number default NULL,
   pubname varchar2(255) default NULL,
   phone varchar2(255) default NULL,
   email varchar2(255) default NULL,
   PRIMARY KEY (pubid)
);

CREATE TABLE Address (
   aid number NOT NULL,
   street varchar2(255) NOT NULL,
   city varchar2(255) NOT NULL,
   state varchar2(255) NOT NULL,
   PRIMARY KEY(aid)
);

CREATE TABLE Membership(
   memberid varchar2(255),
   length number,
   start_date date,
   fee real NOT NULL,
   PRIMARY KEY (memberid)
);

CREATE TABLE Users (
   pid number NOT NULL references person(pid),
   uname varchar2(255),
   PRIMARY KEY (pid)
);

CREATE TABLE Entry (
   eid varchar2(255),
   title varchar2(255),
   body varchar2(255),
   PRIMARY KEY (eid)
);

CREATE TABLE book (
	bid varchar2(255),
bedition integer,
numpages integer,
Primary key(bid),
FOREIGN KEY(bid) REFERENCES Entry(eid) ON DELETE CASCADE
);

CREATE TABLE Journal (
   jid varchar2(255),
   jtopic varchar2(255),
   jvol integer,
   PRIMARY KEY (jid),
   FOREIGN KEY (jid) references Entry(eid) ON DELETE CASCADE
 );

CREATE TABLE Magazine (
   mid varchar2(255),
   cover_description varchar2(255),
   PRIMARY KEY (mid),
   FOREIGN KEY (mid) references Entry(eid) ON DELETE CASCADE 
 );



CREATE TABLE Conference_proceedings (
   cid varchar2(255),
   conference_name varchar2(255),
   conference_date date,
   PRIMARY KEY (cid),
   FOREIGN KEY (cid) references Entry(eid) ON DELETE CASCADE 
 );

CREATE TABLE References (
   eid varchar2(255),
   refid varchar2(255),
   PRIMARY KEY (eid, refid),
   FOREIGN KEY (eid) references Entry ON DELETE CASCADE
 );

CREATE TABLE login(
   pid  number,
   memberid  varchar2(255) NOT NULL,
   PRIMARY KEY (memberid, pid),
   FOREIGN KEY (memberid) references Membership,
   FOREIGN KEY (pid) references Users 
 );

CREATE TABLE Member_Search (
   memberid varchar2(255),
   eid varchar2(255),
   retrieved date,
   PRIMARY KEY (memberid, eid, retrieved),
   FOREIGN KEY (memberid) references Membership,
   FOREIGN KEY (eid) references Entry ON DELETE CASCADE 
 );

CREATE TABLE Non_Member_Search (
   pid number,
   eid varchar2(255),
   search_date date,
   fee real,
   PRIMARY KEY (pid, eid, search_date),
   FOREIGN KEY (pid) references Users,
   FOREIGN KEY (eid) references Entry ON DELETE CASCADE 
 );

CREATE TABLE Authored(
   eid varchar2(255) NOT NULL,
   pid number NOT NULL,
   PRIMARY KEY (eid, pid),
   FOREIGN KEY (eid) references Entry ON DELETE CASCADE,
   FOREIGN KEY (pid) references Author 
 );

CREATE TABLE Publishes (
   eid varchar2(255) NOT NULL,
   pubid number NOT NULL,
   published date,
   PRIMARY KEY (eid, pubid),
   FOREIGN KEY (eid) references Entry ON DELETE CASCADE,
   FOREIGN KEY (pubid) references Publisher 
 );

CREATE TABLE Located_at (
   aid number NOT NULL references Address(aid),
   pubid number NOT NULL references Publisher(pubid),
   PRIMARY KEY (aid, pubid),
   FOREIGN KEY (aid) references Address,
   FOREIGN KEY (pubid) references Publisher
 );

CREATE TABLE Lives_At (
   aid number NOT NULL references Address(aid),
   pid number NOT NULL references Person(pid),
   PRIMARY KEY (aid, pid),
   FOREIGN KEY (aid) references Address,
   FOREIGN KEY (pid) references Person
 );
