2021-1124-03) 조인 cont...

  2. 외부조인
   - 자료가 많은 테이블을 기준으로 부족한 테이블에 NULL값의 행을 채우고 조인 수행
   - 조인조건 기술시 부족한 데이터를 보유한 테이블의 컬럼 뒤에 외부조인 연산자 '(+)'를 추가함
   - (주의할 점)
    . 외부조인에 필요한 모든 조건식에 외부조인 연산자 '(+)' 기술해야 함. --자료의 종류가 적은 쪽에 추가
    . 한번에 하나의 테이블만 외부조인 될 수 있음. 예를들어 A, B, C 테이블이 외부조인 될 때 
      A를 기준으로 B가 확장되어 조인되고, 동시에 C를 기준으로 B가 확장되어 외부조인 될 수 없다. 
      즉, WHERE A=B(+)
            AND C=B(+) 는 허용되지 않음
    . 일반 외부조인조건과 일반조건이 동시에 적용되면 내부조인 결과로 변환되며, 이는 서브쿼리나 ANSI 외부조인으로 해결해야 함.
    
  (ANSI OUTER JOIN)
    SELECT 컬럼list
      FROM 테이블명1 [별칭1]
    LEFT|RIGHT|FULL  OUTER JOIN 테이믈명2 [별칭2] ON (조인조건1 [AND 일반조건1])  -- 테이블1 + 테이블2 에 대한 조건
                                .
                                .
    LEFT|RIGHT|FULL  OUTER JOIN 테이믈명n [별칭n] ON (조인조건n [AND 일반조건n])  -- (테이블 1 + 테이블2) + 테이블3 에 대한 조건
    [WHERE 조건]   --전체 조건
        .
        .
    - 'LEFT' : FROM 다음에 기술된 '테이블명1'의 자료가 '테이블명2'의 자료보다 더 많은 경우
    - 'RIGHT' : FROM 다음에 기술된 '테이블명1'의 자료가 '테이블명2'의 자료보다 더 적은 경우
    - 'FULL' : FROM 다음에 기술된 '테이블명1'의 자료가 '테이블명2'의 자료가 서로 부족한 경우
    - 'WHERE 조건' : 조인 연산 후 반연될 조건
    
    
 사용예) 모든 분류별 상품의 수를 조회하시오. --모든 : 아웃터 조인 / 분류별 : 그룹바이 / 상품의 수 : 집계함수
        Alias는 분류코드, 분류명, 상품의 수
        
        
        (*일반 OUTER JOIN)
        SELECT  A.LPROD_GU AS 분류코드,
                A.LPROD_NM AS 분류명,
                COUNT(B.PROD_ID) AS 상품의수
          FROM LPROD A, PROD B
         WHERE A.LPROD_GU = B.PROD_LGU
         GROUP BY A.LPROD_GU, A.LPROD_NM
         ORDER BY 1;
         
         
        SELECT A.LPROD_GU AS 분류코드,
               A.LPROD_NM AS 분류명,
               COUNT(B.PROD_ID) AS 상품의수
          FROM LPROD A, PROD B
         WHERE A.LPROD_GU = B.PROD_LGU(+)
         GROUP BY A.LPROD_GU, A.LPROD_NM
         ORDER BY 1;
        
        
        (*ANSI OUTER JOIN)
        
        SELECT A.LPROD_GU AS 분류코드,
               A.LPROD_NM AS 분류명,
               COUNT(B.PROD_ID) AS 상품의수
          FROM LPROD A 
          LEFT OUTER JOIN PROD B ON ( A.LPROD_GU = B.PROD_LGU)
          GROUP BY A.LPROD_GU, A.LPROD_NM
          ORDER BY 1;
 
 사용예) 모든 부서별 사원수를 조회하시오.
        Alias는 부서코드, 부서명, 사원수
        
        (* 일반 OUTER JOIN)
        SELECT  A.DEPARTMENT_ID AS 부서코드,
                A.DEPARTMENT_NAME AS 부서명,
                COUNT(B.EMP_NAME) AS 사원수
          FROM  HR.DEPARTMENTS A, HR.EMPLOYEES B
         WHERE  A.DEPARTMENT_ID = B.DEPARTMENT_ID(+)
         GROUP BY A.DEPARTMENT_ID , A.DEPARTMENT_NAME
         ORDER BY 1;
         
         
         (*ANSI OUTER JOIN)
        SELECT  A.DEPARTMENT_ID AS 부서코드,
                A.DEPARTMENT_NAME AS 부서명,
                COUNT(B.EMP_NAME) AS 사원수
          FROM  HR.DEPARTMENTS A
          FULL OUTER JOIN HR.EMPLOYEES B ON (A.DEPARTMENT_ID = B.DEPARTMENT_ID)
         GROUP BY A.DEPARTMENT_ID , A.DEPARTMENT_NAME
         ORDER BY 1;
         
 사용예) 2005년 6월 모든 상품별 매출집계를 조회하시오.    --2005년 6월 : 일반조건 / 모든 : 아웃터 조인 / 상품별 : 그룹바이 / 매출집계 : 집계함수
        Alias는 상품코드, 상품명, 매출금액합계, 
        
        (*일반 OUTER JOIN)
        SELECT  A.CART_PROD AS 상품코드,
                B.PROD_NAME AS 상품명,
                SUM(A.CART_QTY * B.PROD_PRICE) AS 매출금액합계
          FROM  CART A, PROD B
         WHERE  A.CART_PROD(+) = B.PROD_ID
           AND  CART_NO LIKE '200506%'
         GROUP BY A.CART_PROD, B.PROD_NAME
         ORDER BY 1;
         
         
         (*ANSI OUTER JOIN)
        SELECT  B.PROD_ID AS 상품코드,
                B.PROD_NAME AS 상품명,
                NVL(SUM(A.CART_QTY * B.PROD_PRICE),0) AS 매출금액합계
          FROM  CART A
          RIGHT OUTER JOIN PROD B ON (A.CART_PROD = B.PROD_ID AND CART_NO LIKE '200506%')
         GROUP BY B.PROD_ID, B.PROD_NAME
         ORDER BY 1 DESC;
         
         
         (*서브쿼리가 사용된 일반 OUTER JOIN)
        SELECT  B.PROD_ID AS 상품코드,
                B.PROD_NAME AS 상품명,
                NVL(A.ASUM,0) AS 매출금액합계
          FROM  PROD B,(SELECT CART_PROD AS CID,
                               SUM(CART_QTY * PROD_PRICE) AS ASUM
                          FROM CART, PROD
                         WHERE CART_PROD = PROD_ID
                           AND CART_NO LIKE '200506%'
                         GROUP BY CART_PROD) A 
         WHERE A.CID(+) = B.PROD_ID
         ORDER BY 1;
          
          
 사용예) 2005년 4월 모든 상품별 매입집계를 조회하시오 -- 2005년 4월 : 일반조건 / 모든 : 아웃터조인 / 상품별 : 그룹바이 / 매입집계 : 집계함수(sum)
        Alias는 상품코드, 상품명, 매입금액합계
        
        SELECT  B.PROD_ID AS 상품코드,
                B.PROD_NAME AS 상품명,
                SUM(A.CART_QTY * B.PROD_PRICE) AS 매입금액합계
          FROM  CART A, PROD B
         WHERE  A.CART_PROD(+) = B.PROD_ID
           AND  CART_NO LIKE '200504%'
         GROUP BY B.PROD_ID, B.PROD_NAME
         ORDER BY 1;
         
         
        SELECT  B.PROD_ID AS 상품코드,
                B.PROD_NAME AS 상품명,
                NVL(SUM(A.BUY_QTY * A.BUY_COST),0) AS 매입금액합계
          FROM  BUYPROD A
          RIGHT OUTER JOIN PROD B ON (A.BUY_PROD = B.PROD_ID AND  BUY_DATE BETWEEN '20050401' AND '20050430')
          GROUP BY B.PROD_ID, B.PROD_NAME
          ORDER BY 3 DESC;
          
 사용예) 2005년 모든제품별 매입/매출/ 현황을 조회하시오.
        Alias는 상품코드, 상품명, 매입금액합계, 매출금액합계
        
        SELECT  C.PROD_ID AS 상품코드,
                C.PROD_NAME AS 상품명,
                SUM(B.BUY_QTY * B.BUY_COST) AS 매입금액합계,
                SUM(A.CART_QTY * C.PROD_PRICE) AS 매출금액합계
          FROM CART A, BUYPROD B, PROD C
         WHERE A.CART_PROD = C.PROD_ID
           AND B.BUY_PROD = C.PROD_ID
           AND BUY_DATE BETWEEN '20050101' AND '20051231'
         GROUP BY C.PROD_ID, C.PROD_NAME
         
        SELECT  A.PROD_ID AS 상품코드,
                A.PROD_NAME AS 상품명,
                SUM(B.BUY_QTY * B.BUY_COST) AS 매입금액합계,
                NVL(SUM(C.CART_QTY * A.PROD_PRICE),0) AS 매출금액합계
          FROM PROD A
          LEFT OUTER JOIN BUYPROD B ON (A.PROD_ID = B.BUY_PROD AND B.BUY_DATE BETWEEN '20050101' AND '20051231')
          LEFT OUTER JOIN CART C ON (A.PROD_ID = C.CART_PROD AND CART_NO LIKE '2005%')
          GROUP BY A.PROD_ID, A.PROD_NAME
          ORDER BY 1;
          
          
          
          --확인해보기
          
        SELECT A.PROD_ID,
               B.BBSUM AS 매입,
               C.CCSUM AS 매출
          FROM PROD A,
               (SELECT BUY_PROD, SUM(BUY_QTY * PROD_COST) AS BBSUM
                  FROM PROD,BUYPROD
                 WHERE PROD_ID = BUY_PROD
                   AND BUY_DATE BETWEEN '20050101' AND '20051231'
                 GROUP BY BUY_PROD) B
                (SELECT CART_PROD, SUM(CART_QTY * PROD_PRICE) AS CCSUM
                  FROM PROD, CART
                  WHERE PROD_ID = CART_PROD
                  AND CART_NO LIKE '2005%'
                  GROUP BY CART_PROD) C
        WHERE A.PROD_ID = B.BUY_PROD(+)
        AND A.PROD_ID = C.CART_PROD(+)
        ORDER BY 1;

 