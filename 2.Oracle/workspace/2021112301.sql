2021-1123-01) ���̺� ����
 - ������ �����ͺ��̽� ���� �� ���� �߿��� ���� �� �ϳ�
 - ����(Relationship : �ܷ�Ű ����)�� �����ϰ� �ִ� �������� ���̺����� �ʿ��� �ڷḦ �����ϱ� ���� ����
 - ��������(īŸ�þ�����, ��������, �񵿵�����, ��������), �ܺ�����
 -- �������ǿ��� = �� ���Ǹ� ��������, !=�� ���Ǹ� �񵿵�����
 - �Ϲ�����, ANSI����(CROSS JOIN, NATURAL JOIN, INNER JOIN, OUTER JOIN)
 -- ���������� �����ϴ� �ֵ鸸 ������ ������ �����ϴ°� ��������(�̳�����)
 
 1. ��������
 - ���ο� �����ϴ� ���̺��� ���̿� ���������� �������� �ʴ� ��� ���� �����ϰ� ����
 
  (�������)
  SELECT [���̺���, [���̺���Ī.]�÷��� [AS ��Ī][,] 
                        .
                        .
                        .
  FROM ���̺��� [��Ī1], ���̺���2 [��Ī2][,���̺���3 [��Ī3],....]
  WHERE [�Ϲ�����]
  AND ��������1
  [AND ��������2,....]
  
  . �Ϲ����ǰ� ���������� ��� ������ ���Ѿ���
  . ���� ���̺��� ������ n���� ��, ���������� ��� n-1�� �̻� �̾����
  . ���������� �߸� ����ǰų� �����Ǹ� īŸ�þ� PRODUCT �� �����
  . ���������� ���� ���̺����� ����� �÷��� ���迬���ڸ� ����Ͽ� ��
  
 1) Cartesian Product
  - �ټ����� ���̺����� ��� ��, ��� ���� ���յ�
  - ���� ������ ���̵ǰ� ���� ������ ���̵�
  - ���� Ư���� �����̿ܿ��� ������� ���ƾ� ��
  - ���������� ���ų� ���������� �߸� ����� ��� �߻�
  - ANSI�� CROSS JOIN ���� ����
  
  
        SELECT �÷�list
        FROM ���̺���1
        CROSS JOIN ���̺���2 ON(��������)
        [CROSS JOIN ���̺���3 ON(��������)]  
                    .
                    .
        [WHERE �Ϲ�����]
        . ���� 'ON(��������)' ���� ����
 ��뿹)
        SELECT COUNT(*) FROM DUAL;
        
        SELECT COUNT(*) FROM CART;
        
        SELECT COUNT(*) FROM PROD;
        
        SELECT COUNT(*)
        FROM CART, PROD;
        
         SELECT COUNT(*)
        FROM CART, PROD, BUYPROD;
        
        (CROSS JOIN ���)
        SELECT COUNT(*)
        FROM CART
        CROSS JOIN PROD
        CROSS JOIN BUYPROD
        
        SELECT 207*74*148 FROM DUAL;
        
        
 2) ��������(Eai-join)
  - �������ǿ� '=' �����ڸ� ����� ����
  - ���������� �����ϴ� �ڷḸ�� ������� ����
  - ANSI ���ο��� INNER JOIN �� �̿� �ش�
  
  (ANSI INNER JOIN �������)
  
        SELECT �÷�list
        FROM ���̺���1
        INNER JOIN ���̺���2 ON(��������[AND �Ϲ�����1])
        [INNER JOIN ���̺���3 ON(��������[AND �Ϲ�����2])]  
        -- ���� ���� ��� : ���̺�1 �� ���̺�2�� ���� ��, �� ������� ���̺�3�� ���εȴ�.
        -- �������� �Ϲ������� ������ �δ� �� ���̺��� ������ ��Ÿ����. 
        -- ��) �Ϲ�����1 = ���̺�1 �� ���̺�2�� ��������
                    .
                    .
        [WHERE �Ϲ�����]
        
 ��뿹) 2005�� 7�� �����ڷḦ ��ȸ�Ͻÿ�
        Alias�� ����, ��ǰ�ڵ�, ��ǰ��, �Ǹż���, �Ǹűݾ�
        
        SELECT  SUBSTR(A.CART_NO,5,2) || '��' ||
                SUBSTR(A.CART_NO,7,2) || '��' AS ����,
                A.CART_PROD AS ��ǰ�ڵ�,
                B.PROD_NAME AS ��ǰ��,
                A.CART_QTY AS �Ǹż���,
                A.CART_QTY * B.PROD_PRICE AS �Ǹűݾ�
        FROM CART A, PROD B
        WHERE SUBSTR(A.CART_NO,1,8) LIKE '200507%'  --�Ϲ�����
        AND A.CART_PROD = B.PROD_ID  --��������(��ǰ���� �ǸŴܰ��� �����ϱ� ���ؼ�)
        ORDER BY 1;
        
        SELECT
        FROM CART A, PROD B
        
    -- ������ �Ǵ� ���̺��� �ƴ� ���̺��� ����(���̺� ������ �ذ��� �� �ִ°� �� ���°�?)
    -- ������ ���̺��� ã�´�.
    -- ã�� ���̺��� ������ ���̺��� �ִ°� ���°��� ã�´�.
        
                
        
 ��뿹) ������̺����� �޿��� 15000 �̻� �Ǵ� ��������� ��ȸ�Ͻÿ�
        Alias�� �����ȣ, �����, �μ���ȣ, �μ���, ������, �޿�
        
        SELECT  A.EMPLOYEE_ID AS �����ȣ,
                A.EMP_NAME AS �����,
                A.DEPARTMENT_ID AS �μ���ȣ,
                B.DEPARTMENT_NAME AS �μ���,
                C.JOB_ID AS ������,
                A.SALARY AS �޿�
        FROM HR.EMPLOYEES A , HR.DEPARTMENTS B, HR.JOBS C
        WHERE A.SALARY >= 15000 --�Ϲ�����
        AND A.DEPARTMENT_ID = B.DEPARTMENT_ID --��������(�μ��� ����)
        AND A.JOB_ID = C.JOB_ID -- ��������(������ ����)
        ORDER BY 1;
                
        
        
 ��뿹) 2005�� 2�� �ŷ�ó�� �������踦 ��ȸ�Ͻÿ�
        Alias�� �ŷ�ó�ڵ�, �ŷ�ó��, ���Աݾ��հ�
        
        SELECT  B.BUYER_ID AS �ŷ�ó�ڵ�,
                B.BUYER_NAME AS �ŷ�ó��,
                SUM(A.BUY_QTY * C.PROD_COST) AS ���Ա޾��հ�
        FROM BUYPROD A, BUYER B, PROD C
        WHERE A.BUY_DATE BETWEEN TO_DATE('20050201') AND LAST_DAY(TO_DATE('20050201'))
        AND A.BUY_PROD = C.PROD_ID
        AND B.BUYER_ID = C.PROD_BUYER
        GROUP BY B.BUYER_ID, B.BUYER_NAME
        ORDER BY 1;
        
        
        
        
        
        
        
        
        