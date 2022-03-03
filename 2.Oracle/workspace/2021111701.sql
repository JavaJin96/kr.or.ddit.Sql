2021-1117-01) �����Լ�...'cont'
 2) AVG(expr)
  . 'expr'�� ����� ����, �Լ�, �÷� � ����� �������� �������� ��ȯ
  . 'DISTINCT' : �ߺ��� �� ����
  . 'ALL' : �ߺ��� �� ����, default��
  . 'expr' �� �÷��� ���Ǹ� NULL ���� ���ܵǾ� ����
  
 ��뿹) ������̺��� �� �μ��� ����ӱ��� ��ȸ�Ͻÿ�.
 
        SELECT ROUND(AVG(SALARY),2) AS ����ӱ�,
               DEPARTMENT_ID AS �μ���
        FROM HR.EMPLOYEES
        GROUP BY DEPARTMENT_ID
        ORDER BY 2;
        
        
 ��뿹) ������� ����ӱ�(��ü ���)
 -- ���̺� ��ü�� ���� �����Լ��� ����� ����, �Ϲ� �÷��� ������ �� ���� �����Լ��� ��밡��, ���� GROUP BY�� �ʿ� ����.
        SELECT  SUM(SALARY) AS �޿��հ�,
                ROUND(AVG(SALARY)) AS ����ӱ�
        FROM HR.EMPLOYEES;
        
 ��뿹) ������̺��� �μ��� ����ӱ��� ��ü����� ����ӱݺ��� ���� �μ��� ��ȸ�Ͻÿ�.
        Alias�� �μ��ڵ�, �μ���, ��ձ޿�, ��ü��ձ޿�
        
        SELECT  A.DEPARTMENT_ID AS �μ��ڵ�,
                B.DEPARTMENT_NAME AS �μ���,
                ROUND(AVG(SALARY)) AS ��ձ޿�
        FROM HR.EMPLOYEES A , HR.DEPARTMENTS B
        WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
        GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME
        HAVING AVG(SALARY) >= (SELECT AVG(SALARY) FROM HR.EMPLOYEES)  
        ORDER BY 1;
 
 ��뿹) ��ǰ���̺��� �з��� ��ո��԰���, ����ǸŰ����� ��ȸ�Ͻÿ�.
        
        SELECT A.PROD_LGU AS �з��ڵ�,
               B.LPROD_NM AS �з���,
               ROUND(AVG(A.PROD_COST)) AS ��ո��԰���,
               TRUNC(AVG(A.PROD_PRICE)) AS ����ǸŰ���,
               ROUND(AVG(A.PROD_PRICE - A.PROD_COST)) AS ������Ͱ���
        FROM PROD A, LPROD B
        WHERE A.PROD_LGU = B.LPROD_GU
        GROUP BY A.PROD_LGU , B.LPROD_NM
        ORDER BY 1;
 
 ��뿹) ��ٱ������̺��� ȸ������ ���� ��ձ��űݾ��� ��ȸ�Ͻÿ�.
        
        --Join�� ����(2�� �̻��� ���̺��� ���� �� / ������ �����ͺ��̽�)
        
        SELECT  SUBSTR(A.CART_NO,5,2) ||'��' AS ����,
                ROUND(AVG(A.CART_QTY * B.PROD_PRICE)) AS ��ձ��űݾ�
        FROM CART A , PROD B
        WHERE A.CART_PROD = B.PROD_ID     --Join ���� ��������!!!!!!!!!
            AND A.CART_NO LIKE '2005%'
        GROUP BY SUBSTR(A.CART_NO,5,2)
        ORDER BY 1;
        
        
 3) COUNT(*|expr)
  . �� �׷쳻�� �ڷ��� ��(���� ��)�� ��ȯ
  . �ܺ� ���ο� COUNT�Լ��� ���� ��� ' * ' ��� �ش� ���̺��� �⺻Ű �÷��� ����ؾ� �Ѵ�.
  . NULL���� �����Ͽ� ����� ��ȯ��
  . * ����� NULL���� �����Ѵ�.
  
 ��뿹) �� �μ��� ������� ����ӱ��� ��ȸ�Ͻÿ�.
        SELECT  DEPARTMENT_ID AS �μ��ڵ�,
                COUNT(DEPARTMENT_ID) AS �����,
                COUNT(*) AS �����2,
                ROUND(AVG(SALARY)) AS ����ӱ�
        FROM HR.EMPLOYEES
        GROUP BY DEPARTMENT_ID
        ORDER BY 1;
        
 ��뿹) ��ٱ������̺��� 2005�� 5�� ���ں� �ǸŰǼ��� ��ȸ�Ͻÿ�.
        ��, �ǸŰǼ��� 5ȸ �̻�Ǵ� �ڷḸ ��ȸ�Ͻÿ�.
        
            SELECT  '5��' || SUBSTR(CART_NO,7,2) || '��' AS ����,
                    COUNT (CART_PROD) AS �ǸŰǼ�      -- �⺻ŰCART_NO , CART_PROD Ȥ�� * ����
            FROM CART
            WHERE CART_NO LIKE '200505%'
            -- WHERE SUBSTR(CART_NO,1,6) = '200505'
            GROUP BY SUBSTR(CART_NO,7,2)
            HAVING COUNT (CART_QTY) >= 5
            ORDER BY 1;
            
 ��뿹) 2005�� 2�� ��� ��ǰ�� �������踦 ��ȸ�Ͻÿ�. 
        Alias�� ��ǰ�ڵ�, ��ǰ��, ���Լ����հ�, ���Աݾ��հ��̸�
        ���Թ߻����� ���� ��ǰ�� ����� 0���� ǥ���Ͻÿ�.
        --��� ���ľ�� �ƿ��� ���� (�ܺ� ����) ������ ��� ������ �־��ִ� ��.
        -- ������ �ִ� ���� ��Ÿ���°� �̳� ����(���� ����)
        
        (2005�� 2�� ���Ե� ��ǰ�� ������)
        SELECT COUNT(DISTINCT BUY_PROD)
        FROM BUYPROD
        WHERE BUY_DATE BETWEEN TO_DATE('20050201') AND LAST_DAY('20050201')
        
        
        (ANSI OUTER JOIN)
        SELECT 
        FROM BUYPROD A PROD B
        -- �ΰ��� ���̺��� ���Ҷ� ������ �÷��� SELECT ������ ����Ҷ��� ���� ���� ���� �ʰ��� ���
        
        
        
        
        -- NVL (~,0) 0�� ó�����ִ� �Լ�
        SELECT  B.PROD_ID AS ��ǰ�ڵ�,
                B.PROD_NAME AS ��ǰ��,
                COUNT(BUY_PROD) AS ���԰Ǽ�,
                NVL (SUM (A.BUY_QTY),0) AS ���Լ����հ�,
                NVL (SUM (A.BUY_QTY * B.PROD_COST),0) AS ���Աݾ��հ�
        FROM  BUYPROD A
        RIGHT OUTER JOIN PROD B ON(A.BUY_PROD = B.PROD_ID AND
                A.BUY_DATE BETWEEN TO_DATE('20050201') AND LAST_DAY(TO_DATE('20050201')))
        GROUP BY B.PROD_ID, B.PROD_NAME
        ORDER BY 1;
            
        
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
 