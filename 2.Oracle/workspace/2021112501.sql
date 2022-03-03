2021-1125-01)서브쿼리

 - 쿼리 안에 또 다른 쿼리가 존재
 - 서브쿼리는 많은 JOIN 등을 대신할 수 있음
 - 서브쿼리는 주쿼리(메인쿼리)에서 사용할 중간결과를 도출하기 위한 쿼리
 - 서브쿼리는 '(_)' 안에 기술함
 - 서브쿼리는 연산자 오른쪽에 위치해야 함
  (서브쿼리의 분류)
  . 일반서브쿼리 : SELECT절에 위치
  . 인라인(in-line) 서브쿼리 : FROM 절에 위치(독립실행이 가능) -- 가장먼저 실행되기 때문에 독립실행이 가능해야 한다.
  . 중첩서브쿼리 : WHERE절에 위치
 - 메인쿼리와의 연관성 여부에 따라
  . 연관성이 없는 서브쿼리 : 메인쿼리에 사용된 테이블과 서브쿼리에 사용된 테이블 사이에 JOIN이 발생 되지 않는 쿼리
  . 연광성이 있는 서브쿼리 : 메인쿼리에 사용된 테이블과 서브쿼리에 사용된 테이블 사이에 JOIN 으로 연결된 쿼리
 - 반환되는 행의 객수에 따라
  . 단일행 서브쿼리 : 하나의 행만 반환(일반 연산자 사용)
  . 다중행 서브쿼리 : 복수개의 행을 반환(다중행 연산자를 사용하여 처리)
  
  
  1. 연관성없는 서브쿼리
   - 메인쿼리와 서브쿼리 사이에 조인으로 연결되지 않은 서브쿼리
   
   
 사용예) 사원테이블에서 평균급여보다 많은 급여를 받는 사원의 사원번호, 사원명, 부서번호, 급여를 출력하시오.
       
        (메인쿼리 : Alias (사원번호, 사원명, 부서번호, 급여))  
        SELECT  EMPLOYEE_ID AS 사원번호,
                EMP_NAME AS 사원명,
                DEPARTMENT_ID AS 부서번호,
                SALARY AS 급여
          FROM HR.EMPLOYEES
         WHERE A.SALARY >
         
        (서브쿼리 : 평균급여 계산)
        SELECT ROUND(AVG(SALARY))
          FROM HR.EMPLOYEES
           
        (결합) - 모든 사원수 만큼 WHERE 절을 실행한다.
        SELECT  EMPLOYEE_ID AS 사원번호,
                EMP_NAME AS 사원명,
                DEPARTMENT_ID AS 부서번호,
                SALARY AS 급여
          FROM HR.EMPLOYEES
         WHERE SALARY > (SELECT ROUND(AVG(SALARY))
                             FROM HR.EMPLOYEES);
                             
                             
        (결합)  - 셀프조인을 하면서 관련성 있는 서브쿼리가 되었다. 
               - 또한 AS SAVG라고 별칭을 부여하여 별칭과 SALARY 를 비교하게 된다. (서브쿼리 자체가 실행되면서 비교되는 것이 아닌, 별칭에 할당된 변수와 비교를 하게 된다.)
        SELECT  A.EMPLOYEE_ID AS 사원번호,
                A.EMP_NAME AS 사원명,
                A.DEPARTMENT_ID AS 부서번호,
                A.SALARY AS 급여
          FROM HR.EMPLOYEES A, (SELECT ROUND(AVG(SALARY)) AS SAVG
                                FROM HR.EMPLOYEES) B
         WHERE SALARY > B.SAVG;                     
        
        
  2) 연관성이 있는 서브쿼리
   - 메인쿼리와 서브쿼리 사이에 조인으로 연결된 서브쿼리
   
 사용예) 직무변동테이블에서 사용된 부서번호와 부서테이블의 부서번호가 같은 정보를 조회하시오.
        Alias는 부서번호, 부서명
        
        (메인쿼리)
        SELECT  DEPARTMENT_ID AS 부서번호,
                DEPARTMENT_NAME AS 부서명
          FROM  HR.DEPARTMENTS 
         WHERE  DEPARTMENT_ID = 
        
        
        (서브쿼리 : 부서테이블의 부서번호와 동일한 직무변동테이블의 부서번호)
        SELECT B.DEPARTMENT_ID
          FROM HR.DEPARTMENTS A, HR.JOB_HISTORY B
         WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
         
        (결합 : EXISTS 연산자 활용)
        SELECT  A.DEPARTMENT_ID AS 부서번호,
                A.DEPARTMENT_NAME AS 부서명
          FROM  HR.DEPARTMENTS A 
         WHERE  EXISTS (SELECT 1
                          FROM HR.JOB_HISTORY B
                         WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID);              
        -- EXISTS 서브쿼리에 하나의 행이라도 존재하면 참이된다. 
        -- SELECT 절에 1은 아무 의미가 없는 숫자이다.(반환되는 값이 있는지 없는지 판단하기 위해서)
        -- 따라서 단순히 조건만 맞으면 서브쿼리는 1을 출력, 출력값이 존재하기 때문에 EXISTS 는 참이 된다.
        
        (결합 : IN 연산자 활용)
        SELECT  A.DEPARTMENT_ID AS 부서번호,
                A.DEPARTMENT_NAME AS 부서명
          FROM  HR.DEPARTMENTS A 
         WHERE  A.DEPARTMENT_ID IN (SELECT B.DEPARTMENT_ID
                                      FROM HR.JOB_HISTORY B);
                                      
        
        SELECT  /*EMPLOYEE_ID AS 사원번호, 
                (SELECT EMP_NAME
                   FROM HR.EMPLOYEES A
                  WHERE A.EMPLOYEE_ID = B.EMPLOYEE_ID) AS 사원명, */
                DISTINCT B.DEPARTMENT_ID AS 부서번호,
                (SELECT DEPARTMENT_NAME 
                   FROM HR.DEPARTMENTS C
                  WHERE C.DEPARTMENT_ID = B.DEPARTMENT_ID) AS 부서명
          FROM  HR.JOB_HISTORY B;
        
        
 사용예) 2005년 5월 구매금액을 기준으로 가장 많은 구매를 기록한 회원의 회원번호, 회원명, 직업, 마일리지를 조회하시오.
        
        SELECT  A.MEM_ID AS 회원번호,
                A.MEM_NAME AS 회원명,
                A.MEM_JOB AS 직업,
                A.MEM_MILEAGE AS 마일리지
          FROM  MEMBER A
         WHERE  A.MEM_ID = (  SELECT  D.DID
                                FROM  (SELECT  SUM(B.CART_QTY * C.PROD_PRICE) AS DSUM,
                                               B.CART_MEMBER AS DID
                                         FROM CART B, PROD C
                                        WHERE B.CART_PROD = C.PROD_ID
                                          AND B.CART_NO LIKE '200505%'
                                         GROUP BY B.CART_MEMBER
                                         ORDER BY 1 DESC )D,
                                         MEMBER A
                               WHERE  ROWNUM = 1);       
                  
        (서브쿼리)                      
        SELECT  D.DID
          FROM  (SELECT  SUM(B.CART_QTY * C.PROD_PRICE) AS DSUM,
                         B.CART_MEMBER AS DID
                   FROM CART B, PROD C
                  WHERE B.CART_PROD = C.PROD_ID
                    AND B.CART_NO LIKE '200505%'
               GROUP BY B.CART_MEMBER
               ORDER BY 1 DESC )D,
               MEMBER A
         WHERE  ROWNUM = 1;
         
         
         
         
        (조인으로 처리하기 연습)
        SELECT  D.DID
          FROM  (SELECT  SUM(B.CART_QTY * C.PROD_PRICE) AS DSUM,
                         B.CART_MEMBER AS DID
                   FROM CART B, PROD C
                  WHERE B.CART_PROD = C.PROD_ID
                    AND B.CART_NO LIKE '200505%'
               GROUP BY B.CART_MEMBER
               ORDER BY 1 DESC )D,
               MEMBER A
         WHERE  ROWNUM = 1;
          
       
** 다음 조건을 만족하는 재고수불테이블을 생성하시오.
    1) 테이블명 : REMAIN
    2) 컬럼 및 제약조건
    ------------------------------------------------------------------------------
     컬럼명        데이터타입           NULLABLE    DEFAULT         PK/FK
    ------------------------------------------------------------------------------
    REMAIN_YEAR   CHAR(4)               N.N                        PK
    PROD_ID       VARCHAR2(10 BYTE)     N.N                        PK/FK
    REMAIN_J_00   NUMBER(5)                         0                                --기초재고
    REMAIN_I      NUMBER(5)                         0                                --입고재고
    REMAIN_O      NUMBER(5)                         0                                --출고재고   
    REMAIN_J_99   NUMBER(5)                         0                                --기말재고(기초+입고-출고)
    REMAIN_DATE   DATE
    ------------------------------------------------------------------------------
    
    CREATE TABLE REMAIN(
        REMAIN_YEAR   CHAR(4),
        PROD_ID       VARCHAR2(10 BYTE),
        REMAIN_J_00   NUMBER(5) DEFAULT 0,
        REMAIN_I      NUMBER(5) DEFAULT 0,
        REMAIN_O      NUMBER(5) DEFAULT 0,
        REMAIN_J_99   NUMBER(5) DEFAULT 0,
        REMAIN_DATE   DATE,
        
        CONSTRAINT pk_remain PRIMARY KEY(REMAIN_YEAR,PROD_ID ),
        CONSTRAINT fk_re_prod FOREIGN KEY(PROD_ID) REFERENCES PROD(PROD_ID));
        
** 생성된 재고수불테이블에 다음 자료를 입력하시오.
    REMAIN_YEAR : '2005'
    PROD_ID : 상품테이블의 상품코드
    
    INSERT INTO REMAIN (REMAIN_YEAR,PROD_ID)
    --VALUES() : 하나씩 입력할 때,
    --서브쿼리를 이용해 일괄처리를 할때는 VALUES()절 생략
    SELECT '2005', PROD_ID FROM PROD;
        
    SELECT * FROM REMAIN;
    
** 생성된 재고수불테이블에 기초재고와 날짜를 입력하시오.
   기초재고는 상품테이블의 적정재고를 사용하고, 날짜는 2004-12-31을 입력
   
   UPDATE REMAIN A
      SET (A.REMAIN_J_00, A.REMAIN_J_99, A.REMAIN_DATE) =
      (SELECT B.PROD_PROPERSTOCK,
              B.PROD_PROPERSTOCK,       
              TO_DATE('20041231')
         FROM PROD B
        WHERE A.PROD_ID = B.PROD_ID)
    WHERE A.REMAIN_YEAR = '2005';
         
      SELECT * FROM REMAIN;
      
      COMMIT;
      
      
      
      
      