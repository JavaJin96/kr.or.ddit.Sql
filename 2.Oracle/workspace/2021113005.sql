2021-1130-05)CURSOR
 -SQL명령에 의하여 영향받은 행들의 집합(배열??)
 -SELECT문의 결과 집함
 -묵시적 커서 (Implicit Cursor)와 명시적 커서(Explicit Cursor)로 구분
  1) 묵시적 커서 (Implicit Cursor)
   .이름이 없는 커서 
   .한번쓰고 버려짐
   .sql문장이 실행과 동시에 내부적으로 묵시적 커서가 만들어짐
   (커서속성)
   -----------------------------------------------------------------------
      속성              의미
   -----------------------------------------------------------------------
   SQL%FOUND        결과집합의 FETCH ROW수(행의 갯수)가 1개라도 있으면 참 --LOOP에서 종료조건을 걸때 보통 사용.
   SQL%NOTFOUND     결과집합의 FETCH ROW수가 없으면 참, 있으면 거짓
   SQL%ROWFOUND     결과집합의 ROW수 반환
   SQL%ISOPEN       커서가 OPEN상태이면 참(묵시적커서는 항상 거짓임)
   
   2) 명시적 커서 (Explicit Cursor)
   .이름이 있는 커서
   .커서의 사용문 선언 => OPEN => FETCH => CLOSE 4단계로 수행
   (1) 커서 선언
    . DECLARE 영역에서 선언
        (선언형식)
        CURSOR 커서명[(매개변수list)] --CUR_...으로 기술되는 느낌
        IS
        SELECT 문;
            .'매개변수list': 커서 실행시 사용될 데이터를 전달 받을 변수로 
                변수명 데이터타입 형식을 기술되며 데이터는 OPEN문에서 제공한다.
    (2) OPEN 문 
     . 사용할 커서 열기
     . BEGIN 블록에서 사용
         (사용형식)
         OPEN 커서명 [(매개변수list)] --실제 데이터를 이 단계에서 넣어주는것(열어준다?)이다.
          
    (3) FETCH 문
       .커서내의 자료를 행단위로 읽어오는 명령(READ문과 유사 기능)
       .보통 번복명령 안에 위치
         (사용형식)
          FETCH 커서명 INTO 변수,변수,...변수;
       . 커서내의 SELECT 절의 컬럼수가 INTO절의 변수의 갯수 순서, 데이터 타입이 일치해야 함
       . 커서내에 더이상 FETCH할 ROW가 없으면 커서속성 커서명%NOTFOUND가 참이됨 
        --WHILE 문 종료시 : EXIT WHEN 커서명%FOUND;
        --LOOP문 종료조건 : 커서명%NOTFOUND;
        --FOR문은 자기가 알아서 닫히기 때문에 커서속성을 안써도된다~
        --커서와 FOR문은 가장 궁합이 잘맞는 명령어(?)이다~
       . 커서속성은 묵시적 커서속성과 같으니 'SQL'대신 커서명이 기술됨
        ex) 커서명%FOUND,커서명%NOTFOUND,커서명%ISOPEN,커서명%ROWCOUNT,..
        
    (4)CLOSE 문
       . 사용이 종료된 커서는 반드시 CLOSE 해야함 
       
    사용예) 사원테이블에서 80번부서에 속한 사원의 이름, 입사일 직무토드를 
          출력하는 블록을 커서를 이용하여 작성하시오.
          
        (커서부분: 해당부서에 속한 사원명,집무코드,입사일을 출력)
         SELECT EMP_NAME,JOB_ID,HIRE_DATE
           FROM EMP
           WHERE DEPARTMENT_ID = 80;
    
     
    
    DECLARE
       CURSOR CUR_EMP(P_DID EMP.DEPARTMENT_ID%TYPE) --매개변수를 괄호안에 선언해야하지 않으면 어떻게 되나요?
       IS 
         SELECT EMP_NAME,JOB_ID,HIRE_DATE
           FROM EMP
          WHERE DEPARTMENT_ID = P_DID;
        V_ENAME EMP.EMP_NAME%TYPE;
        V_JID EMP.JOB_ID%TYPE;
        V_HDATE DATE;
        
     BEGIN
        OPEN CUR_EMP(80);
        LOOP 
         FETCH CUR_EMP INTO V_ENAME,V_JID,V_HDATE;
         EXIT WHEN CUR_EMP%NOTFOUND; -- FETCH가 EXIT 위에 있어야함 WHY? 그래야 읽을 수 있음
                                     --읽을자료가 행이 없으면 참 -> LOOP를 빠저나감
         DBMS_OUTPUT.PUT_LINE('사원명 : '||V_ENAME);
         DBMS_OUTPUT.PUT_LINE('직무코드 : '||V_JID);
         DBMS_OUTPUT.PUT_LINE('입사일 : '||V_HDATE);
         DBMS_OUTPUT.PUT_LINE('=========================');
        END LOOP;
         DBMS_OUTPUT.PUT_LINE('사원수 : '||CUR_EMP%ROWCOUNT);
     END;
     
     
     사용예) 회원테이블에서 마일리지가 많은 5사람을 조회하시고, 그 회원들이 2005년도 
           구매집계를 조회하시오. 회원번호, 회원명,  --어떤부분을 커서로 사용할것인가? 
           SELECT A.MEM_ID AS MID,A.MEM_NAME AS MNAME
           FROM(SELECT MEM_ID, MEM_NAME, MEM_MILEAGE
             FROM MEMBER 
             ORDER BY MEM_MILEAGE DESC)A
           WHERE ROWNUM <=5;   --Q1. ROWNUM을 1이상을 왜 못쓰나요? 쓸려면????
           
           
           
    
        DECLARE 
          CURSOR CUR_MILEAGE --매개변수 안썼으니 110LINE 도 안써도됨
          IS
           SELECT A.MEM_ID AS MID,A.MEM_NAME AS MNAME
             FROM(SELECT MEM_ID, MEM_NAME, MEM_MILEAGE
                    FROM MEMBER 
                   ORDER BY MEM_MILEAGE DESC)A
            WHERE ROWNUM <=5;  
            V_MNAME MEMBER.MEM_NAME%TYPE;
            V_MID MEMBER.MEM_ID%TYPE;
       --수량합계 변수
       --금액합계 ★변수
            V_SUM NUMBER :=0;
            
        BEGIN
          OPEN CUR_MILEAGE;
          LOOP 
             FETCH CUR_MILEAGE INTO V_MID,V_MNAME;
          EXIT WHEN CUR_MILEAGE%NOTFOUND;
          --나가지 않는다면 회원의 구매금액을 찾아서 출력하라 코드입력
          SELECT SUM(A.CART_QTY*B.PROD_PRICE) INTO V_SUM
            FROM CART A, PROD B 
            WHERE A.CART_PROD=B.PROD_ID
              AND A.CART_NO LIKE '2005%'
              AND A.CART_MEMBER = V_MID;
              
              DBMS_OUTPUT.PUT_LINE('회원번호 : '||V_MID);
              DBMS_OUTPUT.PUT_LINE('회원이름 : '||V_MNAME);
              DBMS_OUTPUT.PUT_LINE('구매금액 : '||V_SUM);
              DBMS_OUTPUT.PUT_LINE('===================================');
          END LOOP;
        END;
          
             
    
    
    
    
    --커서의 기능이 왜 중요한지? 필요성에 대해 알려주는 예제
    --커서는 다시 사용할 수 있는지 ? 
    