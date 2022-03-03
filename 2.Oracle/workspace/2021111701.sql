2021-1117-01) 집계함수...'cont'
 2) AVG(expr)
  . 'expr'로 기술된 수식, 함수, 컬럼 등에 저장된 데이터의 산술평균을 반환
  . 'DISTINCT' : 중복된 값 제외
  . 'ALL' : 중보된 값 포함, default임
  . 'expr' 에 컬럼이 사용되면 NULL 값은 제외되어 연산
  
 사용예) 사원테이블에서 각 부서별 평균임금을 조회하시오.
 
        SELECT ROUND(AVG(SALARY),2) AS 평균임금,
               DEPARTMENT_ID AS 부서명
        FROM HR.EMPLOYEES
        GROUP BY DEPARTMENT_ID
        ORDER BY 2;
        
        
 사용예) 사원들의 평균임금(전체 사원)
 -- 테이블 전체에 대해 집계함수를 사용할 때는, 일반 컬럼은 등장할 수 없고 집계함수만 사용가능, 또한 GROUP BY도 필요 없다.
        SELECT  SUM(SALARY) AS 급여합계,
                ROUND(AVG(SALARY)) AS 평균임금
        FROM HR.EMPLOYEES;
        
 사용예) 사원테이블에서 부서별 평균임금이 전체사원의 평균임금보다 많은 부서를 조회하시오.
        Alias는 부서코드, 부서명, 평균급여, 전체평균급여
        
        SELECT  A.DEPARTMENT_ID AS 부서코드,
                B.DEPARTMENT_NAME AS 부서명,
                ROUND(AVG(SALARY)) AS 평균급여
        FROM HR.EMPLOYEES A , HR.DEPARTMENTS B
        WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
        GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME
        HAVING AVG(SALARY) >= (SELECT AVG(SALARY) FROM HR.EMPLOYEES)  
        ORDER BY 1;
 
 사용예) 제품테이블에서 분류별 평균매입가격, 평균판매가격을 조회하시오.
        
        SELECT A.PROD_LGU AS 분류코드,
               B.LPROD_NM AS 분류명,
               ROUND(AVG(A.PROD_COST)) AS 평균매입가격,
               TRUNC(AVG(A.PROD_PRICE)) AS 평균판매가격,
               ROUND(AVG(A.PROD_PRICE - A.PROD_COST)) AS 평균이익가격
        FROM PROD A, LPROD B
        WHERE A.PROD_LGU = B.LPROD_GU
        GROUP BY A.PROD_LGU , B.LPROD_NM
        ORDER BY 1;
 
 사용예) 장바구니테이블에서 회원들의 월별 평균구매금액을 조회하시오.
        
        --Join의 관계(2개 이상의 테이블이 사용될 때 / 관계형 데이터베이스)
        
        SELECT  SUBSTR(A.CART_NO,5,2) ||'월' AS 월별,
                ROUND(AVG(A.CART_QTY * B.PROD_PRICE)) AS 평균구매금액
        FROM CART A , PROD B
        WHERE A.CART_PROD = B.PROD_ID     --Join 조건 잊지말자!!!!!!!!!
            AND A.CART_NO LIKE '2005%'
        GROUP BY SUBSTR(A.CART_NO,5,2)
        ORDER BY 1;
        
        
 3) COUNT(*|expr)
  . 각 그룹내의 자료의 수(행의 수)를 반환
  . 외부 조인에 COUNT함수가 사용될 경우 ' * ' 대신 해당 테이블의 기본키 컬럼을 기술해야 한다.
  . NULL값도 포함하여 행수를 반환함
  . * 기술시 NULL값을 포함한다.
  
 사용예) 각 부서별 사원수와 평균임금을 조회하시오.
        SELECT  DEPARTMENT_ID AS 부서코드,
                COUNT(DEPARTMENT_ID) AS 사원수,
                COUNT(*) AS 사원수2,
                ROUND(AVG(SALARY)) AS 평균임금
        FROM HR.EMPLOYEES
        GROUP BY DEPARTMENT_ID
        ORDER BY 1;
        
 사용예) 장바구니테이블에서 2005년 5월 일자별 판매건수를 조회하시오.
        단, 판매건수가 5회 이상되는 자료만 조회하시오.
        
            SELECT  '5월' || SUBSTR(CART_NO,7,2) || '일' AS 일자,
                    COUNT (CART_PROD) AS 판매건수      -- 기본키CART_NO , CART_PROD 혹은 * 가능
            FROM CART
            WHERE CART_NO LIKE '200505%'
            -- WHERE SUBSTR(CART_NO,1,6) = '200505'
            GROUP BY SUBSTR(CART_NO,7,2)
            HAVING COUNT (CART_QTY) >= 5
            ORDER BY 1;
            
 사용예) 2005년 2월 모든 상품별 매입집계를 조회하시오. 
        Alias는 상품코드, 상품명, 매입수량합계, 매입금액합계이며
        매입발생되지 않은 상품의 집계는 0으로 표시하시오.
        --모든 수식어는 아웃터 조인 (외부 조인) 실적이 없어도 실적을 넣어주는 것.
        -- 실적이 있는 값만 나타나는게 이너 조인(내부 조인)
        
        (2005년 2월 매입된 상품의 가지수)
        SELECT COUNT(DISTINCT BUY_PROD)
        FROM BUYPROD
        WHERE BUY_DATE BETWEEN TO_DATE('20050201') AND LAST_DAY('20050201')
        
        
        (ANSI OUTER JOIN)
        SELECT 
        FROM BUYPROD A PROD B
        -- 두개의 테이블을 비교할때 동일한 컬럼을 SELECT 절에서 사용할때는 값의 양이 작은 쪽것을 기술
        
        
        
        
        -- NVL (~,0) 0을 처리해주는 함수
        SELECT  B.PROD_ID AS 상품코드,
                B.PROD_NAME AS 상품명,
                COUNT(BUY_PROD) AS 매입건수,
                NVL (SUM (A.BUY_QTY),0) AS 매입수량합계,
                NVL (SUM (A.BUY_QTY * B.PROD_COST),0) AS 매입금액합계
        FROM  BUYPROD A
        RIGHT OUTER JOIN PROD B ON(A.BUY_PROD = B.PROD_ID AND
                A.BUY_DATE BETWEEN TO_DATE('20050201') AND LAST_DAY(TO_DATE('20050201')))
        GROUP BY B.PROD_ID, B.PROD_NAME
        ORDER BY 1;
            
        
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
 