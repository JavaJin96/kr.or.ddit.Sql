2021-1118-01) �����Լ� cont..
 4) MAX(col), MIN(col)
  - ���õ� 'col' �÷��� �� �� �ִ�(�ּ�) ���� ��ȯ
  - �����Լ����� ��ø����� ������
  
 ��뿹) ������̺��� �� �μ��� �Ի簡 ���� ���� ����� ���� ���� ��� ������ ��ȸ�Ͻÿ�.
        -- �׷� ���̷� ���� �ڷ�� ����ڷ��� ���̺��� �ٸ� ���� ���������� ����ؾ��Ѵ�.
        
        (�������� : �� �μ��� �Ի簡 ���� ���� �Ի���)
        SELECT  DEPARTMENT_ID AS �μ��ڵ�,
                COUNT(*) AS �����,
                MIN(HIRE_DATE) AS MIDATE,
                MAX(HIRE_DATE) AS MXDATE
        FROM HR.EMPLOYEES
        GROUP BY DEPARTMENT_ID
        ORDER BY 1;
        
        (�������� : ��� ������ ��ȸ, �� ����� ���)        
         SELECT A.EMPLOYEE_ID AS �����ȣ,
               A.EMP_NAME AS �����,
               B.DEPARTMENT_ID AS �μ��ڵ�,
               B.MIDATE AS �Ի���
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
        
        
 ��뿹) 2005�� 5�� �ִ� ���ž��� ����� ȸ�������� ��ȸ�Ͻÿ�.
 

        (ȸ���� ���ž� ���)
        (MAX�� ������� ���� ���)
        SELECT  A.CID AS ȸ����ȣ,
                B.MEM_NAME AS ȸ����,
                B.MEM_HP AS ��ȭ��ȣ,
                B.MEM_MILEAGE AS ���ϸ���,
                A.CSUM AS ���ž��հ�
        FROM ( SELECT A.CART_MEMBER AS CID,
                      SUM(A.CART_QTY * B.PROD_PRICE) AS CSUM
                FROM CART A, PROD B
                WHERE B.PROD_ID = A.CART_PROD
                AND SUBSTR(CART_NO,1,6) LIKE '200505%'
                GROUP BY A.CART_MEMBER
                ORDER BY 2 DESC ) A, MEMBER B
        WHERE ROWNUM=1
        AND A.CID = B.MEM_ID;
        
        
      
        
        
        
        
    (MAX�� ����� ���)
       
        SELECT MAX( A.CSUM) AS MCSUM
        FROM ( SELECT A.CART_MEMBER AS CID,
                      SUM(A.CART_QTY * B.PROD_PRICE) AS CSUM
                FROM CART A, PROD B
                WHERE B.PROD_ID = A.CART_PROD
                AND SUBSTR(CART_NO,1,6) LIKE '200505%'
                GROUP BY A.CART_MEMBER
                ) A, MEMBER B
                
                
 5) ROLLUP(col1[,col2,...])
  - GROUP BY ���� ���Ǵ� �Լ�
  - ����� �÷��� ��������(������ -> ����) ������ �����ϰ� �� ������ ���踦 ��ȯ�ϸ� ���������� ��ü������� ��ȯ
     ex) GROUP BY ROLLUP(A,B,C)
         - A,B,C �÷��� �������� ����
         - A,B �÷��� �������� ����
         - A �÷��� �������� ����
         - ��ü ����
  - ����� �÷��� ���� n�� �϶�, n+1 ������ ���� ��ȯ
  
 ��뿹) ��ٱ��� ���̺��� �̿��Ͽ� 2005�� ����, ȸ����, ��ǰ�� �������踦 ��ȸ�Ͻÿ�
        Alias�� ��, ȸ����ȣ, ��ǰ�ڵ�, �ݾ��հ�
        
        SELECT  SUBSTR(A.CART_NO,5,2) AS ����,
                A.CART_MEMBER AS ȸ����ȣ,
                A.CART_PROD AS ��ǰ�ڵ�,
                SUM(A.CART_QTY * B.PROD_PRICE) AS �ݾ��հ�
        FROM CART A, PROD B
        WHERE A.CART_NO LIKE '2005%'
        AND A.CART_PROD = B.PROD_ID
       -- GROUP BY ROLLUP(SUBSTR(A.CART_NO,5,2), A.CART_MEMBER, A.CART_PROD )
        GROUP BY SUBSTR(A.CART_NO,5,2), ROLLUP (A.CART_MEMBER, A.CART_PROD )
        ORDER BY 1;
        
 6) CUBE(col1[,col2,...])
  - GROUP BY ���� ���Ǵ� �Լ�
  - CUBE�� ����� �÷��� ������ ���� ������ ����� �� ��ŭ ���踦 ��ȯ�Ͽ� ���� ����� ������ 2^(���� �÷��Ǽ�)�� ��
    ex) GROUP BY CUBE(A, B, C)
        - A�÷��� �������� ����
        - B�÷��� �������� ����
        - C�÷��� �������� ����
        - A�� B�÷��� �������� ����
        - A�� C�÷��� �������� ����
        - C�� B�÷��� �������� ����
        - A,B,C�÷��� �������� ����
        
        SELECT  SUBSTR(A.CART_NO,5,2) AS ����,
                A.CART_MEMBER AS ȸ����ȣ,
                A.CART_PROD AS ��ǰ�ڵ�,
                SUM(A.CART_QTY * B.PROD_PRICE) AS �ݾ��հ�
        FROM CART A, PROD B
        WHERE A.CART_NO LIKE '2005%'
        AND A.CART_PROD = B.PROD_ID
          GROUP BY CUBE(SUBSTR(A.CART_NO,5,2), A.CART_MEMBER, A.CART_PROD )
       -- GROUP BY ROLLUP(SUBSTR(A.CART_NO,5,2), A.CART_MEMBER, A.CART_PROD )
        --GROUP BY SUBSTR(A.CART_NO,5,2), ROLLUP (A.CART_MEMBER, A.CART_PROD )
        ORDER BY 1;
      
   
 
 
        
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 