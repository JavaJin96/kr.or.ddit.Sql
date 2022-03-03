2021-1108-01)

 (3) 논리 연산자
  - 복수개의 관계식을 결합
  - NOT, AND, OR 제공
  -- 위의 순서대로 연산
  -- NOT은 단항 연산자
  
  -----------------------------------------
  입력(A)   입력(B)  AND    OR    EX-OR
  -----------------------------------------
  0        0        0       0       0   
  0        1        0       1       1
  1        0        0       1       1
  1        1        1       1       0
  -----------------------------------------
  ** 0 : False, 1 : True
  
  -- '-'를 표현하는 방법이 '보수' 이다.
  -- EX-OR : 같은 값이 들어오면 0 / 다른 값이 들어오면 1
  -- OR : 논리의 합
  
  
사용예) 사원테이블(HR.EMPLOYEES)에서 60번 부서 또는 80번 부서 또는 100번 부서에 속한 사원의 사원번호, 사원명, 부서번호, 입사일을 조회하시요.
    
    (OR 연산자)
    SELECT  EMPLOYEE_ID AS 사원번호,
            FIRST_NAME || ' ' || LAST_NAME AS 사원명,
            DEPARTMENT_ID AS 부서번호,
            HIRE_DATE AS 입사일
    FROM HR.EMPLOYEES
    WHERE DEPARTMENT_ID = 60 OR DEPARTMENT_ID = 80 OR DEPARTMENT_ID = 100
    ORDER BY 3, 4;
    
    (IN 연산자)
    SELECT  EMPLOYEE_ID AS 사원번호,
            FIRST_NAME || ' ' || LAST_NAME AS 사원명,
            DEPARTMENT_ID AS 부서번호,
            HIRE_DATE AS 입사일
    FROM HR.EMPLOYEES
    WHERE DEPARTMENT_ID IN(60,80,100)       --IN() 괄호안에 포함이 되면 참으로 출력
    -- WHERE DEPARTMENT_ID ANY(60,80,100)
    -- WHERE DEPARTMENT_ID SOME(60,80,100)
    ORDER BY 3, 4;
    
    (AND 연산자)
    
 사용예1)
    회원테이블에서 거주지가 대전이면서 여성이고 마일리지가 3000 이상인 회원을 조회하시오.
    Alias는 회원번호, 회원명, 주소, 주민번호, 마일리지이다.
    
    SELECT MEM_ID AS 회원번호,
            MEM_NAME AS 회원명,
            MEM_ADD1 || ' ' || MEM_ADD2 AS 주소,
            MEM_REGNO1 || '-' || MEM_REGNO2 AS 주민번호,
            MEM_MILEAGE AS 마일리지
    
    FROM MEMBER
    WHERE SUBSTR(MEM_ADD1,1,2) = '대전' AND   -- MEM_ADD1 LIKE '대전%'
          ( SUBSTR(MEM_REGNO2,1,1) = '2' OR SUBSTR(MEM_REGNO2,1,1)  = '4' )AND
           MEM_MILEAGE >= 3000
    
    

 사용예2)    
    상품테이블(PROD)에서 판매가(PROD_PRICE)가 20만원대인 상품정보를 조회하시오.
    Alias는 상품코드(PROD_ID), 상품명(PROD_NAME), 판매가(PROD_PRICE),판매이익(판매가-매입가)
    
    SELECT PROD_ID AS 상품코드,
            PROD_NAME AS 상품명,
            PROD_PRICE AS 판매가,
            PROD_PRICE - PROD_COST AS 판매이익
            
    FROM PROD
    WHERE PROD_PRICE  >= 200000 AND PROD_PRICE < 300000
    ORDER BY 4 DESC;
      
 사용예3) 상품테이블(PROD)에서'P300' 분류에 속한 상품정보를 조회하시오.
    Alias는 상품코드, 상품명, 매입거래처코드(PROD_BUYER), 분류코드(PROD_LGU) 
    
    SELECT PROD_ID AS 상품코드,
            PROD_NAME AS 상품명,
            PROD_BUYER AS 매입거래처코드,
            PROD_LGU AS 분류코드
    FROM PROD
    WHERE PROD_LGU >= 'P300' AND PROD_LGU < 'P400'
    ORDER BY 1;
    -- SUBSTR(PROD_LGU,2)>= 300 AND SUBSTR(PROD_LGU,2) < 400;
    
 4)기타연산자
 (1)'||' 
  - 문자열 결합 연산자
  (사용형식)
   expr || expr[expr ....]
   . 'expr' 로 표현된 문자열 자료를 결합하여 새로운 문자열 자료를 반환
   . 문자열 함수 CONCAT()로 치환 가능
   
 사용예) 회원테이블에서 직업이 '주부'인 회원 정보를 조회하시오.
        Alias는 회원번호, 회원명, 주민등록번호, 주소이며 주민등록번호는 'XXXXXX-XXXXXXX'형식으로, 
        주소는 기본주소와 상세주소를' '을 삽입하여 출력하시오.
        
    SELECT MEM_ID AS 회원번호,
            MEM_NAME AS 회원명,
            MEM_REGNO1 ||'-'|| MEM_REGNO2 AS 주민등록번호,
            CONCAT(CONCAT(MEM_ADD1,' '),MEM_ADD2) AS 주소
            --MEM_ADD1 ||' '|| MEM_ADD2 AS 주소
    FROM MEMBER
    WHERE SUBSTR(MEM_JOB,1,2) = '주부'
    -- WHERE MON_JOB = '주부';
    ORDER BY 2;
    
** ALTER 명령
 - DDL(Data Definition Language) 명령
 - 테이블이름 변경, 컬럼추가/삭제/변경, 테이블 제약사항의 추가/변경/삭제 기능 제공
 
 
 (1) 테이블명 변경
  (사용형식)
  ALTER TABLE 테이블명_OLD RENAME TO 테이블명_NEW;
  .'테이블명_OLD'를 '테이블명_NEW'로 변경
  
 사용예) CREATE TABLE TEMP AS
        SELECT * FROM PROD;
        
        ALTER TABLE TEMP RENAME TO T_PROD
        
        SELECT * FROM T_PROD;
        
  (2) 컬럼명변경
   (사용형식)
    ALTER TABLE 테이블명 RENAME COLUMN 컬럼명_ORD TO 컬럼명_NEW;
    .'테이블명'에 존재하는 '컬럼명_ORD' 를 '컬럼명_NEW' 로 변경
    
 사용예) T_PROD 테이블의 PROD_LGU 컬럼명을 LPROD_GU 로 변경하시오
    ALTER TABLE T_PROD RENAME COLUMN PROD_LGU TO LPROD_GU;
    
    SELECT * FROM T_PROD;
    
  (3) 컬럼추가
  (사용형식)
  ALTER TABLE 테이블명 ADD (컬럼명 데이터타입[크기]);
  . '테이블명' 에 '컬럼명'을 추가
  
 사용예) 사원테이블에 VARCHAR2(80) 의 길이를 가진 EMP_NAME 컬럼명을 추가하시오.
    ALTER TABLE HR.EMPLOYEES ADD (EMP_NAME VARCHAR2(80));
    
 사용예) 사원테이블의 이름 (FIRST_NAME과 LAST_NAME)을 결합하여 EMP_NAME 컬럼에 저장하시오.
    
    UPDATE HR.EMPLOYEES 
        SET EMP_NAME = FIRST_NAME ||' '||LAST_NAME;
    
    SELECT EMP_NAME
    FROM HR.EMPLOYEES;
    
    COMMIT;
    
 (4) 컬럼삭제
 (사용형식)
 ALTER TABLE 테이블명 DROP COLUMN 컬럼명;
  .'테이블명' 테이블 내의 '컬럼명'에 해당하는 컬럼 삭제
  
 사용예) 테이블 T_PROD 에 존재하는 컬럼 PROD_IMG를 삭제하시오.
    ALTER TABLE T_PROD ADD (PROD_IMG VARCHAR2(80));
    ALTER TABLE T_PROD DROP COLUMN PROD_IMG;
    
 (5) 컬럼수정
 (사용형식)
 ALTER TABLE 테이블명 MODIFY(컬럼명 데이터타입(크기));
  . '테이블명' 테이블 내의 '컬럼명' 에 해당하는 컬럼의 자로형(데이터타입)과 크기를 변경시킬수 있음.
  
 사용예) 
 ALTER TABLE T_PROD MODIFY(PROD_MILEAGE VARCHAR2(20));
 ALTER TABLE T_PROD MODIFY(PROD_TOTALSTOCK NUMBER(15));
 COMMIT;
 ALTER TABLE T_PROD MODIFY(PROD_TOTALSTOCK NUMBER(9));
    
    
    
        
    
   
    
    
    
    
    