2021-1118-01) 집계함수 cont..
 4) MAX(col), MIN(col)
  - 제시된 'col' 컬럼의 값 중 최대(최소) 값을 반환
  - 집계함수들은 중첩사용이 금지됨
  
 사용예) 사원테이블에서 각 부서별 입사가 가장 빠른 사원과 가장 늦은 사원 정보를 조회하시오.
        -- 그룹 바이로 묶일 자료와 출력자료의 테이블이 다를 경우는 서브쿼리를 사용해야한다.
        
        (서브쿼리 : 각 부서별 입사가 가장 빠른 입사일)
        SELECT  DEPARTMENT_ID AS 부서코드,
                COUNT(*) AS 사원수,
                MIN(HIRE_DATE) AS MIDATE,
                MAX(HIRE_DATE) AS MXDATE
        FROM HR.EMPLOYEES
        GROUP BY DEPARTMENT_ID
        ORDER BY 1;
        
        (메인쿼리 : 사원 정보를 조회, 총 결과를 담당)        
         SELECT A.EMPLOYEE_ID AS 사원번호,
               A.EMP_NAME AS 사원명,
               B.DEPARTMENT_ID AS 부서코드,
               B.MIDATE AS 입사일
          FROM HR.EMPLOYEES A,
               (SELECT DEPARTMENT_ID,
                       COUNT(*),
                       MIN(HIRE_DATE) AS MIDATE
 --                    MAX(HIRE_DATE) AS MXDATE
                  FROM HR.EMPLOYEES
                 GROUP BY DEPARTMENT_ID) B
         WHERE B.DEPARTMENT_ID = A.DEPARTMENT_ID
           AND B.MIDATE = A.HIRE_DATE
         ORDER BY 3;
        
        
 사용예) 2005년 5월 최대 구매액을 기록한 회원정보를 조회하시오.
 

        (회원별 구매액 계산)
        (MAX를 사용하지 않은 경우)
        SELECT  A.CID AS 회원번호,
                B.MEM_NAME AS 회원명,
                B.MEM_HP AS 전화번호,
                B.MEM_MILEAGE AS 마일리지,
                A.CSUM AS 구매액합계
        FROM ( SELECT A.CART_MEMBER AS CID,
                      SUM(A.CART_QTY * B.PROD_PRICE) AS CSUM
                FROM CART A, PROD B
                WHERE B.PROD_ID = A.CART_PROD
                AND SUBSTR(CART_NO,1,6) LIKE '200505%'
                GROUP BY A.CART_MEMBER
                ORDER BY 2 DESC ) A, MEMBER B
        WHERE ROWNUM=1
        AND A.CID = B.MEM_ID;
        
        
      
        
        
        
        
    (MAX를 사용할 경우)
       
        SELECT MAX( A.CSUM) AS MCSUM
        FROM ( SELECT A.CART_MEMBER AS CID,
                      SUM(A.CART_QTY * B.PROD_PRICE) AS CSUM
                FROM CART A, PROD B
                WHERE B.PROD_ID = A.CART_PROD
                AND SUBSTR(CART_NO,1,6) LIKE '200505%'
                GROUP BY A.CART_MEMBER
                ) A, MEMBER B
                
                
 5) ROLLUP(col1[,col2,...])
  - GROUP BY 절에 사용되는 함수
  - 기술된 컬럼을 기준으로(오른쪽 -> 왼쪽) 레벨로 구분하고 각 레벨별 집계를 반환하며 최종적으로 전체집계까지 반환
     ex) GROUP BY ROLLUP(A,B,C)
         - A,B,C 컬럼을 기준으로 집계
         - A,B 컬럼을 기준으로 집계
         - A 컬럼을 기준으로 집계
         - 전체 집계
  - 기술된 컬럼의 수가 n개 일때, n+1 종류의 집계 반환
  
 사용예) 장바구니 테이블을 이용하여 2005년 월별, 회원별, 제품별 구매집계를 조회하시오
        Alias는 월, 회원번호, 제품코드, 금액합계
        
        SELECT  SUBSTR(A.CART_NO,5,2) AS 월별,
                A.CART_MEMBER AS 회원번호,
                A.CART_PROD AS 제품코드,
                SUM(A.CART_QTY * B.PROD_PRICE) AS 금액합계
        FROM CART A, PROD B
        WHERE A.CART_NO LIKE '2005%'
        AND A.CART_PROD = B.PROD_ID
       -- GROUP BY ROLLUP(SUBSTR(A.CART_NO,5,2), A.CART_MEMBER, A.CART_PROD )
        GROUP BY SUBSTR(A.CART_NO,5,2), ROLLUP (A.CART_MEMBER, A.CART_PROD )
        ORDER BY 1;
        
 6) CUBE(col1[,col2,...])
  - GROUP BY 절에 사용되는 함수
  - CUBE는 기술된 컬럼을 가지고 조합 가능한 경우의 수 만큼 집계를 반환하여 집계 결과의 종류가 2^(사용된 컬럼의수)가 됨
    ex) GROUP BY CUBE(A, B, C)
        - A컬럼만 기준으로 집계
        - B컬럼만 기준으로 집계
        - C컬럼만 기준으로 집계
        - A와 B컬럼만 기준으로 집계
        - A와 C컬럼만 기준으로 집계
        - C와 B컬럼만 기준으로 집계
        - A,B,C컬럼만 기준으로 집계
        
        SELECT  SUBSTR(A.CART_NO,5,2) AS 월별,
                A.CART_MEMBER AS 회원번호,
                A.CART_PROD AS 제품코드,
                SUM(A.CART_QTY * B.PROD_PRICE) AS 금액합계
        FROM CART A, PROD B
        WHERE A.CART_NO LIKE '2005%'
        AND A.CART_PROD = B.PROD_ID
          GROUP BY CUBE(SUBSTR(A.CART_NO,5,2), A.CART_MEMBER, A.CART_PROD )
       -- GROUP BY ROLLUP(SUBSTR(A.CART_NO,5,2), A.CART_MEMBER, A.CART_PROD )
        --GROUP BY SUBSTR(A.CART_NO,5,2), ROLLUP (A.CART_MEMBER, A.CART_PROD )
        ORDER BY 1;
      
   
 
 
        
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 