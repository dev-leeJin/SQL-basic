/* 1. 데이터베이스 생성 명령
DB생성시 한글을 쓸 수 있도록 -> default character set utf8; */
create database ict_practice default character set utf8;

/* 우측 하단의 schemas 클릭 후, 새로고침 한 다음 ict_practice 우클릭
-> set as default schema를 클릭하세요. 이러면 현재 명령을 받을 DB로 지정됩니다.*/
-- 내가 저장할 폴더를 위의 방법으로 지정

/* default schma 지정은 명령어로도 할 수 있습니다.
use 스키마명; 을 사용하면 좌측 schemas에서 우클릭 후 default스키마 지정한 효과를 
낼 수도 있습니다.*/
/*use sys;users
use ict_practice;*/

/* 테이블 생성 명령
primary key -> 컬럼의 주요 키를 뜻하며, 중복데이터를 방지합니다.
테이블 내의 하나의 컬럼은 반드시 primary key 속성을 가져야 합니다.
not null -> 데이터에 null 값이 들어오는것을 방지합니다*/
/* 테이블은 클래스랑 구조가 비슷합니다. 클래스 내부의 멤버변수를 지정하듯이
테이블 요소를 지정해 줄 수 있습니다 (테이블 생성 명령어) 
#sql의 생성명령어는 대문자로 작성(가독성) */
/* varchar 는 자바의 String과 호환됩니다.(글짜 수 지정가능 =20자까지 사용)*/
CREATE TABLE users(
	id varchar(20) primary key,
    pw varchar(20) not null,
    user_name varchar(30) not null,
    email varchar(80) /*입력을 해도 안해도 상관없음*/
    ); /*추상화(모든걸 다 표현하지 않고 필요한 부분만 가려낸다) */
    
/* 데이터 적재하기
INSERT INTO 테이블명 (컬럼1, 컬럼2...) VALUE(S) (컬럼1값, 컬럼2값,...);
만약 모든 컬럼을 대상으로 지정시 컬럼은 생략하고 VALUE(S) 이후 값만 지정할 수 있다.
INSERT INTO 테이블명 VALUES(컬럼1값, 컬럼2값,...);*/
INSERT INTO users (id, pw, user_name, email) VALUE
	('abc1234', 'asdf', '김자바', 'asdf@asdf.com');
    
INSERT INTO users VALUES ('qwer123', 'qwer', '쿼리문', 'qwer@qwer.com');

-- 한 줄 주석은 자바와 달리 -- 내용 을 적어 작성할 수 있습니다.
-- Q여러분들이 계정 3개를 더 넣어주시되, 1개 계정은 이메일을 생략하고 넣어주세요.
-- #모든컬럼을 지정하고 이메일을 생략할 경우 이메일 자리에 null을 입력한다.
INSERT INTO users (id, pw, user_name) VALUES ('zxczxc', 'ssdd', '데이터');
INSERT INTO users VALUES ('xzcz33', '1234', '베이스', 'dkdk@dkdk.com');
INSERT INTO users VALUES ('dddaas', 'fbfb', '입문자', 'base@base.com');
    
/* 데이터 조회하기
SELECT 컬럼1, 컬럼2,... FROM 테이블명;
을 적으면 테이블에 적재된 데이터 조회 가능
SELECT * FROM 테이블명; 으로 조회시 해당 테이블의 전체 컬럼 조회 가능*/
SELECT * FROM users;

-- 조회구문에 조건을 걸기 위해서 WHERE이라는 구문을 사용합니다. #자바의 if문 / ==가 아닌 = 로 표현
-- SELECT 조회컬럼 FROM 테이블명 WHERE 컬럼명 = '조건에 맞는 값';
-- 이름이 김자바인 사람만 출력하기 #필터링
SELECT * FROM users WHERE user_name = '김자바';
-- Q여러분들의 기분으로 필터링을 해 보세요.
-- 아이디가 xxx인 사람만 출력해보세요.
SELECT * FROM users WHERE id = 'dddaas';

-- 조건 여러개를 걸 경우 AND,OR 키워드를 쓰면 됩니다. //자바에서는 앰퍼샌드(&)를 사용
-- 아이디가 dddaas이거나 혹은 유저이름이 김자바인 것들을 얻어오기
SELECT * FROM users WHERE id = 'dddaas' OR user_name = '김자바';

/* 데이터 수정하기
 UPDATE 테이블명 SET 컬럼명1 = '값1', 컬럼명2 = '값2' ...;
 주의할점은 WHERE구문 없이 사용하면 일괄적으로 컬럼 내의 모든 값이 다 바뀝니다. */
UPDATE users SET pw='ssss';
SET SQL_SAFE_UPDATES = 0; -- 0이면 비활성화 1로 주면 다시 safety모드 활성화 //보안장치
SELECT * FROM users;

-- WHERE 구문을 이용해서 pw컬럼의 값을 모두 다르게 바꿔주세요.
UPDATE users SET pw='ssss' WHERE id ='abc1234';
UPDATE users SET pw='dddd' WHERE id ='qwer123';
UPDATE users SET pw='aaaa' WHERE id ='zxczxc';
UPDATE users SET pw='wwww' WHERE id ='xzcz33';
UPDATE users SET pw='oooo' WHERE id ='dddaas';
SELECT * FROM users;
-- Q여러분들이 원하는 로우(row)하나에 대해서 이름과 비밀번호를 바꿔주세요.
UPDATE users SET user_name = '오라클', pw = 'orcl' WHERE id = 'abc1234';
SELECT * FROM users;

-- 데이터 삭제
/* DELETE FROM 테이블명; 을 할 경우 테이블 전체 데이터가 싹 다 날아갑니다.
DELETE구문 역시 WHERE과 조합해서 사용해야 합니다. */
DELETE FROM users WHERE id ='qwer123';
SELECT * FROM users;

/* Q도서관 DB를 한 번 만들어보겠습니다.
   도서관 테이블 이름은 library이고
   내장 데이터는 
   책이름(book_name),primary key,문자열(30)
   책가격(book_price),not null, int(7)
   출판사(book_pup),not null, 문자열(20)
   저자(book_writer),not null, 문자열(10)
   책분량(book_page),not null, int(5)
   생성 후 책 6권을 넣어주세요. */
   
CREATE TABLE library(
	book_name varchar(30) primary key,
    book_price int(7) not null,
    book_pup varchar(20) not null,
    book_writer varchar(10) not null,
    book_page int(5) not null
    ); -- int(3)인 경우 3까지가 아닌 999까지임. (자릿수)
    
INSERT INTO library VALUES ('손자병법', 50000, '손자출판', '손무', 300);
INSERT INTO library VALUES ('나행좋', 40000, '에세이', '박찬위', 200);
INSERT INTO library VALUES ('맹자', 10000, '맹자출판', '맹순', 500);
INSERT INTO library VALUES ('소크라테스', 30000,'소크출판','필라톤',400);
INSERT INTO library VALUES ('정의란무엇인가', 40000, '저스티스', '마이클샌덜', 500);
INSERT INTO library VALUES ('미움받을용기', 70000, '안미워', '가시미', 100);
SELECT * FROM library; 

drop table library; -- 테이블을 실수로 지워버려서 이미 있는경우 다시 작성하면 오류가 뜬다.
					-- 그럴경우 테이블을 한 번 지워버리고 다시 생성하는데 테이블을 지우는 명령어다.
                    
drop table users;

-- 저장은 Ctlr + s 방법과 file의 Save Script As... 로도 가능
    


