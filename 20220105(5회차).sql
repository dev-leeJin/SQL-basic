use ict_practice;

SELECT * FROM testtbl1;

-- 지금 testtbl1같은 경우 id를 수동으로 입력해주고 있습니다.
-- 이 경우 매번 id값을 사용자가 계산해서 insert해야하기때문에
-- 굉장히 불편한데 auto_increment 속성을 컬럼에 걸어주면
-- 데이터가 입력받지 못한다면 컴퓨터가 순차적으로 컬럼에 중복되지 않고
-- 증가하는 숫자를 자동으로 입력해줍니다.
CREATE TABLE testtbl2(
	id int AUTO_INCREMENT PRIMARY KEY,
    user_name varchar(3),
    age int
    );
    
-- id컬럼에는 AUTO_INCREMENT가 붙어있으므로 null로 처리해도
-- 자동으로 1부터 숫자가 1씩 증가하면 들어갑니다.
INSERT INTO testtbl2 VALUES (null, '알파카', 4);
INSERT INTO testtbl2 VALUES (null, '에뮤', 2);
INSERT INTO testtbl2 VALUES (null, '토끼', 1);

-- 현재 3개의 데이터가 들어갔으므로 AUTO_INCREMENT의 다음 값은 4입니다.
SELECT * FROM testtbl2;

-- AUTO_INCREMENT의 기준값은 1부터 1씩 자동으로 증가하지만
-- 만약에 사용자가 임의로 값을 바꾸고 싶다면 ALTER TABLE을 이용해
-- AUTO_INCREMENT의 값을 수정할 수도 있습니다.
-- AUTO_INCTRMENT의 현재 값을 1000으로 수정하는 구문
ALTER TABLE testtbl2 AUTO_INCREMENT = 1000;
INSERT INTO testtbl2 VALUES (null, '호랑이', 10);
INSERT INTO testtbl2 VALUES (null, '반달곰', 3);

-- Q CMD(커맨드라인)에서 testtbl2 컬럼에 데이터를 3개 더 입력해주세요.
-- 커맨드라인에서 조회까지 마쳐주세요.

DELETE FROM testtbl2 WHERE id =4; -- 잘못입력한 데이터 삭제 

-- AUTO_INCREMENT는 기본적으로 1씩 증가하는데
-- 이 증가분을 수정하고 싶다면 서버측 변수인
-- @@auto_increment_increment를 바꿔야 합니다.
-- testtbl2와 모든 조간이 같고 이름만 testtbl3인 테이블을 하나 더 만들어주세요.
CREATE TABLE testtbl3(
	id int AUTO_INCREMENT PRIMARY KEY,
    user_name varchar(3),
    age int
);

-- Q testtbl3의 초기 AUTO_INCREMENT값을 1500으로 고쳐보세요.
ALTER TABLE testtbl3 AUTO_INCREMENT = 1500;
-- 증가분일 1이 아닌 3으로 세팅하는법
-- # testtbl3에만 영향을 주는 것이 아닌 sql전체에 영향을 줌. 
SET @@auto_increment_increment = 3;
-- 동물 3마리를 testtbl3에 추가
INSERT INTO testtbl3 VALUES (null, '강아지', 2);
INSERT INTO testtbl3 VALUES (null, '고양이', 3);
INSERT INTO testtbl3 VALUES (null, '독수리', 8);
SELECT * FROM testtbl3;

-- testtbl2도 3씩 증가하는지 다시 INSERT INTO명령어로 확인
INSERT INTO testtbl2 VALUES (null, '드래곤', 100);
INSERT INTO testtbl2 VALUES (null, '늑대', 10);
-- 다시 증가량을 1로 돌리기
SET @@auto_increment_increment = 1;
-- testtbl2에 하나의 데이터를 더 추가하고 증가량이 돌아왔는지 체크
-- CMD로 해 주세요.
-- # 바로 1증가가 아닌 한번 더 3증가 후 1증가로 변경. 



-- 하나의 INSERT INTO구문으로 여러 row를 추가할 때는
-- VALUES 뒤쪽을 연달아 작성합니다.
INSERT INTO testtbl2 VALUES (null,'말',4), (null,'오리',1), (null,'닭',2);


-- UPDATE 구문은 기존에 입력되어 있는 값을 변경할때 사용합니다.
-- WHERE 조건절을 걸지 않는다면, 컬럼 하나의 값을 전부 바꿉니다.
-- 따라서 일반적으로 무조건 조건절과 조합해서 사용합니다.
-- UPDATE 테이블명 SET 컬럼1=바꿀값1, 컬럼2+바꿀값2...alter

-- testtbl2의 user_name을 전부 '소'로 바꾸는 구문
-- # workbench에서 보안성을 위해 막음. cmd에서는 됌.
-- # workbench에서는 WHERE절을 사용하여 하나씩 바꾸기만 허용함.
UPDATE testtbl2 SET user_name ='소';

-- workbench에서 WHERE절 없이 수정하고 싶다면 safe_update모드를 해제해야 합니다.
SET SQL_SAFE_UPDATES = 0;  -- # 영향은 UPDATE하나에만 영향을 줌(DELETE,drop table에는 필요 없음)

-- testtbl2의 user_name을 전부 '호랑이'로 고치기
UPDATE testtbl2 SET user_name ='호랑이';

-- Q 특정 나이대의 user_name을 여러분들이 좋아하는 동물로 교체해주세요.
-- WHERE을 이용해 age를 필터링해주세요.
-- 하나의 나이대만 우선 고쳐주세요.
UPDATE testtbl2 SET user_name ='드래곤' WHERE age =100;
UPDATE testtbl2 SET user_name ='늑대' WHERE age between 3 and 7; -- 3~7 사이 (3포함)
SELECT * FROM testtbl2;

-- UPDATE구문이 전체 컬럼에 적용될 수 있다는것을 응용해 특정 컬럼의 값을 일관적으로
-- 계산식에 따라 새로운 결과값으로 갱신하는것도 가능합니다.
-- 아래 코드는 나이를 2배한 결과물입니다.
UPDATE testtbl2 SET age = age*2;
-- 다시 원래 나이로 돌리기
UPDATE testtbl2 SET age = age/2;


-- DELETE FROM 구문은 데이터를 삭제하는 구문입니다.
-- SELECT는 특정한 컬럼들만 조회하거나, 전체를 모두 조회하는 등의
-- 경우의 수가 있었기 때문에 SELECT와 FROM 사이에 구체적인 컬럼명이나
-- 혹은 * 을 붙여서 전체 컬럼을 조회했습니다.
-- DELETE 특정 컬럼만 삭제하는 경우가 없고 삭제할거면 전체 row를 삭제하거나
-- 삭제를 안 해 버리거나 이기 때문에
-- DELETE와 FROM 사이에 아무것도 적지 않습니다. ★
-- DELETE 역시 일반적으로는 WHERE절과 함께 사용합니다.
-- WHERE 없이 사용시 해당 테이블의 전체 데이터를 다 삭제합니다.
-- id 1에 해당하는 데이터만 삭제해보세요.(WHERE 사용)
DELETE FROM testtbl2 WHERE id = 1;
SELECT * FROM testtbl2;

-- limit를 사용하면 상위 n개만 삭제할수도 있습니다.
-- 검색 결과물 중 상위 2개만 삭제
DELETE FROM testtbl2 limit 2;

-- WHERE절 없이 삭제하면 테이블 내의 전체 데이터 삭제
DELETE FROM testtbl2;
-- drop table 사용시 테이블 자체를 삭제

-- DELETE FROM은 삭제할 때 시간이 조금 더 오래 걸리는 편인데 이유는 
-- 트랜잭션 로그라는것을 한 로우마다 작성하기 때문입니다.
-- 따라서 속도를 끌어올리고 싶다면 TRUNCATE를 DELETE FROM 대신 쓰는 경우도 있습니다.
TRUNCATE TABLE testtbl2;

-- TRUNCATE와 DELETE FROM의 속도차이를 체험해보기 위해서
-- employees 테이블 자료를 복사해보겠습니다.
CREATE TABLE testtbl4(
	ind int,
    first_name varchar(50),
    last_name varchar(50)
);

INSERT INTO testtbl4 (SELECT emp_no, first_name, last_name FROM employees.employees);
-- # 먼저 ()를 실행하고 SELECT로 30만개를 조회 
-- # 조회된 데이터를 testtbl4에 복사 저장employees
SELECT * FROM testtbl4;

-- CMD에서 DELETE FROM으로 삭제 후 소요시간 확인 (내 컴퓨터 기준 17.79초)
-- CMD에서 TRUNCATE를 이용해 삭제 후 소요시간 확인 (1.37초)
-- # DELETE FORM 은 한줄씩 접속-> 삭제-> 접속해제를 30만번 반복해서 느림
-- # TRUNCATE 는 접속->삭제->삭제 이런식으로 접속과 접속해제를 한번만 하기 때문에 삭제만 돌아감.
-- # TRUNCATE는 트랜잭션 로그를  한줄마다 작성하지 않아서 이력이 통으로 남아 디테일이 떨어진다는 단점.alter


-- 조건부로 데이터 입력하기
-- 예를 들어 100개의 데이터를 입력하려고 하는데 첫 번째 자료만
-- 기존 데이터의 id와 중복되는 값이 있고, 이후 99건은 PK가 중복되지 않는다고 해도
-- SQL 시스템 상 전체 데이터가 입력되지 않는 문제가 발생합니다.
-- # VALUES뒤에 연달아 쓸 경우 첫 번째가 중복이면 뒤에는 중복이 아니더라도 작성이 안됌.
-- 따라서 이 때 중복되는 데이터 1건은 중복된다면 무시하고
-- 이후 나머지 99개 데이터는 중단 없이 정상적으로 입력하도록 만들 수 있습니다.
CREATE TABLE membertbl(
	user_id VARCHAR(6) primary key,
    user_name VARCHAR(3) not null,
    addr VARCHAR(3) not null
);

-- MYSQL은 구문을 통째로 묶어서 실행할 경우 모두 실행하거나 모두 실행하지 않습니다.
-- # 전부 드래그 후 번개모양
INSERT INTO membertbl VALUES ('LSH','이상혁','서울');
INSERT INTO membertbl VALUES ('HS','허수','울산');
INSERT INTO membertbl VALUES ('JJH','정지훈','인천');  

-- 추가 데이터를 입력하되 한 건은 중복, 두건은 중복 없도록 세팅
-- # 묶어서 실행하면 에러. 
INSERT INTO membertbl VALUES ('LSH','이상혁','서울');
INSERT INTO membertbl VALUES ('KHK','김현규','경기');
INSERT INTO membertbl VALUES ('PDH','박도현','충청');

SELECT * FROM membertbl;

-- 만약 PRIMARY KEY가 겹친다면 무시하고 그렇지 않으면 입력해주는 코드로 변환
-- INSERT와 INTO 사이에 IGNORE(무시하다)
INSERT IGNORE INTO membertbl VALUES ('LSH','이상혁','서울');
INSERT IGNORE INTO membertbl VALUES ('KHK','김현규','경기');
INSERT IGNORE INTO membertbl VALUES ('PDH','박도현','충청');
-- # 중복되는 값은 경고를 주고 맡에 나머지 두개는 실행이 된다. 

-- IGNORE는 기존 데이터를 유지하고 신규데이터를 막는 구문이었는데
-- 이미 존재하는 데이터가 있어도 신규데이터로 갱신해서 놓고 싶은 경우 (PRIMARY KEY가 겹쳤을 때)
INSERT INTO membertbl VALUES ('LSH','이성혁','제주')
	ON DUPLICATE KEY UPDATE user_name='이성혁', addr='제주';
    -- 중복되는 값이 없는 경우 그냥 입력되고 중복되는 값이 있으면 갱신됌. 

SELECT * FROM membertbl;

-- ON DUPLICATE KEY UPDATE는 자료가 없으면 INSERT INTO에 적힌 대로 데이터를 넣고
-- 자료가 겹치는 상황인 경우에 ON DUPLICATE KEY UPDATE를 실행하는 구문이기 때문에
-- 만약 데이터가 겹치지 않아도 잘 작동합니다.
-- 기존 테이블 요소와 겹치지 않는것을 넣어서 잘 들어가는 CMD를 이용해 실행한 후 확인해보세요.



-- [사용자 관리하기]
-- 현재 root계정은 모든 권한(수정, 삭제, 조회, 변경, 계정생성 등)
-- 을 가지고 있는 계정입니다.
-- 그렇지만 모든 사람이 모든 권한을 가지는 일은 그만큼 DB접근이 용이해져 위험을 내포하고 있으며
-- 작년 초에도 유명 게임사에서 DB를 날려먹는 사건이 발생한 만큼
-- 일정 규모 이상의 개발사에서는 직급이나 권한별로 DB계정을 나눠서 관리합니다.
-- 이제 root가 아닌 사용자를 만들고, 그 사용자에 대해서
-- 권한부여를 하는 방법과 권한 개념에 대해 알아보겠습니다.

-- workbench에서 계정생성 및 권한부여하기.
-- 1. 좌측의 navigator에서 Administration 탭을 클릭합니다.
-- 2. Users and Privileges를 클릭합니다.
-- 3. 열리는 화면에서 좌하단 Add Account를 클릭한 다음 Login name, password 등을 입력합니다.
-- 4. 우하단 Apply를 누르면 계정생성이 완료됩니다.
-- 5. Account Limit는 시간당 기능 사용 가능 횟수를 설정합니다.
-- 6. Administrative Roles는 어떤 구문 실행까지 허용할지입니다.
-- # Schema Privileges는 테이블에 접근가능한지 얼마나 수정할 수 있는지 등을 설정할 수 있다.
-- # 모든 권한을 주는 방법은 Administrative Roles에서 DBA체크 후 Apply를 누르면 완료.

-- CMD 환경에서 생성하는 경우는
-- CREATE USER 계정명@'%' IDENTIFIED BY '비밀번호'; -- 생성 구문
-- GRANT ALL on *.* To 계정명@'%' WITH GRAND OPTION; --모든 권한을 주는 구문
-- 위 두 줄을 이용해서 생성할수도 있습니다.
-- ict2 계정은 CMD환경에서 만들기. 비밀번호은 ictICT03

-- 계정 접속 방법
-- 커멘드라인 접속시 mysql -u 계정명 -p로 연결 가능
-- 접속 후 show databases; 를 이용해 DB목록 확인 가능
-- use mysql;
-- SELECT user, host FROM user; 를 할 경우 생성된 계정목록 조회가능
show databases; -- DB목록 조회

-- ict와 ict2에 이미 root의 모든 권한을 부여했기 때문에 새로운 계정이 필요
-- icttest 계정을 만들어주세요. 권한은 따로 주지 마세요.

-- 계정 권한주기

-- workbench에서 주기
-- navigator하단 Administration에서 유저 선택 후 Administrative Roles에서 주고싶은 권한을
-- 체크해주면 됩니다.(DBA 선택시 모든 권한 획득)

-- CMD에서 전체가 아닌 일부 권한 주기 
-- (GRANT 권한1, 권한2... ON DB명. 테이블명 TO 계정명@'%';)
-- ict_practice 데이터베이스의 testtbl3 테이블에 대한 SELECT, DELETE권한만 가지도록
-- icttest계정에 권한을 부여한다면
-- GRANT SELECT , DELETE ON ict_practice.testtbl3 TO icttest@'%';
-- icttest계정에 ict_practice의 testtbl3을 SELECT와 DELETE의 권한을 부여