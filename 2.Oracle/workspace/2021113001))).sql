2021-1130-01)INDEX 객체 (ft.자료구조)
-빠르게 찾기위해 INDEX 형식 사용
-기본키와 키의 값이 저장된 주소가 배열혈식(?)으로 데이터가 저장됨.
-단점: 찾기위한 방법을 설계하는계 너무 어려움(관리,설정-주객이전도됨)
--데이터(자료) 구조의 종류?
--1.선형구조 Linear : 기억장소효율측면에서 쵝오 vs 하지만 삽입삭제가 시간이 오래 --->보관용 파일을 저장할때./스택형식?
--2.Linked  구조  :  선형구조(nod)의 단점보안 -> 포인터 사용 -> 데이터저장 부분과 다음자료가 저장될 주소(nod-포인터)가 저장.---->체인형성
        --a. 장점 : 삽입삭제가 쉬움. 
        --b. 단점 : 정렬이 어려움.
(--Double Linked list : 전 데이터 포인터와 후데이터 포인터가 함꼐 저장 )
(--Split Linked list : ?)
--Que 구조??tree구조??그라프이론??(최단비용 알고리즘=오일러그래프)구조? (network공부할때 사용)
--3.HashMap구조? 
-데이터 검색 효율을 증가 시키기 위한 객체
-DBMS의 부화를 줄여 전체 DB의 성능을 향상
-WHERE 조건, GROUP BY의 기준컬럼, ORDER 의 기준컬럼 등에
 인덱스를 사용하면 처리 속도를 증대 시킴
-별도의 기억공간과 자원이 소요됨
-인덱스의 종류 
 a. Unique/Non-Unique
  -중복값의 허용 여부에 따른 분류로 Unique인덱스인 경우 null을 하나만 하용 
   (단, Primary 또는 Foreign 등에서는 허용안됨)
   
 b. Normal Index(B-Tree Index)
  -기본인덱스
  -컬럼 값과 rowid(물리적 위치정보)를 기반으로 주소계산="해싱"
  -B-Tree 의 B 는 balance(binary?) : 자식의 depts가 2이하인 최고검색효율을 내는 구조 
  
 c. Bitup Index="비트맵" 0x1101-->주소를 이진수로...
  - Cardinality(=Tuple 튜플의 수)가 적은 경우 효율적인 인덱스(ex) 남성-여성<Gender>)
  - 컬럼 값과 rowid(물리적 위치정보)를 이진자료로 변환하여 각 비트의 조합으로 주소 산정
  - 데이터 변동이 심한 경우 비효율적
  
 d. Fundion-Based Normal Index
  - 함수가 적용된 컬럼을 기준을 인덱스 구성
  - 조건절에서 해당 함수가 그대로 사용되는 경우 효율적

    (사용형식) 
    CREATE [UNIQUE|BITMAP] INDEX 인덱스명
      ON 테이블명(컬럼명1,[,컬럼명2,...]) [ASC|DESC];
      . '테이블명' : 인덱스 대상이 되는 테이블
      . 'ASC|DESC' : 인덱스의 생성시 오름차순/내림차순으로 저장, default는 ASC
      
      (사용예_ 상품테이블에서 상품이름으로 기본 인덱스를 생성하시오)
      CREATE INDEX IDX_PROD_NAME
          ON PROD(PROD_NAME);
      
    **인덱스 삭제
    DROP INDEX 인덱스명;
    DROP INDEX IDX_PROD_NAME;
    
    SELECT * FROM PROD
    WHERE PROD_NAME = '대우 VTR 6헤드';
  
       (사용예2_ 장바구니 테이블에서 상품코드로 기본 인덱스를 생성하시오)
       CREATE INDEX INX_CART_PROD
           ON CART(CART_PROD);
           
        SELECT * FROM CART
         WHERE CART_PROD = 'P202000003'
         
    (사용예3_ 회원테이블에서 회원의 생년월일로 기본 인덱스를 생성하시오)
        CREATE INDEX IDX_MEM_BIR 
            ON MEMBER(MEM_BIR);
            
        DROP INDEX IDX_MEM_BIR ;
            
            
        SELECT * FROM MEMBER
        WHERE MEM_BIR = TO_DATE('1976/05/06');
        
    (사용예4_ 회원테이블에서 회원의 주민번호 두번째 그룹 뒷자리 5자리로 기본 인덱스를 생성하시오)
        CREATE INDEX IDX_MEM_REGNO2
            ON MEMBER(SUBSTR(MEM_REGNO2,1,5));
            --> FUNTION-BASED INDEX 생성됨
            
 **인덱스 재구성
  - 테이블과 인덱스 파일의 저장위치가 반영된 경우(테이블 스페이스 변경)
  - 데이터의 변동 (삽입/삭제 등)이 많이 발생된 경우
  (사용형식)
   ALTER INDEX 인덱스명 REBUILD;
  
            
  