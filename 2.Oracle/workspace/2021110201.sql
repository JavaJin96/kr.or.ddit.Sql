2021-1102-01) 사용자 등록

1) 계정 생성(사용자 생성)
 - 오라클 사용자계정 생성
 - 오라클 사용자는 객체(object)로 취급
 (사용형식)
 CREATE USER 유저명 IDENTIFIED BY 암호;
 
 CREATE USER PSJ96 IDENTIFIED BY java;
 
 2)권한부여
  - 생성된 사용자의 수행 범위 지정
  (사용형식)
  GRANT 권한명1[,권한명2,...] TO 계정명;
  
  GRANT CONNECT,RESOURCE,DBA TO PSJ96;
  
 3)HR 계정 활성화
  - HR계정의 잠금 상태를 활성화 상태로 변경
  (사용형식)
  ALTER USER 계정명 ACCOUNT UNLOCK;
  - 계정명에 HR 계정명 기술
  ALTER USER HR ACCOUNT UNLOCk;
  
  - 암호변경
  ALTER USER 유저명 IDENTIFIED BY 암호;
  
  ALTER USER HR IDENTIFIED BY java;