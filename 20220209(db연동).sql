-- 테이블을 만들어주세요
-- 테이블 이름 : userinfo
-- uname 10글자 회원이름
-- uid 20글자 회원아이디
-- upw 20글자 회원비밀번호
-- uemail 20글자 회원이메일
CREATE TABLE userinfo(
	uname varchar(10) not null,
    uid varchar(20) primary key,
    upw varchar(20) not null,
    uemail varchar(20)
);

-- 유저 4명을 입력해주세요.
-- 2명은 이메일 넣어주시고 2명은 넣지 말아주세요.
INSERT INTO userinfo(uname, uid, upw, uemail) VALUE
	("이창훈", "dlckdgns","dlckdgns","dlckdgns@naver.com");
INSERT INTO userinfo VALUE("장성빈","wkdtjdqls","wkdtjdqls","wkdtjdqls@nate.com");
INSERT INTO userinfo VALUE("박예은","qkrdPdms","qkrdPdms", null);
INSERT INTO userinfo VALUE("허성현","gjtjdgus","gjtjdgus", null);

SELECT * FROM userinfo;
