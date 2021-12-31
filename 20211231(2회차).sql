-- # Query문(스크립트)은 메모장과 같은 구역이고 실제로 스키마랑은 상관이 없다. 
-- # 저장하고 저장된 파일을 열면 다시 그 메모장을 꺼내올 수 있다.(스키마랑 관련이 없기 때문에 연결시켜 생각할 필요가 없다)
-- # CMD에는 스크립트 기능이 따로 없다. 
-- # (리모콘과 같은 느낌으로 스키마랑 연결이 된 경우에만 조작 가능 <use>)

-- employees를 사용 사용스키마로 지정해주세요.
use employees;

-- employees 내부의 employees 테이블을 조회해주세요.
-- SQL구문은 명령구문은 무조건 대문자, 테이블명이나 호칭 등은
-- 소문자로 작성하는 것이 관례입니다.
-- 무조건 지키지 않아도 실행은 가능하지만, 가독성을 위해 되도록이면 지켜주세요.
SELECT * FROM employees; -- 30만개 정도의 데이터

-- 원래 테이블 조회할때는 스키마명.테이블명으로 모두 표기하는게 정식 구문이다.
-- #employees를 사용스키마로 지정하여 스키마명을 생략했던 것.
SELECT *FROM employees.employees;

-- 스키마명.테이블명으로 조회시 use중이지 않은 스키마의 테이블도 조회할 수 있습니다.
SELECT * FROM ict_practice.users;

-- 컬럼을 전체가 아닌 임의로 가져올때는 컬럼명을 ,로 구분합니다.
-- 이 경우 모든 컬럼이 아닌 일부 컬럼만 조회할 수도 있으며
-- 심지어 한 개의 컬럼만 조회하는 등 개수조절도 가능합니다.
-- # *은 모든 컬럼을 조회하는 키워드고 *대신 컬럼명을 입력한다.
SELECT gender FROM employees;
SELECT gender, first_name, last_name FROM employees;

-- CMD환경에서는 좌측 스키마처럼 스키마 목록을 보여주는 창이 없으므로
-- 아래 명령어를 이용해 SCHEMA 목록을 확인할 수 있습니다.
SHOW databases;

-- 현재 DB정보를 조회하기 위해서는
SHOW TABLE STATUS;

-- 특정 테이블의 컬럼 정보를 조회하고 싶다면 아래 명령어를 씁니다.
-- DESCRIBE 테이블명; 혹은 DESC 테이블명;
DESCRIBE employees;
DESC employees;

-- #정규화 활용하기
-- ict_practice를 디폴트 스키마로 잡아주세요.
use ict_practice;

-- 테이블 생성

-- PRIMARY KEY(주요 키)
-- 각 테이블을 대표할 수 있는 대표데이터를 저장하는 컬럼에 붙이는 제약조건입니다. (고유번호 <아이디,회원번호>)
-- 모든 테이블은 무조건 하나의 PRIMARY KEY를 갖는다. 
-- PRIMARY KEY는 자동으로 중복을 방지하고, NULL도 들어올수 없으므로 NOT NULL도 겸한다.
CREATE TABLE userTbl(
	user_id VARCHAR(8) PRIMARY KEY,
    user_name VARCHAR(10) NOT NULL,
    birth_year INT(4) NOT NULL, -- #int의 경우 ()를 적지 않으면 자리수 제한이 없다. 
    addr VARCHAR(4) NOT NULL,
    phone_number VARCHAR(11),
    hegiht INT(3),
    reg_date DATE  -- 등록 날짜
);   -- 날짜 정보를 나타내는 자료형은 date, time등이 있다. 

-- AUTO_INCREMENT(자동증가) ★
-- INT(정수)자료형이 붙은 컬럼에만 붙일 수 있고, 이게 붙은 컬럼은 자동으로 1씩 증가하는 숫자를 배정받습니다.(null을 넣어도)
-- 시작은 1입니다.
-- INSERT  INTO 구문이 실행될 때 마다 해당 컬럼에 들어갈 숫자를 자동으로 배정받습니다.
-- 한 번 쓰인 숫자는 다시는 사용되지 않습니다. (겹칠 일이 없음)
-- #AUTO_INCREMENT에는 null을 넣고 사용하는게 좋음(숫자를 넣고 진행하면 순번이 꼬일 수 있음)

-- FOREIGN KEY(외래 키) ★
-- 쇼핑몰의 구매자는 반드시 회원이어야 한다는 조건이라면.
-- 특정 테이블에 존재하는 값만 해당 컬럼에 들어올 수 있도록 거는 제약조건
-- FOREIGN KEY를 거는 컬럼의 자료형과 크기는 참조하는 쪽과 원본 모두 같아야 합니다.
-- 참조컬럼에 있는 값만(userTbl의 user_id에 존재하는 값만) buyTbl의 user_id에 올 수 있습니다.
CREATE TABLE buyTbl(
	order_number INT AUTO_INCREMENT PRIMARY KEY,  -- 주문번호
    user_id VARCHAR(8) NOT NULL,
	prod_name VARCHAR(6) NOT NULL,
    group_name VARCHAR(4),
    price INT(7) NOT NULL,
    amount INT(3) NOT NULL,
    FOREIGN KEY(user_id) REFERENCES userTbl(user_id)  
);  -- references는 참고자료라는 뜻으로 userTbl을 참조하라는 뜻.
    
-- 회원부터 집어넣었음.
INSERT INTO userTbl VALUES('lch', '이창훈', 1999, '서울', '01049211920', 170, '1999-1-17');
SELECT * FROM userTbl;

-- 가입한 회원이 물건을 산 이력이 남도록 하겠습니다.
INSERT INTO buyTbl VALUES(null, 'lch', '기계식키보드', '주변기기', 200000, 1);
-- order_number는 값을 null로 주면 AUTO_INCREMENT에 의해 자동으로 1씩 증가된 숫자를 배정받음
INSERT INTO buyTbl VALUES(null, 'lch', '듀얼모니터', '전자기기', 990000, 2);
-- 없는 회원 아이디로 INSERT를 시도해보겠습니다. (userTbl의 user_id에 존재하는 것만 넣을 수 있기 때문에 오류가 난다)
INSERT INTO buyTbl VALUES(null, 'shm', '유니폼', '의료', 300000, 1);
INSERT INTO buyTbl VALUES(null, 'EM', '도지코인', '가상화폐', 5000, 100000);
SELECT * FROM buyTbl;

-- Q shm,EM으로 INSERT를 할 수 있도록 조치를 취해주신 다음 실행시켜 디비에 저장
INSERT INTO userTbl VALUES('shm', '손흥민', 1994, '경기', '01040014532', 180, '2021-03-04');
INSERT INTO userTbl VALUES('EM', '일론머스크', 1994, '미국', '01040014532', 160, '2021-02-13');
SELECT * FROM buyTbl;
