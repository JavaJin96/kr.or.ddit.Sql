2021-1116-02) 집계함수
 - 특정컬럼을 기준으로 자료를 그룹화하고 그룹화된 자료를 대상으로 집계처리에 사용되는 함수
 - SUM, AVG, COUNT, MIN, MAX 가 제공됨
 (표현형식)
    SELECT 컬럼명1 [AS 별칭][,]
           [컬럼명1 [AS 별칭]][,]
           집계함수(expr)[,]
           [집계함수(expr)][,]
           .
           .
           .
    FROM 테이블명
    [WHERE 조건] --일반적인 조건
    [GROUP BY 컬럼명1[,컬럼명2,..]
    [HAVING 조건] -- 집계함수 자체에 부여되는 조건
    [ORDER BY 컬럼명|컬럼인덱스 [ASC|DESC]
    ;
    -- SELECT 절에서 집계함수를 사용하지 않은 컬럼이 GROUP BY 의 기준이 된다.
    -- EX) SELECT COL1,
    --            SUM(COL2)
    --     FROM DUAL;
    --     GROUP BY COL1
    -- 날짜별 / 회원별 ** GROUP BY 가 사용된다. ~별, ~에 따라
    
 사용예) 회원테이블에서 회원전체의 마일리지 합계를 조회하시오.
        SELECT SUM(MEM_MILEAGE),
               ROUND(AVG(MEM_MILEAGE)),
               COUNT(*)
        FROM MEMBER;
    
 1) SUM(expr)
  . 'expr' 로 표현된 컬럼이나 수식의 결과값의 합계를 반환
  
 사용예) 회원테이블에서 거주지별 마일리지 합계를 조회하시오.
        SELECT SUBSTR(MEM_ADD1,1,2) AS 거주지,
               SUM(MEM_MILEAGE)AS 마일리지
        FROM MEMBER
        GROUP BY SUBSTR(MEM_ADD1,1,2);
        
 사용예) 매입테이블에서 2005년 1~3월 월별 매입집계를 구하시오.
        SELECT EXTRACT(MONTH FROM BUY_DATE) AS 월별,
               SUM(BUY_QTY) AS 매입수량합계,
               SUM(BUY_QTY * BUY_COST) AS 매입집계
        FROM BUYPROD
        WHERE BUY_DATE BETWEEN '2005/01/01' AND '2005/03/31'
        GROUP BY EXTRACT(MONTH FROM BUY_DATE)
        ORDER BY 1;
 사용예) 매입테이블에서 2005년 1~3월 제품별 매입집계를 구하시오.
    
        SELECT BUY_PROD AS 제품,
               SUM(BUY_QTY) AS 매입수량합계,
               SUM(BUY_QTY * BUY_COST) AS 매입집계
        FROM BUYPROD
        WHERE BUY_DATE BETWEEN '2005/01/01' AND '2005/03/31'
        GROUP BY BUY_PROD
        ORDER BY 1;
 사용예) 매입테이블에서 2005년 1~3월 제품별 매입집계를 구하시오.
        매입금액합계가 500만원 이상인 제품만 조회하시오.
        
         SELECT BUY_PROD AS 제품,
               SUM(BUY_QTY) AS 매입수량합계,
               SUM(BUY_QTY * BUY_COST) AS 매입집계
        FROM BUYPROD
        WHERE BUY_DATE BETWEEN '2005/01/01' AND '2005/03/31'
        GROUP BY BUY_PROD
        HAVING SUM(BUY_QTY * BUY_COST) >= 5000000
        ORDER BY 1;
 
 
 사용예) 회원테이블에서 성별 마일리지 합계를 구하시오.
        SELECT CASE WHEN SUBSTR(MEM_REGNO2,1,1)='1' OR
                         SUBSTR(MEM_REGNO2,1,1)='3' THEN 
                        '남성회원'
               ELSE 
                        '여성회원'
               END AS 성별,
               SUM(MEM_MILEAGE) AS 마일리지합계
        FROM MEMBER
        GROUP BY 
               CASE WHEN SUBSTR(MEM_REGNO2,1,1)='1' OR
                         SUBSTR(MEM_REGNO2,1,1)='3' THEN 
                        '남성회원'
               ELSE 
                        '여성회원'
               END;
               
 ** CASE WHEN 표현식
  - 분기명령과 유사한 역활
  - SELECT 절에서만 사용 가능
 ------------------------------------ 
  (표현형식1)
   CASE 변수 WHEN 값1 THEN
                    expr1
             WHEN 값2 THEN
                    expr2
                    .
                    .
    ELSE
        expr_n
    END [ AS 컬럼별칭]
 -------------------------------------   
    (표현형식2)
   CASE WHEN 조건식1 THEN
                    expr1
        WHEN 조건식2 THEN
                    expr2
                    .
                    .
    ELSE
        expr_n
    END [ AS 컬럼별칭]
       
 사용예) 회원테이블의 연령대별 마일리지 합계를 구하시오.
 
        SELECT TRUNC (EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR),-1)||'대' AS 연령대,
               SUM(MEM_MILEAGE) AS 마일리지합계
        FROM MEMBER
        GROUP BY TRUNC (EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR),-1)
        ORDER BY 1;
        
        
 사용예) 장바구니테이블에서 2005년 6월 일자별, 회원별 구매집계를 조회하시오.
        Alias는 일자, 회원번호, 구매수량합계
        
        SELECT SUBSTR(CART_NO,1,8) AS 일자,
               CART_MEMBER AS 회원번호,
               SUM(CART_QTY) AS 구매수량합계
        FROM CART
        WHERE SUBSTR(CART_NO,1,8) LIKE '200506%'
        GROUP BY SUBSTR(CART_NO,1,8), CART_MEMBER
        ORDER BY 1;
        
 사용예) 장바구니테이블에서 2005년 6월 일자별, 회원별 구매집계를 조회하시오. 단, 구매수량합계가 10이상되는 자료만 조회하시오.
        Alias는 일자, 회원번호, 구매수량합계
        
        SELECT SUBSTR(CART_NO,1,8) AS 일자,
               CART_MEMBER AS 회원번호,
               SUM(CART_QTY) AS 구매수량합계
        FROM CART
        WHERE SUBSTR(CART_NO,1,8) LIKE '200506%'
        GROUP BY SUBSTR(CART_NO,1,8), CART_MEMBER
        HAVING SUM(CART_QTY) >= 10
        ORDER BY 1;
        
