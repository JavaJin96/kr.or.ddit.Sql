2021-1105-01)검색명령(SELECT)

 - 표준 SQL명령 중 가장 많이 사용되는 명령
 (사용형식)
 SELECT *|[DISTINCT]컬럼명 [AS 별칭][,]   -- distinct ; 중복되어진 것을 없앤다.(대표 한명만 남긴다.)  **중복을 배제할 때 사용하는 예약어
        컬럼명 [AS 별칭][,]   -- 별칭 : 테이블 별칭, 컬럼 별칭
        .   
        .
        컬럼명 [AS 별칭]
    FROM 테이블명 [별칭]                   -- SELECT 절(열) / 필수조건 SELECT절과 FROM절 (Where절 생략 가능하지만, 기본구성)
[WHERE 조건]                              -- WHERE 절(행)
[GROUP BY 컬럼명[,컬럼명,...]]        -- 관계연산자와 논리연산자가 사용된 조건. Where 조건이 참이면 Select 절이 실행, 조건이 불이면 다시 실행
-- sum, avarege,conunt    ;직계함수 (결과값은 group 으로 묶인 수만큼 나온다. ; 다중행 연산자)
-- in, any, 
[HAVING 조건]         
-- where의 조건과 구별 ; 5개의 함수에 조건을 걸 때는 where 절의 조건으로 사용할 수 없다. 즉 5개의 직계함수에 조건을 부여할때 사용
[ORDER BY 컬럼명[컬럼인덱스 [ASC|DESC][,컬럼명[컬럼인덱스 [ASC|DESC],...]];
-- sort;정렬 작업
 
 . 'AS 별칭' : 컬럼에 부여되는 또다른 이름으로 출력시 컬럼제목으로 사용되며 별칭에 특수문자(공백 등)를 사용하는 경우, 컬럼별칭으로 예약어를
              사용하기 위해서는 반드시 " " 안에 기술 해야함
 . '테이블 별칭' : 테이블에 부여된 또 다른 이름으로 서로다른 테이블에 이름이 동일한 컬럼을 참조하기 위하여 사용
 -- 2개 이상의 테이블이 사용될 때, 컬럼의 이름이 같으 경우에 사용한다.
 . '컬럼 인덱스' : SELECT 절에서 컬럼명이 사용된 순서로 1번부터 부여
 . 'ASC|DESC' : 정렬 방법으로 기본은 ASC(오름차순), DESC(내림차순) 정렬
 
 --2가지 이상의 테이블 ; Join (관계형 DB에서 기본이 된다.
 
 사용예) 사원테이블에서 80번 부서에 소속되어있고, 급여가 8000이상인 사원의 사원번호, 사원명, 입사일, 직무코드, 급여를 조회하시오.
        단, 입사일순으로 출력
        
        -- 최종적으로 출력할 컬럼 식별
        
        SELECT EMPLOYEE_ID AS 사원번호,
                FIRST_NAME||' '||LAST_NAME AS 사원명,
                HIRE_DATE AS 입사일,
                JOB_ID AS "직무 코드",
                SALARY AS 급여
            
            FROM HR.EMPLOYEES
            WHERE DEPARTMENT_ID = 80 
            AND SALARY >= 8000
            ORDER BY 3,5;
            -- ORDER BY HIRE_DATE
            
 1) 연산자
 . 사칙연산자 (+,-,/,*)
 . 관계연산자 (<,>,<=,>=,=,!=(<>)) : 두 자료의 크기 비교 후 결과(참,거짓) 반환
 . 논리연산자 (NOT, AND, OR)
 . 기타연산자 ('||', IN, ANY, SOME, ALL, EXISTS, LIKE, BETWEEN 등)
 
  (1) 사칙연산자
  - 이항연산 수행 후 결과값 반환
  - 오라클은 숫자 우선 형변환 수행 
  - 나머지 연산, 증감연산은 제공하지 않음

사용예) SELECT 238 + 78, 238 / 23, 238 * 78, 238 - 78, MOD(10,4)
        FROM DUAL;
    ** DUAL : 시스템이 제공하는 가상의 테이블
                FROM절에 사용할 테이블이 없는 경우에 사용

    SELECT  MEM_ID AS 회원번호, 
            MEM_NAME AS 회원명, 
            MEM_REGNO1 || '-' || MEM_REGNO2 AS 주민번호, 
            
            EXTRACT (YEAR FROM SYSDATE) - 
                    TO_NUMBER('19'||SUBSTR(MEM_REGNO1,1,2)) AS 나이,
            TRUNC (EXTRACT (YEAR FROM SYSDATE) -
                    TO_NUMBER('19'||SUBSTR(MEM_REGNO1,1,2)),-1)||'대' AS 연령대
        FROM MEMBER;
        
    SELECT EMPLOYEE_ID AS 사원번호,
           FIRST_NAME||' '||LAST_NAME AS 사원명, 
           TO_CHAR(SALARY,'99,999') AS 급여, 
           TO_CHAR(NVL(SALARY*COMMISSION_PCT,0),'99,999') AS 보너스,
           TO_CHAR(SALARY+NVL(SALARY*COMMISSION_PCT,0),'99,999') AS 지급액
        FROM HR.EMPLOYEES;

    (DISTINCT 사용예 : 회원테이블에서 회원들의 거주지별 회원수를 조회하시오)
    
    SELECT SUBSTR(MEM_ADD1,1,2) AS 거주지, 
           COUNT(*) AS 회원수
        FROM MEMBER
        GROUP BY SUBSTR(MEM_ADD1,1,2);
    
    DISTINCT 사용예 : 회원테이블에서 회원들의 거주지를 조회하시오
        SELECT DISTINCT SUBSTR(MEM_ADD1,1,2) AS 거주지
            FROM MEMBER;
            
    DISTINCT 사용예 : 상품테이블에서 사용된 분류코드를 조회하시오.


    SELECT DISTINCT A.PROD_LGU AS 분류코드,
        B.LPROD_NM AS 분류명
    FROM PROD A, LPROD B
    WHERE A.PROD_LGU=B.LPROD_GU
    ORDER BY 1;
    
  (2)관계연산자
   - 데이터의 크기를 비교할 때 사용
   - 결과가 참과 거짓으로 반환
   - 조건문 구성에 사용되며 주로 WHERE절의 조건 등에 사용
   - >, <, =, <=, <=, !=(<>)
 
사용예) 회원테이블에서 보유마일리지가 5000이상인 회원을 조회하시오
    Alias는 회원번호, 회원명, 생년월일, 마일리지이다.
    
    SELECT MEM_ID AS 회원번호, 
           MEM_NAME AS 회원명, 
           MEM_BIR AS 생년원일,
           MEM_MILEAGE AS 마일리지
        FROM MEMBER
        WHERE MEM_MILEAGE >= 5000;
           
           
사용예) 장바구니 테이블에서 2005년 4월 회원별 판매집계을 조회하시오.
        Alias는 회원번호, 판매수량합계, 판매금액합계
        
    SELECT A.CART_MEMBER AS 회원번호, 
            SUM(A.CART_QTY) AS 판매수량합계,
            SUM(A.CART_QTY *B.PROD_PRICE) AS 판매금액합계
    FROM CART A, PROD B
    WHERE A.CART_PROD = B.PROD_ID
        AND SUBSTR(CART_NO,1,8) >= '20050401' AND SUBSTR(CART_NO,1,8) >= '20050430'
    GROUP BY A.CART_MEMBER   -- 구매자들 중에서 중복을 제거
    ORDER BY 3 DESC;      -- 3번째 컬럼을 내림차순으로 정렬
    
        
사용예) 회원테이블에서 서울에 거주하는 회원정보를 조회하시오
        Alias는 회원번호, 회원명, 주소, 성별
     
    SELECT MEM_ID AS 회원번호,  
           MEM_NAME AS 회원명,
           MEM_ADD1 ||' '||MEM_ADD2 AS 주소,
           CASE WHEN SUBSTR(MEM_REGNO2,1,1)='1' OR
                     SUBSTR(MEM_REGNO2,1,1)='3' THEN
                '남성회원'
           ELSE
                '여성회원'
           END AS 성별
    -- CASE WHEN ~ ELSE ~ END
           

    FROM MEMBER
    WHERE SUBSTR(MEM_ADD1,1,2)='서울';
    --(MEM_ADD1,1,2) 첫번째에서 2글자를 출력하세요.
    
    -- WHERE MEM_ADD1 LIKE '서울%';
    -- LIKE ~%:와일드 카드 ; 아무거나 나와도 상관없다. 위의 예는 서울 뒤에 나오는 것은 상관없다는 뜻으로 서울을 필터링함.
    
    
사용예) 매입테이블(BUYPROD)에서 2005년 1월 날짜별 판매집계를 조회하시오.
        Alias는 날짜, 매입수량합계, 매입금액합계
    -- PROD : 상품번호 / QTY : 수량 / COST : 매입단가
    -- PRICE : 매출단가 / COST : 매입단가 / SALE : 할인판매단가
 
    SELECT BUY_DATE AS 날짜,
           SUM(BUY_QTY) AS 매입수량합계,
           SUM(BUY_QTY * BUY_COST) AS 매입금액합계
    FROM BUYPROD
    WHERE BUY_DATE >= TO_DATE('20050101') AND
          BUY_DATE <= TO_DATE('20050131')
    GROUP BY BUY_DATE
    ORDER BY 1; 
          
    --날짜 타입이 문자열보다 우선순위를 가지기 때문에 문자 타입이 아닌 날짜 타입으로 변경된다.
    --날짜도 관계연산자의 대상이 된다.
    
    
*** 테이블 삭제
    DROP TABLE 테이블명;
     . 테이블 삭제시 관계가 설정되어 있으면 자식테이블 부터 삭제해야 함(또는 관계를 삭제한 후 각 테이블삭제 가능)
     
    ** TEMP01 ~ TEMP10 테이블을 삭제하시오.
    DROP TABLE TEMP1;
    DROP TABLE TEMP2;
    DROP TABLE TEMP3;
    DROP TABLE TEMP4;
    DROP TABLE TEMP5;
    DROP TABLE TEMP6;
    DROP TABLE TEMP7;
    DROP TABLE TEMP8;
    DROP TABLE TEMP9;
    DROP TABLE TEMP10;
            
    COMMIT;        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
 