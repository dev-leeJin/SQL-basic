-- 위의 UNION으로 처리되는 구문은 user_name이 결과창에 두 번 출력되는 문제가 있습니다.
-- 한 번만 출력되게 만들어보세요.
SELECT m.user_name, s.addr, m.user_point FROM student s RIGHT JOIN membership m 
	ON s.user_name = m.user_name
	UNION
SELECT s.user_name, s.addr,m.user_point FROM student s LEFT JOIN membership m 
	ON s.user_name = m.user_name;
    
/* MYSQL에서도 프로그래밍이 가능하고
변수나 함수 등을 지정할 수 있습니다.
물론 Java, Python, CPP 등의 프로그래밍과는 달리
제한되는 점이 많지만, 이를 활용하는 경우가 빈번하기 때문에
먼저 변수 지정 및 출력부터 진행하겠습니다. */

-- <MySQL에서 변수 사용하기>

-- MySQL에서 변수를 지정할때는 SET @변수명 = 값;의 문법을 씁니다.
SET @myVar1 = 5;
SET @myVar2 = 3;
SET @myVar3 = 4.25;
SET @myVar4 = '가수의 이름 =>';

-- 변수에 저장된 값을 출력할때는 SELECT @변수명; 을 사용합니다.
SELECT @myVar1;

-- 만약 계산식 등이 있다면 SELECT 구문 실행 이전에
-- 계산을 모두 마치고 그 결과를 화면에 보여줍니다.
SELECT @myVar2 + @myVar3;

-- SELECT 구문이 그렇듯 콤마(,)를 이용해서
-- 출력데이터를 여럿 나열할 수도 있습니다.
SELECT @myVar4, user_name FROM usertbl;

-- 일반 구문에서 LIMIT에는 변수를 입력해서 쓸 수 없습니다.
SELECT * FROM usertbl limit 3;
-- SELECT * FROM usertbl limit @myVar2;(불가능)



-- PREPARE 구문
-- PREPARE 구문은 가변적으로 들어갈 문장요소 자리를
-- ?로 구멍을 뚫어놓고, 그 자리를 채우는 방식으로 만듭니다.
-- 사용법은
-- PREPARE 구문이름
-- 		FROM '실제 쿼리문';
-- 방식으로 선언해두고
-- 호출은 EXECUTE 구문이름 USING 전달변수;
-- 로 호출합니다.

SET @myVar5 = 3;

PREPARE MyQuery -- 변수를 저장하듯 MyQuery에 실행구문을 저장
	FROM 'SELECT user_name, hegiht FROM usertbl LIMIT ?';
    
-- myQuery 실행하기
-- 저장된 구문의 ?에 값을 전달하기 위해 USING 전달값 을 씁니다.
EXECUTE myQuery USING @myVar5;


-- <MySQL의 데이터형식과 형 변환>
-- 데이터 변환시는 CAST(), CONVERT() 등의 함수를 이용해서
-- 처리하면 됩니다. 두 함수의 차이점은 거의 없습니다.
-- 문법
-- CAST(실행문 as 바꿀자료형);
-- CONVERT(실행문, 바꿀자료형);
SELECT avg(amount) FROM buytbl; -- 실수(double)로 나오는 평균구매수

SELECT CAST(avg(amount) as SIGNED INTEGER) FROM buytbl; -- INT로 avg(amount)변경

-- CONVERT를 써서 자료형을 바꿔 출력해보세요.
SELECT CONVERT(avg(amount),SIGNED INTEGER) FROM buytbl;

-- CAST을 이용하면 날짜 양식을 통일시킬 수 있습니다.
SELECT CAST('2021$01$07' as DATE);
SELECT CAST('2021/01/07' as DATE);
SELECT CAST('2021%01%07' as DATE);
SELECT CAST('2021@01@07' as DATE);
SELECT CAST('2021.01.07' as DATE);

-- Oracle SQL에서는 sysdate, MySQL에서는 now()를 이용해
-- 현재 시각을 확인할 수 있습니다.
SELECT now();

-- <암시적 형 변환(자동 형 변환)>
SELECT '100' + 200; -- 문자와 숫자 연산 => 정수로 변환 (자바랑 반대)
SELECT '100' + '300'; -- 문자와 문자 연산 => 정수로 변환
SELECT '가나다' + 100; -- 숫자로 변환할 수 없는 문자 + 정수 => 정수끼리만 연산

-- 만약 문자를 붙여서 출력하고 싶다면 concat()을 활용한다. (concatenate연산시키다 의 약자)
SELECT CONCAT('100','200'); -- 100200을 붙여서 출력
SELECT CONCAT(100,'300'); -- 100300을 붙여서 출력
SELECT CONCAT(100,300);

-- 문자는 첫 머리에 숫자가 포함 된 경우 : 첫 글자를 숫자로 변환
-- 문자만 있는 경우 : 0으로 변환
-- 논리식의 경우 0은 false, 1은 true
SELECT 3 > '2mega';
SELECT 1 > 'AMEGA';

-- <MySQL 내장함수>
-- CONCAT, CAST, CONVERT 등과 같이
-- 내부에 이미 선언되어있어서 바로 호출해서 쓸 수 있는
-- 함수들을 보겠습니다.

-- if(수식, 참일때 리턴, 거짓일때 리턴)
-- 삼항연산자와 비슷하게 판단합니다.
SELECT IF(300>200,'참입니다','거짓입니다');

-- IFNULL(수식1, 수식2)
-- 수식1이 NULL이 아니면 수식1이 반환, 수식1이 NULL이면 수식2로 반환합니다.
SELECT IFNULL(NULL,'널입니다'), IFNULL(100,'널입니다');

-- NULLIF(수식1, 수식2)
-- 수식1과 수식2가 같으면 NULL을 반환하고 다르면 수식1가 반환
SELECT NULLIF(100,100), NULLIF(200,100);

-- CASE~WHEN~ELSE~END
-- SWITCH ~ CASE문과 비슷하게
-- 들어온 자료와 일치하는 구간이 있으면 출력
-- 없을때는 ELSE쪽 자료를 출력
-- 단, SQL은 { }로 코드 시작, 끝나는 범위를 표현하지 않기 때문에
-- 구문이 끝나는 시점에 END를 써줘야 합니다.
SELECT CASE 2  -- case의 결과가 있으면 then으로 출력 없으면 else
	WHEN 1 THEN '일'
    WHEN 5 THEN '오'
    WHEN 10 THEN '십'
    ELSE '모름' 
END as '결과'; -- 결과를 쓰지 않으면 위의 구문이 전부 이름으로 나옴


-- <문자열 함수>
-- 문자열을 조작하는데 쓰고 활용도가 높은 편입니다.
-- ASCII(문자), CHAR(숫자)를 넣으면
-- 문자는 숫자로, 숫자는 문자로 바뀝니다.
-- CHAR()는 workbench상에 버그로 인해 모든 문자가 BLOB로 표현되고 있습니다.
-- 원래 값을 보려면 BLOB -> 우클릭 -> Open value in viewer -> text 탭 선택
SELECT ASCII('B'), CHAR(97);

-- 문자열의 길이를 그때그때 확인하기 위해서는
-- CHAR_LENGTH(문자열)을 사용합니다.
-- 이때 결과로 나오는 숫자는 문자열의 길이입니다.
SELECT CHAR_LENGTH('가나다라마바사');
SELECT CHAR_LENGTH('asdadadaqgijswhaafca');

-- CONCAT(문자열1, 문자열2......); -- 여러개를 넣을 수 있음
SELECT CONCAT('가','나','다','라');

-- CONCAT_WS(구분자, 문자열1, 문자열2...);
-- 문자열과 문자열 사이를 구분자를 이용해 붙여줍니다.
SELECT CONCAT_WS('--','1','2','3','4','5','6','7');

-- FORMAT(숫자, 소수점자리) -- 소수점 반올림해서 표시된 부분까지만 표시
SELECT FORMAT(1234.56728312939123,3);

-- BIN(숫자), HEX(숫자), OCT(숫자)
-- 2진수      16진수     8진수
-- 정수로 10진수 숫자를 바꿔서 표현해줍니다.
SELECT BIN(31), HEX(31), OCT(31);

-- INSERT(기준문자열, 위치, 길이, 삽입할 문자열); --INSERT랑 INSERT INT의 구분
-- 기준 문자열의 위치~길이 사이를 지워주고, 그사이에
-- 삽입할 문자열을 새로 넣어줍니다.
SELECT INSERT('abcdefghi',3,4,'@@@@@'); -- 3번부터 4개를 지우고 가운데에 문자열을 삽입


-- LEFT(문자열,길이), RIGHT(문자열, 길이)
-- 해당 문자열의 왼쪽, 오른쪽에서 문자열 길이만큼만 남깁니다.
SELECT LEFT('abcdefghi',3), RIGHT('abcdefghi',4);


-- UCASE(영문자열), LCASE(영문자열) -- UPPERCASE와 LOWERCASE
-- 소문자를 대문자로(UPPERCASE)
-- 대문자를 소문자로(LOWERCASE)
SELECT LCASE('abdcEFGH'), UCASE('abdcEFGH');

-- UPPER(문자열), LOWER(문자열)로 줄여서 쓰기도 합니다.
SELECT UPPER('abdcEFGH'), LOWER('abdcEFGH');

-- LPAD(문자열, 길이, 채울문자열), RPAD(문자열, 길이, 채울문자열)
-- 문자열을 길이만큼 늘려놓고, 빈 칸에 채울 문자열을 채워줍니다.
SELECT LPAD('이것이',5,'#'), RPAD('저것이',6,'-');

-- LTRIM(문자열), PTRIM(문자열)
-- 문자열의 왼쪽/오른쪽 부분의 공백을 모두 없애줍니다.
-- 단, 가운데 부분의 공백은 사라지지 않습니다.
SELECT LTRIM('            이것이'), RTRIM('저것이       ');
SELECT '         이것이','저것이       ';

-- TRIM(문자열), TRIM(방향 '자를문자' FROM '대상문자')
-- TRIM은 기본적으로 LTRIM + RTRIM 형식으로 양쪽의 모든 공백을 다 삭제해줍니다.
-- 공백이 아닌 특정 문자를 삭제하도록 구문을 지정할 수도 있습니다.
SELECT TRIM('        무야호       ');

-- 방향은 BOTH(양쪽다), LEADING(왼쪽), TRAILING(오른쪽)
-- 중 하나를 고르면 됩니다.
SELECT TRIM(TRAILING 'ㅋ' FROM 'ㅋㅋㅋㅋㅋㅋㄹㅇㅋㅋㅋㅋㅋㅋㅋ');

-- REPEAT(문자열, 횟수)
-- 문자열을 횟수만큼 반복합니다.
SELECT REPEAT('ㅋ',10);

-- REPLACE(문자열, 원래문자열, 바꿀문자열)
-- 문자열에서 원래문자열을 찾아 바꿀문자열로 교체합니다.
SELECT REPLACE('JAVA로 작성되었습니다. JAVA','JAVA','MySQL');

-- REVERSE(문자열)
-- 문자열을 인덱스 역순으로 재배치해줍니다.
SELECT REVERSE('MySQL');

-- SPACE(길이)
-- 길이만큼 공백을 사이에 넣어줍니다.
SELECT CONCAT('이것이', SPACE(50), '저것이');

-- SUBSTRING(문자열, 시작위치, 길이)
-- SUBSTRING(문자열 FROM 시작위치 FOR 길이)
-- 시작위치부터 길이만틈의 문자를 반환합니다.
-- 길이를 생략하고 파라미터를 2개만 주면
-- 시작지점부터 끝까지 모든 문자를 반환합니다.
SELECT SUBSTRING('자바스프링마이에스엘', 6, 4);
SELECT SUBSTRING('자바스프링마이에스엘' FROM 6); -- FOR부분을 적지 않으면 끝까지 나옴


-- <SQL 프로그래밍과 프로시저>
-- SQL에서도 변수선인이 되는것을 봤었지만
-- 심지어 스크랩트가 아닌 프로그래밍을 진행할 수도 있습니다.
-- 문법)
-- DELIMITER $$ -- 시작지점
-- CREATE PROCEDURE 선언할프로시저이름()
-- BEGIN -- 실제 실행코드는 BEGIN 아래에 작성합니다.
-- 		실행코드 ...
-- END $$
-- DELIMITER;

-- 선언해둔 프로시저는
-- CALL 프로시저명(); 으로 호출 가능합니다.

-- IF~ELSE문을 프로시저로 작성

DELIMITER $$
CREATE PROCEDURE ifProc()
BEGIN
	DECLARE var1 INT;
    SET var1 = 100;
    IF var1 = 100 THEN
		SELECT '100이 맞습니다.';
	ELSE
		SELECT '100이 아닙니다.';
	END IF;
END $$
DELIMITER ;
CALL ifProc();
-- # BEGIN과 END는 {}로 보면된다.
-- # var1에는 정수밖에 못들어가고 100이 들어간다. 100이 맞기 때문에 IF가 실행 된다.

-- 프로시저 삭제는 DROP PROCEDURE 프로시저명; (프로시저명 오른쪽에 ()는 뺍니다)
DROP PROCEDURE ifProc;

-- Q 테이블 호출구문을 프로시저로 만들어보겠습니다.
-- getUser()를 만들어주세요. usertbl을 조회해줍니다.
-- 만들고 나서 호출까지 해 주세요.
DELIMITER $$
CREATE PROCEDURE getUser()
BEGIN # 프로시저 내부에서 주석 쓰는법.
	SELECT * FROM usertbl;
END $$ # 중괄호가 없으므로 닫는 부분을 END키워드로 대체
DELIMITER ;
CALL getUser();

-- 프로시저를 활용해 employees 테이블의 10001번 직원의
-- 입사일이 5년이 넘었는지 여부를 확인해보겠습니다.
-- hire_date 컬럼의 DATE 자료를 이용해 판단합니다.
use employees;

DELIMITER $$
CREATE PROCEDURE cheakFiveYear()
	BEGIN
		DECLARE hireDATE DATE; # 입사일 얻어오기
        DECLARE todayDATE DATE; # 오늘 날짜 얻어오기
        DECLARE days INT; # 오늘날짜 - 입사일 해서 경과일수 얻어오기
        
        SELECT hire_date INTO hireDATE
			FROM employees WHERE emp_no = 10001;
		# hire_date INTO hireDATE는
        # 위 커리문의 결과로 나온 10001번 직원의 hire_date의 값을 hireDATE에 저장해줍니다.
        
        SET todayDATE = CURRENT_DATE(); # 오늘날짜를 구해오는 기본기능
        SET days = DATEDIFF(todayDATE, hireDATE); # todayDATE - hireDATE를 수행
        
        # 경과일수를 구하는 조건문
        IF (days/365) >= 5 THEN # 입사경과일을 365로 나눠서 5년 이상인지 체크
			SELECT CONCAT('입사한지', days,'일이 경과했습니다');
		ELSE
			SELECT CONCAT('5년미만이고,', days, '일째 근무중.');
		END IF;
	END $$
DELIMITER ;
CALL cheakFiveYear();

-- 10001이라는 값을 직접 내부에서 선언하지 않고 그때그때 포로시저를 호출할 때마다
-- 값을 바꿔넣을수 있도록 파라미터 처리를 하겠습니다. 
-- 10001이라는 값을 직접 내부에서 선언하지 않고 그때그때 프로시저를 호출할 떄마다
-- 값을 바꿔넣을수 있도록 파라미터 처리를 하겠습니다.
DELIMITER $$
CREATE PROCEDURE checkFiveYear2(
	emp_number INTEGER
) # checkFiveYear2는 호출시 emp_number를 입력해야함.
	BEGIN
		DECLARE hireDATE DATE; # 입사일 얻어오기
        DECLARE todayDATE DATE; # 오늘 날짜 얻어오기
        DECLARE days INT; # 오늘날짜 - 입사일 해서 경과일수 얻어오기
        
        SELECT hire_date INTO hireDATE
			FROM employees WHERE emp_no = emp_number;
            # 입력받은 emp_number를 활용해 번호를 처리

        SET todayDATE = CURRENT_DATE(); # 오늘날짜를 구해오는 기본기능
        SET days = DATEDIFF(todayDATE, hireDATE); # todayDATE - hireDATE를 수행
        
        #경과일수를 구하는 조건문
        IF (days/365) >= 5 THEN # 입사경과일을 365로 나눠서 5년 이상인지 체크
			SELECT CONCAT('입사한지', days, '일이 경과했습니다.');
		ELSE
			SELECT CONCAT('5년미만이고, ', days, '일쨰 근무중.');
		END IF;
	END $$
DELIMITER ;
-- 호출시 사원번호를 넣어줘야합니다.
CALL checkFiveYear2(20000);