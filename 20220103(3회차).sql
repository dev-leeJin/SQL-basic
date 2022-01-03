use ict_practice;
SELECT *FROM userTbl;

-- 두명만 더 추가해주세요.
-- 정보는 전부 여러분들이 알아서 집어넣어주시되, 키는 한 명은 160대로 해주세요.
INSERT INTO userTbl VALUES('bb','보비',1756,'조선','65665656565',145,'1800-1-1');
INSERT INTO userTbl VALUES('TL','태일',1994,'서울','01054658798',168,'2022-1-1');
SELECT * FROM userTbl;

-- 새로 추가한 2명의 구매내역을 추가해주세요.
-- 2명 구매내역 합산 3개를 추가해주세요.
INSERT INTO buyTbl VALUES(null, 'bb', '스마트폰','전자기기',1000000,1);
INSERT INTO buyTbl VALUES(null, 'TL', '샴페인','주류',1500000,2);
INSERT INTO buyTbl (user_id, prod_name, group_name, price, amount)
	VALUES ('TL','방송용캠','전자기기',60000,1);
SELECT * FROM buyTbl;

-- 여태까지 SELECT 구문은 조건 없이 모든 데이터를 다 조회했습니다.
-- 극단적인 경우 employees의 테이블의 모든 row를 조회하다보니
-- 조회시간이 굉장히 오래 잡히는 케이스가 발생했습니다.
-- 따라서 조건에 맞도록 필터링을 할 수 있고, 이를 위해 사용하는 구문은 WHERE 구문입니다.
-- SELECT 컬럼명1, 컬럼명2  ... FROM 테이블명 WHERE 컬럼명 = 조건식;

-- 아래는 이름이 손흥민인 사람을 조회하는 구문입니다.
SELECT * FROM userTbl WHERE user_name = '손흥민';

-- Q 서울에 사는 사람만 조회해보세요.
SELECT * FROM userTbl WHERE addr = '서울';

-- 관계연산자를 이용해 대소비교를 하거나 
-- and, or을 이용해 조건 여러개를 연결할 수 있습니다.
-- Q 키 180이상인 사람만 조회해주세요
SELECT * FROM userTbl WHERE hegiht >= 180;

-- Q AND를 이용해 91~99년생까지만 조회하는 구문을 만들어보세요.
-- hint : 91보다다는 크거나 같고 , "그리고", 99보다는 작거나 크다.
SELECT * FROM userTbl WHERE 1991 <= birth_year <= 1999;
-- 위와 같은 문법으로 작성하면 이항연산자이기 때문에 하나밖에 표현하지 못한다.
SELECT * FROM userTbl WHERE (1991 <= birth_year) AND (birth_year <=1999);

-- BETWEEN ~ AND구문을 이용하면 birth_year를 한 번만 적고도
-- 해당 범위의 조호ㅚ가 가능합니다.
SELECT * FROM userTbl WHERE birth_year BETWEEN 1991 AND 1999;

-- 우와 같이 숫자는 연속된 범위를 갖기 때문에 범위연산자로 처리가 가능하지만
-- addr같은 자료는 서울이 크다던가 영국이 작다던가 하는 연산적 처리가 불가능합니다.
-- Q먼저 지역이 서울이가나 혹은 경기도인 사람의 정보를 WHERE절로 조회해주세요.
SELECT * FROM userTbl WHERE addr = '서울' or '경기';
-- #위와 같은 문법은 addr='서울'이 하나의 조건식으로 잡히고 경기는 잡히지 않는다.
SELECT * FROM userTbl WHERE addr='서울' OR addr='경기';

-- in키워드를 사용하면 컬럼명 in(데이터1, 2, 3, 4...);
-- 특정 컬럼의 괄호에 담긴 데이터가 포함되는 경우를 전부 출력합니다.
-- Q경기, 미국, 서울에 있는 사람들만 in키워드로 조회해주세요.
SELECT * FROM userTbl WHERE addr in('경기','미국','서울');

-- like 연산자는 일종의 표현 향식을 만들어줍니다.
-- like 연산자를 이용하면 %라고 불리는 와일드 카드나 혹은 _라고 불리는
-- 와일드 카드 문자를 이용해 매칭되는 문자나 문자열을 찾습니다.

-- 이씨를 찾는 케이스 (%는 몇 글자가 오더라도 상관 없음)
-- 아래 구문은 이로 시작하는 모든 요소를 다 가져옵니다. '이'도 포함
SELECT *FROM userTbl WHERE user_name like '이%';

-- Q휴대폰 번호가 01로 시작하는 모든 사람을 찾아보세요.
SELECT * FROM userTbl WHERE phone_number like '01%';

-- 두 글자만 찾는 케이스(_는 하나에 한 글자임)
SELECT * FROM userTbl WHERE user_name like '__';

-- Q user_id가 3글자이면서 H로 끝나는 사람만 조회해보세요.
SELECT * FROM userTbl WHERE user_id like'__H';


-- 서브쿼리 (하위쿼리)란 1차적 결과를 얻어놓고,
-- 거기서 다시 조회구문을 중첩해서 날리는것을 의미합니다.
-- 이창훈보다 키가 큰 사람을 조회하는 예시를 보겠습니다.

-- 원시적인 방법
-- 1.이창훈의 키를 WHERE절을 이용해 확인한다.
SELECT hegiht FROM userTbl WHERE user_name = '이창훈';
-- 2.확인한 이창훈의 키를 쿼리문에 넣는다.
-- 170보다 큰 사람의 이름과 키만 조회해보겠습니다.
SELECT user_name, hegiht FROM userTbl WHERE hegiht > 170;

-- 서브쿼리 활용 방법
-- 서브쿼리 FROM절 다음에 ()를 이용해서
-- SELECT 구문을 한 번 더 활용합니다.
SELECT user_name, hegiht FROM userTbl WHERE hegiht > 
	(SELECT hegiht FROM userTbl WHERE user_name = '이창훈');
	-- 조회할 사람의 키가 결과로 나오는 구문
    -- ()가 우선순위로 먼저 실행
    -- # 1.()를 먼저 실행하고 170의 결과를 얻은 다음 height를 170으로 치환
    --   2.치환이 된 값을 토대로 위의 실행문을 실행
	--   3.170보다 큰 사람을 조회하라는 실행문에 의해 180인 손흥민의 이름과 키가 콘솔에 찍힘.
    
-- Q 서브쿼리를 활용해 '손흥민' 보다 먼저 태어난 사람들만 골라내보세요.
SELECT * FROM userTbl WHERE birth_year >
	(SELECT birth_year FROM userTbl WHERE user_name = '손흥민');
    
    
-- 최대값은 max()로 구합니다.
-- 현재 userTbl컬럼에서 가장 나이가 적은 사람의 생년 조회
SELECT max(birth_year) FROM userTbl;
SELECT birth_year FROM userTbl;



-- Q user_id에 M이 포함된 사람들 중 키가 제일 작은 사람보다
-- 키가 더 큰 사람을 구하시오.(min를 활용하세요.)
SELECT * FROM userTbl WHERE hegiht >
	(SELECT min(hegiht) FROM userTbl WHERE user_id like '%m%');
    -- %m% m을 가운데에 넣으면 m이 문자열의 어디에 있어도 불러온다.(시작,중간,끝)
    
-- Q 2021년 가입자중 가입일이 제일 빠른 사람보다 키가 큰 사람을 조회해주세요.
-- 날짜도 부등호로 조회 가능합니다.(작다 : 이전날짜, 크다 : 이후날짜)
SELECT * FROM userTbl WHERE reg_date < '2021-06-30';    

-- 1. 2021년 가입자중 가입일이 제일 빠른 사람의 가입일자 구하기
SELECT min(reg_date) FROM userTbl WHERE reg_date >= '2020-01-01';
-- 2. 가입일이 제일 바른 사람의 키 구하기.
SELECT hegiht FROM userTbl WHERE reg_date =
	(SELECT min(reg_date) FROM userTbl WHERE reg_date >= '2021-01-01');
-- 3. 2에서 구한 키를 조건으로 해서 최종적인 명단을 얻어냄
-- 3중 쿼리문 (2중 서브쿼리)
SELECT * FROM userTbl WHERE hegiht >
	(SELECT hegiht FROM userTbl WHERE reg_date=
	(SELECT min(reg_date) FROM userTbl WHERE reg_date >= '2021-01-01'));
    -- #연산자와 마찬가지로 제일 안에 있는 중괄호가 먼저 실행하고 다음 중괄호를 실행한다
    

-- 유저를 다섯 명 더 추가하겠습니다.
INSERT INTO userTbl VALUES ('KJV', '김자바', 1983, '서울', '01112341234', 171, '2020-08-15');
INSERT INTO userTbl VALUES ('ADR', '압둘라', 1995, '경기', '01012341234', 183, '2021-04-01');
INSERT INTO userTbl VALUES ('YSO', '야스오', 2001, '부산', '01043214321', 165, '2021-10-08');
INSERT INTO userTbl VALUES ('ZYA', '장위안', 1985, '부산', '01155555555', 164, '2020-02-28');
INSERT INTO userTbl VALUES ('SPR', '스프링', 1987, '강원', '01066666666', 184, '2021-12-31');
INSERT INTO userTbl VALUES ('JSP', '쟈스피', 1989, '전라', '01077777777', 177, '2022-01-01');

-- ANY, ALL, SOME 구문은 서브쿼리와 조합해서 사용합니다.
-- ANY와 SOME은 사실상 차이가 없는 구문으로 보셔도 무방합니다.
-- Q 지역이 서울인 사람보다 키가 작은 사람을 찾는 쿼리문
-- 1. 서울사람의 키 전체 리스트 가져오기
SELECT hegiht FROM userTbl WHERE addr = '서울';
-- 위 구문을 서브쿼리로 해서 서울사람들보다 키가 작은 사람을 찾을 경우 에러가 납니다.
SELECT * FROM userTbl WHERE hegiht <
	(SELECT hegiht FROM userTbl WHERE addr = '서울');
    -- 여러 수 중 어떤 수를 따라가야(기준) 할지 몰라서 오류가뜸. (min이나 max를 써서 하나의 값을 만들어도됌)
    
-- ANY 구문을 사용하면 169,171,186 모든 데이터에 대해 OR로 처리가 됩니다.
-- 개별값 모두에 대해 OR처리가 붙고 그래서 아래와 같이
-- (height < 169) OR (height < 171) OR (height < 186) 등
-- 모든 조건이 OR로 연결됩니다.  
-- or같은 경우는 하나만 맞으면 전부 true가 되는 특성이 있음. ↓
-- ANY는 OR로 연결된다는 특성상 범위가 가장 넓은 조건 하나로 통일됩니다. ★ 
--  -------ㅣ---ㅣ----------ㅣ 의 범위중 가장 넓은 조건(186)
--        169  171        186
-- 현재 코드에서는 186보다 작은 데이터는 전부 잡혀 나옵니다.
-- 아래 ANY자리에 SOME을 대신 넣어도 똑같이 작동합니다. 
SELECT * FROM userTbl WHERE hegiht < ANY
	(SELECT hegiht FROM userTbl WHERE addr = '서울');
 
-- ALL 구문을 사용하면 169, 171, 186 등 서울사람들의 모든 키 데이터에 대해 AND로 처리됩니다.
-- 개별값 모두에 대해 AND처리가 붙고 그래서 아래와 같이
-- (height < 169) AND (height < 171) AND (height < 186) 등이 AND로 연결됩니다.
-- 그래서 서울 사람중 가장 키가 작은 사람의 169 아래의 사람들 정보가 나오게 된다. 
-- (169보다 작은 값만 true로 판정)
SELECT * FROM userTbl WHERE hegiht < ALL
	(SELECT hegiht FROM userTbl WHERE addr = '서울');
