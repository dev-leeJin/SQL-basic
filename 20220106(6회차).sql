-- 권한 뺏기 
-- GRANT가 들어갈 자리에 REVOKE를 사용하면 됩니다.
-- 단, REVOKE는 GRANT와 TO FROM과 연동해서 씁니다.
-- REVOKE 권한명... ON DB이름.테이블명 FROM 계정명;


-- [조인(JOIN)] ★
-- 테이블 2개를 합쳐주는 기능
-- 연관된 데이터를 여러 테이블에 나눠담았을때
-- 그것을 다시 재조립해줍니다.
-- 조인 문법
-- SELECT 테이블1.컬럽1, 테이블1.컬럼2, 테이블2.컬럼1, 테이블2.컬럼2...
--      FROM 테이블1 조인구문 테이블2
-- 		ON 테이블1.공통컬럼 = 테이블2.공통컬럼;
--      WHERE구문은 ON으로 합쳐진 결과컬럼에 대한 필터링을 해줍니다.
use ict_practice;
SELECT * FROM buyTbl INNER JOIN userTbl on buyTbl.user_id = userTbl.user_id; 
	-- 2정규화 시킨걸 다시 원래대로 돌려놓음
    -- user_id를 기준으로 합쳐짐.
    
-- 지금 현재 구매자 정보를 조회하려고 하는데, 필요한 정보는
-- buytbl의 구매 물품정보 전체에, 구매자 정보는 택배를 받기 위해서
-- 이름, 주소, 휴대폰번호만 있으면 되는 상황입니다.
-- # 특정 테이블의 전체 데이터를 출력하는 경우는 
-- # 테이블명.*로 대채할 수 있습니다. 
SELECT buytbl.*, usertbl.user_name, usertbl.phone_number, usertbl.addr 
		FROM buytbl INNER JOIN userTbl ON buytbl.user_id = usertbl.user_id;
        
-- FROM구문에서 테이블명만 적는게 아니라, 테이블명 별명 형식으로 적을 경우는
-- 테이블명을 풀로 적지 않고 별명으로 대체해서 호출할 수 있어 좀 더 편리합니다. 
SELECT * FROM buytbl b INNER JOIN usertbl u ON b.user_id = u.user_id;
	-- # buytbl을 b로 usertbl을 u로 설정.
    
-- Q 위에 구매자 정보를 조회하는 부분을 고쳐주세요.(단, buytbl.* 에 해당하는 구문은 쓰지 마세요.)
SELECT b.order_number, b.user_id, b.prod_name, b.group_name, b.price, b.amount,
		u.user_name, u.phone_number, u.addr FROM buytbl b INNER JOIN usertbl u ON
        b.user_id = u.user_id;
        
        
-- WHERE절은 먼저 JOIN구문의 결과가 나온 상태에서, 추가 필터링만을 담당합니다.
-- 구매물품의 가격이 50000원 이상인것만 남기는 구문.
SELECT b.order_number, b.user_id, b.prod_name, b.group_name, b.price, b.amount,
		u.user_name, u.phone_number, u.addr FROM buytbl b INNER JOIN usertbl u ON
        b.user_id = u.user_id
        WHERE price >= 50000;
        
-- Q 위쪽 JOIN구문을 활용하시되, 가격이 200000만원 이하인 품목만 남겨주시고
-- 그 남은 자료들을 가격순으로 내림차순 출력해주세요.
SELECT b.order_number, b.user_id, b.prod_name, b.group_name, b.price, b.amount,
		u.user_name, u.phone_number, u.addr FROM buytbl b INNER JOIN usertbl u ON
        b.user_id = u.user_id  -- 실행순서 (1)
        WHERE price <= 200000  -- (2)
        ORDER BY b.price DESC; -- (3)
        
-- # 기간이 만료되 DB정보에서 사라진 데이터나 등록만해놓고 물품을 구매 안한 데이터가 있을 수 있다.
-- 교집합처럼 DB정보에도 있고 구매 목록에도 있는 양쪽 테이블 모두 존재하는 데이터만 출력하는것을
-- (공통데이터)INNER JOIN이라고 한다. 

-- 공통된 데이터가 아닌 데이터까지 출력하는 것은 OUTER JOIN이라고 부른다. // 공통데이터(INNER), 모두출력(OUTER) 

-- # LEFT JOIN은 왼쪽테이블에 있는 것은 매칭의 여부와는 상관없이 모두 살리고
-- 오른쪽 테이블 데이터는 왼쪽에 존재하는것만 출력한다. // 왼쪽이 회원정보라면 구매내역이 없는 회원은 null로 뜬다.

-- # RIGHT JOIN은 오른쪽 테이블에 있는 것은 매칭의 여부와는 상관없이 모두 살리고
-- 왼쪽 테이블 데이틑 왼쪽에 존재하는것만 출력한다.// 오른쪽이 구매내역이라면 회원 정보는 null(없음)표시 

-- LEFT OUTER JOIN, RIGHT OUTER JOIN,FULL OUTER JOIN 처럼 OUTER을 붙여도 똑같다.

-- # FULL JOIN은 양쪽 테이블 데이터를 전부 살린다. // 없는 데이터는 null표시
-- mysql에는 FULL OUTER JOIN 명령이 없기 때문에 다른 방법으로 합쳐야 한다. 

SELECT*FROM usertbl; -- 가입회원은 18명
SELECT*FROM buytbl; -- 구매 이력이 있는 회원은 5명

-- LEFT JOIN인데, usertbl를 LEFT에, buytbl을 RIGHT를 두고 작성
-- INNER JOIN을 넣은 자리에 대신 LEFT OUTER JOIN으로 고쳐주면 작동
-- 테이블의 컬럼을 전체 출력합니다. 
SELECT * FROM usertbl u LEFT OUTER JOIN buytbl b ON b.user_id = u.user_id;

-- RIGHT JOIN인데, usertbl를 RIGHT에, buytbl을 LEFT를 두고 작성
-- INNER JOIN을 넣은 자리에 대신 RIGHT OUTER JOIN으로 고쳐주면 작동
-- 테이블의 컬럼을 전체 출력합니다. 
SELECT * FROM buytbl b RIGHT OUTER JOIN usertbl u ON b.user_id = u.user_id;

-- FULL JOIN은 누락데이터 없이 양쪽 테이블의 모든 자료를 보여줍니다.
-- ORACLE SQL에는 FULL OUTER JOIN을 구문으로 지원하지만 MYSQL에서는
-- FULL OUTER JOIN을 UNION 명령어를 이용해
-- LEFT OUTER JOIN과 RIGHT OUTER JOIN의 결과물을 합쳐서 구현합니다.
-- 이 때 접점이 없는 데이터는 반대쪽 데이터를 NULL로 가집니다.
-- UNION은 위쪽 결과물과 아래쪽 결과물을 합쳐줍니다. 
SELECT * FROM buytbl b LEFT OUTER JOIN usertbl u ON b.user_id = u.user_id
	UNION -- UNION구문은 위 아래 결과 화면을 합쳐줍니다.(LEFT,RIGHT 사이에 넣으면 FULL)
SELECT * FROM buytbl b RIGHT OUTER JOIN usertbl u ON b.user_id = u.user_id;

-- FULL JOIN 이해를 돕기 위한 추가 데이터 설정
CREATE TABLE student( -- 학생
	user_name varchar(3) primary key,
    addr char(2) not null
);
CREATE TABLE membership( -- 회원포인트
	user_name varchar(3) primary key,
    user_point INT NOT NULL
);

INSERT INTO student VALUES ('강건마','서울');
INSERT INTO student VALUES ('노영웅','수원');
INSERT INTO student VALUES ('이상용','인천');
SELECT * FROM student;

INSERT INTO membership VALUES ('강건마',15000);
INSERT INTO membership VALUES ('노영웅',37000);
INSERT INTO membership VALUES ('김철수',500);
SELECT * FROM membership;

SELECT * FROM student s LEFT JOIN membership m ON s.user_name = m.user_name
UNION
SELECT * FROM student s RIGHT JOIN membership m ON s.user_name = m.user_name;

-- 위의 UNION으로 처리되는 구문은 user_name이 결과창에 두 번 출력되는 문제가 있습니다.
-- 한 번만 출력되게 만들어보세요.