2021-1124-01) ���� cont...

 ��뿹) ��ٱ��� ���̺��� �̿��Ͽ� 2005�� 4-6�� ����,ȸ���� �������踦 ��ȸ�Ͻÿ�.
        Alias�� ��, ȸ����ȣ, ȸ����, ���ż����հ�, ���űݾ��հ�
        
        SELECT  SUBSTR(A.CART_NO,5,2) AS ��,
                B.MEM_ID AS ȸ����ȣ,
                B.MEM_NAME AS ȸ����,
                SUM(A.CART_QTY) AS ���ż����հ�,
                SUM(A.CART_QTY * C.PROD_PRICE) AS ���űݾ��հ�
         FROM CART A, MEMBER B, PROD C
        WHERE SUBSTR(A.CART_NO,1,6) BETWEEN '200504' AND '200506'
          AND A.CART_MEMBER = B.MEM_ID
          AND A.CART_PROD = C.PROD_ID
        GROUP BY SUBSTR(A.CART_NO,5,2), B.MEM_ID, B.MEM_NAME
        ORDER BY 1;
        
        
        (ANSI JOIN)
       SELECT  SUBSTR(A.CART_NO,5,2) AS ��,
               B.MEM_ID AS ȸ����ȣ,
               B.MEM_NAME AS ȸ����,
               SUM(A.CART_QTY) AS ���ż����հ�,
               SUM(A.CART_QTY * C.PROD_PRICE) AS ���űݾ��հ�
         FROM CART A 
         INNER JOIN MEMBER B ON (A.CART_MEMBER = B.MEM_ID)
         INNER JOIN PROD C ON (A.CART_PROD = C.PROD_ID) 
         WHERE SUBSTR(A.CART_NO,1,6) BETWEEN '200504' AND '200506'
         GROUP BY SUBSTR(A.CART_NO,5,2), B.MEM_ID, B.MEM_NAME
         ORDER BY 1;
        
        
 ��뿹) ��ٱ������̺��� �̿��Ͽ� 2005�� 4-6�� �з��� �Ǹ����踦 ��ȸ�Ͻÿ�.
        Alias�� �з��ڵ�, �з���, �Ǹż����հ�, �Ǹűݾ��հ�
        
        SELECT  B.LPROD_GU AS �з��ڵ�,
                B.LPROD_NM AS �з���,
                SUM(A.CART_QTY) AS �Ǹż����հ�,
                SUM(A.CART_QTY * C.PROD_PRICE) AS �Ǹűݾ��հ�
          FROM CART A, LPROD B, PROD C
         WHERE SUBSTR(A.CART_NO,1,8) BETWEEN '200504' AND '200506'
           AND A.CART_PROD = C.PROD_ID
           AND C.PROD_LGU = B.LPROD_GU
         GROUP BY B.LPROD_GU ,B.LPROD_NM
         ORDER BY 1;
         
         (ANSI JOIN)
        SELECT  B.LPROD_GU AS �з��ڵ�,
                B.LPROD_NM AS �з���,
                SUM(A.CART_QTY) AS �Ǹż����հ�,
                SUM(A.CART_QTY * C.PROD_PRICE) AS �Ǹűݾ��հ�
          FROM CART A
          INNER JOIN PROD C ON(A.CART_PROD = C.PROD_ID)
          INNER JOIN LPROD B ON(C.PROD_LGU = B.LPROD_GU)
          WHERE SUBSTR(A.CART_NO,1,8) BETWEEN '200504' AND '200506'
         GROUP BY B.LPROD_GU ,B.LPROD_NM
         ORDER BY 1;
         
         
         
         
         
                

 ��뿹) ������̺��� �̱� �̿��� �������� �ٹ��ϴ� ��������� ��ȸ�Ͻÿ�.
        Alias�� �����ȣ, �����, �μ��ڵ�, �μ���, �ּ�, ������
        
        SELECT  A.EMPLOYEE_ID AS �����ȣ,
                A.EMP_NAME AS �����,
                B.DEPARTMENT_ID AS �μ��ڵ�,
                B.DEPARTMENT_NAME AS �μ���,
                C.STREET_ADDRESS ||','||C.CITY||' '||C.STATE_PROVINCE AS �ּ�,
                D.COUNTRY_NAME AS ������
          FROM HR.EMPLOYEES A, HR.DEPARTMENTS B, HR.LOCATIONS C, HR.COUNTRIES D
         WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID -- �������� (�μ��� ����)
           AND B.LOCATION_ID = C.LOCATION_ID -- �������� (��ġ�ڵ� ����)
           AND C.COUNTRY_ID = D.COUNTRY_ID -- �������� (�����ڵ� ����)
           AND D.COUNTRY_NAME != 'United States of America'
        ORDER BY 1;
        
        
        (ANSI JOIN)
         SELECT  A.EMPLOYEE_ID AS �����ȣ,
                 A.EMP_NAME AS �����,
                 B.DEPARTMENT_ID AS �μ��ڵ�,
                 B.DEPARTMENT_NAME AS �μ���,
                 C.STREET_ADDRESS ||','||C.CITY||' '||C.STATE_PROVINCE AS �ּ�,
                 D.COUNTRY_NAME AS ������
          FROM HR.EMPLOYEES A
          INNER JOIN HR.DEPARTMENTS B ON(A.DEPARTMENT_ID = B.DEPARTMENT_ID)
          INNER JOIN HR.LOCATIONS C ON(B.LOCATION_ID = C.LOCATION_ID)
          INNER JOIN HR.COUNTRIES D ON(C.COUNTRY_ID = D.COUNTRY_ID 
                AND D.COUNTRY_NAME!='United States of America')
          ORDER BY 3;
        
        
        
        
        
        
        
        
        