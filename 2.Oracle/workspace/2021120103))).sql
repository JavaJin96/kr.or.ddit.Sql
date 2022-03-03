2021-1201-03) Stored Procedure
  - 저장프로시저로 특정 결과를 도출하는 모듈을 미리 작성하여 컴파일한 후 실행 가능한 형태로 서버에 보관
  - 프로시져는 반환값이 없음
  
  -- JAVA의 메서드와 비슷하며, 리턴값이 있으면 함수(FUNTION), 리턴값이 없으면 프로시저
  (사용 형식)
    CREATE OR REPLACE PROCEDURE 프로시저명 [(
        매개변수 [IN|OUT|INOUT] 데이터타입[:=기본값],
                        .
                        .
        매개변수 [IN|OUT|INOUT] 데이터타입[:=기본값])]
------------------------------------------------------------ 상단 : 프로토타입 /  하단 : 익명블록(PL/SQL의 기본구조)
------------------------------------------------------------ PL/SQL의 기본 구조 상단에 프로시저의 프로토타입이 붙으면 프로시저, 함수의 프로토타입이 붙으면 펑션
    IS|AS
        선언영역;(변수, 상수, 커서)
    BEGIN
        실행영역;
    END;
     . 'IN|OUT|INOUT' : 매개변수의 역활 (IN -> 입력용, OUT-> 출력용, INOUT->입출력용)DEFAULT 는 'IN'
     . '데이터타입' : 크기를 지정하지 않음(지정하면 오류), 참조형타입도 가능
     . '기본값' : 사용자가 지정하지 않으면 자동 저장되는 값 
     
     
 (실행명령)
    EXEC|EXECUTE 프로시저명[(매개변수list)];
    OR
    프로시저명[(매개변수list)]; -- 익명블록 또는 프로시저 등의 내부에서 실행
     
 사용예) 상품코드와 수량을 입력받아 T_PROD 테이블의 PROD_TOTALSTOCK 값을 변경하는 프로시저를 작성하시오.
        
        CREATE OR REPLACE PROCEDURE PROC_TPROD_UPDATE(
            P_PID IN PROD.PROD_ID%TYPE,
            P_AMT IN NUMBER)
        IS --필요없어서 생략  
        BEGIN
            UPDATE T_PROD
               SET PROD_TOTALSTOCK = PROD_TOTALSTOCK + P_AMT
             WHERE PROD_ID = P_PID;
             
             COMMIT;
        END;
        
 (실행)
 EXEC PROC_TPROD_UPDATE('P201000001',37);
 
 사용예) 기간(년도와월)과 회원번호를 입력받아 그 기간동안 구매금액 합계를 구하여 반환하는 프로시저를 작성하시오.
 
        CREATE OR REPLACE PROCEDURE PROC_CART_SUM(
            P_PERIOD IN VARCHAR2,
            P_MID IN MEMBER.MEM_ID%TYPE,
            P_SUM OUT NUMBER)  
        IS
            V_PERIOD CHAR(7) := P_PERIOD||'%';
        BEGIN
            SELECT SUM(A.CART_QTY * B.PROD_PRICE) INTO P_SUM
              FROM CART A, PROD B
             WHERE A.CART_PROD = B.PROD_ID
               AND A.CART_NO LIKE V_PERIOD
               AND A.CART_MEMBER = P_MID;
        END;
        
 (실행)
    SET SERVEROUTPUT ON;
    DECLARE
        V_SUM NUMBER:=0;
    BEGIN
        PROC_CART_SUM('200505' , 'c001', V_SUM); --독립실행시에는 EXEC, EXCUTE 를 기술해야하지만, 실행문 안에서는 생략 해야 실행가능
        DBMS_OUTPUT.PUT_LINE(V_SUM);
    END;
     
     
 사용예) 월(2월 이후) 2개를 입력 받아 2005년 해당기간 동안 상품별 매입집계를 구하고, 재고수불테이블을 갱신하시오.
 
        CREATE OR REPLACE PROCEDURE PROC_BUYPROD_PERIOD(
            P_STARTM VARCHAR2,
            P_ENDM VARCHAR2)
        IS
            V_SDATE DATE :=TO_DATE('2005'||P_STARTM||'01');
            V_EDATE DATE :=LAST_DAY(TO_DATE('2005'||P_ENDM||'01'));
        BEGIN
            UPDATE REMAIN
               SET (REMAIN_I,REMAIN_J_99,REMAIN_DATE)=(
                    SELECT A.BSUM + REMAIN_I,
                           A.BSUM + REMAIN_J_99,
                           V_EDATE
                      FROM (SELECT BUY_PROD,
                                   SUM(BUY_QTY)AS BSUM
                              FROM BUYPROD
                             WHERE BUY_DATE BETWEEN V_SDATE AND V_EDATE
                             GROUP BY BUY_PROD) A
                     WHERE PROD_ID = A.BUY_PROD)
            WHERE REMAIN_YEAR = '2005'
              AND PROD_ID IN(SELECT BUY_PROD
                               FROM BUYPROD
                              WHERE BUY_DATE BETWEEN V_SDATE AND V_EDATE);
            COMMIT;
        END;
        
 (실행)
 
 EXEC PROC_BUYPROD_PERIOD('07','07');
 
 INSERT INTO BUYPROD
    VALUES(TO_DATE('20050703'),'P101000003',20,410000);
 INSERT INTO BUYPROD
    VALUES(TO_DATE('20050703'),'P302000013',35,17000);    
    COMMIT;
     
     
 (사용예) 회원번호를 입력받아 그 회원의 주소와 마일리지를 반환받고 회원번호, 회원명, 주소, 마일리지를 출력하시오.
 
        CREATE OR REPLACE PROCEDURE PROC_MEM_INFO(
            P_MID IN MEMBER.MEM_ID%TYPE,
            P_ADDR OUT VARCHAR2,
            P_MILEAGE OUT MEMBER.MEM_MILEAGE%TYPE)
        IS
            
        BEGIN
            SELECT MEM_ADD1 ||' ' || MEM_ADD2, MEM_MILEAGE INTO P_ADDR, P_MILEAGE
              FROM MEMBER 
             WHERE MEM_ID = P_MID;
        END;
     
        ACCEPT PID PROMPT  '회원번호 :'
        DECLARE
            V_ADDR VARCHAR2(200);
            V_MILEAGE MEMBER.MEM_MILEAGE%TYPE;
            V_NAME MEMBER.MEM_NAME%TYPE;
            V_MID MEMBER.MEM_ID%TYPE := '&PID';
        BEGIN
            PROC_MEM_INFO(V_MID, V_ADDR,V_MILEAGE);
            SELECT MEM_NAME INTO V_NAME
              FROM MEMBER
             WHERE MEM_ID = V_MID;
             
             DBMS_OUTPUT.PUT_LINE('회원번호 : ' || V_MID);
             DBMS_OUTPUT.PUT_LINE('회원명 : ' || V_NAME);
             DBMS_OUTPUT.PUT_LINE('주소 : ' || V_ADDR);
             DBMS_OUTPUT.PUT_LINE('마일리지 : ' || V_MILEAGE);
        END;
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     -- 리턴값과 출력의 늬앙스는 살짝 다르다.
     -- 리턴값 = 그 자리에 돌아오는 값.
     -- 변수 = 프로시저 내부에 존재하는 매개변수를 통해 값을 전달하는 과정.
     
     